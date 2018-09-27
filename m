Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697122154D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJX9qPZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697122154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeI0Jxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:53:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38489 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeI0Jxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:53:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so4382837wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvpVBSIugyYwOy11C1gq6ha6enLriZdzuMP7PuSA3Qg=;
        b=gJX9qPZCDBz8tIWOIW2sL4W2GiKymjXaz2r333mgbEDTPMi/+vxJnjiUB/+XW+osay
         eor+XsncPhReR1cybng+jIdFpyiY/6VSPX8+wT9OjEH03O1f3QJG1QISNeGWgmtr3X2+
         YxRay3WgZrmlymBqSjdkq8KPh2qtXpyJuRSOpucJOVWEvr328kiS5gklEGzaFkj8fwzr
         ElHryBTE7P54Qjmpf5YCegKbwGoLukwFahrvl2YogxK33NE7Th3YIbjltl8z+L7Uni7k
         fR4b3Qtd/Q9iWuXj0JYSCpDQq0I4FnSZ2sLM8V9ZT2c9ApPB5TYGcv88Vs8Kje2GzETn
         ISaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvpVBSIugyYwOy11C1gq6ha6enLriZdzuMP7PuSA3Qg=;
        b=D4N9rhzbV5TNPxHxKe4j0co9o0/qvuv0jCudjTfq4ffElugnZ5Z9P/MbOG8gHw+UIw
         ++iwId6PfdG+sf1u5B0A4krgj+3cobrPjtZ5yk0s4kGHadORgY/mDmtZ/d9IYBfryRXF
         FcVezXhuj+R4vcsoMwM9f6FBO8raod3qaA1ljBei0E8sGdOUmjegH4zfwhd5odd5XOt5
         I2B0cSIkC+UkYan9cdT0i1D57gMtTSU6B1przQjEv88Lq2KL1ur2eomTXUKzBgGP2Pe1
         F+a1zMUIfmw3DhXNRAAIUZJjxXli5ngTbuvxNwL9zAfDZDWHT3Pts/UiYVSBG101uftE
         OG+A==
X-Gm-Message-State: ABuFfog4SjfMSjSr+lATK18lvAUb6wi7uw6uXFpTODUV+PwqtBplfz8T
        OtaZrZFM8kdI6jV8oS6IWcI=
X-Google-Smtp-Source: ACcGV62k9uzS6SAek3jidO7yyirSPy0VFLxJh8E3Qk+PM7ZNWbskOqxiSaRG4yUwauxB/LzgXgIFEA==
X-Received: by 2002:a1c:9f92:: with SMTP id i140-v6mr3817332wme.19.1538019452672;
        Wed, 26 Sep 2018 20:37:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e127-v6sm1152697wmg.45.2018.09.26.20.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 20:37:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mfd: cros_ec: Avoid unneeded internal declaration warning
Date:   Wed, 26 Sep 2018 20:33:17 -0700
Message-Id: <20180927033316.9784-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/mfd/cros_ec_dev.c:509:40: warning: variable 'cros_ec_id' is not
needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct platform_device_id cros_ec_id[] = {
                                       ^
1 warning generated.

Avoid this warning by adding it to the cros_ec_dev_driver definition
under the id_table member like all other platform drivers.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I looked at several drivers with platform_device_id defintions and I
didn't really find any where the definition wasn't then added to the
platform_driver so I'm not sure if this was just missed in commit
afbf8ec7c4f9 ("platform/chrome: cros_ec_dev - Add a platform
device ID table") or if it was an intentional omission. I'm not super
familiar with the inner workings of platform devices.

Should this commit be undesirable, the warning can be silenced with the
__used attribute but this seemed like a more proper first commit.

 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 999dac752bcc..8f9d6964173e 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -546,6 +546,7 @@ static struct platform_driver cros_ec_dev_driver = {
 		.name = DRV_NAME,
 		.pm = &cros_ec_dev_pm_ops,
 	},
+	.id_table = cros_ec_id,
 	.probe = ec_device_probe,
 	.remove = ec_device_remove,
 	.shutdown = ec_device_shutdown,
-- 
2.19.0

