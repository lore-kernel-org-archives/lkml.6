Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0633C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72172083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72172083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJYWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:20:37 -0400
Received: from foss.arm.com ([217.140.101.70]:57116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeJYWUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:20:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FACCA78;
        Thu, 25 Oct 2018 06:47:47 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350BF3F6A8;
        Thu, 25 Oct 2018 06:47:45 -0700 (PDT)
Subject: Re: [PATCH 05/10] sched/fair: Hoist idle_stamp up from idle_balance
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-6-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2a368b7c-3ecf-9b0c-a930-d2e739ea9b17@arm.com>
Date:   Thu, 25 Oct 2018 14:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540220381-424433-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 22/10/2018 15:59, Steve Sistare wrote:
[...]
> @@ -6740,8 +6744,19 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	return p;
>  
>  idle:
> +	/*
> +	 * We must set idle_stamp _before_ calling idle_balance(), such that we
> +	 * measure the duration of idle_balance() as idle time.
> +	 */
> +	IF_SMP(rq->idle_stamp = rq_clock(rq);)
> +
>  	new_tasks = idle_balance(rq, rf);
>  
> +	if (new_tasks)
> +		IF_SMP(rq->idle_stamp = 0;)
> +
> +	schedstat_end_time(rq->find_time, time);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
That's a stray hunk from 10/10

[...]
