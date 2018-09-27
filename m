Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5124C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA02159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CA02159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeI1DvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:51:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1DvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:51:02 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5drO-0003Wc-IO; Thu, 27 Sep 2018 23:30:10 +0200
Date:   Thu, 27 Sep 2018 23:30:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
In-Reply-To: <87zhw4rwiq.fsf@xmission.com>
Message-ID: <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com>        <874lej6nny.fsf@xmission.com>        <20180924205119.GA14833@outlook.office365.com>        <874leezh8n.fsf@xmission.com>        <20180925014150.GA6302@outlook.office365.com>
 <87zhw4rwiq.fsf@xmission.com>
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

On Wed, 26 Sep 2018, Eric W. Biederman wrote:
> Reading the code the calling sequence there is:
> tick_sched_do_timer
>    tick_do_update_jiffies64
>       update_wall_time
>           timekeeping_advance
>              timekeepging_update
> 
> If I read that properly under the right nohz circumstances that update
> can be delayed indefinitely.
> 
> So I think we could prototype a time namespace that was per
> timekeeping_update and just had update_wall_time iterate through
> all of the time namespaces.

Please don't go there. timekeeping_update() is already heavy and walking
through a gazillion of namespaces will just make it horrible,

> I don't think the naive version would scale to very many time
> namespaces.

:)

> At the same time using the techniques from the nohz work and a little
> smarts I expect we could get the code to scale.

You'd need to invoke the update when the namespace is switched in and
hasn't been updated since the last tick happened. That might be doable, but
you also need to take the wraparound constraints of the underlying
clocksources into account, which again can cause walking all name spaces
when they are all idle long enough.

From there it becomes hairy, because it's not only timekeeping,
i.e. reading time, this is also affecting all timers which are armed from a
namespace.

That gets really ugly because when you do settimeofday() or adjtimex() for
a particular namespace, then you have to search for all armed timers of
that namespace and adjust them.

The original posix timer code had the same issue because it mapped the
clock realtime timers to the timer wheel so any setting of the clock caused
a full walk of all armed timers, disarming, adjusting and requeing
them. That's horrible not only performance wise, it's also a locking
nightmare of all sorts.

Add time skew via NTP/PTP into the picture and you might have to adjust
timers as well, because you need to guarantee that they are not expiring
early.

I haven't looked through Dimitry's patches yet, but I don't see how this
can work at all without introducing subtle issues all over the place.

Thanks,

	tglx



