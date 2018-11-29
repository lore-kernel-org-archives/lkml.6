Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47381C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10406205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6thw/t2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10406205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeK3B22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbeK3B21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923E7205C9;
        Thu, 29 Nov 2018 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501376;
        bh=w/uXMKskUaDdkECj/+WQTZcSoM+T1ynNnzHAByfbXEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6thw/t2U0ewVqyHfybh+DBIkdyrHAcl0RWs01xy8FPrUIkjse9K+5Z+os0jctOkO
         v2QZSF2EVyE+8oFQNH2MvoEIxkPkEacZjDUQ/s1f0lrdDcyfzWswxyHUJtx0Yz0Yga
         /LgSkVLhOsqjqHmBs5IRfUFqk9+BnCUP3Xi8YcK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/92] KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE
Date:   Thu, 29 Nov 2018 15:11:58 +0100
Message-Id: <20181129140108.751580518@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2e0e67ef3544..e8cedf32345a 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -5,8 +5,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace
 
 /*
  * Tracepoint for guest mode entry.
@@ -119,4 +117,10 @@ TRACE_EVENT(kvm_check_requests,
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
index 7ec534d1db9f..7eadbf449a1f 100644
--- a/arch/powerpc/kvm/trace_booke.h
+++ b/arch/powerpc/kvm/trace_booke.h
@@ -5,8 +5,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_booke
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_booke
 
 #define kvm_trace_symbol_exit \
 	{0, "CRITICAL"}, \
@@ -217,4 +215,11 @@ TRACE_EVENT(kvm_booke_queue_irqprio,
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
index fb21990c0fb4..d9a21a7bd5c9 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -8,8 +8,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_hv
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_hv
 
 #define kvm_trace_symbol_hcall \
 	{H_REMOVE,			"H_REMOVE"}, \
@@ -496,4 +494,11 @@ TRACE_EVENT(kvmppc_run_vcpu_exit,
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
index d44f324184fb..e8e2b9ad4ac6 100644
--- a/arch/powerpc/kvm/trace_pr.h
+++ b/arch/powerpc/kvm/trace_pr.h
@@ -7,8 +7,6 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_pr
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace_pr
 
 TRACE_EVENT(kvm_book3s_reenter,
 	TP_PROTO(int r, struct kvm_vcpu *vcpu),
@@ -271,4 +269,11 @@ TRACE_EVENT(kvm_unmap_hva,
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



