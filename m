Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB7F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Hg8WBgUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB7F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJ3AaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:30:21 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41511 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeJ3AaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540827672; x=1572363672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OrubCFTf0hB4Sr8BqyPYwAdKbyOGbpSlySqIX4oovJ4=;
  b=Hg8WBgUXKdik9lZmapUw2UcxrZ9Ma1CHVTljMWWwzII+vBYKaPOhhlA+
   Jn+M/0SR6iYRQtXjMIaKp20WgbMl7THfJfrnjPVBzI7Jv9q2VqXr4jWL8
   toqNJQQeN4REgwFf4ieFLKK8WKTo2KQlNvQLUaKiAOuc0aY0Lf21FC1o6
   8=;
X-IronPort-AV: E=Sophos;i="5.54,440,1534809600"; 
   d="scan'208";a="370915898"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 15:41:10 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9TFf5Tw096295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 29 Oct 2018 15:41:06 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9TFf45k000639;
        Mon, 29 Oct 2018 16:41:04 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w9TFf49w000636;
        Mon, 29 Oct 2018 16:41:04 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kvm, vmx: move CR2 context switch out of assembly path
Date:   Mon, 29 Oct 2018 16:40:42 +0100
Message-Id: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM entry/exit path is a giant inline assembly statement. Simplify it
by doing CR2 context switching in plain C. Move CR2 restore behind IBRS
clearing, so we reduce the amount of code we execute with IBRS on.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ccc6a01..a6e5a5c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11212,6 +11212,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
 		(unsigned long)&current_evmcs->host_rsp : 0;
 
+	if (read_cr2() != vcpu->arch.cr2)
+		write_cr2(vcpu->arch.cr2);
+
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
 
@@ -11231,13 +11234,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"2: \n\t"
 		__ex("vmwrite %%" _ASM_SP ", %%" _ASM_DX) "\n\t"
 		"1: \n\t"
-		/* Reload cr2 if changed */
-		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
-		"mov %%cr2, %%" _ASM_DX " \n\t"
-		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
-		"je 3f \n\t"
-		"mov %%" _ASM_AX", %%cr2 \n\t"
-		"3: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
@@ -11298,8 +11294,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"xor %%r14d, %%r14d \n\t"
 		"xor %%r15d, %%r15d \n\t"
 #endif
-		"mov %%cr2, %%" _ASM_AX "   \n\t"
-		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
 
 		"xor %%eax, %%eax \n\t"
 		"xor %%ebx, %%ebx \n\t"
@@ -11331,7 +11325,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		[r14]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R14])),
 		[r15]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R15])),
 #endif
-		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
 #ifdef CONFIG_X86_64
@@ -11365,6 +11358,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
+	vcpu->arch.cr2 = read_cr2();
+
 	/* All fields are clean at this point */
 	if (static_branch_unlikely(&enable_evmcs))
 		current_evmcs->hv_clean_fields |=
-- 
2.7.4

