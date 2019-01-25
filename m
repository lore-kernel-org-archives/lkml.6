Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40585C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086E9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548437069;
	bh=P1u4LwreJrrBgNUr1qX7iaU4fv75Dta1x9DXP10ItA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=siDLd51YXN7aWmUEMrm7D/wd6CYDUHdx++z6hw5MQwWYBq1pTFXRPCqeAhS6ixVL1
	 U6YAZSFtefuZ+9SqqkiafmgzuQb2dx74S5fWccwTQECbM/5gndIw/HS7kyGetCFZtw
	 TKG4311DjjUP04P6hN43H7LGrKbSLb9H5E1+t/30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAYRYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfAYRYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67261ACEF;
        Fri, 25 Jan 2019 17:24:18 +0000 (UTC)
Date:   Fri, 25 Jan 2019 18:24:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: + memcg-do-not-report-racy-no-eligible-oom-tasks.patch added to
 -mm tree
Message-ID: <20190125172416.GB20411@dhcp22.suse.cz>
References: <20190109190306.rATpT%akpm@linux-foundation.org>
 <20190125165624.GA17719@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125165624.GA17719@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 11:56:24, Johannes Weiner wrote:
> On Wed, Jan 09, 2019 at 11:03:06AM -0800, akpm@linux-foundation.org wrote:
> > 
> > The patch titled
> >      Subject: memcg: do not report racy no-eligible OOM tasks
> > has been added to the -mm tree.  Its filename is
> >      memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > 
> > This patch should soon appear at
> >     http://ozlabs.org/~akpm/mmots/broken-out/memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > and later at
> >     http://ozlabs.org/~akpm/mmotm/broken-out/memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > 
> > Before you just go and hit "reply", please:
> >    a) Consider who else should be cc'ed
> >    b) Prefer to cc a suitable mailing list as well
> >    c) Ideally: find the original patch on the mailing list and do a
> >       reply-to-all to that, adding suitable additional cc's
> > 
> > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > 
> > The -mm tree is included into linux-next and is updated
> > there every 3-4 working days
> > 
> > ------------------------------------------------------
> > From: Michal Hocko <mhocko@suse.com>
> > Subject: memcg: do not report racy no-eligible OOM tasks
> > 
> > Tetsuo has reported [1] that a single process group memcg might easily
> > swamp the log with no-eligible oom victim reports due to race between the
> > memcg charge and oom_reaper
> > 
> > Thread 1		Thread2				oom_reaper
> > try_charge		try_charge
> > 			  mem_cgroup_out_of_memory
> > 			    mutex_lock(oom_lock)
> >   mem_cgroup_out_of_memory
> >     mutex_lock(oom_lock)
> > 			      out_of_memory
> > 			        select_bad_process
> > 				oom_kill_process(current)
> > 				  wake_oom_reaper
> > 							  oom_reap_task
> > 							  MMF_OOM_SKIP->victim
> > 			    mutex_unlock(oom_lock)
> >     out_of_memory
> >       select_bad_process # no task
> > 
> > If Thread1 didn't race it would bail out from try_charge and force the
> > charge.  We can achieve the same by checking tsk_is_oom_victim inside the
> > oom_lock and therefore close the race.
> > 
> > [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> > Link: http://lkml.kernel.org/r/20190107143802.16847-3-mhocko@kernel.org
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> It looks like this problem is happening in production systems:
> 
> https://www.spinics.net/lists/cgroups/msg21268.html
> 
> where the threads don't exit because they are trapped writing out the
> oom messages to a slow console (running the reproducer from this email
> thread triggers the oom flooding).
> 
> So IMO we should put this into 5.0 and add:

Please note that Tetsuo has found out that this will not work with the
CLONE_VM without CLONE_SIGHAND cases and his http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
should handle this case as well. I've only had objections to the
changelog but other than that the patch looked sensible to me.
-- 
Michal Hocko
SUSE Labs
