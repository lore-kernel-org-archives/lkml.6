Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971584AbeCSUvY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:51:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967942AbeCSUvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:51:17 -0400
Subject: Re: [RFC 01/12] KVM: arm/arm64: Avoid multiple dist->spis kfree
To: Marc Zyngier <marc.zyngier@arm.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, cdall@kernel.org,
        peter.maydell@linaro.org
References: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
 <1521451220-27754-2-git-send-email-eric.auger@redhat.com>
 <92f4b34e-f361-869a-7fca-c62a70e646b7@arm.com>
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5371a89a-c0f7-6c45-3e3a-abd3ba108c97@redhat.com>
Date: Mon, 19 Mar 2018 21:51:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <92f4b34e-f361-869a-7fca-c62a70e646b7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 19/03/18 14:46, Marc Zyngier wrote:
> On 19/03/18 09:20, Eric Auger wrote:
>> in case kvm_vgic_map_resources() fails, typically if the vgic
>> distributor is not defined, __kvm_vgic_destroy will be called
>> several times. Indeed kvm_vgic_map_resources() is called on
>> first vcpu run. As a result dist->spis is freeed twice and on
>> the second time it causes a "kernel BUG at mm/slub.c:3912!"
>>
>> This patch avoids freeing dist->spis twice.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-init.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
>> index 743ca5c..38fd5f1 100644
>> --- a/virt/kvm/arm/vgic/vgic-init.c
>> +++ b/virt/kvm/arm/vgic/vgic-init.c
>> @@ -324,7 +324,10 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
>>  	dist->ready = false;
>>  	dist->initialized = false;
>>  
>> -	kfree(dist->spis);
>> +	if (dist->spis) {
>> +		kfree(dist->spis);
>> +		dist->spis = NULL;
>> +	}
> 
> Given that kfree(NULL) is always a valid thing to do, you could write
> the same thing just as
> 
> 	dist-> spis = NULL;
> 
> without any test.
sure
> 
>>  	dist->nr_spis = 0;
>>  
>>  	if (vgic_supports_direct_msis(kvm))
>>
> 
> You also may want to add a Fixes tag to it.
OK

Thanks

Eric
> 
> Thanks,
> 
> 	M.
> 
