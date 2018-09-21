Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B8FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702CF21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702CF21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbeIUNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:37:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:46880 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIUNhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:37:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 00:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="90711516"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2018 00:49:30 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, chao.p.peng@intel.com,
        chao.gao@intel.com, isaku.yamahata@intel.com,
        michael.h.kelley@microsoft.com, tianyu.lan@microsoft.com,
        Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v2 1/2] X86/Hyper-V: Add Guest IDLE MSR support
Date:   Fri, 21 Sep 2018 15:25:11 +0800
Message-Id: <1537514712-62434-2-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V may expose a HV_X64_MSR_GUEST_IDLE MSR. We can read
HYPERV_CPUID_FEATURES eax to check it. Read this MSR can
trigger the guest's transition to the idle power state which
can be exited by an IPI even if IF flag is disabled.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e977b6b..2a2fa17 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -38,6 +38,8 @@
 #define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
 /* Partition reference TSC MSR is available */
 #define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
+/* Partition Guest IDLE MSR is available */
+#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		(1 << 10)
 
 /* A partition's reference time stamp counter (TSC) page */
 #define HV_X64_MSR_REFERENCE_TSC		0x40000021
@@ -246,6 +248,9 @@
 #define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT		0x400000B7
 
+/* Hyper-V guest idle MSR */
+#define HV_X64_MSR_GUEST_IDLE			0x400000F0
+
 /* Hyper-V guest crash notification MSR's */
 #define HV_X64_MSR_CRASH_P0			0x40000100
 #define HV_X64_MSR_CRASH_P1			0x40000101
-- 
1.9.1

