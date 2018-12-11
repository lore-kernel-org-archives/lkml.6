Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F60C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B9D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLKPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:04:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKPEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:04:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DF24307D846;
        Tue, 11 Dec 2018 15:04:05 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE1425D717;
        Tue, 11 Dec 2018 15:04:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 4/7] x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID
In-Reply-To: <20181211140247.GC2378@rkaganb.sw.ru>
References: <20181210172159.410-1-vkuznets@redhat.com> <20181210172159.410-5-vkuznets@redhat.com> <20181211124956.GA2378@rkaganb.sw.ru> <87bm5sp501.fsf@vitty.brq.redhat.com> <20181211140247.GC2378@rkaganb.sw.ru>
Date:   Tue, 11 Dec 2018 16:04:01 +0100
Message-ID: <87woognlzy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 11 Dec 2018 15:04:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Tue, Dec 11, 2018 at 02:28:14PM +0100, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> 
>> > On Mon, Dec 10, 2018 at 06:21:56PM +0100, Vitaly Kuznetsov wrote:
>> 
>> >> +
>> >> +Currently, the following list of CPUID leaves are returned:
>> >> + HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS
>> >> + HYPERV_CPUID_INTERFACE
>> >> + HYPERV_CPUID_VERSION
>> >> + HYPERV_CPUID_FEATURES
>> >> + HYPERV_CPUID_ENLIGHTMENT_INFO
>> >> + HYPERV_CPUID_IMPLEMENT_LIMITS
>> >> + HYPERV_CPUID_NESTED_FEATURES
>> >> +
>> >> +HYPERV_CPUID_NESTED_FEATURES leaf is only exposed when Enlightened VMCS was
>> >> +enabled on the corresponding vCPU (KVM_CAP_HYPERV_ENLIGHTENED_VMCS).
>> >
>> > IOW the output of ioctl(KVM_GET_SUPPORTED_HV_CPUID) depends on
>> > whether ioctl(KVM_ENABLE_CAP, KVM_CAP_HYPERV_ENLIGHTENED_VMCS) has
>> > already been called on that vcpu?  I wonder if this fits the intended
>> > usage?
>> 
>> I added HYPERV_CPUID_NESTED_FEATURES in the list (and made the new ioctl
>> per-cpu and not per-vm) for consistency. *In theory*
>> KVM_CAP_HYPERV_ENLIGHTENED_VMCS is also enabled per-vcpu so some
>> hypothetical userspace can later check enabled eVMCS versions (which can
>> differ across vCPUs!) with KVM_GET_SUPPORTED_HV_CPUID. We will also have
>> direct tlb flush and other nested features there so to avoid addning new
>> KVM_CAP_* for them we need the CPUID.
>
> This is different from how KVM_GET_SUPPORTED_CPUID is used: QEMU assumes
> that its output doesn't change between calls, and even caches the result
> calling the ioctl only once.
>

Yes, I'm not sure if we have to have full consistency between
KVM_GET_SUPPORTED_CPUID and KVM_GET_SUPPORTED_HV_CPUID.

>> Another thing I'm thinking about is something like 'hv_all' cpu flag for
>> Qemu which would enable everything by setting guest CPUIDs to what
>> KVM_GET_SUPPORTED_HV_CPUID returns. In that case it would also be
>> convenient to have HYPERV_CPUID_NESTED_FEATURES properly filled (or not
>> filled when eVMCS was not enabled).
>
> I think this is orthogonal to the way you obtain capability info from
> the kernel.

Not necessarily. If very dumb userspace does 'host passthrough' for
Hyper-V features without doing anything (e.g. not enabling Enlightened
VMCS) it will just put the result of KVM_GET_SUPPORTED_HV_CPUID in guest
facing CPUIDs and it will all work. In case eVMCS was previously enabled
it again just copies everything and this still works.

We don't probably need this for Qemu though. If you think it would be
better to have HYPERV_CPUID_NESTED_FEATURES returned regardless of eVMCS
enablement I'm ready to budge)

-- 
Vitaly
