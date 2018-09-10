Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E4C20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIJPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:00:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeIJPAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:00:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B6218A;
        Mon, 10 Sep 2018 03:07:26 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05AF3F557;
        Mon, 10 Sep 2018 03:07:22 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:07:21 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180910100719.uan6gskxpgu25dj5@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-11-quentin.perret@arm.com>
 <3619149.Cl0Cp2apok@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3619149.Cl0Cp2apok@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 Sep 2018 at 11:53:58 (+0200), Rafael J. Wysocki wrote:
> On Monday, August 20, 2018 11:44:16 AM CEST Quentin Perret wrote:
> > Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
> > to decide which frequency to request. Energy Aware Scheduling (EAS)
> > needs to be able to predict those requests to assess the energy impact
> > of scheduling decisions. However, the PELT signals aggregation is only
> > done in schedutil for now, hence making it hard to synchronize it with
> > EAS.
> > 
> > To address this issue, introduce schedutil_freq_util() to perform the
> > aforementioned aggregation and make it available to other parts of the
> > scheduler. Since frequency selection and energy estimation still need
> > to deal with RT and DL signals slightly differently, schedutil_freq_util()
> > is called with a different 'type' parameter in those two contexts, and
> > returns an aggregated utilization signal accordingly.
> 
> This is complementary to patch [02/14] IMO.
> 
> schedutil_freq_util() and map_util_freq() introduced by that patch should
> always be used together as they are two parts of one algorithm in my view.

I agree.

> Would it be possible to make that clearer?

I could squash the two at the beginning of the series in a preparatory
patch that refactors schedutil for EAS all in one go, with a clear
mention of what we intend to do (make EAS depend on sugov) in the commit
message.

Would that work ?

Thanks,
Quentin
