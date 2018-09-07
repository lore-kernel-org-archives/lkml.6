Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E9DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB32075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIGNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:04:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeIGNEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:04:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC567A9;
        Fri,  7 Sep 2018 01:24:32 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30DBF3F557;
        Fri,  7 Sep 2018 01:24:28 -0700 (PDT)
Date:   Fri, 7 Sep 2018 09:24:23 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Message-ID: <20180907082139.ogsdxambyryhgsu4@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
 <20180906092955.tq27mhzfkovo2ehn@queper01-lin>
 <e4e9d572-94ba-9d01-d18a-aa0ddd6fd357@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e9d572-94ba-9d01-d18a-aa0ddd6fd357@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Sep 2018 at 16:49:47 (-0700), Dietmar Eggemann wrote:
> I would prefer a sched_feature. I guess it has to be disabled by default so
> that other systems don't have to check rcu_dereference(rd->pd) in the wakeup
> path.

Right, this is what I had in mind too. I guess downstream kernels can
always carry a patch that changes the default if they want it enabled
without messing around in userspace.

> But since at the beginning EAS will be the only user of the EM there is no
> need to change the static key sched_energy_present right now.

Indeed, I could add a patch introducing this sched_feat in the series
that migrates IPA to using the EM framework (to be posted later). It is
just not required until we have a new user.

However that IPA-related patchset would then change the default
behaviour for users who used to get EAS enabled automatically, but
wouldn't after updating their kernel (meaning they'd now have to flip
switches by hand whereas it used to "just work"). Not sure if that
qualifies as "breaking users" (cf. Linus' rule #1 of kernel
development) ...

Thanks,
Quentin
