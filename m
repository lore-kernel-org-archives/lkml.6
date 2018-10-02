Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05452C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75CB20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75CB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJCEMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:12:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeJCEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:12:24 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7SBb-0003Q4-KB; Tue, 02 Oct 2018 23:26:31 +0200
Date:   Tue, 2 Oct 2018 23:26:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
cc:     Andrei Vagin <avagin@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, crml <criu@openvz.org>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
In-Reply-To: <CAJwJo6a+WWpAxVAUuYt8TrCF+1a=BdoFQjU9vto0iiUN5vygsA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810022310360.1435@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809272335430.8118@nanos.tec.linutronix.de> <20181001232033.GA31324@outlook.office365.com> <alpine.DEB.2.21.1810020811290.32062@nanos.tec.linutronix.de>
 <CAJwJo6a+WWpAxVAUuYt8TrCF+1a=BdoFQjU9vto0iiUN5vygsA@mail.gmail.com>
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

Dmitry,

On Tue, 2 Oct 2018, Dmitry Safonov wrote:
> On Tue, 2 Oct 2018 at 07:15, Thomas Gleixner <tglx@linutronix.de> wrote:
> > I explained that in detail in this thread, but it's not about the initial
> > setting of clock mono/boot before any timers have been armed.
> >
> > It's about setting the offset or clock realtime (via settimeofday) when
> > timers are already armed. Also having a entirely different time domain,
> > e.g. separate NTP adjustments, makes that necessary.
> 
> It looks like, there is a bit of misunderstanding each other:
> Andrei was talking about the current RFC version, where we haven't
> introduced offsets for clock realtime. While Thomas IIUC, is looking
> how-to expand time namespace over realtime.
>
> As CLOCK_REALTIME virtualization raises so many complex questions
> like a different length of the second or list of realtime timers in ns we
> haven't added any realization for it.
> 
> It seems like an initial introduction for timens can be expanded after to cover
> realtime clocks too. While it may seem incomplete, it solves issues for
> restoring/migration of real-world applications like nodejs, Oracle DB server
> which fails after being restored if there is a leap in monotonic time.

Well, yes. But you really have to think about the full picture. Just adding
part of the overall solution right now, just because it can be glued into
the code easily, is not the best approach IMO as it might result in
substantial rework of the whole thing sooner than later. I really don't
want to end up with something which is not extensible and has to be
supported forever.

Just for the record, the current approach with name space offsets for
monotonic is also prone to malfunction vs. timers, unless you can prevent
changing the offset _after_ the namespace has been set up and timers have
been armed. I admit, that I did not look close enough to verify that.

> While solving the mentioned issues, it doesn't bring overhead.
> (well, Andy noted that cmp for zero-offsets on vdso can be optimized too,
> which will be done in v1).
> 
> Thomas, thanks much for your input - now we know that we'll need to
> introduce list for timers in namespace when we'll add realtime clocks.
> Do you believe that CLOCK_MONOTONIC_SYNC would be an easier
> concept than offsets per-namespace?

Haven't thought it through. This was just an idea in reaction to Eric's
question whether setting clock monotonic might be feasible. But yes, it
might be worth to think about it.

I think you should really define the long term requirements for time
namespaces and perhaps set some limitations in functionality upfront.

Thanks,

	tglx


