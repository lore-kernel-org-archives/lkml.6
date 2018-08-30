Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B16C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C846E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C846E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeH3OUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:20:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbeH3OUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070FD7A9;
        Thu, 30 Aug 2018 03:18:49 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110803F721;
        Thu, 30 Aug 2018 03:18:44 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:18:42 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Message-ID: <20180830101842.GU2960@e110439-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <20180829165058.GR2960@e110439-lin>
 <20180829172004.afbe2oukprvptqs2@queper01-lin>
 <20180830092329.GS2960@e110439-lin>
 <20180830095723.4qqbpft7gpbtgkhd@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830095723.4qqbpft7gpbtgkhd@queper01-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Aug 10:57, Quentin Perret wrote:
> Hi Patrick,
> 
> On Thursday 30 Aug 2018 at 10:23:29 (+0100), Patrick Bellasi wrote:
> > Yes, dunno if it's just me but perhaps a bit of rephrasing could help.
> 
> Ok, so what about something a little bit more explicit like:
> 
> /*
>  * The complexity of the Energy Model is defined as:
>  *
>  *		C = nr_pd * (nr_cpus + nr_cs)
>  *
>  * with parameters defined as:
>  *  - nr_pd:	the number of performance domains
>  *  - nr_cpus:	the number of CPUs
>  *  - nr_cs:	the sum of the number of capacity states of all performance
>  *		domains (for example, on a system with 2 performance domains,
>  *		with 10 capacity states each, nr_cs = 2 * 10 = 20).
>  *
>  * It is generally not a good idea to use such a model in the wake-up path on
>  * very complex platforms because of the associated scheduling overheads. The
>  * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
>  * with per-CPU DVFS and less than 8 capacity states each, for example.
>  */

That looks better to me.

> > Alternatively, why not having this comment and check after patches
> > 11 and 12 ?
> 
> Oh, you don't like it here ? What's wrong with it :-) ?

Was just saying that since you refer to the complexity of an algo,
which is effectively introduced by a later patch, it could be easier
to understand where the magic numbers come from if you keep the
comment closer to the algo... but it's not really something major.
At the end, when you look at the full series, you still have all the
full picture... thus, if the maintainers are ok with it being here:
it's perfectly fine for me too ;)

> > Right... I was totally confused by the idea that we don't
> > run EAS if we just have 1 CPU per PD... my bad!
> > 
> > Although on those systems, since we don't have idle costs, should not
> > be a spreading strategy always the best from an energy efficiency
> > standpoint ?
> 
> Even with per-CPU DVFS, if you have big and little CPUs it matters
> _where_ you execute a task, and you'll still need an Energy Model to
> make good decisions in a generic way.

Very good point! ;)

> But yes, there is definitely some room for improvement for those
> platforms. That's something we could improve later on top of this
> series I suppose.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
