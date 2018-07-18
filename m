Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08151ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7B02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7B02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeGRSev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:34:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731356AbeGRSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:34:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F16D7C6CA;
        Wed, 18 Jul 2018 17:55:49 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id B18041C55F;
        Wed, 18 Jul 2018 17:55:46 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 18 Jul 2018 19:55:46 +0200
Date:   Wed, 18 Jul 2018 19:55:46 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v5 2/2] kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
Message-ID: <20180718175545.GA11749@flask>
References: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
 <1531214840-24686-2-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531214840-24686-2-git-send-email-karahmed@amazon.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 17:55:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 17:55:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 11:27+0200, KarimAllah Ahmed:
> From: Jim Mattson <jmattson@google.com>
> 
> For nested virtualization L0 KVM is managing a bit of state for L2 guests,
> this state can not be captured through the currently available IOCTLs. In
> fact the state captured through all of these IOCTLs is usually a mix of L1
> and L2 state. It is also dependent on whether the L2 guest was running at
> the moment when the process was interrupted to save its state.
> 
> With this capability, there are two new vcpu ioctls: KVM_GET_NESTED_STATE
> and KVM_SET_NESTED_STATE. These can be used for saving and restoring a VM
> that is in VMX operation.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>
> [karahmed@ - rename structs and functions and make them ready for AMD and
>              address previous comments.
>            - handle nested.smm state.
>            - rebase & a bit of refactoring.
>            - Merge 7/8 and 8/8 into one patch. ]
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v4 -> v5:
> - Drop the update to KVM_REQUEST_ARCH_BASE in favor of a patch to switch to
>   u64 instead.
> - Fix commit message.
> - Handle nested.smm state as well.
> - rebase
> 
> v3 -> v4:
> - Rename function to have _nested
> 
> v2 -> v3:
> - Remove the forced VMExit from L2 after reading the kvm_state. The actual
>   problem is solved.
> - Rebase again!
> - Set nested_run_pending during restore (not sure if it makes sense yet or
>   not).
> - Reduce KVM_REQUEST_ARCH_BASE to 7 instead of 8 (the other alternative is
>   to switch everything to u64)
> 
> v1 -> v2:
> - Rename structs and functions and make them ready for AMD and address
>   previous comments.
> - Rebase & a bit of refactoring.
> - Merge 7/8 and 8/8 into one patch.
> - Force a VMExit from L2 after reading the kvm_state to avoid mixed state
>   between L1 and L2 on resurrecting the instance.
> ---
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -12976,6 +12977,197 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
> +static int set_vmcs_cache(struct kvm_vcpu *vcpu,
> +			  struct kvm_nested_state __user *user_kvm_nested_state,
> +			  struct kvm_nested_state *kvm_state)
> +
> +{
> [...]
> +
> +	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
> +		vmx->nested.nested_run_pending = 1;
> +
> +	if (check_vmentry_prereqs(vcpu, vmcs12) ||
> +	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
> +		return -EINVAL;
> +
> +	ret = enter_vmx_non_root_mode(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The MMU is not initialized to point at the right entities yet and
> +	 * "get pages" would need to read data from the guest (i.e. we will
> +	 * need to perform gpa to hpa translation). So, This request will
> +	 * result in a call to nested_get_vmcs12_pages before the next
> +	 * VM-entry.
> +	 */
> +	kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
> +
> +	vmx->nested.nested_run_pending = 1;

This is not necessary.  We're only copying state and do not add anything
that would be lost on a nested VM exit without prior VM entry.

> +

Halting the VCPU should probably be done here, just like at the end of
nested_vmx_run().

> +	return 0;
> +}
> +
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> @@ -963,6 +963,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_STATE 156

KVM_CAP_NESTED_STATE

(good documentation makes code worse. :])
