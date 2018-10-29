Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784102082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784102082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeJ3FXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:23:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52721 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbeJ3FXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:23:43 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHEDr-0002gD-SM; Mon, 29 Oct 2018 21:33:16 +0100
Date:   Mon, 29 Oct 2018 21:33:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrei Vagin <avagin@gmail.com>
cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "criu@openvz.org" <criu@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
In-Reply-To: <20181021014121.GA23474@gmail.com>
Message-ID: <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de> <87mus1ftb9.fsf@xmission.com> <20181021014121.GA23474@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei,

On Sat, 20 Oct 2018, Andrei Vagin wrote:
> When a container is migrated to another host, we have to restore its
> monotonic and boottime clocks, but we still expect that the container
> will continue using the host real-time clock.
> 
> Before stating this series, I was thinking about this, I decided that
> these cases can be solved independently. Probably, the full isolation of
> the time sub-system will have much higher overhead than just offsets for
> a few clocks. And the idea that isolation of the real-time clock should
> be optional gives us another hint that offsets for monotonic and
> boot-time clocks can be implemented independently.
> 
> Eric and Tomas, what do you think about this? If you agree that these
> two cases can be implemented separately, what should we do with this
> series to make it ready to be merged?
> 
> I know that we need to:
> 
> * look at device drivers that report timestamps in CLOCK_MONOTONIC base.

and CLOCK_BOOTTIME and that's quite a few.

> * forbid changing offsets after creating timers

There are more things to think about. What about interfaces which expose
boot time or monotonic time in /proc?

Aside of that (I finally came around to look at the series in more detail)
I'm really unhappy about the unconditional overhead once the Time namespace
config switch is enabled. This applies especially to the VDSO. We spent
quite some time recently to squeeze a few cycles out of those functions and
it would be a pity to pointlessly waste cycles for the !namespace case.

I can see the urge for this, but please let us think it through properly
before rushing anything in which we are going to regret once we want to do
more sophisticated time domain management, e.g. support for isolated clock
real time. I'm worried, that without a clear plan about the overall
picture, we end up with duct tape which is hard to distangle after the
fact.

There have been a few other things brought up versus time management in
general, like the TSN folks utilizing grand clock masters which expose
random time instead of proper TAI. Plus some requirements for exposing some
sort of 'monotonic' clocks which are derived from external synchronization
mechanisms, but should not affect the regular time keeping clocks.

While different issues, these all fall into the category of separate time
domains, so taking a step back to the drawing board is probably the best
thing what we can do now.

There are certainly a few things which can be looked at independently,
e.g. the VDSO mechanics or general mechanisms to avoid plastering the whole
kernel with these name space functions applying offsets left and right. I
rather have dedicated core functionality which replaces/amends existing
timer functions to become time namespace aware.

I'll try to find some time in the next weeks to look deeper into that, but
I can't promise anything before returning from LPC. Btw, LPC would be a
great opportunity to discuss that. Are you and the other name space wizards
there by any chance?

Thanks,

	tglx


