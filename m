Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F899208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F899208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:34:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754630AbeFTIeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09865401EF00;
        Wed, 20 Jun 2018 08:24:17 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A5A2156880;
        Wed, 20 Jun 2018 08:24:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
References: <20180615163010.20381-1-vkuznets@redhat.com>
        <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
Date:   Wed, 20 Jun 2018 10:24:14 +0200
In-Reply-To: <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Tue, 19 Jun 2018 17:56:51 +0000")
Message-ID: <87tvpxkgr5.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 20 Jun 2018 08:24:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 20 Jun 2018 08:24:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> writes:

>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
>> Of Vitaly Kuznetsov
>> Sent: Friday, June 15, 2018 9:30 AM
>> To: x86@kernel.org
>> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY Srinivasan
>> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
>> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
>> <Tianyu.Lan@microsoft.com>
>> Subject: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
>> hypercalls when possible
>> 
>> While working on Hyper-V style PV TLB flush support in KVM I noticed that
>> real Windows guests use TLB flush hypercall in a somewhat smarter way: when
>> the flush needs to be performed on a subset of first 64 vCPUs or on all
>> present vCPUs Windows avoids more expensive hypercalls which support
>> sparse CPU sets and uses their 'cheap' counterparts. This means that
>> HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a misnomer: EX
>> hypercalls (which support sparse CPU sets) are "available", not
>> "recommended". This makes sense as they are actually harder to parse.
>> 
>> Nothing stops us from being equally 'smart' in Linux too. Switch to
>> doing cheaper hypercalls whenever possible.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> This is a good idea.  We should probably do the same with the hypercalls for sending
> IPIs -- try the simpler version first and move to the more complex _EX version only
> if necessary.
>
> A complication:  We've recently found a problem with the code for doing IPI
> hypercalls, and the bug affects the TLB flush code as well.  As secondary CPUs
> are started, there's a window of time where the hv_vp_index entry for a
> secondary CPU is uninitialized.  We are seeing IPIs happening in that window, and
> the IPI hypercall code uses the uninitialized hv_vp_index entry.   Same thing could
> happen with the TLB flush hypercall code.  I didn't actually see any occurrences of
> the TLB case in my tracing, but we should fix it anyway in case a TLB flush gets
> added at some point in the future.
>
> KY has a patch coming.  In the patch, hv_cpu_number_to_vp_number()
> and cpumask_to_vpset() can both return U32_MAX if they encounter an
> uninitialized hv_vp_index entry, and the code needs to be able to bail out to
> the native functions for that particular IPI or TLB flush operation.  Once the
> initialization of secondary CPUs is complete, the uninitialized situation won't
> happen again, and the hypercall path will always be used.

Sure,

with TLB flush we can always fall back to doing it natively (by sending
IPIs).

>
> We'll need to coordinate on these patches.  Be aware that the IPI flavor of the
> bug is currently causing random failures when booting 4.18 RC1 on Hyper-V VMs
> with large vCPU counts.

Thanks for the heads up! This particular patch is just an optimization
so there's no rush, IPI fix is definitely more important.

>
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Thanks!

-- 
  Vitaly
