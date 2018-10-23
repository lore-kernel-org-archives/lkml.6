Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAD7C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27A22064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27A22064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJWJWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:22:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36455 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJWJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:22:19 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9N1190s042453;
        Tue, 23 Oct 2018 10:01:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Tue, 23 Oct 2018 10:01:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9N118Et042449;
        Tue, 23 Oct 2018 10:01:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9N118i3042448;
        Tue, 23 Oct 2018 10:01:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810230101.w9N118i3042448@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date:   Tue, 23 Oct 2018 10:01:08 +0900
References: <f9a8079f-55b0-301e-9b3d-a5250bd7d277@i-love.sakura.ne.jp> <20181022120308.GB18839@dhcp22.suse.cz>
In-Reply-To: <20181022120308.GB18839@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> On Mon 22-10-18 20:45:17, Tetsuo Handa wrote:
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index e79cb59552d9..a9dfed29967b 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1380,10 +1380,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  		.gfp_mask = gfp_mask,
> > >  		.order = order,
> > >  	};
> > > -	bool ret;
> > > +	bool ret = true;
> > >  
> > >  	mutex_lock(&oom_lock);
> > > +
> > > +	/*
> > > +	 * multi-threaded tasks might race with oom_reaper and gain
> > > +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> > > +	 * to out_of_memory failure if the task is the last one in
> > > +	 * memcg which would be a false possitive failure reported
> > > +	 */
> > > +	if (tsk_is_oom_victim(current))
> > > +		goto unlock;
> > > +
> > 
> > This is not wrong but is strange. We can use mutex_lock_killable(&oom_lock)
> > so that any killed threads no longer wait for oom_lock.
> 
> tsk_is_oom_victim is stronger because it doesn't depend on
> fatal_signal_pending which might be cleared throughout the exit process.
> 

I still want to propose this. No need to be memcg OOM specific.

 mm/memcontrol.c |  3 ++-
 mm/oom_kill.c   | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e79cb59..2c1e1ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1382,7 +1382,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	};
 	bool ret;
 
-	mutex_lock(&oom_lock);
+	if (mutex_lock_killable(&oom_lock))
+		return true;
 	ret = out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..e453bad 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1055,6 +1055,16 @@ bool out_of_memory(struct oom_control *oc)
 	unsigned long freed = 0;
 	enum oom_constraint constraint = CONSTRAINT_NONE;
 
+	/*
+	 * It is possible that multi-threaded OOM victims get
+	 * task_will_free_mem(current) == false when the OOM reaper quickly
+	 * set MMF_OOM_SKIP. But since we know that tsk_is_oom_victim() == true
+	 * tasks won't loop forever (unleess it is a __GFP_NOFAIL allocation
+	 * request), we don't need to select next OOM victim.
+	 */
+	if (tsk_is_oom_victim(current) && !(oc->gfp_mask & __GFP_NOFAIL))
+		return true;
+
 	if (oom_killer_disabled)
 		return false;
 
-- 
1.8.3.1
