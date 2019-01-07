Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE76C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADA620854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfAGKnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:43:20 -0500
Received: from foss.arm.com ([217.140.101.70]:56484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGKnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:43:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F041596;
        Mon,  7 Jan 2019 02:43:19 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E31FD3F5D4;
        Mon,  7 Jan 2019 02:43:17 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:43:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
Message-ID: <20190107104314.uugftsqcjsi5j6g2@mbp>
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw>
 <20190103093201.GB31793@dhcp22.suse.cz>
 <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
 <20190103170735.GV31793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103170735.GV31793@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:07:35PM +0100, Michal Hocko wrote:
> > > On Wed 02-01-19 13:06:19, Qian Cai wrote:
> > > [...]
> > >> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > >> index f9d9dc250428..9e1aa3b7df75 100644
> > >> --- a/mm/kmemleak.c
> > >> +++ b/mm/kmemleak.c
> > >> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> > >>  	struct rb_node **link, *rb_parent;
> > >>  
> > >>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> > >> +#ifdef CONFIG_PREEMPT_COUNT
> > >> +	if (!object) {
> > >> +		/* last-ditch effort in a low-memory situation */
> > >> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
> > >> +			gfp = GFP_ATOMIC;
> > >> +		else
> > >> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> > >> +		object = kmem_cache_alloc(object_cache, gfp);
> > >> +	}
> > >> +#endif
[...]
> I will not object to this workaround but I strongly believe that
> kmemleak should rethink the metadata allocation strategy to be really
> robust.

This would be nice indeed and it was discussed last year. I just haven't
got around to trying anything yet:

https://marc.info/?l=linux-mm&m=152812489819532

-- 
Catalin
