Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D256C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB0208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="m6gXzwJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB0208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936332AbeFORNJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:13:09 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:62975 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756275AbeFORNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1529082476; x=1560618476;
  h=from:to:cc:subject:date:message-id;
  bh=oQZqgBvt0nQB+Mwqbb5HTI3I66zH7R/3NylK46JUdU8=;
  b=m6gXzwJVSgYcvdleZ+gqGG+ZcmA7cyeS9mkdhaEkD5JAyvJqOY/yEf3y
   H+Wo2qCtbuxz8WKwTmxfOgi5yA/RAFnldglq8B6Ihs4HId2KuA8B2f3lH
   byw29MSiPz4EEX1eo38+FGkc7l9fFAqcg34Tq9U3wmPTjcWWeoEw0aNYP
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F/AADp8iNbmMmZ6ERbHAEBAQQBAQoBA?=
 =?us-ascii?q?YUpKIt9jFKWboF4C4RsglUhNBgBAgEBAQEBAQIBAQIQAQEBAQEICwsGKS+CNSQ?=
 =?us-ascii?q?Bgn5ST28BEoMiggGrVDOISIFoiEyBVD+BD41XAodQhU6LcAcCgWqNFwKNNQGRQ?=
 =?us-ascii?q?YFBggtwgxOCIQ4JjjVRkFkBAQ?=
X-IPAS-Result: =?us-ascii?q?A2F/AADp8iNbmMmZ6ERbHAEBAQQBAQoBAYUpKIt9jFKWboF?=
 =?us-ascii?q?4C4RsglUhNBgBAgEBAQEBAQIBAQIQAQEBAQEICwsGKS+CNSQBgn5ST28BEoMig?=
 =?us-ascii?q?gGrVDOISIFoiEyBVD+BD41XAodQhU6LcAcCgWqNFwKNNQGRQYFBggtwgxOCIQ4?=
 =?us-ascii?q?JjjVRkFkBAQ?=
Received: from esa1.dell-outbound2.iphmx.com ([68.232.153.201])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 12:07:56 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 23:07:32 +0600
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.51,227,1526360400"; 
   d="scan'208";a="1262692554"
X-DLP:  DLP_GlobalPCIDSS
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: dell-smbios-base: Support systems without tokens
Date:   Fri, 15 Jun 2018 12:12:51 -0500
Message-Id: <1529082771-21309-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Dell servers can use dell-smbios but they don't support the
token interface.  Make it optional.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-smbios-base.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 446dbff..ac88032 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -212,6 +212,12 @@ int dell_smbios_call_filter(struct device *d,
 	if ((buffer->cmd_class == CLASS_TOKEN_READ ||
 	     buffer->cmd_class == CLASS_TOKEN_WRITE) &&
 	     buffer->cmd_select < 3) {
+		/* tokens enabled ? */
+		if (!da_tokens) {
+			dev_dbg(d, "no token support on this system\n");
+			return -EINVAL;
+		}
+
 		/* find the matching token ID */
 		for (i = 0; i < da_num_tokens; i++) {
 			if (da_tokens[i].location != buffer->input[0])
@@ -315,6 +321,9 @@ struct calling_interface_token *dell_smbios_find_token(int tokenid)
 {
 	int i;
 
+	if (!da_tokens)
+		return NULL;
+
 	for (i = 0; i < da_num_tokens; i++) {
 		if (da_tokens[i].tokenID == tokenid)
 			return &da_tokens[i];
@@ -570,11 +579,6 @@ static int __init dell_smbios_init(void)
 
 	dmi_walk(find_tokens, NULL);
 
-	if (!da_tokens)  {
-		pr_info("Unable to find dmi tokens\n");
-		return -ENODEV;
-	}
-
 	ret = platform_driver_register(&platform_driver);
 	if (ret)
 		goto fail_platform_driver;
@@ -588,13 +592,6 @@ static int __init dell_smbios_init(void)
 	if (ret)
 		goto fail_platform_device_add;
 
-	/* duplicate tokens will cause problems building sysfs files */
-	zero_duplicates(&platform_device->dev);
-
-	ret = build_tokens_sysfs(platform_device);
-	if (ret)
-		goto fail_create_group;
-
 	/* register backends */
 	wmi = init_dell_smbios_wmi();
 	if (wmi)
@@ -605,7 +602,16 @@ static int __init dell_smbios_init(void)
 	if (wmi && smm) {
 		pr_err("No SMBIOS backends available (wmi: %d, smm: %d)\n",
 			wmi, smm);
-		goto fail_sysfs;
+		goto fail_create_group;
+	}
+
+	if (da_tokens)  {
+		/* duplicate tokens will cause problems building sysfs files */
+		zero_duplicates(&platform_device->dev);
+
+		ret = build_tokens_sysfs(platform_device);
+		if (ret)
+			goto fail_sysfs;
 	}
 
 	return 0;
@@ -633,7 +639,8 @@ static void __exit dell_smbios_exit(void)
 	exit_dell_smbios_smm();
 	mutex_lock(&smbios_mutex);
 	if (platform_device) {
-		free_group(platform_device);
+		if (da_tokens)
+			free_group(platform_device);
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.7.4

