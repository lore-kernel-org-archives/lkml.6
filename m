Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6A21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB6A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJDOqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:46:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeJDOqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E53603082129;
        Thu,  4 Oct 2018 07:54:53 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 260C91710E;
        Thu,  4 Oct 2018 07:54:47 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
In-Reply-To: <20181003190617.GC21381@amt.cnet>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet>
Date:   Thu, 04 Oct 2018 09:54:45 +0200
Message-ID: <87k1mycfju.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 04 Oct 2018 07:54:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <mtosatti@redhat.com> writes:

> On Wed, Oct 03, 2018 at 11:22:58AM +0200, Vitaly Kuznetsov wrote:
>> 
>> There is a very long history of different (hardware) issues Marcelo was
>> fighting with and the current code is the survived Frankenstein.
>
> Right, the code has to handle different TSC modes.
>
>>  E.g. it
>> is very, very unclear what "catchup", "always catchup" and
>> masterclock-less mode in general are and if we still need them.
>
> Catchup means handling exposed (to guest) TSC frequency smaller than
> HW TSC frequency.
>
> That is "frankenstein" code, could be removed.
>
>> That said I'm all for simplification. I'm not sure if we still need to
>> care about buggy hardware though.
>
> What simplification is that again? 
>

I was hoping to hear this from you :-) If I am to suggest how we can
move forward I'd propose:
- Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
is supported).
- Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
clocksource is a single page for the whole VM, not a per-cpu thing. Can
we think that all the buggy hardware is already gone?

-- 
Vitaly
