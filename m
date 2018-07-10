Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD40C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E64D2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E64D2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGJJnq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeGJJnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC96DAD2C;
        Tue, 10 Jul 2018 09:43:43 +0000 (UTC)
Date:   Tue, 10 Jul 2018 11:43:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, oom: remove sleep from under oom_lock
Message-ID: <20180710094341.GD14284@dhcp22.suse.cz>
References: <20180709074706.30635-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-07-18 15:49:53, David Rientjes wrote:
> On Mon, 9 Jul 2018, Michal Hocko wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Tetsuo has pointed out that since 27ae357fa82b ("mm, oom: fix concurrent
> > munlock and oom reaper unmap, v3") we have a strong synchronization
> > between the oom_killer and victim's exiting because both have to take
> > the oom_lock. Therefore the original heuristic to sleep for a short time
> > in out_of_memory doesn't serve the original purpose.
> > 
> > Moreover Tetsuo has noticed that the short sleep can be more harmful
> > than actually useful. Hammering the system with many processes can lead
> > to a starvation when the task holding the oom_lock can block for a
> > long time (minutes) and block any further progress because the
> > oom_reaper depends on the oom_lock as well.
> > 
> > Drop the short sleep from out_of_memory when we hold the lock. Keep the
> > sleep when the trylock fails to throttle the concurrent OOM paths a bit.
> > This should be solved in a more reasonable way (e.g. sleep proportional
> > to the time spent in the active reclaiming etc.) but this is much more
> > complex thing to achieve. This is a quick fixup to remove a stale code.
> > 
> > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> This reminds me:
> 
> mm/oom_kill.c
> 
>  54) int sysctl_oom_dump_tasks = 1;
>  55) 
>  56) DEFINE_MUTEX(oom_lock);
>  57) 
>  58) #ifdef CONFIG_NUMA
> 
> Would you mind documenting oom_lock to specify what it's protecting?

What do you think about the following?

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index ed9d473c571e..32e6f7becb40 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -53,6 +53,14 @@ int sysctl_panic_on_oom;
 int sysctl_oom_kill_allocating_task;
 int sysctl_oom_dump_tasks = 1;
 
+/*
+ * Serializes oom killer invocations (out_of_memory()) from all contexts to
+ * prevent from over eager oom killing (e.g. when the oom killer is invoked
+ * from different domains).
+ *
+ * oom_killer_disable() relies on this lock to stabilize oom_killer_disabled
+ * and mark_oom_victim
+ */
 DEFINE_MUTEX(oom_lock);
 
 #ifdef CONFIG_NUMA
-- 
Michal Hocko
SUSE Labs
