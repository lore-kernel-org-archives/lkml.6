Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F57C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15B5205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SRKtTg9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15B5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeJWC2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:28:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17073 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbeJWC2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:28:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bce12340000>; Mon, 22 Oct 2018 11:08:52 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Oct 2018 11:08:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Oct 2018 11:08:59 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Oct
 2018 18:08:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Oct 2018 18:08:59 +0000
Received: from prpatel-System-Product-Name.nvidia.com (Not Verified[10.24.229.63]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bce12380000>; Mon, 22 Oct 2018 11:08:59 -0700
From:   Prateek Patel <prpatel@nvidia.com>
To:     <catalin.marinas@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-tegra@vger.kernel.org>, <snikam@nvidia.com>,
        <vdumpa@nvidia.com>, <talho@nvidia.com>, <swarren@nvidia.com>,
        <prpatel@nvidia.com>, Sri Krishna chowdary <schowdary@nvidia.com>
Subject: [PATCH V2] kmemleak: Add config to select auto scan
Date:   Mon, 22 Oct 2018 23:38:43 +0530
Message-ID: <1540231723-7087-1-git-send-email-prpatel@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540231732; bh=gUUILHBVOLMP9cQJM58PswCXRezagqDyQqQND/HH+NE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=SRKtTg9Aep7PEy5+fYnCwtGIRiek1mII8Aed7pKbye0fg2btgER4iW3ukD0VOHoiV
         Xj63dwSXkLCYZVyv42W92ai+wYR0wXEMmN3KCvQcHacb3qSrcUQiDkUSfpqVdaZ5A6
         qXPhFfmgqYAkqoXdQ2mhzyixT8FAiucC7vWGW44KwMgytNqGWb5Zs6olEKjsiVqjYW
         m0ij0J+b0G1xDn4gzDyBXjxgIMrc19rTcJ5baUikCn0J1rvg3PwSYdgHNVTLwCVtlg
         X439OJdFFXMHaenz+YIqw2rJuGIZLorrKV2ALlMTye18Zk0vKfKOdKEkw4hPaH2A6T
         jqSHaDCZAwMxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sri Krishna chowdary <schowdary@nvidia.com>

Kmemleak scan can be cpu intensive and can stall user tasks at times.
To prevent this, add config DEBUG_KMEMLEAK_AUTO_SCAN to enable/disable
auto scan on boot up.
Also protect first_run with DEBUG_KMEMLEAK_AUTO_SCAN as this is meant
for only first automatic scan.

Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
Signed-off-by: Sachin Nikam <snikam@nvidia.com>
Signed-off-by: Prateek <prpatel@nvidia.com>
---
v2:
* change config name to DEBUG_KMEMLEAK_AUTO_SCAN from DEBUG_KMEMLEAK_SCAN_ON
* use IS_ENABLED(...) instead of #ifdef ...
* update commit message according to config name
---
 lib/Kconfig.debug | 15 +++++++++++++++
 mm/kmemleak.c     | 10 ++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c958013..a14166d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -593,6 +593,21 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
 	  Say Y here to disable kmemleak by default. It can then be enabled
 	  on the command line via kmemleak=on.
 
+config DEBUG_KMEMLEAK_AUTO_SCAN
+	bool "Enable kmemleak auto scan thread on boot up"
+	default y
+	depends on DEBUG_KMEMLEAK
+	help
+	  Depending on the cpu, kmemleak scan may be cpu intensive and can
+	  stall user tasks at times. This option enables/disables automatic
+	  kmemleak scan at boot up.
+
+	  Say N here to disable kmemleak auto scan thread to stop automatic
+	  scanning. Disabling this option disables automatic reporting of
+	  memory leaks.
+
+	  If unsure, say Y.
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL && !IA64
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 877de4f..a614930 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1647,7 +1647,7 @@ static void kmemleak_scan(void)
  */
 static int kmemleak_scan_thread(void *arg)
 {
-	static int first_run = 1;
+	static int first_run = IS_ENABLED(CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN);
 
 	pr_info("Automatic memory scanning thread started\n");
 	set_user_nice(current, 10);
@@ -2141,9 +2141,11 @@ static int __init kmemleak_late_init(void)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&scan_mutex);
-	start_scan_thread();
-	mutex_unlock(&scan_mutex);
+	if (IS_ENABLED(CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN)) {
+		mutex_lock(&scan_mutex);
+		start_scan_thread();
+		mutex_unlock(&scan_mutex);
+	}
 
 	pr_info("Kernel memory leak detector initialized\n");
 
-- 
2.1.4

