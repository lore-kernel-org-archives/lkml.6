Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39640C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D4F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfA3rnFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D4F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeJZRRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:17:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJZRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5atkWir6ghzgiILbbZT65wg/YpH//DDcxVrUM83TN4E=; b=nfA3rnFoxtn+hM/yvCdTRlax9
        l6NP0qBz+qRdo9OKxEtpEfGISCGYq0TFBUtV0WwLkQcBWdrTeuZSBaPQD9siVvqIGZ45+UD9Tt3X1
        sqFWyRvLqKFQth44l415zRnTQbQFT/oyX2eZwYysNYOCyxG3fOn8QHxgMabdwtjdyQMjs0Rww6zkK
        /DkC+89B21AnMs8WlTAN0vbFA8XweYyJuP5WG9KDngFKzq+X9TgrfI5Tjk9oyhwiEFJqPQz0hYFFG
        HXk04hZJQ1fIbZL3DN+Jh1CLDA43Xiq2TfGSpIib4ZpVe1lJAt2BtOtsQcR13NvGVRCeOzOcmfFsy
        qFVEw9ypA==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFxg8-0000xt-L5; Fri, 26 Oct 2018 08:41:13 +0000
Received: by worktop (Postfix, from userid 1000)
        id 5323E6E07D9; Fri, 26 Oct 2018 10:41:05 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:41:05 +0200
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
Message-ID: <20181026084105.GY3109@worktop.c.hoisthospitality.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024100323.GO3109@worktop.c.hoisthospitality.com>
 <20181024103002.GB18466@linux.vnet.ibm.com>
 <20181025000707.GR3109@worktop.c.hoisthospitality.com>
 <20181025173058.GD18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025173058.GD18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:00:58PM +0530, Srikar Dronamraju wrote:
> > But it doesn't solve the problem.
> > 
> > You can create multiple partitions with cpusets but still have an
> > unbound task in the root cgroup. That would suffer the exact same
> > problems.
> > 
> > Thing is, load-balancing, of any kind, should respect sched_domains, and
> > currently numa balancing barely looks at it.
> 
> Agreed that we should have looked at sched_domains. However I still believe
> we can't have task->cpus_allowed with a mix of isolcpus and non-isolcpus.
> won't it lead to inconsistent behaviour?

We currently can; and it depends on what you call inconsistent.

> > The proposed patch puts the minimal constraints on the numa balancer to
> > respect sched_domains; but doesn't yet correctly deal with hotplug.
> 
> I was also thinking about hotplug. Also your proposed patch and even my
> proposed patch don't seem to work well with the below scenario.
> 
> # cat /sys/devices/system/cpu/possible
> 0-31
> # cat /sys/devices/system/cpu/isolated
> 1,5,9,13
> # cat hist.sh
> echo 0 > /proc/sys/kernel/numa_balancing
> cd /sys/fs/cgroup/cpuset
> mkdir -p student
> cp cpuset.mems student/
> cd student
> echo "0-31" > cpuset.cpus
> echo $$ > cgroup.procs 
> echo "1-8" > cpuset.cpus
> /home/srikar/work/ebizzy-0.3/ebizzy -S 1000 &
> PID=$!
> sleep 10
> pidstat -p $! -t |tail -n +3 |head -n 10
> pidstat -p $$ -t |tail -n +3
> pkill ebizzy
> #
> # ./hist.sh
> 10:35:21  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
> 10:35:21  IST     0      2645         -    8.70    0.01    0.00    8.71     1  ebizzy
> 10:35:21  IST     0         -      2645    0.01    0.00    0.00    0.01     1  |__ebizzy
> 10:35:21  IST     0         -      2647    0.14    0.00    0.00    0.14     1  |__ebizzy
> 10:35:21  IST     0         -      2648    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:21  IST     0         -      2649    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:21  IST     0         -      2650    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:21  IST     0         -      2651    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:21  IST     0         -      2652    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:21  IST     0         -      2653    0.13    0.00    0.00    0.13     1  |__ebizzy
> 10:35:23  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
> 10:35:23  IST     0      2642         -    0.00    0.00    0.00    0.00     1  hist.sh
> 10:35:23  IST     0         -      2642    0.00    0.00    0.00    0.00     1  |__hist.sh
> #

That's correct and specified behaviour.

cpu1 has no sched domain (or the singleton domaon, which is the same)
and thus its tasks will not be migrated.

If there is a problem, it is with cpuset and its interaction with
isolcpus. I still have to look at the last version of cpuset-v2, but
iirc that was better in this regard.

I'm stil saying we should kill isolcpus entirely, its rubbish, has
always been.
