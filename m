Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeDZI3r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:29:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753655AbeDZI3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:29:44 -0400
Subject: Re: [PATCH v3 07/12] KVM: arm/arm64: Adapt vgic_v3_check_base to
 multiple rdist regions
To: Christoffer Dall <christoffer.dall@arm.com>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
 <1523607658-9166-8-git-send-email-eric.auger@redhat.com>
 <20180424210748.GH4533@C02W217FHV2R.local>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, cdall@kernel.org, peter.maydell@linaro.org,
        andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <557b2aaf-3f6f-ea11-55e2-5667b651922b@redhat.com>
Date: Thu, 26 Apr 2018 10:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180424210748.GH4533@C02W217FHV2R.local>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer,
On 04/24/2018 11:07 PM, Christoffer Dall wrote:
> On Fri, Apr 13, 2018 at 10:20:53AM +0200, Eric Auger wrote:
>> We introduce a new helper to check there is no overlap between
>> dist region (if set) and registered rdist regions. This both
>> handles the case of legacy single rdist region (implicitly sized
>> with the number of online vcpus) and the new case of multiple
>> explicitly sized rdist regions.
> 
> I don't understand this change, really.  Is this just a cleanup, or
> changing some functionality (why?).
> 
> I think this could have come with the introduction of
> vgic_v3_rdist_overlap() before patch 6, and then patch 6 could have been
> simplified (hopefully) to just call this "check that nothing in the
> world ever collides withi itself" function.
I have merged this patch and vgic_v3_rd_region_size +
vgic_v3_rdist_overlap and put it before this patch.

Also I reworked the commit message which was unclear I acknowledge.

With respect to using the adapted  vgic_v3_check_base() in
vgic_v3_insert_redist_region(), it is less obvious to me.

In vgic_v3_insert_redist_region we do the checks *before* inserting the
new rdist region in the list of redist regions. While
vgic_v3_check_base() does the checks on already registered rdist and
dist regions. So I would be tempted to leave
vgic_v3_insert_redist_region() implementation as it is.

Thanks

Eric
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-v3.c | 26 +++++++++-----------------
>>  1 file changed, 9 insertions(+), 17 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
>> index dbcba5f..b80f650 100644
>> --- a/virt/kvm/arm/vgic/vgic-v3.c
>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
>> @@ -432,31 +432,23 @@ bool vgic_v3_rdist_overlap(struct kvm *kvm, gpa_t base, size_t size)
>>  bool vgic_v3_check_base(struct kvm *kvm)
>>  {
>>  	struct vgic_dist *d = &kvm->arch.vgic;
>> -	gpa_t redist_size = KVM_VGIC_V3_REDIST_SIZE;
>> -	struct vgic_redist_region *rdreg =
>> -		list_first_entry(&d->rd_regions,
>> -				 struct vgic_redist_region, list);
>> -
>> -	redist_size *= atomic_read(&kvm->online_vcpus);
>> +	struct vgic_redist_region *rdreg;
>>  
>>  	if (!IS_VGIC_ADDR_UNDEF(d->vgic_dist_base) &&
>>  	    d->vgic_dist_base + KVM_VGIC_V3_DIST_SIZE < d->vgic_dist_base)
>>  		return false;
>>  
>> -	if (rdreg && (rdreg->base + redist_size < rdreg->base))
>> -		return false;
>> +	list_for_each_entry(rdreg, &d->rd_regions, list) {
>> +		if (rdreg->base + vgic_v3_rd_region_size(kvm, rdreg) <
>> +			rdreg->base)
>> +			return false;
>> +	}
>>  
>> -	/* Both base addresses must be set to check if they overlap */
>> -	if (IS_VGIC_ADDR_UNDEF(d->vgic_dist_base) || !rdreg)
>> +	if (IS_VGIC_ADDR_UNDEF(d->vgic_dist_base))
>>  		return true;
>>  
>> -	if (d->vgic_dist_base + KVM_VGIC_V3_DIST_SIZE <= rdreg->base)
>> -		return true;
>> -
>> -	if (rdreg->base + redist_size <= d->vgic_dist_base)
>> -		return true;
>> -
>> -	return false;
>> +	return !vgic_v3_rdist_overlap(kvm, d->vgic_dist_base,
>> +				      KVM_VGIC_V3_DIST_SIZE);
>>  }
>>  
>>  /**
>> -- 
>> 2.5.5
>>
> Otherwise this patch looks correct to me.
> 
> Thanks,
> -Christoffer
> 
