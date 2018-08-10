Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFECC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538FD223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538FD223F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHJNo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:44:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49783 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:44:57 -0400
Received: from 79.184.254.16.ipv4.supernova.orange.pl (79.184.254.16) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 67a6834cf7f3fea2; Fri, 10 Aug 2018 13:15:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date:   Fri, 10 Aug 2018 13:13:22 +0200
Message-ID: <8482157.ZqyaK8WryI@aspire.rjw.lan>
In-Reply-To: <20180810091216.nieosjtu7l33z4ap@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com> <2467271.WAtZ4Z8dKT@aspire.rjw.lan> <20180810091216.nieosjtu7l33z4ap@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 10, 2018 11:12:18 AM CEST Quentin Perret wrote:
> On Friday 10 Aug 2018 at 10:41:56 (+0200), Rafael J. Wysocki wrote:
> > On Friday, August 10, 2018 10:15:39 AM CEST Quentin Perret wrote:

[cut]

> Agreed. EAS and IPA don't care about the absolute real power values, all
> they care about is relative correctness. But what I really want to avoid
> is having IPA getting the power of the GPUs in mW, and the power of CPUs
> in an abstract scale without unit. That _will_ create problems eventually
> IMO, because the behaviour is undefined. Specifying a unit everywhere is
> an easy way to enforce a consistent design across sub-systems, that's
> all.

OK

> > > What I am currently proposing is to keep the unit (mW) in the EM
> > > framework so that migrating IPA to using it can be done in a (relatively)
> > > painless way. On a system where drivers  don't know the exact wattage,
> > > then they should just 'lie' to the EM framework, but it's their job to
> > > lie coherently to all subsystems and keep things consistent, because all
> > > subsystems have specified power in comparable units.
> > 
> > Alternatively, there could be a translation layer between EM and IPA.
> 
> Hmm, interesting... What do you have in mind exactly ? What would you
> put in that layer ?

Something able to say how the numbers used by EM and IPA are related. :-)

Do you think that IPA and EM will always need to use the same set of data for
the CPU?

> > From my experience, if you want people to come up with some numbers,
> > they will just choose them to game the system this way or another
> > unless those numbers can be measured directly or are clearly documented.
> > 
> > And if that happens and then you want to make any significant changes,
> > you'll need to deal with "regressions" occuring because someone chose
> > the numbers to make the system behave in a specific way and your changes
> > break that.
> > 
> > As a rule, I rather avoid requesting unknown numbers from people. :-)
> > 
> > > Another solution to solve this problem could be to extend the EM
> > > framework introduced by this patch and make it manage the EM of any
> > > device, not just CPUs. Then we could just specify that all power costs
> > > must be in the same scale, regardless of the actual unit, and register
> > > the EM of CPUs, GPUs, ...
> > > However, I was hoping that this patch as-is was enough for a first step,
> > > and that this extension of the framework could be done in a second step ?
> > > Thoughts ?
> > > 
> > > In any case, if we decide to keep the mW unit for now, I should at least
> > > explain clearly why in the commit message.
> > 
> > Right.
> > 
> > Actually, the unit is as good as any other, but you need to bear in mind that
> > the numbers provided may not be realistic.
> 
> As long as they're all correct in a relative way, that's fine by me :-)

OK

Thanks,
Rafael

