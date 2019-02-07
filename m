Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA14321872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfBGLba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:31:30 -0500
Received: from foss.arm.com ([217.140.101.70]:35536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfBGLba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:31:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F0F1596;
        Thu,  7 Feb 2019 03:31:29 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AEC3F675;
        Thu,  7 Feb 2019 03:31:28 -0800 (PST)
Subject: Re: [PATCH 5/5] sched/fair: Skip LLC nohz logic for asymmetric
 systems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-6-valentin.schneider@arm.com>
 <20190206161452.GL17550@hirez.programming.kicks-ass.net>
 <5010b09f-6954-fda6-a10f-a8aa05806866@arm.com>
 <20190207095639.GA32494@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9b008247-376d-0fbb-900d-033c19a9ba02@arm.com>
Date:   Thu, 7 Feb 2019 11:31:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207095639.GA32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2019 09:56, Peter Zijlstra wrote:
[...]
>> I'm afraid I don't follow - we don't lose a balance opportunity with the
>> below change (compared to the original patch), do we?
> 
> What if each big/little cluster would have multiple cache domains? Would
> we not want to spread the cache usage inside the big/little resp. ?
> 

Ah I see - somewhat, yes. And we kindof already hit that issue - on
regular big.LITTLE each "cluster" (big & LITTLE) will have their own L2,
but there's no L3 to share. That means

- sd_llc == MC
- sd_asym_cpucapacity == DIE

(which I believe is what you meant by sd_llc_shared < sd_asym_capacity)

However the LLC nohz kick condition is way too broad and will keep kicking
if we just have 2 busy LITTLEs with 1 task each, which could be a correct
placement if they were just running some small background task.

I'd argue that since we don't have SMT, <=1 task per CPU means we can't do
anything better to spread cache use within the "cluster", and we have to
rely on the other conditions (mostly rq->nr_running and misfit) to move
things around when we really need to.

The extra kicks are there on non asymmetric topologies as well, so we could
imagine an additional gate for the LLC kick that would look like:

  /* If SMT, <=1 task per CPU can be suboptimal
   * If we have a parent (and thus a sibling), we may need to move some tasks to
   * our sibling.
   * If we have asymmetry, asymmetric placement can be fine so just rely on the
   * other kick conditions
   */
  if (static_key_likely(&sched_smt_present) ||
      (!static_key_unlikely(&sched_asym_cpucapacity) && sd->parent)) {
	  // LLC kick stuff here
  }

but I'd argue the extra nohz kicks have more impact on asymmetric systems.
