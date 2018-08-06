Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F55C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE42321A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDKnSu+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE42321A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbeHFTUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:20:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36301 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHFTUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:20:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so6513183pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uezdt7oHvbRvV99+8KISNdCU5ZABu30Joz22fKYw6A=;
        b=QDKnSu+WqdAMc++4w3Wi57Icm4gmKWSE5J2Rf8SsPI9rwKtXjAD+JIY7G0K+M+M3B1
         eGor5FF/crtd1yIiWzCUrwraf5+sadmKa8I1jIYwwkJAjRFY/05jKOSiJ/kAKTRM6Qo9
         8bY+5GWhR9aIYXiBVC9ATQFAtcZMNqkyMI8gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uezdt7oHvbRvV99+8KISNdCU5ZABu30Joz22fKYw6A=;
        b=S9u8soEvLl64PTwfAXyKcVU0Pu+v4zvB98RudQak+W33dqwe+frYEsDs2doP5hKsDq
         dy0BatoTMP3StPzXe+4bEqB40XyrgWoqSrw9YjPbrwI0NxXokwTbg78ijyJpXbbpJrZ8
         xEYqvtVMfWdFNMhWEleTLUUDx93KfAlsSTIcLkSFaYwUpontQamhKPp7RPrRwFNeKnY3
         CLilNowQVbR2LO189wub/CtWIuVfFMnNCWjsUOrDwbFDt09cyYqpUTN5dcKr+iPlCn+u
         FtkGC7ux/L4uFaxNA0raT00O4t8zFGsUM66+Z8im04rcAz+ZnI8JXTu6omPhr9ysUwBq
         RCcw==
X-Gm-Message-State: AOUpUlGU14FVpmR71xtDSdKfkuOhj/fbpIrDegZkZQaLzQgeIV9p+sFD
        9u0eYUJ5ZlfIpRtFhPFiJt2XrA==
X-Google-Smtp-Source: AAOMgpeCLoZvRj2UXx99vG6gTRIE/MXfcPy1eTk2DFqjPskk+EU9xo2PjUtF1VXafUNTmA9eexugaw==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr12559001pfo.160.1533575450049;
        Mon, 06 Aug 2018 10:10:50 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id c3-v6sm12383333pgw.79.2018.08.06.10.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 10:10:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH] firmware: coreboot: Let OF core populate platform device
Date:   Mon,  6 Aug 2018 10:10:47 -0700
Message-Id: <20180806171047.227835-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
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
be registered, and this driver will never bind. At the same time, we can
move this driver to use platform device APIs instead of DT specific ones
and drop the of_node handling that was presumably placed there to hold a
reference to the DT node created during module init.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table-of.c | 39 +++++----------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
index f15bf404c579..270f112bdc54 100644
--- a/drivers/firmware/google/coreboot_table-of.c
+++ b/drivers/firmware/google/coreboot_table-of.c
@@ -18,21 +18,20 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "coreboot_table.h"
 
 static int coreboot_table_of_probe(struct platform_device *pdev)
 {
-	struct device_node *fw_dn = pdev->dev.of_node;
 	void __iomem *ptr;
+	struct resource *res;
 
-	ptr = of_iomap(fw_dn, 0);
-	of_node_put(fw_dn);
-	if (!ptr)
-		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ptr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 
 	return coreboot_table_init(&pdev->dev, ptr);
 }
@@ -44,8 +43,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
 
 static const struct of_device_id coreboot_of_match[] = {
 	{ .compatible = "coreboot" },
-	{},
+	{}
 };
+MODULE_DEVICE_TABLE(of, coreboot_of_match);
 
 static struct platform_driver coreboot_table_of_driver = {
 	.probe = coreboot_table_of_probe,
@@ -55,28 +55,7 @@ static struct platform_driver coreboot_table_of_driver = {
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

