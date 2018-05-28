Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164265AbeE1KyQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164244AbeE1KyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 250/496] gpu: ipu-v3: prg: avoid possible array underflow
Date: Mon, 28 May 2018 12:00:35 +0200
Message-Id: <20180528100330.420599863@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 746d024c3211813946b319411aeb2b47767f8fb0 ]

gcc-8 reports that we access an array with a negative index
in an error case:

drivers/gpu/ipu-v3/ipu-prg.c: In function 'ipu_prg_channel_disable':
drivers/gpu/ipu-v3/ipu-prg.c:252:43: error: array subscript -22 is below array bounds of 'struct ipu_prg_channel[3]' [-Werror=array-bounds]

This moves the range check in front of the first time that
variable gets used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/ipu-v3/ipu-prg.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -252,10 +252,14 @@ void ipu_prg_channel_disable(struct ipuv
 {
 	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
 	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
-	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
+	struct ipu_prg_channel *chan;
 	u32 val;
 
-	if (!chan->enabled || prg_chan < 0)
+	if (prg_chan < 0)
+		return;
+
+	chan = &prg->chan[prg_chan];
+	if (!chan->enabled)
 		return;
 
 	clk_prepare_enable(prg->clk_ipg);
@@ -282,13 +286,15 @@ int ipu_prg_channel_configure(struct ipu
 {
 	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
 	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
-	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
+	struct ipu_prg_channel *chan;
 	u32 val;
 	int ret;
 
 	if (prg_chan < 0)
 		return prg_chan;
 
+	chan = &prg->chan[prg_chan];
+
 	if (chan->enabled) {
 		ipu_pre_update(prg->pres[chan->used_pre], *eba);
 		return 0;
