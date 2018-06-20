Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A0EC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020F2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsQV64tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B020F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeFTVan (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:30:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40381 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933225AbeFTVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:30:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so417394pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgSCB4isTDVSYWExFAyHvy2VZT4QH2lt+XXJidUqjsc=;
        b=SsQV64tUgew5oVWR6D/6Blc7xydvHR4vK7+2NbD17/g2dLXeILekN5xV5NZ1BDckzC
         3WTQqhq+g9yDJ561vW0cBD0CnQY9l8TGpnNANwOzDAwFN51RhcZaB0FE5zOrZEE6gyEK
         zi+Du2aIHpLZihdO87kELOql8uVrSH0YEp35fGSphy1xL8o9AELrZYfLTsc0oWDXM5sw
         VrUbMmkVvAV35u63ssa+jo9C6DeyD+DvNeL97XcFYEr12btMd61ptk4KhFEekq3ybzJG
         GlXuhUQO/L9qbwYybEWYv7qbz41Iz0q5bA9U8qgqY+SpQQw3hKv4BkPtvxCKs7NZOmRn
         Zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgSCB4isTDVSYWExFAyHvy2VZT4QH2lt+XXJidUqjsc=;
        b=uSM86VSFQ82ao3d+KOkVuvKKIPYYiPVaFGMYpuNTjRcJjbMtLqRYxWbjRzH/qeMFtA
         WiP4Y/cDmes43+B3IJyvzA82KOxuPKDOizGKSCNdbbKJMp2AZSk9VzSaMoQUwTaon02y
         kaIXMfEmIimTqW2M+M+SfxFD5Rv57IC2Hg5xBxdTTHwfXGBRQvnMRSbzYuGEES/FT61U
         JY2mLGvf6cxSqgpbrP1U5Ah09FAj4KPSAGP31Ot7sLsRPNxQPnvT2jN74/HFYU5NVG0/
         lTRSRWlch7xKwoqERw7kVX9u/bAmBRYyTk1jbp8NaKEDvDdrHQKCxraysB8SiuEP/iFU
         9PwA==
X-Gm-Message-State: APt69E0yEA7unRwXMWrItEMXDzcXnrnQqgF/8g/jlk1aByZR7Qx+oKIX
        TasnpEagIh2zOQJxODorryQ=
X-Google-Smtp-Source: ADUXVKLwlMfyfRjwAfLNJILJ3iqrCHS9jotwBUc2PpVF9V4ZU6w/urtFggWwiU66r6MLBoswrG/DYw==
X-Received: by 2002:a62:1855:: with SMTP id 82-v6mr24560525pfy.132.1529530239811;
        Wed, 20 Jun 2018 14:30:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id z74-v6sm8228028pff.54.2018.06.20.14.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 14:30:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 2/2] Revert "mfd: cros_ec: Use devm_kzalloc for private data"
Date:   Wed, 20 Jun 2018 14:30:33 -0700
Message-Id: <20180620213033.100455-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
References: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.

Linux device objects are refcounted and thus should not be allocated
with devm API as they may outlive the timeframe of another device being
bound to a driver.
---
 drivers/mfd/cros_ec_dev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 4b1dbe81fcb6..bd4d4e7ec040 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -262,7 +262,12 @@ static const struct file_operations fops = {
 #endif
 };
 
-static void __remove(struct device *dev) { }
+static void __remove(struct device *dev)
+{
+	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
+					      class_dev);
+	kfree(ec);
+}
 
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
@@ -388,7 +393,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	int retval = -ENOMEM;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
-	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
 
 	if (!ec)
 		return retval;
@@ -410,6 +415,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
+	ec->class_dev.release = __remove;
 
 	retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
 	if (retval) {
-- 
2.18.0.rc1.244.gcf134e6275-goog

