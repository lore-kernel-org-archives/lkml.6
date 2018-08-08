Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1204219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1204219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHHPgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:36:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726971AbeHHPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:36:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEEB1AF31;
        Wed,  8 Aug 2018 13:16:58 +0000 (UTC)
Date:   Wed, 8 Aug 2018 15:16:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
Message-ID: <20180808131658.GP27972@dhcp22.suse.cz>
References: <20180807072553.14941-1-mhocko@kernel.org>
 <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
 <20180807201935.GB4251@cmpxchg.org>
 <1308e0bd-e194-7b35-484c-fc18f493f8da@i-love.sakura.ne.jp>
 <9cea37c8-ab90-2fdf-395c-efe52ff07072@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cea37c8-ab90-2fdf-395c-efe52ff07072@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 21:57:13, Tetsuo Handa wrote:
[...]
> Also, before the OOM reaper was introduced, we waited until TIF_MEMDIE is
> cleared from the OOM victim thread. Compared to pre OOM reaper era, giving up
> so early is certainly a regression.

We did clear TIF_MEMDIE flag after mmput() in do_exit so this was not a silver
bullet either. Any reference on the mm_struct would lead to a similar
problem. So could you please stop making strong stamements and start
being reasonable?

Yeah, this is racy. Nobody is claiming otherwise. All we are trying to
say is that this area is full of dragons and before we start making it
more complicating by covering weird cornercases we really need to see
that those corner cases happen in real workloads. Otherwise we end up
with a unmaintainable and fragile mess.

And more importantly this is _not_ what this patch is trying to address
so please do not go tangent again.

I really do not know how to send this simply message to you. I have
tried so many times before.

-- 
Michal Hocko
SUSE Labs
