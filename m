Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B78C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284B826427
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284B826427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeF0JZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:25:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751314AbeF0JZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F92F401EF06;
        Wed, 27 Jun 2018 09:25:21 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 500362156880;
        Wed, 27 Jun 2018 09:25:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     "the arch\/x86 maintainers" <x86@kernel.org>,
        devel@linuxdriverproject.org, LKML <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tianyu.Lan@microsoft.com,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH 0/4] x86/hyper-v: optimize PV IPIs
References: <20180622170625.30688-1-vkuznets@redhat.com>
        <CANRm+CwNfOkosECeSGaXXDaqTDvh1u228ztU8C5Xe95FGgNsFQ@mail.gmail.com>
Date:   Wed, 27 Jun 2018 11:25:18 +0200
In-Reply-To: <CANRm+CwNfOkosECeSGaXXDaqTDvh1u228ztU8C5Xe95FGgNsFQ@mail.gmail.com>
        (Wanpeng Li's message of "Wed, 27 Jun 2018 08:49:08 +0800")
Message-ID: <877emkh98h.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 09:25:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 09:25:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> Hi Vitaly, (fix my reply mess this time)
> On Sat, 23 Jun 2018 at 01:09, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> When reviewing my "x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_
>> {LIST,SPACE} hypercalls when possible" patch Michael suggested to apply the
>> same idea to PV IPIs. Here we go!
>>
>> Despite what Hyper-V TLFS says about HVCALL_SEND_IPI hypercall, it can
>> actually be 'fast' (passing parameters through registers). Use that too.
>>
>> This series can collide with my "KVM: x86: hyperv: PV IPI support for
>> Windows guests" series as I rename ipi_arg_non_ex/ipi_arg_ex structures
>> there. Depending on which one gets in first we may need to do tiny
>> adjustments.
>
> As hyperv PV TLB flush has already been merged, is there any other
> obvious multicast IPIs scenarios? qemu supports interrupt remapping
> since two years ago, I think windows guest can switch to cluster mode
> after entering x2APIC, so sending IPI per cluster. 

When we manifest ourselves as Hyper-V Windows 'forgets' about x2apic
mode: Hyper-V has a concept of 'Synthetic interrupt controller' - an
xapic extension which we also support in KVM. I don't really know any
obvious scenarios for mass IPIs in Windows besides TLB flush but I'm
worried they may exist. Without PV IPIs any such attempt will likely
lead to a crash.

In general, I do care more about completeness and correctness of our
Hyper-V emulation at this point: Windows is only being tested on 'real'
Hyper-Vs so when we emulate a subset of enlightenments we're on our own
when something is not working. It is also very helpfult for
Linux-on-Hyper-V depelopment as we can see how Windows-on-Hyper-v
behaves :-)

> In addition, you
> can also post the benchmark result for this PV IPI optimization,
> although it also fixes the bug which you mentioned above.

I'd love to get to know how to trigger mass IPIs in Windows so a
benchmark can be performed...

> I can post one variant for Linux guest PV IPI if it also makes
> sense. :)

With x2apic support I'm actually not sure. Maybe configurations with
a very large number of vCPUs and IPIs going to > 256 vCPUs can benefit
from a 'single hypercall' solution.

-- 
  Vitaly
