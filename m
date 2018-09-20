Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6962121526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6962121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbeITNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeITNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37C2F308FE91;
        Thu, 20 Sep 2018 08:12:58 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-168.brq.redhat.com [10.40.204.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F3805C26E;
        Thu, 20 Sep 2018 08:12:55 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 6/9] x86/kvm/mmu: make space for source data caching in struct kvm_mmu
References: <20180802100132.5249-1-vkuznets@redhat.com>
        <20180802100132.5249-7-vkuznets@redhat.com>
        <1537372499.9937.42.camel@intel.com>
Date:   Thu, 20 Sep 2018 10:12:52 +0200
In-Reply-To: <1537372499.9937.42.camel@intel.com> (Sean Christopherson's
        message of "Wed, 19 Sep 2018 08:54:59 -0700")
Message-ID: <87h8iky4cb.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 20 Sep 2018 08:12:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, 2018-08-02 at 12:01 +0200, Vitaly Kuznetsov wrote:
>> In preparation to MMU reconfiguration avoidance we need a space to
>> cache source data. As this partially intersects with kvm_mmu_page_role,
>> create 64bit sized union kvm_mmu_role holding both base_role and
>> extended data. No functional change.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 14 +++++++++++++-
>>  arch/x86/kvm/mmu.c              | 19 ++++++++++++-------
>>  arch/x86/kvm/vmx.c              |  2 +-
>>  3 files changed, 26 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index c5f116f9783d..830166ab4d59 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -272,6 +272,18 @@ union kvm_mmu_page_role {
>>  	};
>>  };
>>  
>> +union kvm_mmu_scache {
>> +	unsigned int word;
>> +};
>> +
>> +union kvm_mmu_role {
>> +	unsigned long as_u64;
>
> No clue if it matters, but can't this be a u32 since both
> kvm_mmu_page_role and kvm_mmu_scache are capped at 16 bits?

kvm_mmu_page_role is 32 bits, even if we make 'smm' a 1-bit field and
throw away its padding we'll end up with 19 bits ...

(Generally speaking, I would prefer to leave some space for future
extension: we only have 3 'struct kvm_mmu' per vcpu so we're talking
about 12 bytes. We can, of course, change types here in future - this in
not a stable ABI or anything - but the one doing that will have to check
all users and this is always error-prone.)

>
> Tangentially related, it seems like we should have build-
> time asserts on the size of the unions since we're (ab)using
> union behavior to dereference the entire value in a single
> shot, e.g. base_role.word and mmu_role->as_u64.

(I was told that union aliasing is UB, however, it's all over kernel so
it's unlikely that gcc's behavior is ever going to change).

I like your idea, I'll add a couple of BUILD_BUG_ONs in v2. Thanks!

>
>> +	struct {
>> +		union kvm_mmu_page_role base_role;
>> +		union kvm_mmu_scache scache;
>> +	};
>> +};
>> +
>>  struct kvm_rmap_head {
>>  	unsigned long val;
>>  };
>> @@ -359,7 +371,7 @@ struct kvm_mmu {
>>  	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>>  			   u64 *spte, const void *pte);
>>  	hpa_t root_hpa;
>> -	union kvm_mmu_page_role base_role;
>> +	union kvm_mmu_role mmu_role;
>>  	u8 root_level;
>>  	u8 shadow_root_level;
>>  	u8 ept_ad;
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index 85ec027299d6..c538e47e471b 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -2331,7 +2331,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>>  	int collisions = 0;
>>  	LIST_HEAD(invalid_list);
>>  
>> -	role = vcpu->arch.mmu->base_role;
>> +	role = vcpu->arch.mmu->mmu_role.base_role;
>>  	role.level = level;
>>  	role.direct = direct;
>>  	if (role.direct)
>> @@ -4377,7 +4377,8 @@ static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
>>  void
>>  reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
>>  {
>> -	bool uses_nx = context->nx || context->base_role.smep_andnot_wp;
>> +	bool uses_nx = context->nx ||
>> +		context->mmu_role.base_role.smep_andnot_wp;
>>  	struct rsvd_bits_validate *shadow_zero_check;
>>  	int i;
>>  
>> @@ -4696,7 +4697,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_mmu *context = vcpu->arch.mmu;
>>  
>> -	context->base_role.word = mmu_base_role_mask.word &
>> +	context->mmu_role.base_role.word = mmu_base_role_mask.word &
>>  				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
>>  	context->page_fault = tdp_page_fault;
>>  	context->sync_page = nonpaging_sync_page;
>> @@ -4777,7 +4778,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>>  	else
>>  		paging32_init_context(vcpu, context);
>>  
>> -	context->base_role.word = mmu_base_role_mask.word &
>> +	context->mmu_role.base_role.word = mmu_base_role_mask.word &
>>  				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
>>  	reset_shadow_zero_bits_mask(vcpu, context);
>>  }
>> @@ -4786,7 +4787,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
>>  static union kvm_mmu_page_role
>>  kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
>>  {
>> -	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
>> +	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base_role;
>>  
>>  	role.level = PT64_ROOT_4LEVEL;
>>  	role.direct = false;
>> @@ -4816,7 +4817,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>>  	context->update_pte = ept_update_pte;
>>  	context->root_level = PT64_ROOT_4LEVEL;
>>  	context->direct_map = false;
>> -	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
>> +	context->mmu_role.base_role.word =
>> +		root_page_role.word & mmu_base_role_mask.word;
>>  	context->get_pdptr = kvm_pdptr_read;
>>  
>>  	update_permission_bitmask(vcpu, context, true);
>> @@ -5131,10 +5133,13 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>>  
>>  		local_flush = true;
>>  		while (npte--) {
>> +			unsigned int base_role =
>> +				vcpu->arch.mmu->mmu_role.base_role.word;
>> +
>>  			entry = *spte;
>>  			mmu_page_zap_pte(vcpu->kvm, sp, spte);
>>  			if (gentry &&
>> -			      !((sp->role.word ^ vcpu->arch.mmu->base_role.word)
>> +			      !((sp->role.word ^ base_role)
>>  			      & mmu_base_role_mask.word) && rmap_can_add(vcpu))
>>  				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
>>  			if (need_remote_flush(entry, *spte))
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 494148818b8d..0d41116bef1f 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -9028,7 +9028,7 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
>>  
>>  		kvm_mmu_unload(vcpu);
>>  		mmu->ept_ad = accessed_dirty;
>> -		mmu->base_role.ad_disabled = !accessed_dirty;
>> +		mmu->mmu_role.base_role.ad_disabled = !accessed_dirty;
>>  		vmcs12->ept_pointer = address;
>>  		/*
>>  		 * TODO: Check what's the correct approach in case

-- 
  Vitaly
