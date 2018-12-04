Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA991C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DAA214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqf6o59X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DAA214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeLDLIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbeLDLIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7581C2082D;
        Tue,  4 Dec 2018 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921687;
        bh=BZyZWPwO/0JZ2VgcCjC0DYBb74IAR3JObroDB27GTfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqf6o59Xaom/Shrcq79aojMn9dJYuicHBP9CxbGx+MK3ZVBEAoSj1zKZdEuaO242G
         fQetfy8vSrNfMKWT9KiKRhUszev2ZkPGQujzCCPEnhD4uyXH3hn20SI0V6zqCmvXgX
         TdTYuToQrzBtmVHASHqYFNgroRgliGKSYLqsYuBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neel Natu <neelnatu@google.com>,
        Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 20/50] kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb
Date:   Tue,  4 Dec 2018 11:50:15 +0100
Message-Id: <20181204103715.545480297@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit fd65d3142f734bc4376053c8d75670041903134d upstream.

Previously, we only called indirect_branch_prediction_barrier on the
logical CPU that freed a vmcb. This function should be called on all
logical CPUs that last loaded the vmcb in question.

Fixes: 15d45071523d ("KVM/x86: Add IBPB support")
Reported-by: Neel Natu <neelnatu@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1672,21 +1672,31 @@ out:
 	return ERR_PTR(err);
 }
 
+static void svm_clear_current_vmcb(struct vmcb *vmcb)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		cmpxchg(&per_cpu(svm_data, i)->current_vmcb, vmcb, NULL);
+}
+
 static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * The vmcb page can be recycled, causing a false negative in
+	 * svm_vcpu_load(). So, ensure that no logical CPU has this
+	 * vmcb page recorded as its current vmcb.
+	 */
+	svm_clear_current_vmcb(svm->vmcb);
+
 	__free_page(pfn_to_page(svm->vmcb_pa >> PAGE_SHIFT));
 	__free_pages(virt_to_page(svm->msrpm), MSRPM_ALLOC_ORDER);
 	__free_page(virt_to_page(svm->nested.hsave));
 	__free_pages(virt_to_page(svm->nested.msrpm), MSRPM_ALLOC_ORDER);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, svm);
-	/*
-	 * The vmcb page can be recycled, causing a false negative in
-	 * svm_vcpu_load(). So do a full IBPB now.
-	 */
-	indirect_branch_prediction_barrier();
 }
 
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)


