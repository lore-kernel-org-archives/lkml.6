Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60702C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2584621707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2584621707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbeHGNRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:17:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeHGNRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:17:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B438EAFC9;
        Tue,  7 Aug 2018 11:04:06 +0000 (UTC)
Date:   Tue, 7 Aug 2018 13:04:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
Message-ID: <20180807110405.GW10003@dhcp22.suse.cz>
References: <20180807072553.14941-1-mhocko@kernel.org>
 <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-08-18 19:15:11, Tetsuo Handa wrote:
[...]
> Of course, if the hard limit is 0, all processes will be killed after all. But
> Michal is ignoring the fact that if the hard limit were not 0, there is a chance
> of saving next process from needlessly killed if we waited until "mm of PID=23766
> completed __mmput()" or "mm of PID=23766 failed to complete __mmput() within
> reasonable period". 

This is a completely different issue IMHO. I haven't seen reports about
overly eager memcg oom killing so far.
 
> We can make efforts not to return false at
> 
> 	/*
> 	 * This task has already been drained by the oom reaper so there are
> 	 * only small chances it will free some more
> 	 */
> 	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> 		return false;
> 
> (I admit that ignoring MMF_OOM_SKIP for once might not be sufficient for memcg
> case), and we can use feedback based backoff like
> "[PATCH 4/4] mm, oom: Fix unnecessary killing of additional processes." *UNTIL*
> we come to the point where the OOM reaper can always reclaim all memory.

The code is quite tricky and I am really reluctant to make it even more
so without seeing this is really hurting real users with real workloads.
-- 
Michal Hocko
SUSE Labs
