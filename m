Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3223ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53216214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L9WQiaLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53216214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJQP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:58:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14465 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:58:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6ecd70000>; Wed, 17 Oct 2018 01:03:35 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 01:03:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 01:03:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 08:03:31 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 08:03:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Oct 2018 08:03:30 +0000
Received: from prpatel-System-Product-Name.nvidia.com (Not Verified[10.24.229.63]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bc6ecd00000>; Wed, 17 Oct 2018 01:03:30 -0700
From:   Prateek Patel <prpatel@nvidia.com>
To:     <catalin.marinas@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-tegra@vger.kernel.org>, <snikam@nvidia.com>,
        <vdumpa@nvidia.com>, <talho@nvidia.com>, <swarren@nvidia.com>,
        <prpatel@nvidia.com>, "Sri Krishna chowdary" <schowdary@nvidia.com>
Subject: [PATCH] kmemleak: Add config to select auto scan
Date:   Wed, 17 Oct 2018 13:33:28 +0530
Message-ID: <1539763408-22085-1-git-send-email-prpatel@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539763415; bh=ynQt3JpL6UcVlULe3g/L1fR5EB/M0ItkbnrVl7SdaTE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=L9WQiaLUwkcN3ygi9lz46ZPqxDRyCpHOf1S86zkM3WTGTroWvKY2jvd6v1/xvD+ut
         kig6l+NOaP0dUyotTKAEZiBvQYMN5a6BBISq5mkGXbGfdiT8oX9Ygik7q94vG6MVJD
         gdl0hGcSosVcVDjPMnwbJqVkmcKABziHZO+SH7oa9AXQfJJdTpU95kfGkxp+Yn2hEz
         jJWAYPoWIKLxaGf2dHPD9ZBDciWFyXvOGYkgD8Oe1b6EG3Wce24/Y2OFC72PuHxQRf
         sFRa1C2geT8DnEuh1tL/FSE3OyxDvgfYNX/6ikXSIJlPWxUeMlpAD1G9jvplvLKJKQ
         WKGtxyzDX8L6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sri Krishna chowdary <schowdary@nvidia.com>

Kmemleak scan is cpu intensive and can stall user tasks at times.
To prevent this, add config DEBUG_KMEMLEAK_SCAN_ON to enable/disable
auto scan on boot up.
Also protect first_run with CONFIG_DEBUG_KMEMLEAK_SCAN_ON as this is
meant for only first automatic scan.

Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
Signed-off-by: Sachin Nikam <snikam@nvidia.com>
Signed-off-by: Prateek <prpatel@nvidia.com>
---
 lib/Kconfig.debug | 11 +++++++++++
 mm/kmemleak.c     |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5e7c03..9542852 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -593,6 +593,17 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
 	  Say Y here to disable kmemleak by default. It can then be enabled
 	  on the command line via kmemleak=on.
 
+config DEBUG_KMEMLEAK_SCAN_ON
+	bool "Enable kmemleak auto scan thread on boot up"
+	default y
+	depends on DEBUG_KMEMLEAK
+	help
+	  Kmemleak scan is cpu intensive and can stall user tasks at times.
+	  This option enables/disables automatic kmemleak scan at boot up.
+
+	  Say N here to disable kmemleak auto scan thread to stop automatic
+	  scanning.
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL && !IA64
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 877de4f..ac53678 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1647,11 +1647,14 @@ static void kmemleak_scan(void)
  */
 static int kmemleak_scan_thread(void *arg)
 {
+#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
 	static int first_run = 1;
+#endif
 
 	pr_info("Automatic memory scanning thread started\n");
 	set_user_nice(current, 10);
 
+#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
 	/*
 	 * Wait before the first scan to allow the system to fully initialize.
 	 */
@@ -1661,6 +1664,7 @@ static int kmemleak_scan_thread(void *arg)
 		while (timeout && !kthread_should_stop())
 			timeout = schedule_timeout_interruptible(timeout);
 	}
+#endif
 
 	while (!kthread_should_stop()) {
 		signed long timeout = jiffies_scan_wait;
@@ -2141,9 +2145,11 @@ static int __init kmemleak_late_init(void)
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
 	mutex_lock(&scan_mutex);
 	start_scan_thread();
 	mutex_unlock(&scan_mutex);
+#endif
 
 	pr_info("Kernel memory leak detector initialized\n");
 
-- 
2.1.4

