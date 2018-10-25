Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6003320824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDAWtcQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6003320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJYIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:55:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ksyAYOWSevC/f13+2db0I2FkGuOIdjkFY1dIp9g9k3w=; b=GDAWtcQDyZSousnW8q9khcgx6
        97AOvQ3XTYA1Cuq67juMYrqmFmBXA+Db0hjm8HiAy9lFPBrtFfEPyHmMm2fl9t/w8BkOxjfTWsePE
        9xIMtzpVoB4KQAZjIXNP6R+47vDmwDkLKkC4Jhzp1eDRMIu+NQhfP6oV0+3EecFwbNOvPXrXTt8x+
        YQWXorMPAubKPiRQI8/eZscRIKQ2L+0y69k233nNy1Gs9SyxlFfhUeAmlLIA7aHDnLrA/BAT4Xgk6
        ewzMyZsEaPcuJONzmsIVSoHyhW5IU393b1vuyN4tq1OEf6kOoV1SsNv9Hl5HCoPU3NU7okhr19LRH
        DOoFcqfHw==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTSC-0006SC-3i; Thu, 25 Oct 2018 00:24:49 +0000
Received: by worktop (Postfix, from userid 1000)
        id 89BF66E08B3; Thu, 25 Oct 2018 02:07:07 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:07:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181025000707.GR3109@worktop.c.hoisthospitality.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024100323.GO3109@worktop.c.hoisthospitality.com>
 <20181024103002.GB18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024103002.GB18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:00:02PM +0530, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-10-24 12:03:23]:
> 
> > It appears to me the for_each_online_node() iteration in
> > task_numa_migrate() needs an addition test to see if the selected node
> > has any CPUs in the relevant sched_domain _at_all_.
> > 
> 
> Yes, this should work.
> Yi Wang does this extra check a little differently.
> 
> http://lkml.kernel.org/r/1540177516-38613-1-git-send-email-wang.yi59@zte.com.cn

That's completely broken. Nothing in the numa balancing path uses that
variable and afaict preemption is actually enabled where that's used, so
using that per-cpu variable at all is broken.

> However the last time I had posted you didn't like that approach.
> http://lkml.kernel.org/r/20170406073659.y6ubqriyshax4v4m@hirez.programming.kicks-ass.net

You again checked against isolated_map there, which is not the immediate
problem.

Both of you are fixing symptoms, not the cause.

> Further, I would think the number of times, we would be calling
> sched_setaffinity would be far less than task_numa_migrate().
> In the regular case, where we never have isolcpus, we add this extra check.

But it doesn't solve the problem.

You can create multiple partitions with cpusets but still have an
unbound task in the root cgroup. That would suffer the exact same
problems.

Thing is, load-balancing, of any kind, should respect sched_domains, and
currently numa balancing barely looks at it.

The proposed patch puts the minimal constraints on the numa balancer to
respect sched_domains; but doesn't yet correctly deal with hotplug.

isolcpus is just one case that goes wrong.
