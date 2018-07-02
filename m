Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C925065
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TFDx4Dxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155C925065
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeGBVOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:14:17 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:60105 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeGBVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:14:15 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 17:14:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1262; q=dns/txt; s=iport;
  t=1530566054; x=1531775654;
  h=from:to:cc:subject:date:message-id;
  bh=KdN1OkqFY6/LenlgEaQPg241zjchKzZg5vCWiLuFUg8=;
  b=TFDx4DxmruervHtP6VSry6BO28sOZGx0GrocPEJkpLsZ998eygEypP/F
   IZfq+1CrRrBOkDeGnq2GV7WsvcwcDoTEDgPnWe/vDRJGKYyRk75WV3mW1
   PXi0eygzSsT/FJGZHNmdMZVkfPPcy+SlApkZAQxBRErPRMEZEBC70jxxh
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D1AAAukjpb/4YNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoi32MQJcrgXoLhGyDNiE0GAECAQECAQECbSiGNoE?=
 =?us-ascii?q?+ARKDIIF/AapahFuDdIE2FIhZgVY/jm4CjTeMDwmPEguNVZIHgUE4gVIzGgg?=
 =?us-ascii?q?bFYMkkHJPkQcBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,300,1526342400"; 
   d="scan'208";a="418342071"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 21:04:52 +0000
Received: from sjc-ads-3734.cisco.com (sjc-ads-3734.cisco.com [171.68.250.181])
        by alln-core-12.cisco.com (8.14.5/8.14.5) with ESMTP id w62L4pnj024843;
        Mon, 2 Jul 2018 21:04:52 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
Date:   Mon,  2 Jul 2018 14:04:51 -0700
Message-Id: <20180702210451.16057-2-nkela@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 43bit physical address. Additionally,
this patch adds support for 27bit section size. This is useful in
reducing kernel memory usage. One usecase is in kdump kernel.

Cc: xe-kernel@external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index edf327f..76d0bfb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -665,6 +665,9 @@ choice
 	  Choose the maximum physical address range that the kernel will
 	  support.
 
+config ARM64_PA_BITS_43
+	bool "43-bit"
+
 config ARM64_PA_BITS_48
 	bool "48-bit"
 
@@ -684,6 +687,7 @@ endchoice
 
 config ARM64_PA_BITS
 	int
+	default 43 if ARM64_PA_BITS_43
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
@@ -693,6 +697,9 @@ choice
 	help
 	  Choose the maximum amount of memory in a section.
 
+config ARM64_SEC_BITS_27
+	bool "27-bit"
+
 config ARM64_SEC_BITS_30
 	bool "30-bit"
 
@@ -700,6 +707,7 @@ endchoice
 
 config ARM64_SEC_BITS
 	int
+	default 27 if ARM64_SEC_BITS_27
 	default 30 if ARM64_SEC_BITS_30
 
 config CPU_BIG_ENDIAN
-- 
2.5.0

