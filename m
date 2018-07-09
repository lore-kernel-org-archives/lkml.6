Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F922208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F922208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGIPIu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:08:50 -0400
Received: from foss.arm.com ([217.140.101.70]:60864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932949AbeGIPIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:08:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A09ED1;
        Mon,  9 Jul 2018 08:08:48 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81D463F589;
        Mon,  9 Jul 2018 08:08:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 16:08:39 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Message-ID: <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:18:27PM +0200, Vincent Guittot wrote:
> Hi Morten,
> 
> On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >
> > On asymmetric cpu capacity systems (e.g. Arm big.LITTLE) it is crucial
> > for performance that cpu intensive tasks are aggressively migrated to
> > high capacity cpus as soon as those become available. The capacity
> > awareness tweaks already in the wake-up path can't handle this as such
> > tasks might run or be runnable forever. If they happen to be placed on a
> > low capacity cpu from the beginning they are stuck there forever while
> > high capacity cpus may have become available in the meantime.
> >
> > To address this issue this patch set introduces a new "misfit"
> > load-balancing scenario in periodic/nohz/newly idle balance which tweaks
> > the load-balance conditions to ignore load per capacity in certain
> > cases. Since misfit tasks are commonly running alone on a cpu, more
> > aggressive active load-balancing is needed too.
> >
> > The fundamental idea of this patch set has been in Android kernels for a
> > long time and is absolutely essential for consistent performance on
> > asymmetric cpu capacity systems.
> >
> 
> As already said , I'm not convinced by the proposal which seems quite
> complex and also adds some kind of arbitrary and fixed power
> management policy by deciding which tasks can or not go on big cores
> whereas there are other frameworks to take such decision like EAS or
> cgroups.

The misfit patches are a crucial part of the EAS solution but they also
make sense for some users on their own without an energy model. This is
why they are posted separately.

We have already discussed at length why the patches are needed and why
the look like they do here in this thread:

https://lore.kernel.org/lkml/CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com/

> Furthermore, there is already something similar in the kernel
> with SD_ASYM_PACKING and IMO, it would be better to improve this
> feature (if needed) instead of adding a new one which often do similar
> things.

As said in the previous thread, while it might look similar it isn't.
SD_ASYM_PACKING isn't utilization-based which is the key metric used for
EAS, schedutil, util_est, and util_clamp. SD_ASYM_PACKING serves a
different purpose (see previous thread for details).

> I have rerun your tests and got same results than misfit task patchset
> on my hikey960 with SD_ASYM_PACKING feature for legacy b.L topology
> and fake dynamiQ topology. And it give better performance when the
> pinned tasks are short and scheduler has to wait for the task to
> increase their utilization before getting a chance to migrate on big
> core.

Right, the test cases are quite simple and could be served better by
SD_ASYM_PACKING. As we already discussed in that thread, that is due to
the PELT lag but this the cost we have to pay if we don't have
additional information about the requirements of the task and we don't
want to default to big-first with all its implications.

We have covered all this in the thread in early April.

> Then, I have tested SD_ASYM_PACKING with EAS patchset and they work
> together for b/L and dynamiQ topology

Could you provide some more details about your evaluation? It probably
works well for some use-cases but it isn't really designed for what we
need for EAS.

Morten
