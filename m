Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B93C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E3B2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E3B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeH2IRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 04:17:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47531 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeH2IRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 04:17:16 -0400
Received: from 209.82.80.116 (209.82.80.116) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id e36ddbacb472b73f; Wed, 29 Aug 2018 06:22:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Cc:     'Leo Yan' <leo.yan@linaro.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date:   Wed, 29 Aug 2018 06:19:52 +0200
Message-ID: <1849888.3sQZZ7JY7b@aspire.rjw.lan>
In-Reply-To: <000001d43d74$306e1b50$914a51f0$@net>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> <000701d43bc1$5e0c2c50$1a2484f0$@net> <000001d43d74$306e1b50$914a51f0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 26, 2018 9:37:09 PM CEST Doug Smythies wrote:
> On 2018.08.25 04:22 Rafael J. Wysocki wrote:
> > On Fri, Aug 24, 2018 at 5:52 PM Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2018.08.24 02:44 Rafael J. Wysocki wrote:
> >>> On Tuesday, August 21, 2018 10:44:10 AM CEST Rafael J. Wysocki wrote:
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
> >>>> stopped tick more aggressively) in the stopped tick case is present
> >>>> when the tick has not been stopped yet too.
> >>
> >> ... [snip] ...
> >>
> >>>> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> >>
> >> ... [snip] ...
> >>
> >>> Due to the lack of objections, I'm inclined to queue this up.
> >>
> >> I have been following these threads.
> >> Recall that I was involved, over a period of months, in the original
> >> "powernightmare" stuff.
> >> I have revived my tests (and wish I had left myself better notes), and
> >> am establishing a baseline before adding and trying this patch.
> >> My baseline is actually two tests with and without the previous two patches (the ones
> >> that were just sent a couple of days ago in "More power management updates for v4.19-rc1".
> >> I might have those results in some presentable form by later today (it looks O.K.)
> >> Results with this patch will take another couple of days.
> >
> > Thanks Doug, much appreciated!
> 
> Test 1: A Thomas Ilsche type "powernightmare" test:
> (forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered threads.
> Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200 minutes of the test.
> (note: overheads mean that actual loop times are quite different.)
> And then from 5 to 500 in steps of 1, for the remaining 1000 minutes of the test.
> Each step ran for 2 minutes. The system was idle for 1 minute at the start, and a few
> minutes at the end of the graphs.
> While called "kernel 4.18", the baseline was actually from mainline at head = df2def4,
> or just after Rafael's linux-pm "pm-4.19-rc1-2" merge.
> (actually after the next acpi merge).
> Reference kernel = df2def4 with the two patches reverted.
> 
> Test 1.1 compares baseline reference and the two patches added.
> Summary: Nothing of note.
> Results: http://fast.smythies.com/linux-pm/k418-pn-sweep.htm 
> Differences: http://fast.smythies.com/linux-pm/k418-pn-sweep-differences.htm
> Note: the title in the last graph in each link above is mislabelled.
> 
> Test 1.2 compares baseline reference and the three patches added (the two at 
> df2def4 plus the one of this thread).
> Summary: Nothing of note.
> Results: http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw.htm
> Differences: http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw-differences.htm
> 
> Side note: There is an interesting, slight, power bump at about the 
> 260 minute point of the tests. Perhaps for further investigation some other day.
> 
> Test 2: pipe test 2 CPUs, one core. CPU test.
> 
> Recall this was one of the more interesting tests with the original "powernightmare"
> work, and in the end, back then, both energy was saved and performance improved.
> 
> The average loop times graph is here:
> http://fast.smythies.com/linux-pm/k418-rjw-pipe-1core.png
> with the average loop times:
> Baseline:		4.83 uSec
> + 2 rjw patches:	4.69 uSec
> + 3 rjw patches:	4.80 uSec
> 
> The power and idle statistics graphs are here:
> http://fast.smythies.com/linux-pm/k418-rjw-pipe-1core.htm
> 
> Test 3: 100% load on CPU 7 test.
> 
> Recall this was another of the more interesting tests last time, but
> had more to do with idle state 0 than anything else.
> 
> The performance seems to stay within a 1% window, with the 3 patches
> being about 1% faster than the 2 patches and the baseline somewhere
> in the middle.
> 
> The power and idle statistics graphs are here:
> http://fast.smythies.com/linux-pm/k418-rjw-100.htm
> 
> From observing at the test 2 and test 3 results, it looks as
> though there are indeed "powernightmares" in the baseline kernel.
> This was not the situation at the end of the original work, 
> "V9" for anybody that recalls. I don't know when they got
> re-introduced, and didn't look.
> 
> While these don't add up to much extra energy for my processor,
> they might be more significant for other processors.
> 
> I revived my "powernightmare" trace post processor assessment
> program, and re-did some 100% Single load tests (20 minute trace):
> (recall that the "is it a 'powernigthmare' or not" threshold
> is rather arbitrary [1]. However, and for what is being done here,
> it should be greater than a tick time, which it is for my 1000Hz
> kernel.)
> 
> 1.) Reference or baseline kernel:
> 
> Idle State 0: Total Entries: 458 : PowerNightmares: 0 : Not PN time (seconds): 0.016160 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 1: Total Entries: 950 : PowerNightmares: 33 : Not PN time (seconds): 0.084723 : PN time: 3.172124 : Ratio: 37.441120
> Idle State 2: Total Entries: 456 : PowerNightmares: 3 : Not PN time (seconds): 0.142255 : PN time: 0.396037 : Ratio: 2.783994
> Idle State 3: Total Entries: 218 : PowerNightmares: 1 : Not PN time (seconds): 0.095584 : PN time: 0.214608 : Ratio: 2.245229
> 
> 2.) + 2 rjw patches:
> 
> Idle State 0: Total Entries: 481 : PowerNightmares: 0 : Not PN time (seconds): 0.014849 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 1: Total Entries: 734 : PowerNightmares: 0 : Not PN time (seconds): 0.046496 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 2: Total Entries: 534 : PowerNightmares: 0 : Not PN time (seconds): 0.133086 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 3: Total Entries: 145 : PowerNightmares: 0 : Not PN time (seconds): 0.054476 : PN time: 0.000000 : Ratio: 0.000000
> 
> 3.) + 3 rjw patches:
> 
> Idle State 0: Total Entries: 369 : PowerNightmares: 0 : Not PN time (seconds): 0.010182 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 1: Total Entries: 800 : PowerNightmares: 0 : Not PN time (seconds): 0.122816 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 2: Total Entries: 1041 : PowerNightmares: 0 : Not PN time (seconds): 0.233984 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 3: Total Entries: 269 : PowerNightmares: 0 : Not PN time (seconds): 0.114399 : PN time: 0.000000 : Ratio: 0.000000
> 
> 4.) The old kernel 4.16+V9 patch set (sanity check):
> 
> Idle State 0: Total Entries: 265 : PowerNightmares: 0 : Not PN time (seconds): 0.009892 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 1: Total Entries: 708 : PowerNightmares: 0 : Not PN time (seconds): 0.091070 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 2: Total Entries: 712 : PowerNightmares: 0 : Not PN time (seconds): 0.212778 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 3: Total Entries: 421 : PowerNightmares: 0 : Not PN time (seconds): 0.230097 : PN time: 0.000000 : Ratio: 0.000000
> 
> [1] https://marc.info/?l=linux-kernel&m=152156611814576&w=2  (formatting a mess)

Thanks a lot for the detailed information!

Cheers,
Rafael

