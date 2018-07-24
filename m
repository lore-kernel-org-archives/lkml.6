Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584B220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeGXRu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:28 -0400
Received: from foss.arm.com ([217.140.101.70]:54996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbeGXRu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E51C380D;
        Tue, 24 Jul 2018 09:43:08 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 465043F5B3;
        Tue, 24 Jul 2018 09:43:06 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:43:03 +0100
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
Subject: Re: [PATCH v2 12/12] sched/core: uclamp: use percentage clamp values
Message-ID: <20180724164303.GB3162@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-13-patrick.bellasi@arm.com>
 <CAJuCfpEwRtXoa_tnWTFP8CuyPMHsLAXky14K_jyphEeo2d32qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEwRtXoa_tnWTFP8CuyPMHsLAXky14K_jyphEeo2d32qg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Jul 21:04, Suren Baghdasaryan wrote:
> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +static inline unsigned int scale_from_percent(unsigned int pct)
> > +{
> > +       WARN_ON(pct > 100);
> > +
> > +       return ((SCHED_FIXEDPOINT_SCALE * pct) / 100);
> > +}
> > +
> > +static inline unsigned int scale_to_percent(unsigned int value)
> > +{
> > +       unsigned int rounding = 0;
> > +
> > +       WARN_ON(value > SCHED_FIXEDPOINT_SCALE);
> > +
> > +       /* Compensate rounding errors for: 0, 256, 512, 768, 1024 */
> > +       if (likely((value & 0xFF) && ~(value & 0x700)))
> > +               rounding = 1;
> 
> Hmm. I don't think ~(value & 0x700) will ever yield FALSE... What am I missing?

So, 0x700 is the topmost 3 bits sets (111 0000 0000) which different
configuration corresponds to:

 001 0000 0000 =>  256
 010 0000 0000 =>  512
 011 0000 0000 =>  768
 100 0000 0000 => 1024

Thus, if 0x700 matches then we have one of these values in input and
for these cases we have to add a unit to the percentage value.

For the case (value == 0) we translate it into 0% thanks to the check
on (value & 0xFF) to ensure rounding = 0.

Here is a small python snippet I've used to check the conversion of
all the possible percentage values:

---8<---
values = range(0, 101)
for pct in xrange(0, 101):
	util = int((1024 * pct) / 100)
        rounding = 1
        if not ((util & 0xFF) and ~(util & 0x700)):
            print "Fixing util_to_perc({:3d} => {:4d})".format(pct, util)
            rounding = 0
	pct2 = (rounding + ((100 * util) / 1024))
	if pct2 in values:
		values.remove(pct2)
        if pct != pct2:
            print "Convertion failed for: {:3d} => {:4d} => {:3d}".format(pct, util, pct2)
if values:
    print "ERROR: not all percentage values converted"
---8<---

-- 
#include <best/regards.h>

Patrick Bellasi
