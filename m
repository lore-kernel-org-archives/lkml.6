Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF7C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774542082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774542082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeK0WNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:13:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:5178 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeK0WNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:13:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 03:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="114082880"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 03:16:14 -0800
From:   Luming Yu <luming.yu@intel.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spurious check tace point
Date:   Tue, 27 Nov 2018 13:16:12 +0200
Message-Id: <20181127111612.74578-2-luming.yu@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181127111612.74578-1-luming.yu@intel.com>
References: <20181127111612.74578-1-luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a trace point for debugging spurious fault problem.

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Yongkai Wu <yongkaiwu@tencent.com>
---
 arch/x86/include/asm/trace/exceptions.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c                     |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 69615e387973..0cae50c5fcb2 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -44,6 +44,36 @@ DEFINE_EVENT_FN(x86_exceptions, name,				\
 DEFINE_PAGE_FAULT_EVENT(page_fault_user);
 DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
 
+DECLARE_EVENT_CLASS(spurious_fault_check,
+
+	TP_PROTO(unsigned long error_code,
+		unsigned long pte),
+	TP_ARGS(error_code,
+		pte),
+	TP_STRUCT__entry(
+		__field(unsigned long, error_code)
+		__field(unsigned long, pte)
+	),
+	TP_fast_assign(
+		__entry->error_code = error_code;
+		__entry->pte = pte;
+	),
+	TP_printk("error_code=%lx pte=%lx",
+		 __entry->error_code,
+		 __entry->pte
+		)
+);
+
+#define DEFINE_SPURIOUS_FAULT_CHECK_EVENT(name)	\
+DEFINE_EVENT_FN(spurious_fault_check, name,	\
+	TP_PROTO(unsigned long error_code,	\
+		 unsigned long pte),			\
+	TP_ARGS(error_code, pte),	\
+	trace_pagefault_reg,		\
+	trace_pagefault_unreg);
+
+DEFINE_SPURIOUS_FAULT_CHECK_EVENT(spurious_fault_1_sample);
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE exceptions
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 5e2a49010d87..aa9bc9609c68 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1001,6 +1001,8 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 	if ((error_code & X86_PF_INSTR) && !pte_exec(*pte))
 		return 0;
 
+	trace_spurious_fault_1_sample(error_code, (unsigned long)pte);
+
 	return 1;
 }
 
-- 
2.14.4

