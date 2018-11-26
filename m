Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B4020659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B4020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK0DjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:39:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeK0DjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:39:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4433430842AB;
        Mon, 26 Nov 2018 16:44:31 +0000 (UTC)
Received: from [10.36.112.66] (ovpn-112-66.ams2.redhat.com [10.36.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82CC4608FA;
        Mon, 26 Nov 2018 16:44:27 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-4-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
Date:   Mon, 26 Nov 2018 17:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126154732.23025-4-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 26 Nov 2018 16:44:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/18 16:47, Vitaly Kuznetsov wrote:
> Turns out Hyper-V on KVM (as of 2016) will only use synthetic timers
> if direct mode is available. With direct mode we notify the guest by
> asserting APIC irq instead of sending a SynIC message.
> 
> The implementation uses existing vec_bitmap for letting lapic code
> know that we're interested in the particular IRQ's EOI request. We assume
> that the same APIC irq won't be used by the guest for both direct mode
> stimer and as sint source (especially with AutoEOI semantics). It is
> unclear how things should be handled if that's not true.
> 
> Direct mode is also somewhat less expensive; in my testing
> stimer_send_msg() takes not less than 1500 cpu cycles and
> stimer_notify_direct() can usually be done in 300-400. WS2016 without
> Hyper-V, however, always sticks to non-direct version.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Changes since v1: avoid open-coding stimer_mark_pending() in
>   kvm_hv_synic_send_eoi() [Paolo Bonzini]
> ---
>  arch/x86/kvm/hyperv.c    | 67 +++++++++++++++++++++++++++++++++++-----
>  arch/x86/kvm/trace.h     | 10 +++---
>  arch/x86/kvm/x86.c       |  1 +
>  include/uapi/linux/kvm.h |  1 +
>  4 files changed, 67 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index eaec15c738df..9533133be566 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -38,6 +38,9 @@
>  
>  #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
>  
> +static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
> +				bool vcpu_kick);
> +
>  static inline u64 synic_read_sint(struct kvm_vcpu_hv_synic *synic, int sint)
>  {
>  	return atomic64_read(&synic->sint[sint]);
> @@ -53,8 +56,21 @@ static inline int synic_get_sint_vector(u64 sint_value)
>  static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
>  				      int vector)
>  {
> +	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
> +	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
> +	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
>  
> +	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> +		stimer = &hv_vcpu->stimer[i];
> +		if (stimer->config.enable && stimer->config.direct_mode &&
> +		    stimer->config.apic_vector == vector)
> +			return true;
> +	}
> +
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return false;
> +
>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>  			return true;
> @@ -80,14 +96,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
>  static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>  				int vector)
>  {
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return;
> -
>  	if (synic_has_vector_connected(synic, vector))
>  		__set_bit(vector, synic->vec_bitmap);
>  	else
>  		__clear_bit(vector, synic->vec_bitmap);
>  
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return;
> +
>  	if (synic_has_vector_auto_eoi(synic, vector))
>  		__set_bit(vector, synic->auto_eoi_bitmap);
>  	else
> @@ -202,6 +218,7 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
>  	for (idx = 0; idx < ARRAY_SIZE(hv_vcpu->stimer); idx++) {
>  		stimer = &hv_vcpu->stimer[idx];
>  		if (stimer->msg_pending && stimer->config.enable &&
> +		    !stimer->config.direct_mode &&
>  		    stimer->config.sintx == sint) {
>  			set_bit(stimer->index,
>  				hv_vcpu->stimer_pending_bitmap);
> @@ -371,7 +388,9 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vpidx, u32 sint)
>  
>  void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>  {
> +	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
>  	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
> +	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
>  
>  	trace_kvm_hv_synic_send_eoi(vcpu->vcpu_id, vector);
> @@ -379,6 +398,14 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>  			kvm_hv_notify_acked_sint(vcpu, i);
> +
> +	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> +		stimer = &hv_vcpu->stimer[i];
> +		if (stimer->msg_pending && stimer->config.enable &&
> +		    stimer->config.direct_mode &&
> +		    stimer->config.apic_vector == vector)
> +			stimer_mark_pending(stimer, false);
> +	}
>  }
>  
>  static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vpidx, u32 sint, int gsi)
> @@ -545,15 +572,25 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
>  static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
>  			     bool host)
>  {
> -	union hv_stimer_config new_config = {.as_uint64 = config};
> +	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
> +	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
> +	union hv_stimer_config new_config = {.as_uint64 = config},
> +		old_config = {.as_uint64 = stimer->config.as_uint64};
>  
>  	trace_kvm_hv_stimer_set_config(stimer_to_vcpu(stimer)->vcpu_id,
>  				       stimer->index, config, host);
>  
>  	stimer_cleanup(stimer);
> -	if (stimer->config.enable && new_config.sintx == 0)
> +	if (old_config.enable &&
> +	    !new_config.direct_mode && new_config.sintx == 0)
>  		new_config.enable = 0;
>  	stimer->config.as_uint64 = new_config.as_uint64;
> +
> +	if (old_config.direct_mode)
> +		synic_update_vector(&hv_vcpu->synic, old_config.apic_vector);
> +	if (new_config.direct_mode)
> +		synic_update_vector(&hv_vcpu->synic, new_config.apic_vector);
> +
>  	stimer_mark_pending(stimer, false);
>  	return 0;
>  }
> @@ -640,14 +677,28 @@ static int stimer_send_msg(struct kvm_vcpu_hv_stimer *stimer)
>  				 stimer->config.sintx, msg);
>  }
>  
> +static int stimer_notify_direct(struct kvm_vcpu_hv_stimer *stimer)
> +{
> +	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
> +	struct kvm_lapic_irq irq = {
> +		.delivery_mode = APIC_DM_FIXED,
> +		.vector = stimer->config.apic_vector
> +	};
> +
> +	return !kvm_apic_set_irq(vcpu, &irq, NULL);
> +}
> +
>  static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
>  {
> -	int r;
> +	int r, direct = stimer->config.direct_mode;
>  
>  	stimer->msg_pending = true;
> -	r = stimer_send_msg(stimer);
> +	if (!direct)
> +		r = stimer_send_msg(stimer);
> +	else
> +		r = stimer_notify_direct(stimer);
>  	trace_kvm_hv_stimer_expiration(stimer_to_vcpu(stimer)->vcpu_id,
> -				       stimer->index, r);
> +				       stimer->index, direct, r);
>  	if (!r) {
>  		stimer->msg_pending = false;
>  		if (!(stimer->config.periodic))
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index 0659465a745c..705f40ae2532 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1254,24 +1254,26 @@ TRACE_EVENT(kvm_hv_stimer_callback,
>   * Tracepoint for stimer_expiration.
>   */
>  TRACE_EVENT(kvm_hv_stimer_expiration,
> -	TP_PROTO(int vcpu_id, int timer_index, int msg_send_result),
> -	TP_ARGS(vcpu_id, timer_index, msg_send_result),
> +	TP_PROTO(int vcpu_id, int timer_index, int direct, int msg_send_result),
> +	TP_ARGS(vcpu_id, timer_index, direct, msg_send_result),
>  
>  	TP_STRUCT__entry(
>  		__field(int, vcpu_id)
>  		__field(int, timer_index)
> +		__field(int, direct)
>  		__field(int, msg_send_result)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->vcpu_id = vcpu_id;
>  		__entry->timer_index = timer_index;
> +		__entry->direct = direct;
>  		__entry->msg_send_result = msg_send_result;
>  	),
>  
> -	TP_printk("vcpu_id %d timer %d msg send result %d",
> +	TP_printk("vcpu_id %d timer %d direct %d send result %d",
>  		  __entry->vcpu_id, __entry->timer_index,
> -		  __entry->msg_send_result)
> +		  __entry->direct, __entry->msg_send_result)
>  );
>  
>  /*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5cd5647120f2..b21b5ceb8d26 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2997,6 +2997,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_HYPERV_TLBFLUSH:
>  	case KVM_CAP_HYPERV_SEND_IPI:
>  	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> +	case KVM_CAP_HYPERV_STIMER_DIRECT:
>  	case KVM_CAP_PCI_SEGMENT:
>  	case KVM_CAP_DEBUGREGS:
>  	case KVM_CAP_X86_ROBUST_SINGLESTEP:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2b7a652c9fa4..b8da14cee8e5 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
>  #define KVM_CAP_EXCEPTION_PAYLOAD 164
>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
> +#define KVM_CAP_HYPERV_STIMER_DIRECT 166

I wonder if all these capabilities shouldn't be replaced by a single
KVM_GET_HYPERV_SUPPORTED_CPUID ioctl, or something like that.  If you
can do it for 4.21, before this one cap is crystallized into userspace
API, that would be great. :)

Paolo
