Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79B023F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79B023F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeGFObo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:31:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932725AbeGFObn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:31:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37BA15B2;
        Fri,  6 Jul 2018 07:31:42 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2F33F2EA;
        Fri,  6 Jul 2018 07:31:41 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:31:39 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
Message-ID: <20180706143139.GE8596@e105550-lin.cambridge.arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:18:17PM +0200, Vincent Guittot wrote:
> On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >
> > The 'prefer sibling' sched_domain flag is intended to encourage
> > spreading tasks to sibling sched_domain to take advantage of more caches
> > and core for SMT systems. It has recently been changed to be on all
> > non-NUMA topology level. However, spreading across domains with cpu
> > capacity asymmetry isn't desirable, e.g. spreading from high capacity to
> > low capacity cpus even if high capacity cpus aren't overutilized might
> > give access to more cache but the cpu will be slower and possibly lead
> > to worse overall throughput.
> >
> > To prevent this, we need to remove SD_PREFER_SIBLING on the sched_domain
> > level immediately below SD_ASYM_CPUCAPACITY.
> 
> This makes sense. Nevertheless, this patch also raises a scheduling
> problem and break the 1 task per CPU policy that is enforced by
> SD_PREFER_SIBLING.

Scheduling one task per cpu when n_task == n_cpus on asymmetric
topologies is generally broken already and this patch set doesn't fix
that problem.

SD_PREFER_SIBLING might seem to help in very specific cases:
n_litte_cpus == n_big_cpus. In that case the little group might
classified as overloaded. It doesn't guarantee that anything gets pulled
as the grp_load/grp_capacity in the imbalance calculation on some system
still says the little cpus are more loaded than the bigs despite one of
them being idle. That depends on the little cpu capacities.

On systems where n_little_cpus != n_big_cpus SD_PREFER_SIBLING is broken
as it assumes the group_weight to be the same. This is the case on Juno
and several other platforms.

IMHO, SD_PREFER_SIBLING isn't the solution to this problem. It might
help for a limited subset of topologies/capacities but the right
solution is to change the imbalance calculation. As the name says, it is
meant to spread tasks and does so unconditionally. For asymmetric
systems we would like to consider cpu capacity before migrating tasks.

> When running the tests of your cover letter, 1 long
> running task is often co scheduled on a big core whereas short pinned
> tasks are still running and a little core is idle which is not an
> optimal scheduling decision

This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
say that this patch breaks anything that isn't broken already. In fact
we this happening with and without this patch applied.

Morten
