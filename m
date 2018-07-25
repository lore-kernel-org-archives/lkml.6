Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E17C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590F120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590F120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeGYOh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:37:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbeGYOh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C12AF85627;
        Wed, 25 Jul 2018 13:26:16 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87FBB2026D68;
        Wed, 25 Jul 2018 13:26:13 +0000 (UTC)
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
        <87in53pjgv.fsf@vitty.brq.redhat.com>
        <f464b4fa-19d0-6b8b-5afe-d491b1eee08a@redhat.com>
Date:   Wed, 25 Jul 2018 15:26:12 +0200
In-Reply-To: <f464b4fa-19d0-6b8b-5afe-d491b1eee08a@redhat.com> (Paolo
        Bonzini's message of "Wed, 25 Jul 2018 14:55:10 +0200")
Message-ID: <87effrphu3.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 13:26:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 13:26:16 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/07/2018 14:50, Vitaly Kuznetsov wrote:
>>>
>>> But is L0 allowed to write to hv_clean_fields?  
>> It is kinda expected to: currently I reset it in vmx_vcpu_run() and (if
>> I remember correctly) L1 Hyper-V only clears bits in this mask when it
>> touches certain fields so if we don't set it to 'all clean' it stays
>> zeroed forever.
>
> Oh, good.  I didn't understand it was bidirectional.
>
>  So nothing stops us from doing
>> 
>>        if (hv_evmcs && vmx->nested.dirty_vmcs12)
>>                hv_evmcs->hv_clean_fields &=
>>                        ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>> 
>> in prepare_vmcs02() I guess.
>
> In prepare_vmcs02, or rather in the enlightened VMPTRLD?
>

Doing it in nested_vmx_handle_enlightened_vmptrld() is even better: we
can simplify copy_enlightened_to_vmcs12() too!

The other place where we set dirty_vmcs12 is the newly introduced
vmx_set_nested_state() but I think I'm going to add support for eVMCS
there later and just return something like -ENOTSUPP for now. Too many
people work on nested simultaneously :-)

-- 
  Vitaly
