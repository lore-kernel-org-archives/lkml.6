Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAFEC10F07
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1A222E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550223473;
	bh=QGbHPHam0nZAAKVTJGc4jMKkl6ZdqfsGVJ5GDavarkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkyfVRVNIe2ZzjMAqjMV0++1TqlCYrc5B7ozCQdYx2wXxmQcXI7YQ1XwYjqz+6QpH
	 /3RQw6PQ/HY/JxwEFy4tkoRM4snZLvcgKdR6nPGlW64SPw31obZTiedVKpc/8KMsis
	 AwD0FrHfmPltTttldC24ATmE+griYT6L2sT2klu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393099AbfBOJhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:37:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:56838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393049AbfBOJhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:37:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01C71AFBD;
        Fri, 15 Feb 2019 09:37:49 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:37:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 oom_score_adj
Message-ID: <20190215093748.GV4525@dhcp22.suse.cz>
References: <201902130124.x1D1OGg3070046@www262.sakura.ne.jp>
 <20190213114733.GB4525@dhcp22.suse.cz>
 <201902150057.x1F0vxHb076966@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902150057.x1F0vxHb076966@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 09:57:59, Tetsuo Handa wrote:
> Sigh, you are again misunderstanding...
> 
> I'm not opposing to forbid CLONE_VM without CLONE_SIGHAND threading model.

We cannot do that unfortunatelly. This is a long term allowed threading
model and somebody might depend on it.

> I'm asserting that we had better revert the iteration for now, even if we will
> strive towards forbidding CLONE_VM without CLONE_SIGHAND threading model.
> 
> You say "And that is a correctness issue." but your patch is broken because
> your patch does not close the race.

Removing the printk as done in this patch has hardly anything to do with
race conditions and it is not advertised to close any either. So please
stop being off topic again.

> Since nobody seems to be using CLONE_VM
> without CLONE_SIGHAND threading, we can both avoid hungtask problem and close
> the race by eliminating this broken iteration. We don't need to worry about
> "This could easily lead to breaking the OOM_SCORE_ADJ_MIN protection." case
> because setting OOM_SCORE_ADJ_MIN needs administrator's privilege.

This is simply wrong. We have to care about the OOM_SCORE_ADJ_MIN
especially because it is the _admin's_ decision to hide a task from the
OOM killer.

> And it is
> YOUR PATCH that still allows leading to breaking the OOM_SCORE_ADJ_MIN
> protection. My patch is more simpler and accurate than your patch.

Please stop this already. Your patch to revert the oom_score_adj
consistency is simply broken. Full stop. I have already outlined how to
do that properly. If you do care really, go and try to play with that
idea. I can be convinced there are holes in that approach and can
discuss further solutions but trying to propose a broken approach again
and again is just wasting time.
-- 
Michal Hocko
SUSE Labs
