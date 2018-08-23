Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8349FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EB1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EB1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbeHWM24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:28:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeHWM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:55 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81DBFE64;
        Thu, 23 Aug 2018 09:00:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 221/324] net: ieee802154: adf7242: Fix OCL calibration runs
Date:   Thu, 23 Aug 2018 09:54:47 +0200
Message-Id: <20180823075007.233800978@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Hennerich <michael.hennerich@analog.com>

[ Upstream commit 58e9683d14752debc6f22daf6b23e031787df31f ]

Reissuing RC_RX every 400ms - to adjust for offset drift in
receiver see datasheet page 61, OCL section.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/adf7242.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -275,6 +275,8 @@ struct adf7242_local {
 	struct spi_message stat_msg;
 	struct spi_transfer stat_xfer;
 	struct dentry *debugfs_root;
+	struct delayed_work work;
+	struct workqueue_struct *wqueue;
 	unsigned long flags;
 	int tx_stat;
 	bool promiscuous;
@@ -575,10 +577,26 @@ static int adf7242_cmd_rx(struct adf7242
 	/* Wait until the ACK is sent */
 	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
 	adf7242_clear_irqstat(lp);
+	mod_delayed_work(lp->wqueue, &lp->work, msecs_to_jiffies(400));
 
 	return adf7242_cmd(lp, CMD_RC_RX);
 }
 
+static void adf7242_rx_cal_work(struct work_struct *work)
+{
+	struct adf7242_local *lp =
+	container_of(work, struct adf7242_local, work.work);
+
+	/* Reissuing RC_RX every 400ms - to adjust for offset
+	 * drift in receiver (datasheet page 61, OCL section)
+	 */
+
+	if (!test_bit(FLAG_XMIT, &lp->flags)) {
+		adf7242_cmd(lp, CMD_RC_PHY_RDY);
+		adf7242_cmd_rx(lp);
+	}
+}
+
 static int adf7242_set_txpower(struct ieee802154_hw *hw, int mbm)
 {
 	struct adf7242_local *lp = hw->priv;
@@ -686,7 +704,7 @@ static int adf7242_start(struct ieee8021
 	enable_irq(lp->spi->irq);
 	set_bit(FLAG_START, &lp->flags);
 
-	return adf7242_cmd(lp, CMD_RC_RX);
+	return adf7242_cmd_rx(lp);
 }
 
 static void adf7242_stop(struct ieee802154_hw *hw)
@@ -694,6 +712,7 @@ static void adf7242_stop(struct ieee8021
 	struct adf7242_local *lp = hw->priv;
 
 	disable_irq(lp->spi->irq);
+	cancel_delayed_work_sync(&lp->work);
 	adf7242_cmd(lp, CMD_RC_IDLE);
 	clear_bit(FLAG_START, &lp->flags);
 	adf7242_clear_irqstat(lp);
@@ -817,6 +836,7 @@ static int adf7242_xmit(struct ieee80215
 	/* ensure existing instances of the IRQ handler have completed */
 	disable_irq(lp->spi->irq);
 	set_bit(FLAG_XMIT, &lp->flags);
+	cancel_delayed_work_sync(&lp->work);
 	reinit_completion(&lp->tx_complete);
 	adf7242_cmd(lp, CMD_RC_PHY_RDY);
 	adf7242_clear_irqstat(lp);
@@ -955,6 +975,7 @@ static irqreturn_t adf7242_isr(int irq,
 	unsigned int xmit;
 	u8 irq1;
 
+	mod_delayed_work(lp->wqueue, &lp->work, msecs_to_jiffies(400));
 	adf7242_read_reg(lp, REG_IRQ1_SRC1, &irq1);
 
 	if (!(irq1 & (IRQ_RX_PKT_RCVD | IRQ_CSMA_CA)))
@@ -1244,6 +1265,9 @@ static int adf7242_probe(struct spi_devi
 	spi_message_add_tail(&lp->stat_xfer, &lp->stat_msg);
 
 	spi_set_drvdata(spi, lp);
+	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
+	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
+					     WQ_MEM_RECLAIM);
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
@@ -1287,6 +1311,9 @@ static int adf7242_remove(struct spi_dev
 	if (!IS_ERR_OR_NULL(lp->debugfs_root))
 		debugfs_remove_recursive(lp->debugfs_root);
 
+	cancel_delayed_work_sync(&lp->work);
+	destroy_workqueue(lp->wqueue);
+
 	ieee802154_unregister_hw(lp->hw);
 	mutex_destroy(&lp->bmux);
 	ieee802154_free_hw(lp->hw);


