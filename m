Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8647C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80646214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QBQYVdXp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IoJ7TFfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80646214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHFKpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:45:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:45:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F95A604BE; Mon,  6 Aug 2018 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533544663;
        bh=0qKgZSUE2DjPo7VCqS67fpJL0G/P0pih+tcFb0Xkh9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBQYVdXpLSjE80pxI6pWhYRxqUVag/SGnXV98o6yRzXgAlqt2aCZkR7/MxyK4zZH7
         BqCC6NnMYVna+nvBaytORc/FN/Pjqq4E05+121ClED29TLgrc8vvSwKpKMzeK1Ih+t
         sSFeqY90BXj058ZxHJCijN5NaXU1SwFHLHfihiZc=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7BF5604BE;
        Mon,  6 Aug 2018 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533544662;
        bh=0qKgZSUE2DjPo7VCqS67fpJL0G/P0pih+tcFb0Xkh9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoJ7TFfGOp/bzYffsAPSk4qZe5SD+JzCQfLuM7LXTlBDN6rMEEZEAVWUDcbxZjHbf
         5hcbT+6gLoMXBkwZRrBzZhkmqrYTCR5k13FihIZ5W5iGHztamwR47wsCmGgsUHHmr8
         q3vsbK+KuWqLlbMrdAQVuIwL1zYqjRHbmfY8x238=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7BF5604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 6 Aug 2018 14:07:36 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        isaacm@codeaurora.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
Message-ID: <20180806083736.GA2661@codeaurora.org>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
 <20180724062350.nlem2suuy5wlxpts@linutronix.de>
 <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
 <20180730112140.GH2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807301440340.2518@nanos.tec.linutronix.de>
 <109d0e70606ccd34861a80525d6d11aa@codeaurora.org>
 <20180730210728.GQ2494@hirez.programming.kicks-ass.net>
 <52a34ed365cd560457e9abf5877c5b37@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a34ed365cd560457e9abf5877c5b37@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On Wed, Aug 01, 2018 at 01:07:03AM -0700, Sodagudi Prasad wrote:
> On 2018-07-30 14:07, Peter Zijlstra wrote:
> >On Mon, Jul 30, 2018 at 10:12:43AM -0700, Sodagudi Prasad wrote:
> >>How about including below change as well?  Currently, there is
> >>no way to
> >>identify thread migrations completed or not.  When we observe
> >>this issue,
> >>the symptom was work queue lock up. It is better to have some
> >>timeout here
> >>and induce the bug_on.
> >
> >You'd trigger the soft-lockup or hung-task detector I think. And
> >if not,
> >we ought to look at making it trigger at least one of those.
> >
> >>There is no way to identify the migration threads stuck or not.
> >
> >Should be pretty obvious from the splat generated by the above, no?
> Hi Peter and Thomas,
> 
> Thanks for your support.
> I have another question on this flow and retry mechanism used in
> this cpu_stop_queue_two_works() function using the global variable
> stop_cpus_in_progress.
> 
> This variable is getting used in various paths, such as task
> migration, set task affinity, and CPU hotplug.
> 
> For example cpu hotplug path, stop_cpus_in_progress variable getting
> set with true with out checking.
> takedown_cpu()
> --stop_machine_cpuslocked()
> ---stop_cpus()
> ---__stop_cpus()
> ----queue_stop_cpus_work()
> setting stop_cpus_in_progress to true directly.
> 
> But in the task migration path only, the stop_cpus_in_progress
> variable is used for retry.
> 
> I am thinking that stop_cpus_in_progress variable lead race
> conditions, where CPU hotplug and task migration happening
> simultaneously. Please correct me If my understanding wrong.
> 

The stop_cpus_in_progress variable is to guard against out of order queuing.
The stopper locks does not protect this when cpu_stop_queue_two_works() and
stop_cpus() are executing in parallel.

stop_one_cpu_{nowait} functions are called to handle affinity change and
load balance. Since we are queuing the work only on 1 CPU,
stop_cpus_in_progress variable protection is not needed.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

