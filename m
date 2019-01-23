Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAEAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464A421726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfAWI0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:26:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfAWI0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:26:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A5715AB;
        Wed, 23 Jan 2019 00:26:01 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 644CC3F6A8;
        Wed, 23 Jan 2019 00:25:58 -0800 (PST)
Subject: Re: [PATCH v8 2/3] sched/fair: update scale invariance of PELT
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org, pkondeti@codeaurora.org,
        quentin.perret@arm.com, srinivas.pandruvada@linux.intel.com
References: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
 <1547631791-16018-3-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a3671d96-5003-6a50-ad2d-64833ca216a1@arm.com>
Date:   Wed, 23 Jan 2019 09:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547631791-16018-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 10:43 AM, Vincent Guittot wrote:

[...]

> +static inline u64 rq_clock_pelt(struct rq *rq)
> +{

Doesn't this function need

   lockdep_assert_held(&rq->lock);
   assert_clock_updated(rq);

like rq_clock() and rq_clock_task()? Later to support commit 
cb42c9a3ebbb "sched/core: Add debugging code to catch missing 
update_rq_clock() calls".

> +	return rq->clock_pelt - rq->lost_idle_time;
> +}

[...]
