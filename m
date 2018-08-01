Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61910C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A8320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A8320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbeHAHg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:36:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733124AbeHAHg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:36:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 647C4ADD8;
        Wed,  1 Aug 2018 05:53:04 +0000 (UTC)
Date:   Wed, 1 Aug 2018 07:53:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] mm: introduce mem_cgroup_put() helper
Message-ID: <20180801055302.GA16767@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-2-guro@fb.com>
 <20180731084509.GE4557@dhcp22.suse.cz>
 <CALvZod75t+uK=FDtpuBCMZCk7cb4vQMy7DpXQ53Aj7ZLiYsTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod75t+uK=FDtpuBCMZCk7cb4vQMy7DpXQ53Aj7ZLiYsTQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 07:58:00, Shakeel Butt wrote:
> On Tue, Jul 31, 2018 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 30-07-18 11:00:58, Roman Gushchin wrote:
> > > Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> > > memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
> >
> > Is there any reason for this to be a separate patch? I usually do not
> > like to add helpers without their users because this makes review
> > harder. This one is quite trivial to fit into Patch3 easilly.
> >
> 
> The helper function introduced in this change is also used in the
> remote charging patches, so, I asked Roman to separate this change out
> and thus can be merged independently.

Ok, that was not clear from the description. Then this is ok

Acked-by: Michal Hocko <mhocko@suse.com>
 
> Shakeel
> 
> > > Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  include/linux/memcontrol.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 6c6fb116e925..e53e00cdbe3f 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -375,6 +375,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
> > >       return css ? container_of(css, struct mem_cgroup, css) : NULL;
> > >  }
> > >
> > > +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > > +{
> > > +     css_put(&memcg->css);
> > > +}
> > > +
> > >  #define mem_cgroup_from_counter(counter, member)     \
> > >       container_of(counter, struct mem_cgroup, member)
> > >
> > > @@ -837,6 +842,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
> > >       return true;
> > >  }
> > >
> > > +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > > +{
> > > +}
> > > +
> > >  static inline struct mem_cgroup *
> > >  mem_cgroup_iter(struct mem_cgroup *root,
> > >               struct mem_cgroup *prev,
> > > --
> > > 2.14.4
> > >
> >
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
