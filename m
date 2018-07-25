Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D51C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C000B20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C000B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeGYQbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:31:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728537AbeGYQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:31:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27AAF859A0;
        Wed, 25 Jul 2018 15:19:31 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 939582026D68;
        Wed, 25 Jul 2018 15:19:27 +0000 (UTC)
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
        <87effrphu3.fsf@vitty.brq.redhat.com>
        <2ed3d00b-bc99-2e2d-3a23-a86de767bfec@redhat.com>
        <87a7qfpfnr.fsf@vitty.brq.redhat.com>
        <a18d5eb9-e796-1d09-b3d5-1573ad7b1d20@redhat.com>
Date:   Wed, 25 Jul 2018 17:19:26 +0200
In-Reply-To: <a18d5eb9-e796-1d09-b3d5-1573ad7b1d20@redhat.com> (Paolo
        Bonzini's message of "Wed, 25 Jul 2018 16:39:11 +0200")
Message-ID: <87muufz6kh.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 15:19:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 15:19:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/07/2018 16:13, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 25/07/2018 15:26, Vitaly Kuznetsov wrote:
>>>
>>>> The other place where we set dirty_vmcs12 is the newly introduced
>>>> vmx_set_nested_state() but I think I'm going to add support for eVMCS
>>>> there later and just return something like -ENOTSUPP for now. Too many
>>>> people work on nested simultaneously :-)
>>>
>>> Hmm, I think that means you have to put the clean fields in the
>>> vmx_nested struct.  Then it's really easy in vmx_set_nested_state to
>>> clear all the clean bits.  Touching memory in vmx_set_nested_state is...
>>> *puts on sunglasses* a touchy subject (see comment in kvm/queue's
>>> enter_vmx_non_root_mode).
>>>
>> 
>> Not only clean fields, in case we can't touch memory in
>> vmx_set_nested_state I guess we'll need to cache the whole eVMCS, just
>> like we save cached_shadow_vmcs12. Anyway, let's eat the elephant one
>> bite at a time :-)
>
> You're right, but do we actually need to save the vmcs12 if eVMCS is
> active?  The format would be different, but the size wouldn't.

I think we don't: vmcs12 can always be re-constructed from eVMCS and
vice versa. The size is not exactly the same as we have some stuff
which is missing in eVMCS but we know that eVMCS will always fit into
vmcs12 area.

-- 
  Vitaly
