Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A3EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EC2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547EC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeIDPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:23:55 -0400
Received: from foss.arm.com ([217.140.101.70]:40686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbeIDPXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6197A9;
        Tue,  4 Sep 2018 03:59:17 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255B33F5BC;
        Tue,  4 Sep 2018 03:59:13 -0700 (PDT)
Date:   Tue, 4 Sep 2018 11:59:08 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20180904105906.t5i7twyyt2omc45b@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-14-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820094420.26590-14-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 Aug 2018 at 10:44:19 (+0100), Quentin Perret wrote:
> Energy Aware Scheduling (EAS) is designed with the assumption that
> frequencies of CPUs follow their utilization value. When using a CPUFreq
> governor other than schedutil, the chances of this assumption being true
> are small, if any. When schedutil is being used, EAS' predictions are at
> least consistent with the frequency requests. Although those requests
> have no guarantees to be honored by the hardware, they should at least
> guide DVFS in the right direction and provide some hope in regards to the
> EAS model being accurate.
> 
> To make sure EAS is only used in a sane configuration, create a strong
> dependency on schedutil being used. Since having sugov compiled-in does
> not provide that guarantee, extend the existing CPUFreq policy notifier
> with a new case on governor changes. That allows the scheduler to
> register a callback on this notifier to rebuild the scheduling domains
> when governors are changed, and enable/disable EAS accordingly.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> ---
> This patch could probably be squashed into another one, but I kept it
> separate to ease the review. Also, it's probably optional as not having
> it will not 'break' things per se.
> 
> I went for the smallest possible solution I could find, which has the
> good side of being simple, but it's definitely not the only one.
> 
> Another possibility would be to hook things in sugov_start() and
> sugov_stop(), but that requires some more work. In this case, it
> wouldn't be possible to just re-build the sched_domains() from there,
> because when sugov_stop() is called, the 'governor' field of the policy
> hasn't been updated yet, so the condition (if gov == schedutil) in
> build_freq_domains() doesn't work.
> 
> To workaround the issue we'll need to find a way to pass a cpumask to
> the topology code to specifically say 'sugov has been stopped on these
> CPUs'. That would mean more code to handle that, but that would also
> mean we don't have to mess around with the CPUFreq notifiers ...
> 
> Not sure what's best, so all feedback is more than welcome.

Hi,

Does anybody have concerns with this patch ? Is it a reasonable option
to use the CPUFreq notifiers in this case ? If there is anything I can
do to ease the review please let me know.

Also, is there any hope that the 12 first patches could make it in 4.20
on their own ? Or is it already too late ?

Thanks,
Quentin
