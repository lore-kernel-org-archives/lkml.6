Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2782C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9BB21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbeLURPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:15:34 -0500
Received: from foss.arm.com ([217.140.101.70]:55088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbeLURPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:15:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BE31596;
        Fri, 21 Dec 2018 09:15:33 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75D3E3F5C0;
        Fri, 21 Dec 2018 09:15:32 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
 <c482361e-cfb4-d172-32c3-4d82ceb1e7d2@arm.com>
 <CAKfTPtCQTMs=6yGbrfuUGyhwPHWvMODcyyDROVjbURHFxLTxCQ@mail.gmail.com>
 <d87cba1f-fa5c-3d82-ec7f-f2c72d40cb30@arm.com>
 <CAKfTPtBh5tFgSLfTtKafUMjtHMrFLKj1Ep9YwNn5hZS=p756aQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <55dcf87d-21fd-65d6-ff5c-bbcb0f6a6d29@arm.com>
Date:   Fri, 21 Dec 2018 17:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBh5tFgSLfTtKafUMjtHMrFLKj1Ep9YwNn5hZS=p756aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2018 14:49, Vincent Guittot wrote:
[...]
> After looking at shed.c at this sha1,  (sd->nr_balance_failed >
> sd->cache_nice_tries+2) was the only condition for doing active
> migration and as a result it was the only reason for doubling
> sd->balance_interval.
> My patch keeps exactly the same behavior for this condition
> 'sd->nr_balance_failed > sd->cache_nice_tries+2). And, I'm even more
> convinced to exclude (sd->nr_balance_failed > sd->cache_nice_tries+2)
> condition because it's the condition that has introduced the doubling
> of the interval.
> 
> As said previously, you can argue that this behavior is not optimal
> and discuss its validity, but the sha1 that you mentioned above,
> introduced the current policy for (sd->nr_balance_failed >
> sd->cache_nice_tries+2) condition.
> Reverting such behavior would need more studies, tests and cares

I agree with you on that, those are valid concerns.

What I'm arguing for is instead of doing this in two steps (reset interval
only for some active balance types, then experiment only increasing it for
"active balance as a last resort"), I'd prefer doing it in one step.

Mostly because I think the intermediate step adds an active balance
categorization that can easily become confusing. Furthermore, that 2005
commit explicitly states it wants to cater to pinned tasks, but we didn't
have those LBF_* flags back then, so if we are to do something about it
we should be improving upon the original intent.

In the end it's not for me to decide, I just happen to find doing it that
way more elegant (from a functionality & code readability PoV).

> which
> are out of the scope of this patchset and more related to a whole
> refactoring of load_balance and calculte_imbalance; FYI, I have
> submitted a topic on the subject for the next OSPM

