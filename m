Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC12098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJKR3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeJKR3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E9A6B2AC;
        Thu, 11 Oct 2018 10:03:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-17.brq.redhat.com [10.40.204.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC107A46F;
        Thu, 11 Oct 2018 10:03:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()
Date:   Thu, 11 Oct 2018 12:03:12 +0200
Message-Id: <20181011100312.4083-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 11 Oct 2018 10:03:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm observing random crashes in multi-vCPU L2 guests running on KVM on
Hyper-V. I bisected the issue to the commit 877ad952be3d ("KVM: vmx: Add
tlb_remote_flush callback support"). Hyper-V TLFS states:

"AddressSpace specifies an address space ID (an EPT PML4 table pointer)"

So apparently, Hyper-V doesn't expect us to pass naked EPTP, only PML4
pointer should be used. Strip off EPT configuration information before
calling into vmx_hv_remote_flush_tlb().

Fixes: 877ad952be3d ("KVM: vmx: Add tlb_remote_flush callback support")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 612fd17be635..e665aa7167cf 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1572,8 +1572,12 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 		goto out;
 	}
 
+	/*
+	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
+	 * base of EPT PML4 table, strip off EPT configuration information.
+	 */
 	ret = hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
+			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
 
 out:
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
-- 
2.17.1

