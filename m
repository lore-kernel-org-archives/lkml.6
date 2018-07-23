Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A4AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E1620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E1620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbeGWOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:37:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387871AbeGWOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:37:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3657780D;
        Mon, 23 Jul 2018 06:36:20 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CBB23F237;
        Mon, 23 Jul 2018 06:36:17 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:36:15 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180723133615.GB2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-3-patrick.bellasi@arm.com>
 <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 <20180720151156.GA31421@e110439-lin>
 <CAJuCfpGvpX5U9rED+vX=wW624GLZo8f=-2kOLGrY1UJSEXRh6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGvpX5U9rED+vX=wW624GLZo8f=-2kOLGrY1UJSEXRh6g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Jul 17:25, Suren Baghdasaryan wrote:

[...]

> > ---8<---
> >
> > /* Uclamp flags */
> > #define SCHED_FLAG_UTIL_CLAMP_STRICT    0x11 /* Roll-back on failure */
> > #define SCHED_FLAG_UTIL_CLAMP_MIN       0x12 /* Update util_min */
> > #define SCHED_FLAG_UTIL_CLAMP_MAX       0x14 /* Update util_max */
> > #define SCHED_FLAG_UTIL_CLAMP           ( \
> >                 SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)
> >
> 
> Having ability to update only min or only max this way might be indeed
> very useful.
> Instead of rolling back on failure I would suggest to check both
> inputs first to make sure there won't be any error before updating.
> This would remove the need for SCHED_FLAG_UTIL_CLAMP_STRICT (which I
> think any user would want to set to 1 anyway).
> Looks like uclamp_group_get() can fail only if uclamp_group_find()
> fails to find a slot for uclamp_value or a free slot. So one way to do
> this search before update is to call uclamp_group_find() for both
> UCLAMP_MIN and UCLAMP_MAX beforehand and if they succeed then pass
> obtained next_group_ids into uclamp_group_get() to avoid doing the
> same search twice. This requires some refactoring of
> uclamp_group_get() but I think the end result would be a cleaner and
> more predictable solution.

Yes, that sound possible... provided we check all the groups under the
same uclamp_mutex, it should be possible to find the group_ids before
actually increasing the refcount.

... will look into this for the next reposting.

-- 
#include <best/regards.h>

Patrick Bellasi
