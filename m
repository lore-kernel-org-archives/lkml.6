Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E478208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E478208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeGPK4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:56:13 -0400
Received: from foss.arm.com ([217.140.101.70]:56646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbeGPK4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:56:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9756E15AD;
        Mon, 16 Jul 2018 03:29:26 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A354C3F589;
        Mon, 16 Jul 2018 03:29:22 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:29:17 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Message-ID: <20180716102917.GA19311@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
 <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 Jul 2018 at 09:32:02 (+0100), Quentin Perret wrote:
> Indeed, having 'capacity' values in the EM framework is just an
> optimization for the scheduler, so that it doesn't need to compute them
> in the wake-up path. I could get rid of the whole
> em_rescale_cpu_capacity() mess (and by the same occasion the RCU
> protection of the tables ...) if I removed the 'capacity' values from
> the EM.

Another thing to take into consideration here is basically that the
thermal subsystem (IPA) will be impacted by the RCU protection on the
cs_table. However, since the 'frequency' and 'power' fields do not change
at run-time, and since IPA doesn't need the 'capacity' value, there is no
good reason to have IPA do rcu_read_lock() all over the place, so
arguably something needs to be fixed here.

One possibility is to remove entirely the following struct:
	struct em_cap_state {
		unsigned long capacity;
		unsigned long frequency; /* Kilo-hertz */
		unsigned long power; /* Milli-watts */
	};

and to have three independent vectors (of the same size) for frequency,
power and capacity. That way only the 'capacity' vector would be RCU
protected, and IPA could use 'frequency' and 'power' directly, without
further protections.

A second possibility is to remove the capacity values from the EM
altogether (as I suggested in my previous message) and to get rid of the
need for RCU protection at the same occasion.

The second option simplifies the code of the EM framework significantly
(no more em_rescale_cpu_capacity()) and shouldn't introduce massive
overheads on the scheduler side (the energy calculation already
requires one multiplication and one division, so nothing new on that
side). At the same time, that would make it a whole lot easier to
interface the EM framework with IPA without having to deal with RCU all
over the place.

So, if there are no objections, I'll try to explore that possibility for
v5.

I hope that makes sense

Thanks,
Quentin
