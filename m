Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E72C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8D2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeLSPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:54:34 -0500
Received: from foss.arm.com ([217.140.101.70]:37914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeLSPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:54:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA6F80D;
        Wed, 19 Dec 2018 07:54:33 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5373F675;
        Wed, 19 Dec 2018 07:54:32 -0800 (PST)
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
 <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com>
 <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
 <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com>
 <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
 <7a1aaf61-c352-69fc-b990-861bc2aef85b@arm.com>
 <CAKfTPtDk8z_aBapA3FM5Af1benOyqYYcTpMVWZ9KsjDP7wSJ4Q@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6afedeb0-62bc-27ec-56f0-107be22d2494@arm.com>
Date:   Wed, 19 Dec 2018 15:54:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDk8z_aBapA3FM5Af1benOyqYYcTpMVWZ9KsjDP7wSJ4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 13:29, Vincent Guittot wrote:
[...]
>> My point is that AFAICT the LBF_ALL_PINNED flag would cover all the cases
>> we care about, although the one you're mentioning is the only one I can
>> think of. In that case LBF_ALL_PINNED would never be cleared, so when we do
>> the active balance we'd know it's because all other tasks were pinned so
>> we should probably increase the interval (see last snippet I sent).
> 
> There are probably several other UC than the one mentioned below as
> tasks can be discarded for several reasons.
> So instead of changing for all UC by default, i would prefer only
> change for those for which we know it's safe

I get your point. Thing is, I've stared at the code for a while and
couldn't find any other usecase where checking LBF_ALL_PINNED wouldn't
suffice.

It would be nice convince ourselves it is indeed enough (or not, but then
we should be sure of it rather than base ourselves on assumptions), because
then we can have just a simple condition rather than something that
introduces active balance categories.
