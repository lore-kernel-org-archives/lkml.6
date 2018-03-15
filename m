Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeCOLB7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:01:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751617AbeCOLBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:01:31 -0400
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
 <87fu51br1p.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02490491-9809-0057-fd4b-b1de81c713f3@redhat.com>
Date: Thu, 15 Mar 2018 12:01:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87fu51br1p.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2018 10:56, Vitaly Kuznetsov wrote:
>> +	EVMCS1_FIELD(VM_EXIT_MSR_STORE_ADDR, vm_exit_msr_store_addr,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
>> +	EVMCS1_FIELD(VM_EXIT_MSR_LOAD_ADDR, vm_exit_msr_load_addr,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
>> +	EVMCS1_FIELD(VM_ENTRY_MSR_LOAD_ADDR, vm_entry_msr_load_addr,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
>> +	EVMCS1_FIELD(VM_EXIT_MSR_STORE_COUNT, vm_exit_msr_store_count,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
>> +	EVMCS1_FIELD(VM_EXIT_MSR_LOAD_COUNT, vm_exit_msr_load_count,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
>> +	EVMCS1_FIELD(VM_ENTRY_MSR_LOAD_COUNT, vm_entry_msr_load_count,
>> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),

Hmm, actually these six are used.  I guess
HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL is the best we can do, apart from
asking Microsoft to fix the spec.


>>> +{
>>> +	*pin_based_exec_ctrl &= ~PIN_BASED_POSTED_INTR;> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_APIC_REGISTER_VIRT;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_PML;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_SHADOW_VMCS;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
>>> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
>>> +	*pin_based_exec_ctrl &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
>> How can these be set?
>>
> They can not if Hyper-V behaves but Radim didn't want to trust it -- so
> the suggestion was to forcefully disable unsupported controls.

Yeah, it's good to have, especially if placed before we start using the
values that are read.

>> This is wrong, we're reading the VMCS so the values must already be
>> sanitized (and if not, that's the bug and we want dump_vmcs to print the
>> "wrong" values).
> 
> The problem is that we vmcs_read these fields later in the function and
> this will now WARN(). Initally, there was no WARN() for non-existent
> fields so this could work (we would just print zeroes for unsupported
> fields). Maybe, additional WARN_ON() is not a big deal here.

If you WARN(), isn't it because the secondary_exec_control had a bad
value to begin with?  As you say, the controls should never be set.

Thanks,

Paolo
