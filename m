Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566A42083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566A42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIAQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:58:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39343 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeIAQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:58:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so7673672wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+e7PacGEQJyefIybs72FItPu9MA3wQVdBoFJ1XZSXrw=;
        b=j6GvEjLxy/Ate8PH8h+DtY9J4GEyVq1cDuAg1dQEy1x7eRkV/8NkvGLFBsF3EA5tc3
         uAk71Nl3xbGpgRuKHgJq4mKDbn5wNW6WZtnHqpawttT98TTIk1ilQ1imG5qCj3C9aFvl
         z8MW/Tp8dhwh7aelMkYP6jCkfIBiPSffo5bjMmXQbtwA2S1/uqqQtOlme1//WfgvSt2g
         JWomFwdl0E0KVh5Off8vjfREh8CsBhMMelCVtWx8B9Cu26gqp5+xbRbfVSyfT0qmiMal
         M7evqHn+jtEIl0Uo96AQhCPVluo+nMurHeBOUdQ5TPhQ6DQrnMhNZt5OETEPUSw7GJa/
         iECw==
X-Gm-Message-State: APzg51CBuGAoa8EciKtQ5lIpESb7zpSLT6RJb8Jnkqpi9NdbWv1rO8I4
        7KzfpKMwxLPwLR/CVFUfL57EhcY2taA=
X-Google-Smtp-Source: ANB0VdZ0lLlB54ENGLHuvzrUdHg/wohlwyZKdJslqNwMpv5DSkO9WQsidDlrjFHVim8a3WUsTBqRwA==
X-Received: by 2002:a1c:230f:: with SMTP id j15-v6mr696485wmj.124.1535805996523;
        Sat, 01 Sep 2018 05:46:36 -0700 (PDT)
Received: from minerva.home ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id q3-v6sm8515547wma.45.2018.09.01.05.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 05:46:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v2 1/2] media: ov2680: don't register the v4l2 subdevice before checking chip ID
Date:   Sat,  1 Sep 2018 14:46:29 +0200
Message-Id: <20180901124630.14139-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver registers the v4l2 subdevice before attempting to power on the
chip and checking its ID. This means that a media device driver that it's
waiting for this subdevice to be bound, will prematurely expose its media
device node to userspace because if something goes wrong the media entity
will be cleaned up again on the ov2680 probe function.

This also simplifies the probe function error path since no initialization
is made before attempting to enable the resources or checking the chip ID.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

Changes in v2:
- Just move ov2680_check_id() before ov2680_v4l2_init() - Suggested by Sakari.

 drivers/media/i2c/ov2680.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index f753a1c333ef..3ccd584568fb 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1088,26 +1088,20 @@ static int ov2680_probe(struct i2c_client *client)
 
 	mutex_init(&sensor->lock);
 
-	ret = ov2680_v4l2_init(sensor);
+	ret = ov2680_check_id(sensor);
 	if (ret < 0)
 		goto lock_destroy;
 
-	ret = ov2680_check_id(sensor);
+	ret = ov2680_v4l2_init(sensor);
 	if (ret < 0)
-		goto error_cleanup;
+		goto lock_destroy;
 
 	dev_info(dev, "ov2680 init correctly\n");
 
 	return 0;
 
-error_cleanup:
-	dev_err(dev, "ov2680 init fail: %d\n", ret);
-
-	media_entity_cleanup(&sensor->sd.entity);
-	v4l2_async_unregister_subdev(&sensor->sd);
-	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
-
 lock_destroy:
+	dev_err(dev, "ov2680 init fail: %d\n", ret);
 	mutex_destroy(&sensor->lock);
 
 	return ret;
-- 
2.17.1

