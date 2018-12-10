Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3996720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3996720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLJMyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJMyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:54:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3427F3082E4E;
        Mon, 10 Dec 2018 12:54:22 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A7E25DA63;
        Mon, 10 Dec 2018 12:54:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
In-Reply-To: <20181210120637.GA13294@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-4-vkuznets@redhat.com> <20181210120637.GA13294@rkaganb.sw.ru>
Date:   Mon, 10 Dec 2018 13:54:18 +0100
Message-ID: <87va41czk5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 10 Dec 2018 12:54:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Nov 26, 2018 at 04:47:31PM +0100, Vitaly Kuznetsov wrote:
>> Turns out Hyper-V on KVM (as of 2016) will only use synthetic timers
>> if direct mode is available. With direct mode we notify the guest by
>> asserting APIC irq instead of sending a SynIC message.
>> 
>> The implementation uses existing vec_bitmap for letting lapic code
>> know that we're interested in the particular IRQ's EOI request. We assume
>> that the same APIC irq won't be used by the guest for both direct mode
>> stimer and as sint source (especially with AutoEOI semantics). It is
>> unclear how things should be handled if that's not true.
>> 
>> Direct mode is also somewhat less expensive; in my testing
>> stimer_send_msg() takes not less than 1500 cpu cycles and
>> stimer_notify_direct() can usually be done in 300-400. WS2016 without
>> Hyper-V, however, always sticks to non-direct version.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> - Changes since v1: avoid open-coding stimer_mark_pending() in
>>   kvm_hv_synic_send_eoi() [Paolo Bonzini]
>> ---
>>  arch/x86/kvm/hyperv.c    | 67 +++++++++++++++++++++++++++++++++++-----
>>  arch/x86/kvm/trace.h     | 10 +++---
>>  arch/x86/kvm/x86.c       |  1 +
>>  include/uapi/linux/kvm.h |  1 +
>>  4 files changed, 67 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index eaec15c738df..9533133be566 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -38,6 +38,9 @@
>>  
>>  #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
>>  
>> +static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
>> +				bool vcpu_kick);
>> +
>>  static inline u64 synic_read_sint(struct kvm_vcpu_hv_synic *synic, int sint)
>>  {
>>  	return atomic64_read(&synic->sint[sint]);
>> @@ -53,8 +56,21 @@ static inline int synic_get_sint_vector(u64 sint_value)
>>  static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
>>  				      int vector)
>>  {
>> +	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
>> +	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
>> +	struct kvm_vcpu_hv_stimer *stimer;
>>  	int i;
>>  
>> +	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
>> +		stimer = &hv_vcpu->stimer[i];
>> +		if (stimer->config.enable && stimer->config.direct_mode &&
>> +		    stimer->config.apic_vector == vector)
>> +			return true;
>> +	}
>> +
>> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>> +		return false;
>> +
>>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
>>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>>  			return true;
>> @@ -80,14 +96,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
>>  static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>>  				int vector)
>>  {
>> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>> -		return;
>> -
>>  	if (synic_has_vector_connected(synic, vector))
>>  		__set_bit(vector, synic->vec_bitmap);
>>  	else
>>  		__clear_bit(vector, synic->vec_bitmap);
>>  
>> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>> +		return;
>> +
>
> Just noticed that the patch seems to assume that "direct" timers are
> allowed to use any vectors including 0-15.  I guess this is incorrect,
> and instead stimer_set_config should error out on direct mode with a
> vector less than HV_SYNIC_FIRST_VALID_VECTOR.

The spec is really vague about this and I'm not sure that this has
anything to do with HV_SYNIC_FIRST_VALID_VECTOR (as these are actually
not "synic" vectors, I *think* that SynIC doesn't even need to be
enabled to make them work).

I checked and Hyper-V 2016 uses vector '0xff', not sure if it proves
your point :-)

Do you envision any issues in KVM if we keep allowing vectors <
HV_SYNIC_FIRST_VALID_VECTOR?

-- 
Vitaly
