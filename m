Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02460C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD3921565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD3921565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeIZXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbeIZXaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A54543001760;
        Wed, 26 Sep 2018 17:16:05 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 140365D73F;
        Wed, 26 Sep 2018 17:16:03 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
In-Reply-To: <20180926141129.GD27433@linux.intel.com>
References: <20180925175844.20277-1-vkuznets@redhat.com> <20180925175844.20277-3-vkuznets@redhat.com> <20180926141129.GD27433@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:16:02 +0200
Message-ID: <87zhw4nprh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 26 Sep 2018 17:16:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Sep 25, 2018 at 07:58:37PM +0200, Vitaly Kuznetsov wrote:
>> kvm_init_shadow_ept_mmu() doesn't set get_pdptr() hook and is this
>> not a problem just because MMU context is already initialized and this
>> hook points to kvm_pdptr_read(). As we're intended to use a dedicated
>> MMU for shadow EPT MMU set this hook explicitly.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/kvm/mmu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index ca79ec0d8060..2bdc63f67886 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -4846,6 +4846,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>>  	context->root_level = PT64_ROOT_4LEVEL;
>>  	context->direct_map = false;
>>  	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
>> +	context->get_pdptr = kvm_pdptr_read;
>
> Would it make sense to set this in nested_ept_init_mmu_context()
> along with set_cr3, get_cr3 and inject_page_fault?  The other MMU
> flows set them as a package deal.

Well, kvm_init_shadow_ept_mmu() has only one call site and reading the
code I was under an impression we set set_cr3/get_cr3/inject_page_fault
in vmx.c just to avoid passing all these vmx-specific functions as
pointers to kvm_init_shadow_ept_mmu(). With get_pdptr() I was thinking
"oh, great, this is not vmx-specific so we can set it in mmu.c" - but I
see your point and I'm ready to budge :-)

>
> Either way...
>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks!

>
>> +
>>  	update_permission_bitmask(vcpu, context, true);
>>  	update_pkru_bitmask(vcpu, context, true);
>>  	update_last_nonleaf_level(vcpu, context);

-- 
Vitaly
