Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F936C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0BF20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0BF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeLKOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:49:09 -0500
Received: from foss.arm.com ([217.140.101.70]:48852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLKOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:49:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31CC61596;
        Tue, 11 Dec 2018 06:49:07 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53253F575;
        Tue, 11 Dec 2018 06:49:02 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:49:01 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
 <20181211141509.GA32005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211141509.GA32005@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Tuesday 11 Dec 2018 at 15:15:09 (+0100), Ingo Molnar wrote:
> 
> * Quentin Perret <quentin.perret@arm.com> wrote:
> 
> > In its current state, Energy Aware Scheduling (EAS) starts automatically
> > on asymmetric platforms having an Energy Model (EM). However, there are
> > users who want to have an EM (for thermal management for example), but
> > don't want EAS with it.
> 
> Well, then introduce a new Kconfig variant for EAS, if it's super 
> important to allow this to be disabled.
> 
> Why do we want to disable it - is it not reliable in some circumstances?

There are people out there using big.little systems who do not care
about energy. Not very many of them, that is true, but they exist. And
those people can be interested in having an Energy Model for
IPA/thermal but also want to spread tasks to minimize latency for
example. So those guys will appreciate a knob, I think. Otherwise EAS
gets enabled/disabled only by side effects (by enabling/disabling
schedutil for example).

> > In order to let users disable EAS explicitly, introduce a new sysctl
> > called 'sched_energy_aware'. It is enabled by default so that EAS can
> > start automatically on platforms where it makes sense. Flipping it to 0
> > rebuilds the scheduling domains and disables EAS.
> 
> Yeah, making this a sysctl ABI is asking for trouble - this really should 
> be a Kconfig or debug space knob, at most.

My original proposal was a sched_feat, but Peter didn't like it because,
well, it's a debug knob :-). I'm personally not against a Kconfig, I
just had the feeling scheduler-specific Kconfig weren't welcome in
general. But if you feel like EAS could be a reasonable exception to the
rule, I won't argue. Otherwise, Juri suggested to have a command line
option at some point. Would that be a better solution ?

Also, when you say we're asking for trouble, what are you referring to
exactly ? There are a couple of existing sysctl to enable/disable
scheduler features.

Thanks,
Quentin
