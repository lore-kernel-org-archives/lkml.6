Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF7C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF727E8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACF727E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936174AbeF2Lht (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:37:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932331AbeF2Lhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60A4BC12A0;
        Fri, 29 Jun 2018 11:37:47 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1582156700;
        Fri, 29 Jun 2018 11:37:45 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx mapping
References: <20180628135313.17468-1-vkuznets@redhat.com>
        <20180628135313.17468-3-vkuznets@redhat.com>
        <20180629101134.GA15656@rkaganb.sw.ru>
        <87y3exdh2o.fsf@vitty.brq.redhat.com>
        <20180629111227.GB15656@rkaganb.sw.ru>
Date:   Fri, 29 Jun 2018 13:37:44 +0200
In-Reply-To: <20180629111227.GB15656@rkaganb.sw.ru> (Roman Kagan's message of
        "Fri, 29 Jun 2018 14:12:28 +0300")
Message-ID: <87tvplddrr.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 29 Jun 2018 11:37:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 29 Jun 2018 11:37:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jun 29, 2018 at 12:26:23PM +0200, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> 
>> > On Thu, Jun 28, 2018 at 03:53:10PM +0200, Vitaly Kuznetsov wrote:
>> >> While it is easy to get VP index from vCPU index the reverse task is hard.
>> >> Basically, to solve it we have to walk all vCPUs checking if their VP index
>> >> matches. For hypercalls like HvFlushVirtualAddress{List,Space}* and the
>> >> upcoming HvSendSyntheticClusterIpi* where a single CPU may be specified in
>> >> the whole set this is obviously sub-optimal.
>> >> 
>> >> As VP index can be set to anything <= U32_MAX by userspace using plain
>> >> [0..MAX_VP_INDEX] array is not a viable option. Use condensed sorted
>> >> array with logarithmic search complexity instead. Use RCU to make read
>> >> access as fast as possible and maintain atomicity of updates.
>> >
>> > Quoting TLFS 5.0C section 7.8.1:
>> >
>> >> Virtual processors are identified by using an index (VP index). The
>> >> maximum number of virtual processors per partition supported by the
>> >> current implementation of the hypervisor can be obtained through CPUID
>> >> leaf 0x40000005. A virtual processor index must be less than the
>> >> maximum number of virtual processors per partition.
>> >
>> > so this is a dense index, and VP_INDEX >= KVM_MAX_VCPUS is invalid.  I
>> > think we're better off enforcing this in kvm_hv_set_msr and keep the
>> > translation simple.  If the algorithm in get_vcpu_by_vpidx is not good
>> > enough (and yes it can be made to return NULL early on vpidx >=
>> > KVM_MAX_VCPUS instead of taking the slow path) then a simple index array
>> > of KVM_MAX_VCPUS entries should certainly do.
>> 
>> Sure, we can use pre-allocated [0..KVM_MAX_VCPUS] array instead and put
>> limits on what userspace can assign VP_INDEX to. Howver, while thinking
>> about it I decided to go with the more complex condensed array approach
>> because the tendency is for KVM_MAX_VCPUS to grow and we will be
>> pre-allocating more and more memory for no particular reason (so I think
>> even 'struct kvm_vcpu *vcpus[KVM_MAX_VCPUS]' in 'struct kvm' will need
>> to be converted to something else eventually). 
>
> We're talking of kilobytes here.  I guess this is going to be the least
> of the scalability problems.

Yes, kilobytes but per-VM.

>
>> Anyway, I'm flexible and if you think we should go this way now I'll do
>> this in v3. We can re-think this when we later decide to raise
>> KVM_MAX_VCPUS significantly.
>
> Although there's no strict requirement for that I think every sensible
> userspace will allocate VP_INDEX linearly resulting in it being equal to
> KVM's vcpu index.  So we've yet to see a case where get_vcpu_by_vpidx
> doesn't take the fast path.  If it ever starts appearing in the profiles
> we may consider optimiziing it but ATM I don't even think introducing
> the translation array is justified.

It was Radim who suggested it in the first place :-)

The problem we're trying to solve here is: with PV TLB flush and IPI we
need to walk through the supplied list of VP_INDEXes and get VCPU
ids. Usually they match. But in case they don't we'll fall back to full
scan for every VP_INDEX in the supplied list. Now let's say we have 128
CPUs. We'll need to perform up to 128 * 128 extra comparisons on every
hypercall. Not good. So instead of using get_vcpu_by_vpidx() I opted for
walking the whole VCPU list and checking if VPU's VP_INDEX is in the
supplied set. This way we end up with 128 comparisons in the example
above (worst case scenarion). However, we lose in simple scenarios like
only 1 VP_INDEX was specified in the set: we'll still need to walk the
whole list. So having the translation array (one way or another) is IMO
justified.

-- 
  Vitaly
