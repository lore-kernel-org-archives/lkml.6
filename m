Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC3C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519B720645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519B720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJCStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3223 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeJCStv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:49:51 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CFEEC049E3A;
        Wed,  3 Oct 2018 12:01:44 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCEE420155E0;
        Wed,  3 Oct 2018 12:01:40 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
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
In-Reply-To: <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
Date:   Wed, 03 Oct 2018 14:01:38 +0200
Message-ID: <87murvdysd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 03 Oct 2018 12:01:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:

>> On Oct 3, 2018, at 2:22 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Andy Lutomirski <luto@kernel.org> writes:
>> 
>>> Hi Vitaly, Paolo, Radim, etc.,
>>> 
>> The notification you're talking about exists, it is called
>> Reenligntenment, see 0092e4346f49 "x86/kvm: Support Hyper-V
>> reenlightenment"). When TSC page changes (and this only happens when L1
>> is migrated to a different host with a different TSC frequency and TSC
>> scaling is not supported by the CPU) we receive an interrupt in L1 (at
>> this moment all TSC accesses are emulated which guarantees the
>> correctness of the readings), pause all L2 guests, update their kvmclock
>> structures with new data (we already know the new TSC frequency) and
>> then tell L0 that we're done and it can stop emulating TSC accesses.
>
> That’s delightful!  Does the emulation magic also work for L1 user
> mode?

As far as I understand - yes, all rdtsc* calls will trap into L0.

>  If so, couldn’t we drop the HyperV vclock entirely and just
> fold the adjustment into the core timekeeping data?  (Preferably the
> actual core data, which would require core changes, but it could
> plausibly be done in arch code, too.)

Not all Hyper-V hosts support reenlightenment notifications (and, if I'm
not mistaken, you need to enable nesting for the VM to get the feature -
and most VMs don't have this) so I think we'll have to keep Hyper-V
vclock for the time being.

-- 
Vitaly
