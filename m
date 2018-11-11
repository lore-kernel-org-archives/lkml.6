Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B630AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F24214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yr/4xFGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F24214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeKLKAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbeKLIR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:27 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB91721582;
        Sun, 11 Nov 2018 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975251;
        bh=HEgQJ+m8ZU14KUYuQ/psMVG1Num6eTHp7nf3G9ciF1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yr/4xFGsLQZf1gYkyejGkXuBQZPt0js/DKhrFagUNBnbLz2qFKjfu8KoYgUAj+1Qw
         vEBY/hVmV/pOprcHJ+Y/VgWkOtRS3denPlrGn6T7PfO4vv/xGjwieDLYUlcW3EyT+v
         CKG+XNOHJqpVGZqDPmt+MWmjtIXpKWkNGKdFEObc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/361] mt76x2u: run device cleanup routine if resume fails
Date:   Sun, 11 Nov 2018 14:17:45 -0800
Message-Id: <20181111221636.512561607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 9b2fd48d36e25b9be9ddb8be8cc1eb263a1d1843 ]

Cleanup {tx,rx} and mcu queues if resume operation fails

Fixes: ee676cd5017c ("mt76: add driver code for MT76x2u based devices")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_usb.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_usb.c
@@ -107,16 +107,24 @@ static int __maybe_unused mt76x2u_resume
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


