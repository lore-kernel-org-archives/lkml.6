Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E95C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF962064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="oh8sveRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF962064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeKAWqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:46:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22182 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeKAWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541079810; x=1572615810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmPSq4O4t/ZoVzS9e0JD5eV9J2AijNZfE0ieCjJ7n1w=;
  b=oh8sveRDCgRt653Tbd/Gq4fTZBQgToAHO5tEYRvdgSY5ayZnGtulxASm
   Pn43tfGGa3s9NkQ/DRqEIDlXO/Qmwwl56ewOXCcbZrEcpJbU3yB6GV7TR
   5ecPvlZExMNee/xonI0eNl6QRluCp2RuUcaS4HA493QygrftW/IHj9/fZ
   w=;
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208";a="702530356"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 13:43:29 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA1DhNMj005651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 1 Nov 2018 13:43:25 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wA1DhMQw004819;
        Thu, 1 Nov 2018 14:43:22 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wA1DhMOs004818;
        Thu, 1 Nov 2018 14:43:22 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] kvm, vmx: move register clearing out of assembly path
Date:   Thu,  1 Nov 2018 14:42:48 +0100
Message-Id: <e084cefd9c0620692787b8581312ec896c96056b.1541079752.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
References: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
In-Reply-To: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
References: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
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
index a6e5a5c..8ebd41d 100644
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
@@ -11336,6 +11319,35 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	      );
 
 	/*
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
+	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
 	 * turn it off. This is much more efficient than blindly adding
-- 
2.7.4

