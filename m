Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5CA20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547213645;
	bh=FcK3UAKxT3I+OY6IifjcBzoOExj9NV5+KS+uQs9U5iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qll1qupd76nEnwe8mWNhwncWe06kanMYKxnph8/Gwi0C30mGMlftcAm5nRvQQd6R
	 vD3dcVajKyewrV3+PlzZzZnkqEoUSymZnFY3/NsWWQ9ZvM93ALVQZ+T+MGOuF2C0ry
	 uBZEVq0g05PZZdyRnmLuCYOJSqnEPa2dWFtVC2Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfAKNeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:34:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:33316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728941AbfAKNeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:34:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72C56AC76;
        Fri, 11 Jan 2019 13:34:02 +0000 (UTC)
Date:   Fri, 11 Jan 2019 14:34:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190111133401.GA6997@dhcp22.suse.cz>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-01-19 21:40:52, Tetsuo Handa wrote:
[...]
> Did you notice that there is no
> 
>   "Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n"
> 
> line between
> 
>   [   71.304703][ T9694] Memory cgroup out of memory: Kill process 9692 (a.out) score 904 or sacrifice child
> 
> and
> 
>   [   71.309149][   T54] oom_reaper: reaped process 9750 (a.out), now anon-rss:0kB, file-rss:0kB, shmem-rss:185532kB
> 
> ? Then, you will find that [ T9694] failed to reach for_each_process(p) loop inside
> __oom_kill_process() in the first round of out_of_memory() call because
> find_lock_task_mm() == NULL at __oom_kill_process() because Ctrl-C made that victim
> complete exit_mm() before find_lock_task_mm() is called.

OK, so we haven't killed anything because the victim has exited by the
time we wanted to do so. We still have other tasks sharing that mm
pending and not killed because nothing has killed them yet, right?

How come the oom reaper could act on this oom event at all then?

What am I missing?
-- 
Michal Hocko
SUSE Labs
