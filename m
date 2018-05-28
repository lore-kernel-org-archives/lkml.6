Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938602AbeE1MFM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423195AbeE1LGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corneliu Doban <corneliu.doban@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.16 017/272] mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
Date: Mon, 28 May 2018 12:00:50 +0200
Message-Id: <20180528100241.835633675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corneliu Doban <corneliu.doban@broadcom.com>

commit 5f651b870485ee60f5abbbd85195a6852978894a upstream.

When the host controller accepts only 32bit writes, the value of the
16bit TRANSFER_MODE register, that has the same 32bit address as the
16bit COMMAND register, needs to be saved and it will be written
in a 32bit write together with the command as this will trigger the
host to send the command on the SD interface.
When sending the tuning command, TRANSFER_MODE is written and then
sdhci_set_transfer_mode reads it back to clear AUTO_CMD12 bit and
write it again resulting in wrong value to be written because the
initial write value was saved in a shadow and the read-back returned
a wrong value, from the register.
Fix sdhci_iproc_readw to return the saved value of TRANSFER_MODE
when a saved value exist.
Same fix for read of BLOCK_SIZE and BLOCK_COUNT registers, that are
saved for a different reason, although a scenario that will cause the
mentioned problem on this registers is not probable.

Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
Signed-off-by: Corneliu Doban <corneliu.doban@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-iproc.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -33,6 +33,8 @@ struct sdhci_iproc_host {
 	const struct sdhci_iproc_data *data;
 	u32 shadow_cmd;
 	u32 shadow_blk;
+	bool is_cmd_shadowed;
+	bool is_blk_shadowed;
 };
 
 #define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
@@ -48,8 +50,22 @@ static inline u32 sdhci_iproc_readl(stru
 
 static u16 sdhci_iproc_readw(struct sdhci_host *host, int reg)
 {
-	u32 val = sdhci_iproc_readl(host, (reg & ~3));
-	u16 word = val >> REG_OFFSET_IN_BITS(reg) & 0xffff;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_iproc_host *iproc_host = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+	u16 word;
+
+	if ((reg == SDHCI_TRANSFER_MODE) && iproc_host->is_cmd_shadowed) {
+		/* Get the saved transfer mode */
+		val = iproc_host->shadow_cmd;
+	} else if ((reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) &&
+		   iproc_host->is_blk_shadowed) {
+		/* Get the saved block info */
+		val = iproc_host->shadow_blk;
+	} else {
+		val = sdhci_iproc_readl(host, (reg & ~3));
+	}
+	word = val >> REG_OFFSET_IN_BITS(reg) & 0xffff;
 	return word;
 }
 
@@ -105,13 +121,15 @@ static void sdhci_iproc_writew(struct sd
 
 	if (reg == SDHCI_COMMAND) {
 		/* Write the block now as we are issuing a command */
-		if (iproc_host->shadow_blk != 0) {
+		if (iproc_host->is_blk_shadowed) {
 			sdhci_iproc_writel(host, iproc_host->shadow_blk,
 				SDHCI_BLOCK_SIZE);
-			iproc_host->shadow_blk = 0;
+			iproc_host->is_blk_shadowed = false;
 		}
 		oldval = iproc_host->shadow_cmd;
-	} else if (reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) {
+		iproc_host->is_cmd_shadowed = false;
+	} else if ((reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) &&
+		   iproc_host->is_blk_shadowed) {
 		/* Block size and count are stored in shadow reg */
 		oldval = iproc_host->shadow_blk;
 	} else {
@@ -123,9 +141,11 @@ static void sdhci_iproc_writew(struct sd
 	if (reg == SDHCI_TRANSFER_MODE) {
 		/* Save the transfer mode until the command is issued */
 		iproc_host->shadow_cmd = newval;
+		iproc_host->is_cmd_shadowed = true;
 	} else if (reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) {
 		/* Save the block info until the command is issued */
 		iproc_host->shadow_blk = newval;
+		iproc_host->is_blk_shadowed = true;
 	} else {
 		/* Command or other regular 32-bit write */
 		sdhci_iproc_writel(host, newval, reg & ~3);
