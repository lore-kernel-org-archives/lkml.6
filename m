Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033144AbeBNQ7E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:59:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032821AbeBNQ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:59:03 -0500
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
 <20180214164438.GI18349@pd.tnic>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5ede174-9fd7-3303-41b8-a14673d8edca@redhat.com>
Date: Wed, 14 Feb 2018 17:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180214164438.GI18349@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 17:44, Borislav Petkov wrote:
> On Thu, Feb 08, 2018 at 04:58:46PM -0600, Tom Lendacky wrote:
>> @@ -2681,11 +2731,15 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
>>  {
>>  	int i, idx;
>>  
>> -	idx = srcu_read_lock(&vcpu->kvm->srcu);
>> +	if (vcpu)
>> +		idx = srcu_read_lock(&vcpu->kvm->srcu);
>> +
>>  	for (i = 0; i < msrs->nmsrs; ++i)
>>  		if (do_msr(vcpu, entries[i].index, &entries[i].data))
>>  			break;
>> -	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>> +
>> +	if (vcpu)
>> +		srcu_read_unlock(&vcpu->kvm->srcu, idx);
> 
> 
> ./include/linux/srcu.h:175:2: warning: ‘idx’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   __srcu_read_unlock(sp, idx);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/kvm/x86.c:2739:9: note: ‘idx’ was declared here
>   int i, idx;
>          ^~~
> 
> I know, silly gcc.
> 

Nice point---even better, just push srcu_read_lock/unlock to msr_io or
even msr_io's callers.

Thanks,

Paolo
