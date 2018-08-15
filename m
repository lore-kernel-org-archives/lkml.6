Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FE821545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MIbe0g8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FE821545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHOXaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:30:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHOXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:30:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10-v6so1002297pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N93Umr1PtltKX3rdSyESxkH6iUGNbJzMgXbN0NnvBFM=;
        b=MIbe0g8enAWUMNof8lj00l2GUY0Qh8QhVuIM89rYfwaj5I5WkqMiz4JC0s1UcNvheY
         Upbcx1rmdcyVj6zwaHels4z6f8sJsXvnsWu8Tys8LHgXshmI+egXWNz9/2NgIRHOV4UD
         eIUbZcnQ8AxAFsYwkht6ZTaYthf+dov8ChQk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N93Umr1PtltKX3rdSyESxkH6iUGNbJzMgXbN0NnvBFM=;
        b=o0UWmr7W0lWtuzMUkOf0yOLYpo2DGckxsdVNUT0OFFvIsTyBhue+zkGZju5hGB4cs/
         6YWuBPw+oIdQX3zwrPJbKcWrvSy/NujmMHy1mxOB40vXpsWcMN1waZmMPEFTk1kzXT6x
         cRnvfPH33nr1RK3JdzVebz1qM++lD1tdCBDREp0YpVcxHnpSPUJmuFnW1jilgIGgX+cv
         p6RZhq7fvLUoqQDNpuLf008ieODui2g2Us8oCI28MAArrQKtbg59U4UYfYm8m669g4kO
         rU89GFeOy8HTQLUzcIOjYcLslUiHqgoU4C1lY2AIR22V9DO1YCORaDnftHbjArCf0+cV
         3spQ==
X-Gm-Message-State: AOUpUlGEra+1h9ARZLA8MThDuwmLhZvVtZydz2RLjK+MBI5jVHVzEcYR
        M0lp6AxVCZh+5oMZNYfLBuj80w==
X-Google-Smtp-Source: AA+uWPx/oDVY2w79KDz7LVLmu5SfY8GIc1Y+WxKxgkUlaZKFnEKHFX6AJLu6fyqGedNi9BsDJsssxg==
X-Received: by 2002:a63:416:: with SMTP id 22-v6mr26523280pge.229.1534365430858;
        Wed, 15 Aug 2018 13:37:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z20-v6sm54606269pfd.99.2018.08.15.13.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:37:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 1/6] firmware: coreboot: Let OF core populate platform device
Date:   Wed, 15 Aug 2018 13:37:03 -0700
Message-Id: <20180815203708.67090-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
References: <20180815203708.67090-1-swboyd@chromium.org>
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Reviewed-by: Sudeep Holla <Sudeep.Holla@arm.com>
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

