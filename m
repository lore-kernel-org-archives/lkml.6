Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F5C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F8221473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548772992;
	bh=1YHaNgJNYbqTBaPd3fpVlrbvWM1kC7HMYAo6DJJai4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UntP966cLArDGeqHmyOwGaj9hSA8ZZwwRSdAQiY5wqDBDEQYQOBj9314aICVp2fIZ
	 5nN5gb/DTOtD1rPygctk2BHlWhYltNGvsN59PMTJ9ky16p0WgoRsxPQW42L+ioGawX
	 MHQkdbJspSw3FOcp0nYMZRSHKpKiLgCTD5Ue5TOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfA2OnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:43:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:47060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfA2OnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:43:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BBAFB049;
        Tue, 29 Jan 2019 14:43:08 +0000 (UTC)
Date:   Tue, 29 Jan 2019 15:43:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190129144306.GO18811@dhcp22.suse.cz>
References: <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128174905.GU50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 09:49:05, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Jan 28, 2019 at 06:05:26PM +0100, Michal Hocko wrote:
> > Yeah, that is quite clear. But it also assumes that the hierarchy is
> > pretty stable but cgroups might go away at any time. I am not saying
> > that the aggregated events are not useful I am just saying that it is
> > quite non-trivial to use and catch all potential corner cases. Maybe I
> 
> It really isn't complicated and doesn't require stable subtree.
> 
> > am overcomplicating it but one thing is quite clear to me. The existing
> > semantic is really useful to watch for the reclaim behavior at the
> > current level of the tree. You really do not have to care what is
> > happening in the subtree when it is clear that the workload itself
> > is underprovisioned etc. Considering that such a semantic already
> > existis, somebody might depend on it and we likely want also aggregated
> > semantic then I really do not see why to risk regressions rather than
> > add a new memory.hierarchy_events and have both.
> 
> The problem then is that most other things are hierarchical including
> some fields in .events files, so if we try to add local stats and
> events, there's no good way to add them.

All memcg events are represented non-hierarchical AFAICS
memcg_memory_event() simply accounts at the level when it happens. Or do
I miss something? Or are you talking about .events files for other
controllers?
-- 
Michal Hocko
SUSE Labs
