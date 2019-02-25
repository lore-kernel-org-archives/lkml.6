Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD012084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130124;
	bh=rNmeZzECpB2gwyMOVM2oHGv2eZrGwIzVqJO0Zsets2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhQ8WeHcVJTUneTq+MRN+kzUWGoXFF55/gIpB97vYeCIkhcPMxMb0tiQYysCmbr+T
	 hgrCcOo39BiOKpoHDAqZ2tLgDUynB1LaXrW1BLfQoW9xuXbWUl7HcEpS/c2fGIZXcy
	 s9ixzKVr5Ij6izaw4gBV1ksP6fQlUcgveXXQaavE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfBYV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729914AbfBYV2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA56213A2;
        Mon, 25 Feb 2019 21:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130117;
        bh=rNmeZzECpB2gwyMOVM2oHGv2eZrGwIzVqJO0Zsets2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lox9upEbpLY81cU6hMv5FF1RQCcdJFlgT6EAqbRlE7iNKyYzWgy0PDsRAaCrscWwv
         2N6ef6wwwDnGL38z8gHNNr0nLyghMiAA/leUrB/m6NN8Vk23ZLH6KvbCCPJ+vvQSTV
         dmtS0lTp7EcsGY8Ws3ma6tjPlyMIfpp6iLTCKR8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.20 005/183] mt76x0u: fix suspend/resume
Date:   Mon, 25 Feb 2019 22:09:38 +0100
Message-Id: <20190225195055.574567882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit d04ca383860bef90a0dab4eb397907f7f05e839e upstream.

We need to reset MCU and do other initializations on resume otherwise
MT7610U device will fail to initialize, what cause system hung due to
USB requests timeouts.

Patch fixes 4.19 -> 4.20 regression.

Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c |   46 +++++++++++++++---------
 1 file changed, 29 insertions(+), 17 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -159,39 +159,49 @@ static const struct ieee80211_ops mt76x0
 	.wake_tx_queue = mt76_wake_tx_queue,
 };
 
-static int mt76x0u_register_device(struct mt76x02_dev *dev)
+static int mt76x0u_init_hardware(struct mt76x02_dev *dev)
 {
-	struct ieee80211_hw *hw = dev->mt76.hw;
 	int err;
 
-	err = mt76u_alloc_queues(&dev->mt76);
-	if (err < 0)
-		goto out_err;
-
-	err = mt76u_mcu_init_rx(&dev->mt76);
-	if (err < 0)
-		goto out_err;
-
 	mt76x0_chip_onoff(dev, true, true);
-	if (!mt76x02_wait_for_mac(&dev->mt76)) {
-		err = -ETIMEDOUT;
-		goto out_err;
-	}
+
+	if (!mt76x02_wait_for_mac(&dev->mt76))
+		return -ETIMEDOUT;
 
 	err = mt76x0u_mcu_init(dev);
 	if (err < 0)
-		goto out_err;
+		return err;
 
 	mt76x0_init_usb_dma(dev);
 	err = mt76x0_init_hardware(dev);
 	if (err < 0)
-		goto out_err;
+		return err;
 
 	mt76_rmw(dev, MT_US_CYC_CFG, MT_US_CYC_CNT, 0x1e);
 	mt76_wr(dev, MT_TXOP_CTRL_CFG,
 		FIELD_PREP(MT_TXOP_TRUN_EN, 0x3f) |
 		FIELD_PREP(MT_TXOP_EXT_CCA_DLY, 0x58));
 
+	return 0;
+}
+
+static int mt76x0u_register_device(struct mt76x02_dev *dev)
+{
+	struct ieee80211_hw *hw = dev->mt76.hw;
+	int err;
+
+	err = mt76u_alloc_queues(&dev->mt76);
+	if (err < 0)
+		goto out_err;
+
+	err = mt76u_mcu_init_rx(&dev->mt76);
+	if (err < 0)
+		goto out_err;
+
+	err = mt76x0u_init_hardware(dev);
+	if (err < 0)
+		goto out_err;
+
 	err = mt76x0_register_device(dev);
 	if (err < 0)
 		goto out_err;
@@ -300,6 +310,8 @@ static int __maybe_unused mt76x0_suspend
 
 	mt76u_stop_queues(&dev->mt76);
 	mt76x0u_mac_stop(dev);
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state);
+	mt76x0_chip_onoff(dev, false, false);
 	usb_kill_urb(usb->mcu.res.urb);
 
 	return 0;
@@ -327,7 +339,7 @@ static int __maybe_unused mt76x0_resume(
 	tasklet_enable(&usb->rx_tasklet);
 	tasklet_enable(&usb->tx_tasklet);
 
-	ret = mt76x0_init_hardware(dev);
+	ret = mt76x0u_init_hardware(dev);
 	if (ret)
 		goto err;
 


