Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A448C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F59C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F59C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeGYOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:02:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbeGYOCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:02:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41E1A40216E3;
        Wed, 25 Jul 2018 12:51:01 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2614D20389E0;
        Wed, 25 Jul 2018 12:50:57 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 6/6] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
References: <20180621123046.29606-1-vkuznets@redhat.com>
        <20180621123046.29606-7-vkuznets@redhat.com>
        <a826fd88-0199-8e7b-ebfc-290e936b5efc@redhat.com>
        <87va93pv6w.fsf@vitty.brq.redhat.com>
        <46052d1e-9ee1-8cee-3f7c-cf27b1cd0373@redhat.com>
Date:   Wed, 25 Jul 2018 14:50:56 +0200
In-Reply-To: <46052d1e-9ee1-8cee-3f7c-cf27b1cd0373@redhat.com> (Paolo
        Bonzini's message of "Wed, 25 Jul 2018 14:14:49 +0200")
Message-ID: <87in53pjgv.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 12:51:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 12:51:01 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/07/2018 10:37, Vitaly Kuznetsov wrote:
>>> Why is this needed?  If it weren't for it, you could pass hv_evmcs
>>> directly to evmcs_needs_write, which would simplify the code a bit in
>>> the caller.
>> This is an equivalent of prepare_vmcs02()/prepare_vmcs02_full() split
>> for eVMCS case: when we switch from L2 guest A to L2 guest B we need to
>> write the whole VMCS so evmcs_needs_write() needs to return true.
>
> Right, I missed the dirty_vmcs12 assignment in patch 5.
>
> But is L0 allowed to write to hv_clean_fields?  

It is kinda expected to: currently I reset it in vmx_vcpu_run() and (if
I remember correctly) L1 Hyper-V only clears bits in this mask when it
touches certain fields so if we don't set it to 'all clean' it stays
zeroed forever. So nothing stops us from doing 

       if (hv_evmcs && vmx->nested.dirty_vmcs12)
               hv_evmcs->hv_clean_fields &=
                       ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;

in prepare_vmcs02() I guess.

> One possibility is to
> add a dirty_evmcs field to struct nested_vmx, and "OR" ~hv_clean_fields
> into it at the beginning of prepare_vmcs02.
>
> Something like
>
> 	if (vmx->nested.hv_evmcs) {
> 		vmx->nested.dirty_evmcs |=
> 			~vmx->nested.hv_evmcs->hv_clean_fields;
> 		prepare_vmcs02_full(vcpu, vmcs12,
> 				    vmx->nested.dirty_evmcs);
> 	} else if (vmx->nested.dirty_vmcs12) {
> 		prepare_vmcs02_full(vcpu, vmcs12, ~0);
> 	}
>
> 	...
> 	vmx->nested.dirty_evmcs = 0;
> 	vmx->nested.dirty_vmcs12 = false;
>
> ?
>

I think we can even get away with a local variable in prepare_vmcs02()
and pass it to prepare_vmcs02_full(), no need to have it in struct
nested_vmx. But I would slightly prefer to just reset
hv_evmcs->hv_clean_fields when vmcs12 is dirty.

Thanks,

-- 
  Vitaly
