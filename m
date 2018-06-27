Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA78426503
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA78426503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbeF0JcX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:32:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933282AbeF0JcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F80EC328;
        Wed, 27 Jun 2018 09:32:21 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 021962026D5B;
        Wed, 27 Jun 2018 09:32:18 +0000 (UTC)
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
Date:   Wed, 27 Jun 2018 11:32:17 +0200
In-Reply-To: <CANRm+CwNfOkosECeSGaXXDaqTDvh1u228ztU8C5Xe95FGgNsFQ@mail.gmail.com>
        (Wanpeng Li's message of "Wed, 27 Jun 2018 08:49:08 +0800")
Message-ID: <8736x8h8wu.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Jun 2018 09:32:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Jun 2018 09:32:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
> after entering x2APIC, so sending IPI per cluster. In addition, you
> can also post the benchmark result for this PV IPI optimization,
> although it also fixes the bug which you mentioned above.

I got confused, which of my patch series are you actually looking at?
:-)

This particular one ("x86/hyper-v: optimize PV IPIs") is not about
KVM/qemu, it is for Linux running on top on real Hyper-V server. We
already support PV IPIs and here I'm just trying to optimize the way how
we send them by switching to a cheaper hypercall (and using 'fast'
version of it) when possible. I don't actually have a good benchmark
(and I don't remember seeing one when K.Y. posted PV IPI support) but
this can be arranged I guess: I can write a dump 'IPI sender' in kernel
and send e.g. 1000 IPIs.

-- 
  Vitaly
