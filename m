Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B00DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90C52152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90C52152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeIZXdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeIZXdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:33:19 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 643573DBC4;
        Wed, 26 Sep 2018 17:19:23 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A375DB564;
        Wed, 26 Sep 2018 17:19:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] x86/kvm/mmu: make space for source data caching in struct kvm_mmu
In-Reply-To: <20180926144018.GH27433@linux.intel.com>
References: <20180925175844.20277-1-vkuznets@redhat.com> <20180925175844.20277-7-vkuznets@redhat.com> <20180926144018.GH27433@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:19:18 +0200
Message-ID: <87tvmcnpm1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 26 Sep 2018 17:19:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Sep 25, 2018 at 07:58:41PM +0200, Vitaly Kuznetsov wrote:
>> In preparation to MMU reconfiguration avoidance we need a space to
>> cache source data. As this partially intersects with kvm_mmu_page_role,
>> create 64bit sized union kvm_mmu_role holding both base and extended data.
>> No functional change.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> One nit below, other than that...
>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index e59e5f49c8c2..bb1ef0f68f8e 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -2359,7 +2359,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>>  	int collisions = 0;
>>  	LIST_HEAD(invalid_list);
>>  
>> -	role = vcpu->arch.mmu->base_role;
>> +	role = vcpu->arch.mmu->mmu_role.base;
>>  	role.level = level;
>>  	role.direct = direct;
>>  	if (role.direct)
>> @@ -4407,7 +4407,8 @@ static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
>>  void
>>  reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
>>  {
>> -	bool uses_nx = context->nx || context->base_role.smep_andnot_wp;
>> +	bool uses_nx = context->nx ||
>> +		context->mmu_role.base.smep_andnot_wp;
>>  	struct rsvd_bits_validate *shadow_zero_check;
>>  	int i;
>>  
>> @@ -4726,7 +4727,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_mmu *context = vcpu->arch.mmu;
>>  
>> -	context->base_role.word = mmu_base_role_mask.word &
>> +	context->mmu_role.base.word = mmu_base_role_mask.word &
>>  				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
>>  	context->page_fault = tdp_page_fault;
>>  	context->sync_page = nonpaging_sync_page;
>> @@ -4807,7 +4808,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>>  	else
>>  		paging32_init_context(vcpu, context);
>>  
>> -	context->base_role.word = mmu_base_role_mask.word &
>> +	context->mmu_role.base.word = mmu_base_role_mask.word &
>>  				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
>>  	reset_shadow_zero_bits_mask(vcpu, context);
>>  }
>> @@ -4816,7 +4817,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
>>  static union kvm_mmu_page_role
>>  kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
>>  {
>> -	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
>> +	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base;
>>  
>>  	role.level = PT64_ROOT_4LEVEL;
>>  	role.direct = false;
>> @@ -4846,7 +4847,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>>  	context->update_pte = ept_update_pte;
>>  	context->root_level = PT64_ROOT_4LEVEL;
>>  	context->direct_map = false;
>> -	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
>> +	context->mmu_role.base.word =
>> +		root_page_role.word & mmu_base_role_mask.word;
>>  	context->get_pdptr = kvm_pdptr_read;
>>  
>>  	update_permission_bitmask(vcpu, context, true);
>> @@ -5161,10 +5163,13 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>>  
>>  		local_flush = true;
>>  		while (npte--) {
>> +			unsigned int base_role =
>
> Nit: should this be a u32 to match mmu_role.base.word?
>

Of course, will do in v3. Thanks!

>> +				vcpu->arch.mmu->mmu_role.base.word;
>> +
>>  			entry = *spte;
>>  			mmu_page_zap_pte(vcpu->kvm, sp, spte);
>>  			if (gentry &&
>> -			      !((sp->role.word ^ vcpu->arch.mmu->base_role.word)
>> +			      !((sp->role.word ^ base_role)
>>  			      & mmu_base_role_mask.word) && rmap_can_add(vcpu))
>>  				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
>>  			if (need_remote_flush(entry, *spte))
>> @@ -5861,6 +5866,16 @@ int kvm_mmu_module_init(void)
>>  {
>>  	int ret = -ENOMEM;
>>  
>> +	/*
>> +	 * MMU roles use union aliasing which is, generally speaking, an
>> +	 * undefined behavior. However, we supposedly know how compilers behave
>> +	 * and the current status quo is unlikely to change. Guardians below are
>> +	 * supposed to let us know if the assumption becomes false.
>> +	 */
>> +	BUILD_BUG_ON(sizeof(union kvm_mmu_page_role) != sizeof(u32));
>> +	BUILD_BUG_ON(sizeof(union kvm_mmu_extended_role) != sizeof(u32));
>> +	BUILD_BUG_ON(sizeof(union kvm_mmu_role) != sizeof(u64));
>> +
>>  	kvm_mmu_reset_all_pte_masks();
>>  
>>  	pte_list_desc_cache = kmem_cache_create("pte_list_desc",
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 93ff08136fc1..c56a80c15c4f 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -9321,7 +9321,7 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
>>  
>>  		kvm_mmu_unload(vcpu);
>>  		mmu->ept_ad = accessed_dirty;
>> -		mmu->base_role.ad_disabled = !accessed_dirty;
>> +		mmu->mmu_role.base.ad_disabled = !accessed_dirty;
>>  		vmcs12->ept_pointer = address;
>>  		/*
>>  		 * TODO: Check what's the correct approach in case
>> -- 
>> 2.17.1
>> 

-- 
Vitaly
