Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FEB20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SoKym7/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FEB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeKSITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:19:50 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52514 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeKSITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mPX0rLvb/DOshuMsfaOMGkmitlEwJKs/scCkkhfcO5g=; b=SoKym7/VE5PxI1/wCBiJbjY3O
        kor9ZNJfMAsuiNWbvfTCoOMIykKPRcJK0NW1jYdW3f5ARhPzNRohHm6GGIw7Bg8txTccYIMFSS+6K
        5hukhNImG8MON+xALKh6MTOo6TDHc89Bjvd/DbclkpS/RWMDlHXm8A+APnyOnC5NWGYhg=;
Received: from p200300ccfbe8ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbe8:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV55-00077o-Eh; Sun, 18 Nov 2018 22:58:15 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV55-0003D8-3D; Sun, 18 Nov 2018 22:58:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/5] gnss: sirf: write data to gnss only when the gnss device is open
Date:   Sun, 18 Nov 2018 22:57:57 +0100
Message-Id: <20181118215801.12280-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181118215801.12280-1-andreas@kemnade.info>
References: <20181118215801.12280-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The api forbids writing data there otherwise. Prepare for the
serdev_open()/close() being a part of runtime pm.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/sirf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 79cb98950013..b5efbb062316 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -34,6 +34,7 @@ struct sirf_data {
 	struct gpio_desc *wakeup;
 	int irq;
 	bool active;
+	bool opened;
 	wait_queue_head_t power_wait;
 };
 
@@ -43,6 +44,7 @@ static int sirf_open(struct gnss_device *gdev)
 	struct serdev_device *serdev = data->serdev;
 	int ret;
 
+	data->opened = true;
 	ret = serdev_device_open(serdev);
 	if (ret)
 		return ret;
@@ -54,6 +56,7 @@ static int sirf_open(struct gnss_device *gdev)
 	if (ret < 0) {
 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
 		pm_runtime_put_noidle(&serdev->dev);
+		data->opened = false;
 		goto err_close;
 	}
 
@@ -73,6 +76,7 @@ static void sirf_close(struct gnss_device *gdev)
 	serdev_device_close(serdev);
 
 	pm_runtime_put(&serdev->dev);
+	data->opened = false;
 }
 
 static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
@@ -105,7 +109,17 @@ static int sirf_receive_buf(struct serdev_device *serdev,
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
 
-	return gnss_insert_raw(gdev, buf, count);
+	/*
+	 * we might come here everytime when runtime is resumed
+	 * and data is received. Two cases are possible
+	 * 1. device is opened during initialisation
+	 * 2. kernel is compiled without runtime pm
+	 *    and device is opened all the time
+	 */
+	if (data->opened)
+		return gnss_insert_raw(gdev, buf, count);
+
+	return 0;
 }
 
 static const struct serdev_device_ops sirf_serdev_ops = {
-- 
2.11.0

