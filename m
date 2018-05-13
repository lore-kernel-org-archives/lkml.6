Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeEMIrS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:47:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeEMIrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:47:16 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
References: <20180416110806.4896-1-vkuznets@redhat.com>
        <20180416110806.4896-5-vkuznets@redhat.com>
        <20180510194016.GB3885@flask>
Date: Sun, 13 May 2018 10:47:12 +0200
In-Reply-To: <20180510194016.GB3885@flask> ("Radim \=\?utf-8\?B\?S3LEjW3DocWZ\?\=
 \=\?utf-8\?B\?Iidz\?\= message of "Thu,
        10 May 2018 21:40:17 +0200")
Message-ID: <877eo8lz73.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-04-16 13:08+0200, Vitaly Kuznetsov:
...
>
>> +		/*
>> +		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
>> +		 * can't analyze it here, flush TLB regardless of the specified
>> +		 * address space.
>> +		 */
>> +		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>> +
>> +		/*
>> +		 * It is possible that vCPU will migrate and we will kick wrong
>> +		 * CPU but vCPU's TLB will anyway be flushed upon migration as
>> +		 * we already made KVM_REQ_TLB_FLUSH request.
>> +		 */
>> +		cpu = vcpu->cpu;
>> +		if (cpu != -1 && cpu != me && cpu_online(cpu) &&
>> +		    kvm_arch_vcpu_should_kick(vcpu))
>> +			cpumask_set_cpu(cpu, &hv_current->tlb_lush);
>> +	}
>> +
>> +	if (!cpumask_empty(&hv_current->tlb_lush))
>> +		smp_call_function_many(&hv_current->tlb_lush, ack_flush,
>> +				       NULL, true);
>
> Hm, quite a lot of code duplication with EX hypercall and also
> kvm_make_all_cpus_request ... I'm thinking about making something like
>
>   kvm_make_some_cpus_request(struct kvm *kvm, unsigned int req,
>                              bool (*predicate)(struct kvm_vcpu *vcpu))
>
> or to implement a vp_index -> vcpu mapping and using
>
>   kvm_vcpu_request_mask(struct kvm *kvm, unsigned int req, long *vcpu_bitmap)
>
> The latter would probably simplify logic of the EX hypercall.

We really want to avoid memory allocation for cpumask on this path and
that's what kvm_make_all_cpus_request() currently does (when
CPUMASK_OFFSTACK). vcpu bitmap is probably OK as KVM_MAX_VCPUS is much
lower.

Making cpumask allocation avoidable leads us to the following API:

bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
				 long *vcpu_bitmap, cpumask_var_t tmp);

or, if we want to prettify this a little bit, we may end up with the
following pair:

bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
				 long *vcpu_bitmap);

bool __kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
  				   long *vcpu_bitmap, cpumask_var_t tmp);

and from hyperv code we'll use the later. With this, no code duplication
is required.

Does this look acceptable?

-- 
  Vitaly
