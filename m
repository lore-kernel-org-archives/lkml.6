Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/FgTnQSybABxyik9CwphzhSQIz+obbchUhtdQXRja75g3YOyitWdImkd5SG5xIVYRUp6KQ
ARC-Seal: i=1; a=rsa-sha256; t=1523473367; cv=none;
        d=google.com; s=arc-20160816;
        b=LQVyvzFCJteXLPKfF1k3zZq7wTaLTL7h/85Xi05RbPUNOnOG3xO7VL91mxSsf2JIoW
         LRVGq/XU76v0XZjiMYKZ2cN1nKSHpc8TCI7iMmvuCN4hroSESTA0LH2pKzupNIhSlRHP
         W14R/v1jG72fn9JTN5Wn+ZqwCyZ82dC6UWkbpNpp45MwNIUHJwO8mpxMiZMl/xTf5ks1
         cLmpd5fsH2o7KENtBCajgpy6YwJtvFi/bwJsX6a3bmBsEmVtP5umPrXLyylDh6/g/xv8
         lSQ+NbCtkfx0laqdL+soBUlmEhDMaoHtOSUbwWIzTOuZZlODicvhkYGq3RkTxjjyiTZH
         EXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gHeSgCkm2o1vqofXaSUoo0vpvcIjit2npjtvrxdZACA=;
        b=IDlouWOiAlKhB3NEAzoF3jTWkfGBFs2Kj35FwPj+S+6Q7dg1/qZxumnLpK66J45yMG
         sn72goGtmadQvSnlP+bo4Mwc9BOUXe286KCLfRBDY4SFrWCjqAXq48S5AL938htq+L3d
         zafF/Hs03qaDgtQHB+UF8QmPURhWzC5XM2hhX6J1d+KOUJZt/0xCoNhP7nHk2D+Xz9/O
         XmIOJWna/BNMDnHUM6k9cJjSJBUAC9kyIizA/zm3KDinCjI+QAMDxs/nn8feksPOpi2U
         N7ShkU6IPOt7uEo6BGjJuS7O8EQAjld3U3vfo7sT70K+gF2I1jWY8BwIr1Luq3+nMYc7
         vwvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Blake <chrisrblake93@gmail.com>,
	Russell Senior <russell@personaltelco.net>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 223/310] net: emac: fix reset timeout with AR8035 phy
Date: Wed, 11 Apr 2018 20:36:02 +0200
Message-Id: <20180411183632.123725656@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476263755286621?=
X-GMAIL-MSGID: =?utf-8?q?1597477610276462253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@googlemail.com>


[ Upstream commit 19d90ece81da802207a9b91ce95a29fbdc40626e ]

This patch fixes a problem where the AR8035 PHY can't be
detected on an Cisco Meraki MR24, if the ethernet cable is
not connected on boot.

Russell Senior provided steps to reproduce the issue:
|Disconnect ethernet cable, apply power, wait until device has booted,
|plug in ethernet, check for interfaces, no eth0 is listed.
|
|This appears to be a problem during probing of the AR8035 Phy chip.
|When ethernet has no link, the phy detection fails, and eth0 is not
|created. Plugging ethernet later has no effect, because there is no
|interface as far as the kernel is concerned. The relevant part of
|the boot log looks like this:
|this is the failing case:
|
|[    0.876611] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.882532] /plb/opb/ethernet@ef600c00: reset timeout
|[    0.888546] /plb/opb/ethernet@ef600c00: can't find PHY!
|and the succeeding case:
|
|[    0.876672] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.883952] eth0: EMAC-0 /plb/opb/ethernet@ef600c00, MAC 00:01:..
|[    0.890822] eth0: found Atheros 8035 Gigabit Ethernet PHY (0x01)

Based on the comment and the commit message of
commit 23fbb5a87c56 ("emac: Fix EMAC soft reset on 460EX/GT").
This is because the AR8035 PHY doesn't provide the TX Clock,
if the ethernet cable is not attached. This causes the reset
to timeout and the PHY detection code in emac_init_phy() is
unable to detect the AR8035 PHY. As a result, the emac driver
bails out early and the user left with no ethernet.

In order to stay compatible with existing configurations, the driver
tries the current reset approach at first. Only if the first attempt
timed out, it does perform one more retry with the clock temporarily
switched to the internal source for just the duration of the reset.

LEDE-Bug: #687 <https://bugs.lede-project.org/index.php?do=details&task_id=687>

Cc: Chris Blake <chrisrblake93@gmail.com>
Reported-by: Russell Senior <russell@personaltelco.net>
Fixes: 23fbb5a87c56e98 ("emac: Fix EMAC soft reset on 460EX/GT")
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/emac/core.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -342,6 +342,7 @@ static int emac_reset(struct emac_instan
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	int n = 20;
+	bool __maybe_unused try_internal_clock = false;
 
 	DBG(dev, "reset" NL);
 
@@ -354,6 +355,7 @@ static int emac_reset(struct emac_instan
 	}
 
 #ifdef CONFIG_PPC_DCR_NATIVE
+do_retry:
 	/*
 	 * PPC460EX/GT Embedded Processor Advanced User's Manual
 	 * section 28.10.1 Mode Register 0 (EMACx_MR0) states:
@@ -361,10 +363,19 @@ static int emac_reset(struct emac_instan
 	 * of the EMAC. If none is present, select the internal clock
 	 * (SDR0_ETH_CFG[EMACx_PHY_CLK] = 1).
 	 * After a soft reset, select the external clock.
+	 *
+	 * The AR8035-A PHY Meraki MR24 does not provide a TX Clk if the
+	 * ethernet cable is not attached. This causes the reset to timeout
+	 * and the PHY detection code in emac_init_phy() is unable to
+	 * communicate and detect the AR8035-A PHY. As a result, the emac
+	 * driver bails out early and the user has no ethernet.
+	 * In order to stay compatible with existing configurations, the
+	 * driver will temporarily switch to the internal clock, after
+	 * the first reset fails.
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address == 0xffffffff &&
-		    dev->phy_map == 0xffffffff) {
+		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
+					   dev->phy_map == 0xffffffff)) {
 			/* No PHY: select internal loop clock before reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    0, SDR0_ETH_CFG_ECS << dev->cell_index);
@@ -382,8 +393,15 @@ static int emac_reset(struct emac_instan
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address == 0xffffffff &&
-		    dev->phy_map == 0xffffffff) {
+		if (!n && !try_internal_clock) {
+			/* first attempt has timed out. */
+			n = 20;
+			try_internal_clock = true;
+			goto do_retry;
+		}
+
+		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
+					   dev->phy_map == 0xffffffff)) {
 			/* No PHY: restore external clock source after reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    SDR0_ETH_CFG_ECS << dev->cell_index, 0);
