Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeDMOXn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:23:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752093AbeDMOXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:23:41 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
References: <20180412152508.27617-1-vkuznets@redhat.com>
        <ef082ed6-1af9-a578-d9da-e0874cc4769c@redhat.com>
Date: Fri, 13 Apr 2018 16:23:37 +0200
In-Reply-To: <ef082ed6-1af9-a578-d9da-e0874cc4769c@redhat.com> (Paolo
        Bonzini's message of "Fri, 13 Apr 2018 15:52:30 +0200")
Message-ID: <87muy7423a.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/04/2018 17:25, Vitaly Kuznetsov wrote:
>> @@ -5335,6 +5353,9 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
>>  	if (!cpu_has_vmx_msr_bitmap())
>>  		return;
>>  
>> +	if (static_branch_unlikely(&enable_emsr_bitmap))
>> +		evmcs_touch_msr_bitmap();
>> +
>>  	/*
>>  	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>>  	 * have the write-low and read-high bitmap offsets the wrong way round.
>> @@ -5370,6 +5391,9 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
>>  	if (!cpu_has_vmx_msr_bitmap())
>>  		return;
>>  
>> +	if (static_branch_unlikely(&enable_emsr_bitmap))
>> +		evmcs_touch_msr_bitmap();
>
> I'm not sure about the "unlikely".  Can you just check current_evmcs
> instead (dropping the static key completely)?

current_evmcs is just a cast:

 (struct hv_enlightened_vmcs *)this_cpu_read(current_vmcs)

so it is always not NULL here :-) We need to check enable_evmcs static
key first. Getting rid of the newly added enable_emsr_bitmap is, of
course, possible.

(Actually, we only call vmx_{dis,en}able_intercept_for_msr in the very
beginning of vCPUs life so this is not a hotpath and likeliness doesn't
really matter).

Will do v2 without the static key, thanks!

>
> The function, also, is small enough that inlining should be beneficial.
>
> Paolo

-- 
  Vitaly
