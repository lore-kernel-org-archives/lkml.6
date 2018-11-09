Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA119C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E7520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E7520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeKITf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:35:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeKITf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:35:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE4D6ADDD;
        Fri,  9 Nov 2018 09:56:06 +0000 (UTC)
Date:   Fri, 9 Nov 2018 10:56:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Kyungtae Kim <kt0755@gmail.com>, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, vbabka@suse.cz, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181109095604.GC5321@dhcp22.suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-11-18 18:41:53, Tetsuo Handa wrote:
> On 2018/11/09 17:43, Michal Hocko wrote:
> > @@ -4364,6 +4353,17 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> >  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> >  	struct alloc_context ac = { };
> >  
> > +	/*
> > +	 * In the slowpath, we sanity check order to avoid ever trying to
> 
> Please keep the comment up to dated.

Does this following look better?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9fc10a1029cf..bf9aecba4222 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4354,10 +4354,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	struct alloc_context ac = { };
 
 	/*
-	 * In the slowpath, we sanity check order to avoid ever trying to
-	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
-	 * be using allocators in order of preference for an area that is
-	 * too large.
+	 * There are several places where we assume that the order value is sane
+	 * so bail out early if the request is out of bound.
 	 */
 	if (order >= MAX_ORDER) {
 		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));

> I don't like that comments in OOM code is outdated.
> 
> > +	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> > +	 * be using allocators in order of preference for an area that is
> > +	 * too large.
> > +	 */
> > +	if (order >= MAX_ORDER) {
> 
> Also, why not to add BUG_ON(gfp_mask & __GFP_NOFAIL); here?

Because we do not want to blow up the kernel just because of a stupid
usage of the allocator. Can you think of an example where it would
actually make any sense?

I would argue that such a theoretical abuse would blow up on an
unchecked NULL ptr access. Isn't that enough?
-- 
Michal Hocko
SUSE Labs
