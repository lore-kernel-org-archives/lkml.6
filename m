Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A1E20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546535260;
	bh=5PBSf12pbKwSUexgWg1GAsKAKqCovSF/h/0uOscYRvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bcgtdrPYudC0z7qEGVc0P+h527g0VzPntzJuP052IOFzQpfjE6uo6jRxMIxSeugX8
	 Xpn+o1OHFhYy3N4mPQl0ClARaOCv87aXT6VDwa1gVaKgJQqV1BRKIKR/wi3GtGZQnb
	 2cUPRI783cK/mzONva3Wqh62Oj3Jyi2uiDlr3xZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfACRHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:07:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730229AbfACRHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:07:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E997AEB4;
        Thu,  3 Jan 2019 17:07:37 +0000 (UTC)
Date:   Thu, 3 Jan 2019 18:07:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
Message-ID: <20190103170735.GV31793@dhcp22.suse.cz>
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw>
 <20190103093201.GB31793@dhcp22.suse.cz>
 <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9197d86b-a684-c7f4-245b-63c890f1104f@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 11:51:57, Qian Cai wrote:
> On 1/3/19 4:32 AM, Michal Hocko wrote:
> > On Wed 02-01-19 13:06:19, Qian Cai wrote:
> > [...]
> >> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >> index f9d9dc250428..9e1aa3b7df75 100644
> >> --- a/mm/kmemleak.c
> >> +++ b/mm/kmemleak.c
> >> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> >>  	struct rb_node **link, *rb_parent;
> >>  
> >>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> >> +#ifdef CONFIG_PREEMPT_COUNT
> >> +	if (!object) {
> >> +		/* last-ditch effort in a low-memory situation */
> >> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
> >> +			gfp = GFP_ATOMIC;
> >> +		else
> >> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> >> +		object = kmem_cache_alloc(object_cache, gfp);
> >> +	}
> >> +#endif
> > 
> > I do not get it. How can this possibly help when gfp_kmemleak_mask()
> > adds __GFP_NOFAIL modifier to the given gfp mask? Or is this not the
> > case anymore in some tree?
> 
> Well, __GFP_NOFAIL can still fail easily without __GFP_DIRECT_RECLAIM in a
> low-memory situation.

OK, I guess I understand now. So the issue is that a (general) atomic
allocation will provide its gfp mask down to kmemleak and you are
trying/hoping that if the allocation is no from an atomic context then
you can fortify it by using a sleepable allocation for the kmemleak
metadata or giving it access to memory reserves for atomic allocations.

I think this is still fragile because most atomic allocations are for a
good reason. As I've said earlier the current implementation which
abuses __GFP_NOFAIL is fra from great and we have discussed some
alternatives. Not sure whan came out of it.

I will not object to this workaround but I strongly believe that
kmemleak should rethink the metadata allocation strategy to be really
robust.
-- 
Michal Hocko
SUSE Labs
