Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A355F208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A355F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeG3V07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:26:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeG3V06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:26:58 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkEAu-0006AY-Sw; Mon, 30 Jul 2018 21:49:49 +0200
Date:   Mon, 30 Jul 2018 21:49:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eduardo Valentin <eduval@amazon.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
In-Reply-To: <20180730164100.GD15414@u40b0340c692b58f6553c.ant.amazon.com>
Message-ID: <alpine.DEB.2.21.1807302140390.1725@nanos.tec.linutronix.de>
References: <20180726155656.14873-1-eduval@amazon.com> <20180730085354.GA2494@hirez.programming.kicks-ass.net> <20180730164100.GD15414@u40b0340c692b58f6553c.ant.amazon.com>
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

On Mon, 30 Jul 2018, Eduardo Valentin wrote:
> On Mon, Jul 30, 2018 at 10:53:54AM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 26, 2018 at 08:56:56AM -0700, Eduardo Valentin wrote:
> > > System instability are seen during resume from hibernation when system
> > > is under heavy CPU load. This is due to the lack of update of sched
> > > clock data
> > 
> > Which would suggest you're already running with unstable sched clock.
> > Otherwise nobody would care about the scd stuff.
> 
> Yes.

I doubt that...

> > 
> > What kind of machine are you running? What does:
> > 
> >   dmesg | grep -i tsc
> > 
> > say?
> 
> Here:
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.004005] tsc: Detected 3000.000 MHz processor
> [    0.066796] TSC deadline timer enabled
> [    3.904269] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
>

... because if the sched clock would be unstable then you'd have something
like 'TSC unstable' in dmesg, which you obviously do not.

'sched_clock: Marking unstable' is the other message which would be
emitted.

> > > The fix for this situation is to mark the sched clock as unstable
> > > as early as possible in the resume path, leaving it unstable
> > > for the duration of the resume process. This will force the
> > > scheduler to attempt to align the sched clock across CPUs using
> > > the delta with time of day, updating sched clock data. In a post
> > > hibernation event, we can then mark the sched clock as stable
> > > again, avoiding unnecessary syncs with time of day on systems
> > > in which TSC is reliable.
> > 
> > None of this makes any sense. Either you were already unstable and it
> > should already have worked and them marking it stable is an outright
> > bug, or your sched clock was stable but then your initial diagnosis of
> > lack of scd updates is complete garbage.
> > 
> 
> I see, or it is just a workaround for the underling issue. I, for sure, see no
> lockups anymore after forcing the scd updates. The other thing which are not
> super clear is that this happens during the unfreezing of tasks. If I get a
> set of cpu hog tasks while unfreezing, I see the system throwing worqueue lockup
> detectors in hibernation restore.

Yes, it pretty much papers over something else. Can you please provide a
full dmesg from boot to failure case?

Another question: Does the system recover after issuing the lockup messages
or is it hosed completely?

Thanks,

	tglx
