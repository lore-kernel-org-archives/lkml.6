Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E703FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B0F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B0F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeFUPFn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:05:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33031 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932808AbeFUPFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:05:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61830AEF3;
        Thu, 21 Jun 2018 15:05:41 +0000 (UTC)
Date:   Thu, 21 Jun 2018 17:05:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180621150540.GO10465@dhcp22.suse.cz>
References: <20180620103736.13880-1-mhocko@kernel.org>
 <20180621080927.GE10465@dhcp22.suse.cz>
 <20180621143751.GA11230@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621143751.GA11230@cmpxchg.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 10:37:51, Johannes Weiner wrote:
> On Thu, Jun 21, 2018 at 10:09:27AM +0200, Michal Hocko wrote:
> > @@ -496,14 +496,14 @@ void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
> >  
> >  static inline void mem_cgroup_oom_enable(void)
> >  {
> > -	WARN_ON(current->memcg_may_oom);
> > -	current->memcg_may_oom = 1;
> > +	WARN_ON(current->in_user_fault);
> > +	current->in_user_fault = 1;
> >  }
> >  
> >  static inline void mem_cgroup_oom_disable(void)
> >  {
> > -	WARN_ON(!current->memcg_may_oom);
> > -	current->memcg_may_oom = 0;
> > +	WARN_ON(!current->in_user_fault);
> > +	current->in_user_fault = 0;
> >  }
> 
> Would it make more sense to rename these to
> mem_cgroup_enter_user_fault(), mem_cgroup_exit_user_fault()?

OK, makes sense. It is less explicit about the oom behavior... 

> Other than that, this looks great to me.

Thanks for the review! I will wait few days for other feedback and
retest and repost then.
-- 
Michal Hocko
SUSE Labs
