Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0qmyG6tMGFsIHAAAmS7hNA
	; Wed, 06 Jun 2018 21:05:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5D1CE607E4; Wed,  6 Jun 2018 21:05:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ACFD86063F;
	Wed,  6 Jun 2018 21:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACFD86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeFFVFo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:05:44 -0400
Received: from mail.santannapisa.it ([193.205.80.99]:41932 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeFFVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:05:43 -0400
X-Greylist: delayed 746 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 17:05:43 EDT
Received: from [151.40.69.140] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 131054505; Wed, 06 Jun 2018 23:05:42 +0200
Date: Wed, 6 Jun 2018 23:05:36 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180606230536.2c0ae587@nowhere>
In-Reply-To: <20180606132046.GC10870@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
        <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
        <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
        <20180605121153.GD16081@localhost.localdomain>
        <20180605130548.GB12193@e108498-lin.cambridge.arm.com>
        <20180605131518.GG16081@localhost.localdomain>
        <20180605140101.GE12193@e108498-lin.cambridge.arm.com>
        <20180605141317.GJ16081@localhost.localdomain>
        <6c2dc1aa-3e19-be14-0ed8-b29003c72e61@evidence.eu.com>
        <20180606132046.GC10870@e108498-lin.cambridge.arm.com>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Jun 2018 14:20:46 +0100
Quentin Perret <quentin.perret@arm.com> wrote:
[...]
> > However, IMHO, these are corner cases and in the average case it is
> > better to rely on running_bw and reduce the CPU frequency
> > accordingly.  
> 
> My point was that accepting to go at a lower frequency than required
> by this_bw is fundamentally unsafe. If you're at a low frequency when
> a DL task starts, there are real situations where you won't be able
> to increase the frequency immediately, which can eventually lead to
> missing deadlines. Now, if this risk is known, has been discussed,
> and is accepted, that's fair enough. I'm just too late for the
> discussion :-)

Well, our conclusion was that this issue can be addressed when
designing the scheduling parameters:
- If we do not consider frequency scaling, a task can respect its
  deadlines if the SCHED_DEADLINE runtime is larger than the task's
  execution time and the SCHED_DEADLINE period is smaller than the
  task's period (and if some kind of "global" admission test is
  respected)
- Considering frequency scaling (and 0-time frequency switches), the
  SCHED_DEADLINE runtime must be larger than the task execution time at
  the highest frequency
- If the frequency switch time is larger than 0, then the
  SCHED_DEADLINE runtime must be larger than the task execution time
  (at the highest frequency) plus the frequency switch time

If this third condition is respected, I think that deadline misses can
be avoided even if running_bw is used (and the CPU takes a considerable
time to switch frequency). Of course, this requires an over-allocation
of runtime (and the global admission test has more probabilities to
fail)...



			Luca
