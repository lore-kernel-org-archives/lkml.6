Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD64520864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpCXPEx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD64520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406999AbeKWGf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbeKWGfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:55 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D918C20866;
        Thu, 22 Nov 2018 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916503;
        bh=uQ45pvzg6Tm+p+MHZfZh0anocaP0uHde5t8Aed9gKOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpCXPEx06sw3oNxbCWDEhnvmDX8OpX2uGDAUSm8uFz5Y3gLeadbmI3cHg2ip8l4Le
         xuVz9rQZJ8VlXvdAWf3FoDe2/vXrMyuhmLMn0zgZ4ZlD+x6f3gGYkWcHG8RWGNnt5z
         sKBw3uV4YC+bbrDPkduJQBKzBu4NF4dmnJDszcnM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 03/21] KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE
Date:   Thu, 22 Nov 2018 14:54:34 -0500
Message-Id: <20181122195452.13520-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <oss@buserror.net>

[ Upstream commit 28c5bcf74fa07c25d5bd118d1271920f51ce2a98 ]

TRACE_INCLUDE_PATH and TRACE_INCLUDE_FILE are used by
<trace/define_trace.h>, so like that #include, they should
be outside #ifdef protection.

They also need to be #undefed before defining, in case multiple trace
headers are included by the same C file.  This became the case on
book3e after commit cf4a6085151a ("powerpc/mm: Add missing tracepoint for
tlbie"), leading to the following build error:

   CC      arch/powerpc/kvm/powerpc.o
In file included from arch/powerpc/kvm/powerpc.c:51:0:
arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined
[-Werror]
  #define TRACE_INCLUDE_PATH .
  ^
In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
                  from arch/powerpc/kvm/powerpc.c:48:
./arch/powerpc/include/asm/trace.h:224:0: note: this is the location of
the previous definition
  #define TRACE_INCLUDE_PATH asm
  ^
cc1: all warnings being treated as errors

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/trace.h       | 8 ++++++--
 arch/powerpc/kvm/trace_booke.h | 9 +++++++--
 arch/powerpc/kvm/trace_hv.h    | 9 +++++++--
 arch/powerpc/kvm/trace_pr.h    | 9 +++++++--
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 491b0f715d6b..ea1d7c808319 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -6,8 +6,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace
 
 /*
  * Tracepoint for guest mode entry.
@@ -120,4 +118,10 @@ TRACE_EVENT(kvm_check_requests,
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+
 #include <trace/define_trace.h>
diff --git a/arch/powerpc/kvm/trace_booke.h b/arch/powerpc/kvm/trace_booke.h
index ac640e81fdc5..3837842986aa 100644
--- a/arch/powerpc/kvm/trace_booke.h
+++ b/arch/powerpc/kvm/trace_booke.h
@@ -6,8 +6,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_booke
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_booke
 
 #define kvm_trace_symbol_exit \
 	{0, "CRITICAL"}, \
@@ -218,4 +216,11 @@ TRACE_EVENT(kvm_booke_queue_irqprio,
 #endif
 
 /* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_booke
+
 #include <trace/define_trace.h>
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index bcfe8a987f6a..8a1e3b0047f1 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -9,8 +9,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_hv
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_hv
 
 #define kvm_trace_symbol_hcall \
 	{H_REMOVE,			"H_REMOVE"}, \
@@ -497,4 +495,11 @@ TRACE_EVENT(kvmppc_run_vcpu_exit,
 #endif /* _TRACE_KVM_HV_H */
 
 /* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_hv
+
 #include <trace/define_trace.h>
diff --git a/arch/powerpc/kvm/trace_pr.h b/arch/powerpc/kvm/trace_pr.h
index 85785a370c0e..256530eb1354 100644
--- a/arch/powerpc/kvm/trace_pr.h
+++ b/arch/powerpc/kvm/trace_pr.h
@@ -8,8 +8,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_pr
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_pr
 
 TRACE_EVENT(kvm_book3s_reenter,
 	TP_PROTO(int r, struct kvm_vcpu *vcpu),
@@ -272,4 +270,11 @@ TRACE_EVENT(kvm_unmap_hva,
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_pr
+
 #include <trace/define_trace.h>
-- 
2.17.1

