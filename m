Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D5y4EcZXGFsJDgAAmS7hNA
	; Wed, 06 Jun 2018 21:53:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2C0FE6089E; Wed,  6 Jun 2018 21:53:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F1BD601C3;
	Wed,  6 Jun 2018 21:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F1BD601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeFFVxU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:53:20 -0400
Received: from mail.santannapisa.it ([193.205.80.99]:52467 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeFFVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:53:19 -0400
Received: from [151.40.69.140] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 131054393; Wed, 06 Jun 2018 22:53:15 +0200
Date: Wed, 6 Jun 2018 22:53:09 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Quentin Perret <quentin.perret@arm.com>,
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
Message-ID: <20180606225309.24602773@nowhere>
In-Reply-To: <6c2dc1aa-3e19-be14-0ed8-b29003c72e61@evidence.eu.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
        <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
        <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
        <20180605121153.GD16081@localhost.localdomain>
        <20180605130548.GB12193@e108498-lin.cambridge.arm.com>
        <20180605131518.GG16081@localhost.localdomain>
        <20180605140101.GE12193@e108498-lin.cambridge.arm.com>
        <20180605141317.GJ16081@localhost.localdomain>
        <6c2dc1aa-3e19-be14-0ed8-b29003c72e61@evidence.eu.com>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry; I missed the beginning of this thread... Anyway, below I add
some comments:

On Wed, 6 Jun 2018 15:05:58 +0200
Claudio Scordino <claudio@evidence.eu.com> wrote:
[...]
> >> Ok, I see ... Have you guys already tried something like my patch
> >> above (keeping the freq >= this_bw) in real world use cases ? Is
> >> this costing that much energy in practice ? If we fill the gaps
> >> left by DL (when it  
> > 
> > IIRC, Claudio (now Cc-ed) did experiment a bit with both
> > approaches, so he might add some numbers to my words above. I
> > didn't (yet). But, please consider that I might be reserving (for
> > example) 50% of bandwidth for my heavy and time sensitive task and
> > then have that task wake up only once in a while (but I'll be
> > keeping clock speed up for the whole time). :/  
> 
> As far as I can remember, we never tested energy consumption of
> running_bw vs this_bw, as at OSPM'17 we had already decided to use
> running_bw implementing GRUB-PA. The rationale is that, as Juri
> pointed out, the amount of spare (i.e. reclaimable) bandwidth in
> this_bw is very user-dependent.

Yes, I agree with this. The appropriateness of using this_bw or
running_bw is highly workload-dependent... If a periodic task consumes
much less than its runtime (or if a sporadic task has inter-activation
times much larger than the SCHED_DEADLINE period), then running_bw has
to be preferred. But if a periodic task consumes almost all of its
runtime before blocking, then this_bw has to be preferred...

But this also depends on the hardware: if the frequency switch time is
small, then running_bw is more appropriate... On the other hand,
this_bw works much better if the frequency switch time is high.
(Talking about this, I remember Claudio measured frequency switch times
large almost 3ms... Is this really due to hardware issues? Or maybe
there is some software issue invoved? 3ms look like a lot of time...)

Anyway, this is why I proposed to use some kind of /sys/... file to
control the kind of deadline utilization used for frequency scaling: in
this way, the system designer / administrator, who hopefully has the
needed information about workload and hardware, can optimize the
frequency scaling behaviour by deciding if running_bw or this_bw will be
used.


			Luca

> For example, the user can let this_bw
> be much higher than the measured bandwidth, just to be sure that the
> deadlines are met even in corner cases. In practice, this means that
> the task executes for quite a short time and then blocks (with its
> bandwidth reclaimed, hence the CPU frequency reduced, at the 0lag
> time). Using this_bw rather than running_bw, the CPU frequency would
> remain at the same fixed value even when the task is blocked. I
> understand that on some cases it could even be better (i.e. no waste
> of energy in frequency switch). However, IMHO, these are corner cases
> and in the average case it is better to rely on running_bw and reduce
> the CPU frequency accordingly.
> 
> Best regards,
> 
>               Claudio
