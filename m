Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B742086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867063;
	bh=foRi73XmZpyT2S6Lfh2ScdyDo7AuATJqrfRuvggPlUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCFdgoNIYAoES8FjM+EHkv2ivsVc8JwulgatrVAs9l4vlReMtja1CXsvHrNQphanr
	 RwLAK/vIhY9thhhZ7KOJoLmr4YjkhYCk5bLe5S1eJf0TJVeIVQNvZAg7WjHKRzirMK
	 +vlqje6qHWfWc3asNpp88xTVI8fXhEfNqamdZqeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfA3QvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:51:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728469AbfA3QvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:51:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42860AFCE;
        Wed, 30 Jan 2019 16:51:00 +0000 (UTC)
Date:   Wed, 30 Jan 2019 17:50:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130165058.GA18811@dhcp22.suse.cz>
References: <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129145240.GX50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 06:52:40, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 29, 2019 at 03:43:06PM +0100, Michal Hocko wrote:
> > All memcg events are represented non-hierarchical AFAICS
> > memcg_memory_event() simply accounts at the level when it happens. Or do
> > I miss something? Or are you talking about .events files for other
> > controllers?
> 
> Yeah, cgroup.events and .stat files as some of the local stats would
> be useful too, so if we don't flip memory.events we'll end up with sth
> like cgroup.events.local, memory.events.tree and memory.stats.local,
> which is gonna be hilarious.

Why cannot we simply have memory.events_tree and be done with it? Sure
the file names are not goin to be consistent which is a minus but that
ship has already sailed some time ago.

> If you aren't willing to change your mind, the only option seems to be
> introducing a mount option to gate the flip and additions of local
> files.  Most likely, userspace will enable the option by default
> everywhere, so the end result will be exactly the same but I guess
> it'll better address your concern.

How does the consumer of the API learns about the mount type?
-- 
Michal Hocko
SUSE Labs
