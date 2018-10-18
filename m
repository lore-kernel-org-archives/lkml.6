Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20BA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20BA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJRQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:28:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55465 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbeJRQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:28:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so4507732wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A81vAJGptTkeCRBtHozeAQu4M/6x9Fy2WNuynQ1scSU=;
        b=szFWoladd9u3aC7uNkskSDFKGdtDkmy6i7/WKMfMZAcswss0rhHU7/NEHverJS2Bhp
         USdEgkeeEOQfukmIe81ovI6Us920I/RFjQJFCUQQ0z90ywkQD+HJ3FcEUmjn/rYYIAph
         sJRwck6CqTabHxGDTYnKn8lJ7bvPHrLdoamG3PyKlgubGrNHXjTY4CFiGRAOsc1ZilUk
         +rk2CncKOJZXK4QA+PE54JXZPKgJHnpeqUu65amOftFSAN67N3Wjb5caKPnDxYbr2GfV
         2NF/AwJyNHaarL3dLzf8Jbg1+mGnJYrE6CAc0b5z5PQOlgGQKN/mheASEvsaFtfvpTh5
         8bPQ==
X-Gm-Message-State: ABuFfojCy0dIfrCzrBOLuELhOzKxYWyTbinrEdhmHvLhm/EusCz4fWCn
        oYWNnl12dB0bqKbAKbgFAjaUTQ==
X-Google-Smtp-Source: ACcGV62G6O9xEd8dMLusGK73KBKeAOzuJRi1d/38KBhaDJxlGHNR0tY1s3Vs8lCykNkirVBno54qdg==
X-Received: by 2002:a1c:3702:: with SMTP id e2-v6mr5902477wma.89.1539851324184;
        Thu, 18 Oct 2018 01:28:44 -0700 (PDT)
Received: from localhost.localdomain ([151.37.218.44])
        by smtp.gmail.com with ESMTPSA id i13-v6sm4872308wrn.62.2018.10.18.01.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 01:28:43 -0700 (PDT)
Date:   Thu, 18 Oct 2018 10:28:38 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        Luca Abeni <luca.abeni@santannapisa.it>, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181018082838.GA21611@localhost.localdomain>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016153608.GH9130@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 16:03, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 03:24:06PM +0200, Thomas Gleixner wrote:
> > It does reproduce here but with a kworker stall. Looking at the reproducer:
> > 
> >   *(uint32_t*)0x20000000 = 0;
> >   *(uint32_t*)0x20000004 = 6;
> >   *(uint64_t*)0x20000008 = 0;
> >   *(uint32_t*)0x20000010 = 0;
> >   *(uint32_t*)0x20000014 = 0;
> >   *(uint64_t*)0x20000018 = 0x9917;
> >   *(uint64_t*)0x20000020 = 0xffff;
> >   *(uint64_t*)0x20000028 = 0;
> >   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
> > 
> > which means:
> > 
> >   struct sched_attr {
> >   	 .size		= 0,
> > 	 .policy	= 6,
> > 	 .flags		= 0,
> > 	 .nice		= 0,
> > 	 .priority	= 0,
> > 	 .deadline	= 0x9917,
> > 	 .runtime	= 0xffff,
> > 	 .period	= 0,
> >   }
> > 
> > policy 6 is SCHED_DEADLINE
> > 
> > That makes the thread hog the CPU and prevents all kind of stuff to run.
> > 
> > Peter, is that expected behaviour?
> 
> Sorta, just like FIFO-99 while(1);. Except we should be rejecting the
> above configuration, because of the rule:
> 
>   runtime <= deadline <= period
> 
> Juri, where were we supposed to check that?

OK, looks like the "which means" part above had me fooled, as
we actually have ([1], where the comment is wrong)

 struct sched_attr {
    .size	= 0,
    .policy	= 6,
    .flags	= 0,
    .nice	= 0,
    .priority	= 0,
    .runtime	= 0x9917,
    .deadline	= 0xffff,
    .period	= 0,
 }

So, we seem to be correctly (in theory, see below) accepting the task.

What seems to generate the problem here is that CONFIG_HZ=100 and
reproducer task has "tiny" runtime (~40us) and deadline (~66us)
parameters, combination that "bypasses" the enforcing mechanism
(performed at each tick).

Another side problem seems also to be that with such tiny parameters we
spend lot of time in the while (dl_se->runtime <= 0) loop of replenish_dl_
entity() (actually uselessly, as deadline is most probably going to
still be in the past when eventually runtime becomes positive again), as
delta_exec is huge w.r.t. runtime and runtime has to keep up with tiny
increments of dl_runtime. I guess we could ameliorate things here by
limiting the number of time we execute the loop before bailing out.

Enabling HRTICK makes a difference [2]. I played a bit with several
combinations and could verify that parameters in the ~50us range seem
usable. However, still to mention that when runtime gets close to
deadline (very high bandwidth) enforcing could be tricked again, as
hrtick overheads might make the task effectively executing for more than
the runtime, over passing the replenish instant (old deadline), so
replenish timer is not set, and letting the task continuing executing
after a replenishment.

This is all however very much platform and config dependent, of course.

So, I tend to think that we might want to play safe and put some higher
minimum value for dl_runtime (it's currently at 1ULL << DL_SCALE).
Guess the problem is to pick a reasonable value, though. Maybe link it
someway to HZ? Then we might add a sysctl (or similar) thing with which
knowledgeable users can do whatever they think their platform/config can
support?

Thoughts?

I'm adding more people on Cc as I'm not sure they are following this.
Thread starts here [3].

1 - https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/sched/types.h#L70
2 - noticed that we don't actually start hrtick on setup_new_dl_entity()
    and think we should
3 - https://lore.kernel.org/lkml/000000000000a4ee200578172fde@google.com/
