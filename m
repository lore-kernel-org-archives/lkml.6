Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF232083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF232083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeHaT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:27:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36914 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeHaT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:27:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so11548010wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YMd+w6xu6z5E6UfjvFxCMon3HjXziUFla9i/JhUAeyI=;
        b=aQcNBLAe63rVvApNCX7FMwH1uRMpN65x1s+mtUsGM0FTWwPTu3s7PeyAWCFHCmoj4h
         FHCB5pfRMB/0UpQ2DW+hBuv/O3QSagBs239A4pnS6MvC1MSNK0na8TrCwzfNuVCK/Zo0
         HBUKTKvzGOFhw00gmWhZCYqUY9+mLpZJin4BZkUD2IhWWdwyPAuDRldcFuiCw82fRR5+
         uQy2RaboCSUjPiSEfaRGU/gyqAlyVEWo0rXz1S0HVqbws91TNqAaFCqvU0e1ygCTmOmC
         SUgr/Ux9/Wg6Rrl8DNxTSpi2sZ/oCkDmUtM0lXQkni16CYueCBgkZSu+lxydePWx6cMX
         wa6A==
X-Gm-Message-State: APzg51A9ZGn4XVsCByzCxPI9CV9s6aOEJ5GrXVEEx+drEvMFS8mRjjZE
        A9XfOSS95DyhUHH65hsPgYpzi8hrfSI=
X-Google-Smtp-Source: ANB0VdZ9aRhrN6ckmFswpdH1PiAiKOXoqocvGG29uniVqoNZUeuYtKmzNdHqaj1lonMB6EgFpLpTRQ==
X-Received: by 2002:adf:82c3:: with SMTP id 61-v6mr11610326wrc.131.1535728754888;
        Fri, 31 Aug 2018 08:19:14 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id q3-v6sm5788904wma.45.2018.08.31.08.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:19:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ov2680: register the v4l2 subdev async at the end of probe
Date:   Fri, 31 Aug 2018 17:19:06 +0200
Message-Id: <20180831151906.9315-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver registers the subdev async in the middle of the probe function
but this has to be done at the very end of the probe function to prevent
registering a device whose probe function could fail (i.e: the clock and
regulators enable can fail, the I2C transfers could return errors, etc).

It could also lead to a media device driver that is waiting to bound the
v4l2 subdevice to incorrectly expose its media device to userspace, since
the subdev is registered but later its media entity is cleaned up on error.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/media/i2c/ov2680.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index f753a1c333ef..2ef920a17278 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -983,10 +983,6 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
 
 	sensor->sd.ctrl_handler = hdl;
 
-	ret = v4l2_async_register_subdev(&sensor->sd);
-	if (ret < 0)
-		goto cleanup_entity;
-
 	return 0;
 
 cleanup_entity:
@@ -1096,6 +1092,10 @@ static int ov2680_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto error_cleanup;
 
+	ret = v4l2_async_register_subdev(&sensor->sd);
+	if (ret < 0)
+		goto error_cleanup;
+
 	dev_info(dev, "ov2680 init correctly\n");
 
 	return 0;
@@ -1104,7 +1104,6 @@ static int ov2680_probe(struct i2c_client *client)
 	dev_err(dev, "ov2680 init fail: %d\n", ret);
 
 	media_entity_cleanup(&sensor->sd.entity);
-	v4l2_async_unregister_subdev(&sensor->sd);
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 
 lock_destroy:
-- 
2.17.1

