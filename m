Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 12895C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9B320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeFLJUe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:20:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932497AbeFLJUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:20:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 462FC1435;
        Tue, 12 Jun 2018 02:20:33 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4563F59D;
        Tue, 12 Jun 2018 02:20:30 -0700 (PDT)
Date:   Tue, 12 Jun 2018 10:20:29 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
Message-ID: <20180612092028.GG17720@e108498-lin.cambridge.arm.com>
References: <CAKfTPtCCi665e45Ar52VLvaeem4Acin0jgo_563nAhYEkhHacw@mail.gmail.com>
 <1528795016-18208-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528795016-18208-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Jun 2018 at 11:16:56 (+0200), Vincent Guittot wrote:
> The time spent under interrupt can be significant but it is not reflected
> in the utilization of CPU when deciding to choose an OPP. Now that we have
> access to this metric, schedutil can take it into account when selecting
> the OPP for a CPU.
> rqs utilization don't see the time spend under interrupt context and report
> their value in the normal context time window. We need to compensate this when
> adding interrupt utilization
> 
> The CPU utilization is :
>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> 
> A test with iperf on hikey (octo arm64) gives:
> iperf -c server_address -r -t 5
> 
> w/o patch		w/ patch
> Tx 276 Mbits/sec        304 Mbits/sec +10%
> Rx 299 Mbits/sec        328 Mbits/sec +09%
> 
> 8 iterations
> stdev is lower than 1%
> Only WFI idle state is enable (shallowest diel state)
                                            ^^^^
nit: s/diel/idle

And, out of curiosity, what happens if you leave the idle states
untouched ? Do you still see an improvement ? Or is it lost in the
noise ?

Thanks,
Quentin
