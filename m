Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeJKU15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeJKU14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF4E13001FD1;
        Thu, 11 Oct 2018 13:00:50 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-17.brq.redhat.com [10.40.204.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9FA88B92E;
        Thu, 11 Oct 2018 13:00:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel\@vger kernel org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()
In-Reply-To: <CAOLK0pzL5qvUksKwieoVgsqM9e6Bibu1kKR1kvr96jMMz_RxdQ@mail.gmail.com>
References: <20181011100312.4083-1-vkuznets@redhat.com> <CAOLK0pzTzubAcgv3nd_G6pSbB48Xw-ANbCn7+wX0NE1ssDW2Vg@mail.gmail.com> <87zhvkpth0.fsf@vitty.brq.redhat.com> <CAOLK0pzL5qvUksKwieoVgsqM9e6Bibu1kKR1kvr96jMMz_RxdQ@mail.gmail.com>
Date:   Thu, 11 Oct 2018 15:00:47 +0200
Message-ID: <87woqopri8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 11 Oct 2018 13:00:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <lantianyu1986@gmail.com> writes:

> On Thu, Oct 11, 2018 at 8:18 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Tianyu Lan <lantianyu1986@gmail.com> writes:
>>
>> > On Thu, Oct 11, 2018 at 6:32 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >>
>> >> I'm observing random crashes in multi-vCPU L2 guests running on KVM on
>> >> Hyper-V. I bisected the issue to the commit 877ad952be3d ("KVM: vmx: Add
>> >> tlb_remote_flush callback support"). Hyper-V TLFS states:
>> >>
>> >> "AddressSpace specifies an address space ID (an EPT PML4 table pointer)"
>> >>
>> >> So apparently, Hyper-V doesn't expect us to pass naked EPTP, only PML4
>> >> pointer should be used. Strip off EPT configuration information before
>> >> calling into vmx_hv_remote_flush_tlb().
>> >
>> > Hi Vitaly:
>> > :               Thanks to fix this. Sorry, I didn't meet the issue..
>> > I think we may just store EPT PML4 table pointer without EPT
>> > configuration information
>> > in the ept_pointer field for this case.
>> >
>> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> > index 619307b3e6bb..e316058b41a6 100644
>> > --- a/arch/x86/kvm/vmx.c
>> > +++ b/arch/x86/kvm/vmx.c
>> > @@ -5379,7 +5379,7 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu,
>> > unsigned long cr3)
>> >
>> >                 if (kvm_x86_ops->tlb_remote_flush) {
>> >                         spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
>> > -                       to_vmx(vcpu)->ept_pointer = eptp;
>> > +                       to_vmx(vcpu)->ept_pointer = cr3;
>>
>> True, we can do that (and I even had a version of my patch doing so)
>> but 'ept_pointer' will likely need to be renamed as it's not obvious
>> why vcpu->ept_pointer != eptp.
>>
>
> Yes. that need to rename ept_pointer.
>

Honestly, I would prefer to keep more information cached, e.g. if
someone needs EPT configuration data later he can easily get it from
ept_pointer and by putting raw cr3 there we'll just keep less.

But I don't have a strong opinion, I'll leave it up to the maintainers
to tell us how to proceed)

>> Alternatively, we can filter lower 12 bits out in
>> hyperv_flush_guest_mapping() but I would rename 'as' parameter to eptp
>> then.
>
> OK. I got it. Thanks.

-- 
Vitaly
