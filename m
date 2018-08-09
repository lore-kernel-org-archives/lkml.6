Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADFC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB07B21D07
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB07B21D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeHIMCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:02:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbeHIMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2342118A;
        Thu,  9 Aug 2018 02:38:18 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253DF3F5D4;
        Thu,  9 Aug 2018 02:38:14 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:38:09 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180809093808.dkhf53a7gecv3djo@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <CAKfTPtBxWheWa4igKtwUmQR3x=7Zojnb65uFpeFUqxHmSkOh5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBxWheWa4igKtwUmQR3x=7Zojnb65uFpeFUqxHmSkOh5w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 Aug 2018 at 11:30:57 (+0200), Vincent Guittot wrote:
> On Tue, 24 Jul 2018 at 14:26, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > From: Morten Rasmussen <morten.rasmussen@arm.com>
> >
> > Energy-aware scheduling is only meant to be active while the system is
> > _not_ over-utilized. That is, there are spare cycles available to shift
> > tasks around based on their actual utilization to get a more
> > energy-efficient task distribution without depriving any tasks. When
> > above the tipping point task placement is done the traditional way based
> > on load_avg, spreading the tasks across as many cpus as possible based
> > on priority scaled load to preserve smp_nice. Below the tipping point we
> > want to use util_avg instead. We need to define a criteria for when we
> > make the switch.
> >
> > The util_avg for each cpu converges towards 100% (1024) regardless of
> 
> remove the "(1024)" because util_avg converges to max cpu capacity
> which can be different from 1024

Good point, will be fixed in v6.

Thanks,
Quentin
