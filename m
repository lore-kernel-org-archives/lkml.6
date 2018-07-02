Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3988C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AB25A67
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Np9l3eDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0AB25A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeGBVOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:14:25 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:60105 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeGBVOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:14:17 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 17:14:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1443; q=dns/txt; s=iport;
  t=1530566056; x=1531775656;
  h=from:to:cc:subject:date:message-id;
  bh=wtUlEVqnx0m6+x4eQzBYfO1CY4i8e7LTf93uBA6gtZg=;
  b=Np9l3eDqKfI+mXqwbs9WCd/QaSb27gL0gGCkY2rqKFwR3hox/80BZkRz
   bc3ji0FBFGE+BF0O2Gu1a1LliS5L3rBMXVQs/CjHGvkCSNPwQ6R1Wps5N
   WdZdbFCMX7lo2wMfl85LcG0+7fcBUSgiENPX1tCdno5SycpyUItFGf+lS
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BDAQAukjpb/4YNJK1cGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNJgWEoi32MQJcrgXoLhGyDNiE0GAECAQECAQECbSiGNoE+ARK?=
 =?us-ascii?q?DIIF/AapahFuDdIE2FIhZgVY/g2mEeIYNAo03jA8JjxILjVWSB4FBOIFSMxo?=
 =?us-ascii?q?IGxWDJJByT44/gkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,300,1526342400"; 
   d="scan'208";a="418342066"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 21:04:52 +0000
Received: from sjc-ads-3734.cisco.com (sjc-ads-3734.cisco.com [171.68.250.181])
        by alln-core-12.cisco.com (8.14.5/8.14.5) with ESMTP id w62L4pni024843;
        Mon, 2 Jul 2018 21:04:52 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: add kconfig symbol to configure section size
Date:   Mon,  2 Jul 2018 14:04:50 -0700
Message-Id: <20180702210451.16057-1-nkela@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, section size is fixed to 1024MB. This change
adds a config that would allow it to be customized.
This could be useful in reducing kernel memory usage.

Cc: xe-kernel@external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig                 | 15 +++++++++++++++
 arch/arm64/include/asm/sparsemem.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..edf327f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -687,6 +687,21 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+choice
+	prompt "Section size"
+	default ARM64_SEC_BITS_30
+	help
+	  Choose the maximum amount of memory in a section.
+
+config ARM64_SEC_BITS_30
+	bool "30-bit"
+
+endchoice
+
+config ARM64_SEC_BITS
+	int
+	default 30 if ARM64_SEC_BITS_30
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index b299929..dc8fb4b 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -18,7 +18,7 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
+#define SECTION_SIZE_BITS	CONFIG_ARM64_SEC_BITS
 #endif
 
 #endif
-- 
2.5.0

