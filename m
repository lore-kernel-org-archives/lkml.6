Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528BBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179E5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIETYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:24:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbeIETYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D2380D;
        Wed,  5 Sep 2018 07:54:04 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B89B3F575;
        Wed,  5 Sep 2018 07:54:02 -0700 (PDT)
Date:   Wed, 5 Sep 2018 15:53:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        peterz@infradead.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dzickus@redhat.com, brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
Message-ID: <20180905145353.GA14069@e107155-lin>
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
 <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:23:46PM +0200, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Thomas Gleixner wrote:
> > On Tue, 4 Sep 2018, Neeraj Upadhyay wrote:
> > >  	ret = cpuhp_down_callbacks(cpu, st, target);
> > >  	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> > > -		cpuhp_reset_state(st, prev_state);
> > > +		/*
> > > +		 * As st->last is not set, cpuhp_reset_state() increments
> > > +		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
> > > +		 * skipped during rollback. So, don't use it here.
> > > +		 */
> > > +		st->rollback = true;
> > > +		st->target = prev_state;
> > > +		st->bringup = !st->bringup;
> > 
> > No, this is just papering over the actual problem.
> > 
> > The state inconsistency happens in take_cpu_down() when it returns with a
> > failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
> > and st->state is then incremented in undo_cpu_down().
> > 
> > That's the real issue and we need to analyze the whole cpu_down rollback
> > logic first.
> 
> And looking closer this is a general issue. Just that the TEARDOWN state
> makes it simple to observe. It's universaly broken, when the first teardown
> callback fails because, st->state is only decremented _AFTER_ the callback
> returns success, but undo_cpu_down() increments unconditionally.
> 
> Patch below.

This patch fixes the issue reported @[1]. Lorenzo did some debugging and
I wanted to have a look at it at some point but this discussion drew my
attention and sounded very similar[2]. So I did a quick test with this
patch and it fixes the issue.

--
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/CAMuHMdVg868LgL5xTg5Dp5rReKxoo+8fRy+ETJiMxGWZCp+hWw@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20180823131505.GA31558@red-moon/
