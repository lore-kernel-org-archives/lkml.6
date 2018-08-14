Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB6F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OuqHGI1M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D3Rh4fUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB6F21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHNOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:12:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeHNOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:12:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 28711601B4; Tue, 14 Aug 2018 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534245920;
        bh=Q8OzZ3XWX+ekHPBBUqWeqb5nk2X+feis/WIY09XTyW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuqHGI1MHg/BW8/H28+HwJHM+KPkwqkFI8J/6fxdVREzc5S1IUJ1CadAny7hYn+Nb
         E+MCmzzE7Tgk6DqRYBvvezCwatHaqbNd6SGfmh1cR4T8t7XthlUwVgLqDylzYP4Wk9
         4P1VwQaEXZNHzlhSdMl4Rw0zHLtzHG9dIcJoWWyw=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B7F6601B4;
        Tue, 14 Aug 2018 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534245918;
        bh=Q8OzZ3XWX+ekHPBBUqWeqb5nk2X+feis/WIY09XTyW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3Rh4fUUaKvQvWCVaR1H931yhhLk8ym+zFkABWjdepP9rVsB1ZCemaFTdr332SQ5b
         HxjgrzRMc45ab18SLUANiAiuvUTa07LsQzANYOSydwlDbI0ZCw6qvj5cXLcZz5j621
         GBm3S3F+8Ws8jNN+LseDW5g3jCaRl5UtZa7eZqtQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B7F6601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 14 Aug 2018 16:55:09 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 02/14] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180814112509.GB2661@codeaurora.org>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:39:34PM +0100, Patrick Bellasi wrote:
> Utilization clamping requires each CPU to know which clamp values are
> assigned to tasks that are currently RUNNABLE on that CPU.
> Multiple tasks can be assigned the same clamp value and tasks with
> different clamp values can be concurrently active on the same CPU.
> Thus, a proper data structure is required to support a fast and
> efficient aggregation of the clamp values required by the currently
> RUNNABLE tasks.
> 
> For this purpose we use a per-CPU array of reference counters,
> where each slot is used to account how many tasks require a certain
> clamp value are currently RUNNABLE on each CPU.
> Each clamp value corresponds to a "clamp index" which identifies the
> position within the array of reference couters.
> 
>                                  :
>        (user-space changes)      :      (kernel space / scheduler)
>                                  :
>              SLOW PATH           :             FAST PATH
>                                  :
>     task_struct::uclamp::value   :     sched/core::enqueue/dequeue
>                                  :         cpufreq_schedutil
>                                  :
>   +----------------+    +--------------------+     +-------------------+
>   |      TASK      |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
>   +----------------+    +--------------------+     +-------------------+
>   |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
>   | util_{min,max} |    |      se_count      |     |    tasks count    |
>   +----------------+    +--------------------+     +-------------------+
>                                  :
>            +------------------>  :  +------------------->
>     group_id = map(clamp_value)  :  ref_count(group_id)
>                                  :
>                                  :
> 
> Let's introduce the support to map tasks to "clamp groups".
> Specifically we introduce the required functions to translate a
> "clamp value" into a clamp's "group index" (group_id).
> 
> Only a limited number of (different) clamp values are supported since:
> 1. there are usually only few classes of workloads for which it makes
>    sense to boost/limit to different frequencies,
>    e.g. background vs foreground, interactive vs low-priority
> 2. it allows a simpler and more memory/time efficient tracking of
>    the per-CPU clamp values in the fast path.
> 
> The number of possible different clamp values is currently defined at
> compile time. Thus, setting a new clamp value for a task can result into
> a -ENOSPC error in case this will exceed the number of maximum different
> clamp values supported.
> 

I see that we drop reference on the previous clamp group when a task changes
its clamp limits. What about exiting tasks which claimed clamp groups? should
not we drop the reference?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

