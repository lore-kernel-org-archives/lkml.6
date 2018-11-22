Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E9C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pmQ1SNqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD5820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404358AbeKWDaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:30:17 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48409 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403948AbeKWDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905405; x=1574441405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JrL1vEL41+eim8P8jSIRf07IUBu42y+4esgLR4Um2+s=;
  b=pmQ1SNqvMsEup1BwmRaG0OWvne8cSfnw5T3qYzpb58fJukGZPCDKi3n1
   xcWMuKP9EAIwecgVy/BDEkTjKBR2N9HeJ0VOGSVi/T9W2I8oEBpFamnCu
   0VW2HzXTss8tmff5Ppd+10HLQjcgx4QjSBl737joMGFuRO+PDvjDlLnd3
   w=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="766849695"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:03 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGnwWR079444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:50:00 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGnvPc008110;
        Thu, 22 Nov 2018 17:49:57 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGnuwX008109;
        Thu, 22 Nov 2018 17:49:56 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 2/6] kvm, vmx: move register clearing out of assembly path
Date:   Thu, 22 Nov 2018 17:49:35 +0100
Message-Id: <4c9432269f81f28cc929811b3eb17c473f94bcfa.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the security related register clearing out of the large inline
assembly VM entry path. This results in two slightly less complicated
inline assembly statements, where it is clearer what each one does.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a6e5a5cd8f14..8ebd41d935b8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11281,24 +11281,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%r13, %c[r13](%0) \n\t"
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
-		/*
-		* Clear host registers marked as clobbered to prevent
-		* speculative use.
-		*/
-		"xor %%r8d,  %%r8d \n\t"
-		"xor %%r9d,  %%r9d \n\t"
-		"xor %%r10d, %%r10d \n\t"
-		"xor %%r11d, %%r11d \n\t"
-		"xor %%r12d, %%r12d \n\t"
-		"xor %%r13d, %%r13d \n\t"
-		"xor %%r14d, %%r14d \n\t"
-		"xor %%r15d, %%r15d \n\t"
 #endif
-
-		"xor %%eax, %%eax \n\t"
-		"xor %%ebx, %%ebx \n\t"
-		"xor %%esi, %%esi \n\t"
-		"xor %%edi, %%edi \n\t"
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 		".pushsection .rodata \n\t"
 		".global vmx_return \n\t"
@@ -11335,6 +11318,35 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 	      );
 
+	/*
+         * Explicitly clear (in addition to marking them as clobbered) all GPRs
+         * that have not been loaded with host state to prevent speculatively
+         * using the guest's values.
+         */
+	asm volatile (
+		"xor %%eax, %%eax \n\t"
+		"xor %%ebx, %%ebx \n\t"
+		"xor %%esi, %%esi \n\t"
+		"xor %%edi, %%edi \n\t"
+#ifdef CONFIG_X86_64
+		"xor %%r8d,  %%r8d \n\t"
+		"xor %%r9d,  %%r9d \n\t"
+		"xor %%r10d, %%r10d \n\t"
+		"xor %%r11d, %%r11d \n\t"
+		"xor %%r12d, %%r12d \n\t"
+		"xor %%r13d, %%r13d \n\t"
+		"xor %%r14d, %%r14d \n\t"
+		"xor %%r15d, %%r15d \n\t"
+#endif
+		::: "cc"
+#ifdef CONFIG_X86_64
+		 , "rax", "rbx", "rsi", "rdi"
+		 , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+#else
+		 , "eax", "ebx", "esi", "edi"
+#endif
+		);
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
-- 
2.17.1

