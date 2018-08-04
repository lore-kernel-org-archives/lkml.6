Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD2C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68080217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68080217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbeHDLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbeHDLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:06:24 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DA7EBB3;
        Sat,  4 Aug 2018 09:06:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 29/32] kvm: x86: vmx: fix vpid leak
Date:   Sat,  4 Aug 2018 11:01:19 +0200
Message-Id: <20180804082651.370702153@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kagan <rkagan@virtuozzo.com>

commit 63aff65573d73eb8dda4732ad4ef222dd35e4862 upstream.

VPID for the nested vcpu is allocated at vmx_create_vcpu whenever nested
vmx is turned on with the module parameter.

However, it's only freed if the L1 guest has executed VMXON which is not
a given.

As a result, on a system with nested==on every creation+deletion of an
L1 vcpu without running an L2 guest results in leaking one vpid.  Since
the total number of vpids is limited to 64k, they can eventually get
exhausted, preventing L2 from starting.

Delay allocation of the L2 vpid until VMXON emulation, thus matching its
freeing.

Fixes: 5c614b3583e7b6dab0c86356fa36c2bcbb8322a0
Cc: stable@vger.kernel.org
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7085,6 +7085,8 @@ static int handle_vmon(struct kvm_vcpu *
 		     HRTIMER_MODE_REL_PINNED);
 	vmx->nested.preemption_timer.function = vmx_preemption_timer_fn;
 
+	vmx->nested.vpid02 = allocate_vpid();
+
 	vmx->nested.vmxon = true;
 
 	skip_emulated_instruction(vcpu);
@@ -9264,10 +9266,8 @@ static struct kvm_vcpu *vmx_create_vcpu(
 			goto free_vmcs;
 	}
 
-	if (nested) {
+	if (nested)
 		nested_vmx_setup_ctls_msrs(vmx);
-		vmx->nested.vpid02 = allocate_vpid();
-	}
 
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
@@ -9285,7 +9285,6 @@ static struct kvm_vcpu *vmx_create_vcpu(
 	return &vmx->vcpu;
 
 free_vmcs:
-	free_vpid(vmx->nested.vpid02);
 	free_loaded_vmcs(vmx->loaded_vmcs);
 free_msrs:
 	kfree(vmx->guest_msrs);


