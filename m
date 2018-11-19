Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE56C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C55214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIJs3IwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C55214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeKTJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbeKTJLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:36 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1711208E4;
        Mon, 19 Nov 2018 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667543;
        bh=waq7X06IKbt3RYVmVBWBbwP5/xE4kI0BL+Nt2QAS734=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SIJs3IwWpZBXqml1eL5aHfUHI0EHf4RsN0ub4TALAn6OljwL31dH9b9FkslF3IRzm
         f+H/1+GXeBLK+cj5lYFrHDqzfDEkWW9U0rdsyJj/IBW6ELytAsfMA4rcGqqvcf3WRZ
         diGMq9aTcN3Qw0m+T4LmGi54QeCXa68lo0YEzeD8=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 03/13] x86/cpufeatures, x86/fault: Mark SMAP as disabled when configured out
Date:   Mon, 19 Nov 2018 14:45:27 -0800
Message-Id: <fe93332eded3d702f0b0b4cf83928d6830739ba3.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add X86_FEATURE_SMAP to the disabled features mask as appropriate
and use cpu_feature_enabled() in the fault code.  This lets us get
rid of a redundant IS_ENABLED(CONFIG_X86_SMAP).

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/mm/fault.c                      | 5 +----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 33833d1909af..a5ea841cc6d2 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
 #endif
 
+#ifdef CONFIG_X86_SMAP
+# define DISABLE_SMAP	0
+#else
+# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
+#endif
+
 #ifdef CONFIG_X86_INTEL_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -68,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index eae7ee3ce89b..0597342d4a55 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1150,10 +1150,7 @@ static int fault_in_kernel_space(unsigned long address)
 
 static inline bool smap_violation(int error_code, struct pt_regs *regs)
 {
-	if (!IS_ENABLED(CONFIG_X86_SMAP))
-		return false;
-
-	if (!static_cpu_has(X86_FEATURE_SMAP))
+	if (!cpu_feature_enabled(X86_FEATURE_SMAP))
 		return false;
 
 	if (error_code & X86_PF_USER)
-- 
2.17.2

