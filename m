Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1543216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1543216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeI0UCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeI0UCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:02:55 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 641C78830F;
        Thu, 27 Sep 2018 13:44:35 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D144CB7E9F;
        Thu, 27 Sep 2018 13:44:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] x86/kvm/nVMX: introduce source data cache for kvm_init_shadow_ept_mmu()
In-Reply-To: <87r2hgnp3r.fsf@vitty.brq.redhat.com>
References: <20180925175844.20277-1-vkuznets@redhat.com> <20180925175844.20277-8-vkuznets@redhat.com> <20180926150556.GI27433@linux.intel.com> <87r2hgnp3r.fsf@vitty.brq.redhat.com>
Date:   Thu, 27 Sep 2018 15:44:32 +0200
Message-ID: <87mus3f41r.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 27 Sep 2018 13:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>
>> On Tue, Sep 25, 2018 at 07:58:42PM +0200, Vitaly Kuznetsov wrote:
...
>>>  
>>> -static union kvm_mmu_page_role
>>> -kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
>>> +static union kvm_mmu_role
>>> +kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
>>> +				   bool execonly)
>>>  {
>>> -	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base;
>>> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu);
>>
>> kvm_calc_mmu_role_common() doesn't preserve the current mmu_role.base
>> and kvm_calc_mmu_role_common() doesn't capture all base fields.  Won't
>> @role will be incorrect for base fields that aren't set below, e.g.
>> cr4_pae, smep_andnot_wp, smap_andnot_wp, etc...
>
> Oh, I see what you mean. Actually, PATCH8 of this series adds some of
> this stuff but smep_andnot_wp and smap_andnot_wp are still not set. I
> think I'll enhance kvm_calc_mmu_role_common() and move some stuff from
> PATCH8 to this one.
> (The fact that @role is currently not fully re-initialized here is very
> unobvious so I would definitely prefer to explicitly initialize
> everything over inheriting something from previously initialized role).

On the other hand if we want to perform full re-initialization we'll
have to distinguish between shadow and TDP here and this isn't what we
want. I'm about to change my mind as it seems that inheriting base role
here is not the worst idea after all...

-- 
Vitaly
