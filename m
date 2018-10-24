Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1EC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A182082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="H8fIi0NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A182082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJXQ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:56:51 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:47755 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540369782; x=1571905782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5sqDDn7QP7sBKIfJPTSAIDBRqBS3u0CYMIP5f/m9YTo=;
  b=H8fIi0NQckGtDMIdojY9H6PbWpp9t59nOMM8mx3cC/6JecjoWMetEwu5
   HYpf2105umSBBMp92wYHj4SztDiqR+3Kd2W70sIgvE3cwkRisuz775P19
   YlQ1ZXs93AiZFGYn4c6buhiJLDdKyH6IbUHLUclYV+S24hR4Gb3c3+4Ph
   0=;
X-IronPort-AV: E=Sophos;i="5.54,419,1534809600"; 
   d="scan'208";a="701226933"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Oct 2018 08:29:41 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9O8TbpF022039
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 24 Oct 2018 08:29:38 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9O8Ta9A030178;
        Wed, 24 Oct 2018 10:29:36 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w9O8TaIe030177;
        Wed, 24 Oct 2018 10:29:36 +0200
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>, js@alien8.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
Date:   Wed, 24 Oct 2018 10:28:57 +0200
Message-Id: <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
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
---
 arch/x86/kvm/vmx.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 93562d5..9225099 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10797,20 +10797,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%r13, %c[r13](%0) \n\t"
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
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
@@ -10847,6 +10834,26 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 	      );
 
+	/* Don't let guest register values survive. */
+	asm volatile (
+		""
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
+		:: "a" (0), "b" (0), "S" (0), "D" (0)
+		: "cc"
+#ifdef CONFIG_X86_64
+		  , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+#endif
+		);
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
-- 
2.7.4

