Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0477B21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNp5HuQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0477B21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeHHTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:44:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37369 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:44:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so1471014pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLYtl6Yye1J6evlszTweUjzH/hlVZrMfBhW5aytAPZI=;
        b=JNp5HuQGVSxwleAFcO4nzA0SflX28n+BSrJdRfbQ8tnHr9JyFFPynFiHYUczCRNPT2
         NxexsHpBUvuAsTacZ9V8QC9QR53LKwH54IMOpmoOACw+QBaWhu7TcYD+W2OB274ydx7T
         TBNla6lDWgrmAf1QPtQmLKo5sCB41XWkW8Hhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLYtl6Yye1J6evlszTweUjzH/hlVZrMfBhW5aytAPZI=;
        b=IOPdzksqO7pD4rF3AeVE9kGfhIkvHYtde5OwBG2ji/Y7f3Tzv4UIQ06E6xesxD8ldF
         RVBzB73TkFYoHakgbaJoOkiIkc8hs7QTjUclFxFuOKNyCnUZg5mzgqMKJ9JjhA8IPjNS
         hUI654jXivJi4UkipA6dqBLyBl/98iStBZ6jxV+cjSHxbP323vJdxZKyA0//apSz/JGJ
         VSbAwib26Rl04YQV7CrhOh4DM7+VgZqp8mVWmx3Ry0S6RFFzJgFhbFVKSy4C1BvLC2bU
         h6ZAdqhI+Z/snP6c+jbZOXF5PIFxN0IsaDqeqvvrJtsRYuuRWSZgXOyOzTWlVWBkoD4w
         7xWg==
X-Gm-Message-State: AOUpUlFZqk1PeJIDqmEjsu3FfSpb6WmFiuHv0cdmvyLvAxBpa7jnj0ka
        2vYQeEJqEFeakM7QvueEmBTptg==
X-Google-Smtp-Source: AA+uWPylaVPDpOpXN5mYzaDq8AELljf7R6TMtrXqGutLqokzkbA9Is4eewSods1VxEhjedY0rRLXtA==
X-Received: by 2002:a63:9311:: with SMTP id b17-v6mr3404868pge.261.1533749057147;
        Wed, 08 Aug 2018 10:24:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9679503pfm.145.2018.08.08.10.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 10:24:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [PATCH v2 1/2] firmware: coreboot: Let OF core populate platform device
Date:   Wed,  8 Aug 2018 10:24:13 -0700
Message-Id: <20180808172414.29983-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180808172414.29983-1-swboyd@chromium.org>
References: <20180808172414.29983-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the /firmware/coreboot node in DT is populated by the core DT
platform code with commit 3aa0582fdb82 ("of: platform: populate
/firmware/ node from of_platform_default_populate_init()") we should and
can remove the platform device creation here. Otherwise, the
of_platform_device_create() call will fail, the coreboot of driver won't
be registered, and this driver will never bind. At the same time, we
should move this driver to use MODULE_DEVICE_TABLE so that module
auto-load works properly when the coreboot device is auto-populated and
we should drop the of_node handling that was presumably placed here to
hold a reference to the DT node created during module init that no
longer happens.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>
Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table-of.c | 28 +++------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
index f15bf404c579..9b90c0fa4a0b 100644
--- a/drivers/firmware/google/coreboot_table-of.c
+++ b/drivers/firmware/google/coreboot_table-of.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include "coreboot_table.h"
@@ -30,7 +29,6 @@ static int coreboot_table_of_probe(struct platform_device *pdev)
 	void __iomem *ptr;
 
 	ptr = of_iomap(fw_dn, 0);
-	of_node_put(fw_dn);
 	if (!ptr)
 		return -ENOMEM;
 
@@ -44,8 +42,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
 
 static const struct of_device_id coreboot_of_match[] = {
 	{ .compatible = "coreboot" },
-	{},
+	{}
 };
+MODULE_DEVICE_TABLE(of, coreboot_of_match);
 
 static struct platform_driver coreboot_table_of_driver = {
 	.probe = coreboot_table_of_probe,
@@ -55,28 +54,7 @@ static struct platform_driver coreboot_table_of_driver = {
 		.of_match_table = coreboot_of_match,
 	},
 };
-
-static int __init platform_coreboot_table_of_init(void)
-{
-	struct platform_device *pdev;
-	struct device_node *of_node;
-
-	/* Limit device creation to the presence of /firmware/coreboot node */
-	of_node = of_find_node_by_path("/firmware/coreboot");
-	if (!of_node)
-		return -ENODEV;
-
-	if (!of_match_node(coreboot_of_match, of_node))
-		return -ENODEV;
-
-	pdev = of_platform_device_create(of_node, "coreboot_table_of", NULL);
-	if (!pdev)
-		return -ENODEV;
-
-	return platform_driver_register(&coreboot_table_of_driver);
-}
-
-module_init(platform_coreboot_table_of_init);
+module_platform_driver(coreboot_table_of_driver);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
-- 
Sent by a computer through tubes

