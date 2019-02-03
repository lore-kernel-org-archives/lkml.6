Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD7C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF94218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfBCOVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55680 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728523AbfBCOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:06 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdt-0006OM-Fv; Sun, 03 Feb 2019 14:21:05 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9n-0007Jt-71; Sun, 03 Feb 2019 14:49:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jim Mattson" <jmattson@google.com>,
        "Neel Natu" <neelnatu@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.609419108@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 242/305] kvm: svm: Ensure an IBPB on all affected
 CPUs when freeing a vmcb
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1317,21 +1317,31 @@ out:
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

