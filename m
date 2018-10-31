Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABFA2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR4sYufq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABFA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeKAIHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbeKAIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED5D20840;
        Wed, 31 Oct 2018 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027209;
        bh=yOJIyMrtPXFaP5aSToUv5MgueleK1Q5RK+u6smJ/9tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KR4sYufqSE+oTFn8EPp0PZiPg+zbKOmfOWPQ2H1RpOYtKF3kFq3BRDXzr3G3uT5ga
         o1wtxVVga0L3v8qzAD1OC088/8mg/OPAdr2QT10OM/knGpRTC01quQnUZlb/VZ2/HY
         LAZAKfKMqLJIIImIImtY9zQzjPeAX3kMybMVfQ90=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 073/146] mt76x2u: run device cleanup routine if resume fails
Date:   Wed, 31 Oct 2018 19:04:28 -0400
Message-Id: <20181031230541.28822-73-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 9b2fd48d36e25b9be9ddb8be8cc1eb263a1d1843 ]

Cleanup {tx,rx} and mcu queues if resume operation fails

Fixes: ee676cd5017c ("mt76: add driver code for MT76x2u based devices")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_usb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c
index 1428cfdee579..9594433234cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c
@@ -107,16 +107,24 @@ static int __maybe_unused mt76x2u_resume(struct usb_interface *intf)
 			       mt76u_mcu_complete_urb,
 			       &usb->mcu.cmpl);
 	if (err < 0)
-		return err;
+		goto err;
 
 	err = mt76u_submit_rx_buffers(&dev->mt76);
 	if (err < 0)
-		return err;
+		goto err;
 
 	tasklet_enable(&usb->rx_tasklet);
 	tasklet_enable(&usb->tx_tasklet);
 
-	return mt76x2u_init_hardware(dev);
+	err = mt76x2u_init_hardware(dev);
+	if (err < 0)
+		goto err;
+
+	return 0;
+
+err:
+	mt76x2u_cleanup(dev);
+	return err;
 }
 
 MODULE_DEVICE_TABLE(usb, mt76x2u_device_table);
-- 
2.17.1

