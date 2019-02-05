Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A9BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476032081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="jTqQbFn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbfBEFHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:07:14 -0500
Received: from tomli.me ([153.92.126.73]:48040 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfBEFHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 00:07:14 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id ec014f81;
        Tue, 5 Feb 2019 05:07:11 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b75:4650)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 05 Feb 2019 05:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=1490979754; bh=NceRHPqDrDkLFOYSqO21VRUQ9518LtfnwRv7ykBICHE=; b=jTqQbFn9HeimbpOiINVAyaMQEHaXrumYQ6U8czo1V/pOlGFAWiwjGctiD0TBI3x4tzPFBhrN6oiqUPmT6F8Uzpj9WXmvjHVaMYFUXL3HnpRGmDzSJK8n0LaajqFkIXaQdigD6mAcOr9wDCpd5OcdbboL69gOwV7SUi+mvoz8ysrCjcRVIAY+6T27udPDBbZ93qrGk+mKIAV6sdFUyECMvs8i/RPjlL/fFVfrEHdI4xHpvCwZTrH/wacrzjYhnjRmht8WgXfwRyPhCxJtS+MBBkVfDXID+ASvqqaZZIIZc8/atyGXVImptzdfLJYhj6sLdB3qL0cHUR9HKM+3J2GYJQ==
Date:   Tue, 5 Feb 2019 13:07:00 +0800
From:   Tom Li <tomli@tomli.me>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     paulmck@linux.ibm.com, ak@linux.intel.com, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjw@rjwysocki.net, ville.syrjala@linux.intel.com,
        viresh.kumar@linaro.org, tomli@tomli.me, linux-mips@vger.kernel.org
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190205050700.GA31571@localhost.localdomain>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126220122.GA6345@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 03:54:53PM +0200, Ville Syrjälä wrote:
> Hi Paul,
> After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
> I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
> API in terms of RCU for Tree RCU PREEMPT builds").
> 
> I traced the hang into
> -> cpufreq_suspend()
>  -> cpufreq_stop_governor()
>   -> cpufreq_dbs_governor_stop()
>    -> gov_clear_update_util()
>     -> synchronize_sched()
>      -> synchronize_rcu()
>
> Only PREEMPT=y is affected for obvious reasons, but that couldn't
> explain why the same UP kernel booted on an SMP machine worked fine.
> Eventually I realized that the difference between working and
> non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
> that we mask everything in the PIC before cpufreq is shut down,

Hello Paul & Ville.

I'm not a kernel hacker, just a n00b playing with various non-x86
systems, but I've been forced getting into kernel hacking due to
the same issue.

Since February, I'm working on porting some trivial out-of-tree
drivers to the upstream, and noticed my Yeeloong 8089D, a machine running
the Loongson 2F 64-bit MIPS-III processor, will completely hang during
reboot or shutdown. I tried bisecting it for 24 hours without sleep, but
the attempt had failed.

I managed to narrow it in-between 4.19 and 4.20, most unusual thing I've
observed was its probabilistic nature. The chance of triggering it seems
getting progressively higher since 4.20, making pinpointing the specific
commit difficult, finally with a 100% chance since Linux 4.19.

I initially suspected a bug in the platform driver, later I also tried
to disable various kernel hardening options, all without success. At this
point I've realized, because it has shown to be probabilistic, it must be
a race condition, and since it's an uniprocessor system, it must be the
CPU scheduler getting preempted somehow. Disabling CONFIG_PREEMPT makes
the issue go away. I tried to add various preempt_disable() in the platform
driver but didn't work.

Finally I've hooked up a netconsole and started adding printk()s.

[   23.652000] loongson2_cpufreq loongson2_cpufreq: shutdown
[   23.656000] loongson-gpio loongson-gpio: shutdown
[   23.660000] migrate_to_reboot_cpu()
[   23.664000] syscore_shutdown()
[   23.668000] PM: Calling i8259A_shutdown+0x0/0xa8
[   23.672000] PM: Calling irq_gc_shutdown+0x0/0x88
[   23.672000] PM: Calling cpufreq_suspend+0x0/0x1a0
[   23.672000] cpufreq_suspend()
[   23.672000] cpufreq_suspend: Suspending Governors
[   23.672000] cpufreq_stop_governor()
[   23.672000] cpufreq_stop_governor: for CPU 0

Looks like something in the core cpufreq code? So I tried searching
"cpufreq_stop_governor()" at LKML... Oops!

So it must be the same issue. To summary, the issue exists on all Linux
kernels since 4.20-rc1, and the chance of triggering it, is now 100%.

What is the current progress of purposed solutions? If a complete solution
is still work-in-progress, could we simply submit a hotfix into the linux-stable
trees, so at least the issue can be temporarily solved? What can I do to help
testing?

Thanks!
Tom Li
