Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39342C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090B3218DA
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546935067;
	bh=EyXyjv2LV51gU9K00s1hSS9vFFUdLpAztwtWMtqCTrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m6iy8PqwUtsCY/Hk7DYTZ7/arHHUjB6uoX20fKcLWdblFE/xB0UbEL72+oUlrJGcf
	 /H9NWdVT39B936rCPnB5nCIhPruFgdsYLoHiw5feIFByJLFWIpzeOXB7cVULrh5Z3V
	 +8exGGzLJffmYW5Nbok0DSIvjkkzNfXhsXm8L47Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfAHILF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:11:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:41344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfAHILF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:11:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1028EAE3C;
        Tue,  8 Jan 2019 08:11:04 +0000 (UTC)
Date:   Tue, 8 Jan 2019 09:11:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, oom: marks all killed tasks as oom victims
Message-ID: <20190108081101.GN31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-2-mhocko@kernel.org>
 <1054b5c6-19c0-53a4-206e-dd55f5a3d732@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054b5c6-19c0-53a4-206e-dd55f5a3d732@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 05:58:41, Tetsuo Handa wrote:
> On 2019/01/07 23:38, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Historically we have called mark_oom_victim only to the main task
> > selected as the oom victim because oom victims have access to memory
> > reserves and granting the access to all killed tasks could deplete
> > memory reserves very quickly and cause even larger problems.
> > 
> > Since only a partial access to memory reserves is allowed there is no
> > longer this risk and so all tasks killed along with the oom victim
> > can be considered as well.
> > 
> > The primary motivation for that is that process groups which do not
> > shared signals would behave more like standard thread groups wrt oom
> > handling (aka tsk_is_oom_victim will work the same way for them).
> > 
> > - Use find_lock_task_mm to stabilize mm as suggested by Tetsuo
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/oom_kill.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index f0e8cd9edb1a..0246c7a4e44e 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -892,6 +892,7 @@ static void __oom_kill_process(struct task_struct *victim)
> >  	 */
> >  	rcu_read_lock();
> >  	for_each_process(p) {
> > +		struct task_struct *t;
> >  		if (!process_shares_mm(p, mm))
> >  			continue;
> >  		if (same_thread_group(p, victim))
> > @@ -911,6 +912,11 @@ static void __oom_kill_process(struct task_struct *victim)
> >  		if (unlikely(p->flags & PF_KTHREAD))
> >  			continue;
> >  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
> > +		t = find_lock_task_mm(p);
> > +		if (!t)
> > +			continue;
> > +		mark_oom_victim(t);
> > +		task_unlock(t);
> 
> Thank you for updating this patch. This patch is correct from the point of
> view of avoiding TIF_MEMDIE race. But if I recall correctly, the reason we
> did not do this is to avoid depleting memory reserves. And we still grant
> full access to memory reserves for CONFIG_MMU=n case. Shouldn't the changelog
> mention CONFIG_MMU=n case?

Like so many times before. Does nommu matter in this context at all? You
keep bringing it up without actually trying to understand that nommu is
so special that reserves for those architectures are of very limited
use. I do not really see much point mentioning nommu in every oom patch.

Or do you know of a nommu oom killer bug out there? I would be more than
curious. Seriously.
-- 
Michal Hocko
SUSE Labs
