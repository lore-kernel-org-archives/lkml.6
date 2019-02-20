Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41721218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Oozu2hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBTUSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfBTUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8X06087279;
        Wed, 20 Feb 2019 20:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yZpRshFok7HHOJ43X643k5AyRcEujMIw9dtV9CXJRJg=;
 b=1Oozu2huMwf2Gl/VTapxfKIOkytKKYlt4+xaqThxN2OB/hlboNYscxIHX57rQtoWsC8R
 qQhXT/d8/xX8+cycbr6ou16pSgenmBI198Y5k/5qLwCvdp5yeeb3wPKim9bJr1NCms/R
 PBDOH54MidArV5/tRW9dnLsONqBwaXxVD+cJy2jQNP6d35XD1SpZPtCRdnIWipGo2rf7
 RQQDMwWWYcdcp3Ig4p0QC6nmCa+LyOkBfA0aoLiubxRbYxD4z4OitAD2BypRAmsZkTwM
 Vph7cApzHUgmuQBwid1qPL6T8fxa9Q8gU54fYFIAa1JW30ZUzL2eCO+Wz6wBpV2iXDdv eQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rktrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHr3T022699
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:53 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHqvq012033;
        Wed, 20 Feb 2019 20:17:52 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:51 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH RFC 18/39] x86/xen: make hypercall_page generic
Date:   Wed, 20 Feb 2019 20:15:48 +0000
Message-Id: <20190220201609.28290-19-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Export hypercall_page as a generic interface which can be implemented
by other hypervisors. With this change, hypercall_page now points to
the newly introduced xen_hypercall_page which is seeded by Xen, or to
one that is filled in by a different hypervisor.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/xen/hypercall.h | 12 +++++++-----
 arch/x86/xen/enlighten.c             |  1 +
 arch/x86/xen/enlighten_hvm.c         |  3 ++-
 arch/x86/xen/enlighten_pv.c          |  1 +
 arch/x86/xen/enlighten_pvh.c         |  3 ++-
 arch/x86/xen/xen-asm_32.S            |  2 +-
 arch/x86/xen/xen-asm_64.S            |  2 +-
 arch/x86/xen/xen-head.S              |  8 ++++----
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index ef05bea7010d..1a3cd6680e6f 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -86,11 +86,13 @@ struct xen_dm_op_buf;
  * there aren't more than 5 arguments...)
  */
 
-extern struct { char _entry[32]; } hypercall_page[];
+struct hypercall_entry { char _entry[32]; };
+extern struct hypercall_entry xen_hypercall_page[128];
+extern struct hypercall_entry *hypercall_page;
 
-#define __HYPERCALL		"call hypercall_page+%c[offset]"
+#define __HYPERCALL	CALL_NOSPEC
 #define __HYPERCALL_ENTRY(x)						\
-	[offset] "i" (__HYPERVISOR_##x * sizeof(hypercall_page[0]))
+	[thunk_target] "0" (hypercall_page + __HYPERVISOR_##x)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -116,7 +118,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	register unsigned long __arg4 asm(__HYPERCALL_ARG4REG) = __arg4; \
 	register unsigned long __arg5 asm(__HYPERCALL_ARG5REG) = __arg5;
 
-#define __HYPERCALL_0PARAM	"=r" (__res), ASM_CALL_CONSTRAINT
+#define __HYPERCALL_0PARAM	"=&r" (__res), ASM_CALL_CONSTRAINT
 #define __HYPERCALL_1PARAM	__HYPERCALL_0PARAM, "+r" (__arg1)
 #define __HYPERCALL_2PARAM	__HYPERCALL_1PARAM, "+r" (__arg2)
 #define __HYPERCALL_3PARAM	__HYPERCALL_2PARAM, "+r" (__arg3)
@@ -208,7 +210,7 @@ xen_single_call(unsigned int call,
 
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [thunk_target] "a" (&hypercall_page[call])
+		     : [thunk_target] "0" (hypercall_page + call)
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 73b9736e89d2..b36a10e6b5d7 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -20,6 +20,7 @@
 #include "smp.h"
 #include "pmu.h"
 
+struct hypercall_entry *hypercall_page;
 EXPORT_SYMBOL_GPL(hypercall_page);
 
 /*
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 0e75642d42a3..40845e3e9a96 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -105,8 +105,9 @@ static void __init init_hvm_pv_info(void)
 
 		pv_info.name = "Xen HVM";
 		msr = cpuid_ebx(base + 2);
-		pfn = __pa(hypercall_page);
+		pfn = __pa(xen_hypercall_page);
 		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+		hypercall_page = xen_hypercall_page;
 	}
 
 	xen_setup_features();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c54a493e139a..e1537713b57d 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1197,6 +1197,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	if (!xen_start_info)
 		return;
+	hypercall_page = xen_hypercall_page;
 
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 35b7599d2d0b..d57a8ad1769e 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -30,8 +30,9 @@ void __init xen_pvh_init(void)
 	xen_start_flags = pvh_start_info.flags;
 
 	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
+	pfn = __pa(xen_hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	hypercall_page = xen_hypercall_page;
 }
 
 void __init mem_map_via_hcall(struct boot_params *boot_params_p)
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index c15db060a242..ee4998055ea9 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -121,7 +121,7 @@ xen_iret_end_crit:
 
 hyper_iret:
 	/* put this out of line since its very rarely used */
-	jmp hypercall_page + __HYPERVISOR_iret * 32
+	jmp xen_hypercall_page + __HYPERVISOR_iret * 32
 
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 1e9ef0ba30a5..2172d6aec9a3 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -70,7 +70,7 @@ ENTRY(xen_early_idt_handler_array)
 END(xen_early_idt_handler_array)
 	__FINIT
 
-hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
+hypercall_iret = xen_hypercall_page + __HYPERVISOR_iret * 32
 /*
  * Xen64 iret frame:
  *
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..7ff5437bd83f 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -58,18 +58,18 @@ END(startup_xen)
 
 .pushsection .text
 	.balign PAGE_SIZE
-ENTRY(hypercall_page)
+ENTRY(xen_hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_EMPTY
 		.skip 32
 	.endr
 
 #define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
+	.equ xen_hypercall_##n, xen_hypercall_page + __HYPERVISOR_##n * 32; \
 	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
-END(hypercall_page)
+END(xen_hypercall_page)
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
@@ -85,7 +85,7 @@ END(hypercall_page)
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR xen_hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
 		.ascii "!writable_page_tables|pae_pgdir_above_4gb")
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
-- 
2.11.0

