Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YBmRHdJqGVvmQAAAmS7hNA
	; Thu, 07 Jun 2018 17:26:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 45B2E608BF; Thu,  7 Jun 2018 17:26:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC7B8605A2;
	Thu,  7 Jun 2018 17:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC7B8605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934456AbeFGR0p (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:26:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54868 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933668AbeFGR0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97A471435;
        Thu,  7 Jun 2018 10:26:41 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A9A3F59D;
        Thu,  7 Jun 2018 10:26:37 -0700 (PDT)
Date: Thu, 7 Jun 2018 18:26:36 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180607172635.GC3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180607144422.GA17216@localhost.localdomain>
 <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
 <20180607162910.GE3311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607162910.GE3311@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jun 2018 at 18:29:10 (+0200), Juri Lelli wrote:
> On 07/06/18 17:02, Quentin Perret wrote:
> > On Thursday 07 Jun 2018 at 16:44:22 (+0200), Juri Lelli wrote:
> > > Not sure about this. How about multi-freq domain same max capacity
> > > systems. I understand that most of the energy saving come from selecting
> > > the right (big/LITTLE) cluster, but EM should still be useful to drive
> > > OPP selection (that was one of the use-cases we discussed lately IIRC)
> > > and also to decide between packing or spreading, no?
> > 
> > So, let's discuss the usage of the EM for frequency selection first,
> > and its usage for task placement after.
> > 
> > For frequency selection, schedutil could definitely use the EM as
> > provided by the framework introduced in patch 03/10. We could definitely
> > use that to make policy decisions (jump faster to the so called "knee"
> > if there is one for ex). This is true for symmetric and asymmetric
> > system. And I consider that independent from this patch. This patch is
> > about providing the scheduler with an EM to biais _task placement_.
> > 
> > So, about the task placement ... There are cases (at least theoretical
> > ones) where EAS _could_ help on symmetric systems, but I have never
> > been able to measure any real benefits in practice. Most of the time,
> > it's a good idea from an energy standpoint to just spread the tasks
> > and to keep the OPPs as low as possible on symmetric systems, which is
> > already what CFS does. Of course you can come-up with specific counter
> > examples, but the question is whether or not these (corner) cases are
> > that important. They might or might not, it's not so easy to tell.
> > 
> > On asymmetric systems, it is pretty clear that there is a massive
> > potential for saving energy with a different task placement strategy.
> > So, since the big savings are there, our idea was basically to address
> > that first, while we minimize the risk of hurting others (server folks
> > for ex). I guess that enabling EAS for asymmetric systems can be seen as
> > an incremental step. We should be able to extend the scope of EAS to
> > symmetric systems later, if proven useful.
> > 
> > Another thing is that, if you are using an asymmetric system (e.g.
> > big.LITTLE), it is a good indication that energy/battery life is probably
> > important for your use-case, and that you might be ready to "pay" the
> > cost of EAS to save energy. This isn't that obvious for symmetric
> > systems.
> 
> Ok, I buy the step by step approach starting from the use case that
> seems to fit most. But I still feel that having something like 3. stated
> (or in the code) might stop people from trying to see if having an EM
> around might help other cases (freq, sym, etc.).

Ok, I see what you mean. What I should make more clear is that this
patch-set really is split in two relatively independent parts. Patches
01 to 04 introduce a centralized EM framework, which doesn't depend on
the scheduler, or thermal, or schedutil, or anything. It's an
independent thing. And then you can see patches 05 to 10 as _one
possible use-case_ for this framework: EAS.

I'm not convinced that patches 01-04 can leave on their own though. I
assume it must pretty hard to understand how this whole framework can be
used if there isn't an example of user with it ...


> Also, if no EM data is present should equally result in disabling the
> whole thing, so not much (at all?) overhead for who is simply not
> providing data, no?

Right, but some users might want to have an EM without EAS I guess ...
Otherwise, the other solution would be to have a new knob (a sched_feat
for ex ?) to let users disable EAS if they're not interested in saving
energy.

Thanks,
Quentin
