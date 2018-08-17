Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC676C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B280A218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280A218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeHQOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:00:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeHQOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:00:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6877A9;
        Fri, 17 Aug 2018 03:57:37 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DFA93F5BD;
        Fri, 17 Aug 2018 03:57:34 -0700 (PDT)
Date:   Fri, 17 Aug 2018 11:57:31 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180817105731.GI2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
 <20180809091427.4p2c4fbxocpkjaby@darkstar>
 <20180809095043.GC22465@localhost.localdomain>
 <20180809152313.lewfhufidhxb2qrk@darkstar>
 <20180817103406.gmve4clcxmhwlmtc@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817103406.gmve4clcxmhwlmtc@queper01-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Aug 11:34, Quentin Perret wrote:
> Hi Patrick,
> 
> On Thursday 09 Aug 2018 at 16:23:13 (+0100), Patrick Bellasi wrote:
> > On 09-Aug 11:50, Juri Lelli wrote:
> > > On 09/08/18 10:14, Patrick Bellasi wrote:
> > > > On 07-Aug 14:35, Juri Lelli wrote:
> > > > > On 06/08/18 17:39, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > > 1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
> > > >    time parameter to relax this check
> > > 
> > > It seems to me that this might work well with that the intended usage of
> > > the interface that you depict above. SMS only (or any privileged user)
> > > will be in control of how groups are configured, so no problem for
> > > normal users.
> > 
> > Yes, well... apart normal users still getting a -ENOSPC is they are
> > requesting one of the not pre-configured clamp values. Which is why
> > the following bits can be helpful.
> 
> So IIUC, normal users would still be free of choosing their clamp values
> as long as they choose one in the list of pre-allocated ones ? Is that
> correct ?

No, with the CAP_SYS_NICE/ADMIN guard in place, as discussed above in
point 1, the syscall will just fail for normal users.

Only privileged tasks (i.e. SMS control threads) can change clamp values.

> If yes, that would still let normal users make they tasks look bigger no ?
> They could just choose the clamp group with the highest min_clamp or
> something. Isn't this a problem too ? I mean, if that can be abused easily,
> I'm pretty sure people _will_ abuse it ...

It should not be possible with 1) in place.

However, if the system is booted with that check disabled (e.g. via
kernel boot parameter) that probably means you trust/control your
userspace and don't want to impose restrictions on non privileged
tasks. In this case "abuses" are just "acceptable usages"...

-- 
#include <best/regards.h>

Patrick Bellasi
