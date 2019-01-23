Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26294C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E711821726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ES9ixFtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfAWK2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:28:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2OAmpkokEWvOSnyXOX8ZFJLh+s8HCCit4PaQWJzU6w0=; b=ES9ixFtWVwntvSBMhOv90hgJ1
        qBpSsweVRRiinXEaq1UqbSmaahV+qlPZacTmLRwbTTD10OjCt1Gtt87/OQJUxqYKQ6MkwUkqvcjbo
        lOI6fbaKbJHHENrduAGceqPnL0GOLFHdFjmztNe/iR7jpfyt9wr/b+i1pFSuvdEeEXgEMDCstv7Xc
        Et9JDQd2iSiTVC7i3DC8kDmbgHeh7eX9ag9AMxi0UCiK/lmKuNde59HkbHTKetLVBDPcR/07cnmHA
        1yEXxBi0hGNpYWPzyuAm+zpB8F32P5bcuWSdHszklTBnx0gvyRgXytbr4nrJB0Fx3W0bQ65SxXMw6
        zjCVMnJNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmFlf-0002J1-4X; Wed, 23 Jan 2019 10:28:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FDC7201EC17E; Wed, 23 Jan 2019 11:28:21 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:28:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190123102821.GW27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-10-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> -	util = (type == ENERGY_UTIL)
> -		? util_cfs
> -		: uclamp_util(rq, util_cfs);
> -	util += cpu_util_rt(rq);
> +	util = cpu_util_rt(rq);
> +	if (type == FREQUENCY_UTIL) {
> +		util += cpu_util_cfs(rq);
> +		util  = uclamp_util(rq, util);
> +	} else {
> +		util += util_cfs;
> +	}

Or the combined thing:

-       util = util_cfs;
-       util += cpu_util_rt(rq);
+       util = cpu_util_rt(rq);
+       if (type == FREQUENCY_UTIL) {
+               util += cpu_util_cfs(rq);
+               util  = uclamp_util(rq, util);
+       } else {
+               util += util_cfs;
+       }


Leaves me confused.

When type == FREQ, util_cfs should already be cpu_util_cfs(), per
sugov_get_util().

So should that not end up like:

	util = util_cfs;
	util += cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_util(rq, util);

instead?


