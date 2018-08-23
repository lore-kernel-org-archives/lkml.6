Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D28C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B421208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B421208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeHWWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeHWWkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:40:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED497B03A;
        Thu, 23 Aug 2018 19:09:35 +0000 (UTC)
Date:   Thu, 23 Aug 2018 21:09:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/gntdev: fix up blockable calls to mn_invl_range_start
Message-ID: <20180823190933.GP29735@dhcp22.suse.cz>
References: <20180823120707.10998-1-mhocko@kernel.org>
 <07c7ead4-334d-9b25-f588-25e9b46bbea0@i-love.sakura.ne.jp>
 <20180823135151.GM29735@dhcp22.suse.cz>
 <9d2d11eb-7fe1-b836-056c-7886d6fc56e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2d11eb-7fe1-b836-056c-7886d6fc56e5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 10:06:53, Boris Ostrovsky wrote:
> On 08/23/2018 09:51 AM, Michal Hocko wrote:
> > On Thu 23-08-18 22:44:07, Tetsuo Handa wrote:
> >> On 2018/08/23 21:07, Michal Hocko wrote:
> >>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> >>> index 57390c7666e5..e7d8bb1bee2a 100644
> >>> --- a/drivers/xen/gntdev.c
> >>> +++ b/drivers/xen/gntdev.c
> >>> @@ -519,21 +519,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
> >>>  	struct gntdev_grant_map *map;
> >>>  	int ret = 0;
> >>>  
> >>> -	/* TODO do we really need a mutex here? */
> >>>  	if (blockable)
> >>>  		mutex_lock(&priv->lock);
> >>>  	else if (!mutex_trylock(&priv->lock))
> >>>  		return -EAGAIN;
> >>>  
> >>>  	list_for_each_entry(map, &priv->maps, next) {
> >>> -		if (in_range(map, start, end)) {
> >>> +		if (!blockable && in_range(map, start, end)) {
> >> This still looks strange. Prior to 93065ac753e4, in_range() test was
> >> inside unmap_if_in_range(). But this patch removes in_range() test
> >> if blockable == true. That is, unmap_if_in_range() will unconditionally
> >> unmap if blockable == true, which seems to be an unexpected change.
> > You are right. I completely forgot I've removed in_range there. Does
> > this look any better?
> >
> > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > index e7d8bb1bee2a..30f81004ea63 100644
> > --- a/drivers/xen/gntdev.c
> > +++ b/drivers/xen/gntdev.c
> > @@ -525,14 +525,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
> >  		return -EAGAIN;
> >  
> >  	list_for_each_entry(map, &priv->maps, next) {
> > -		if (!blockable && in_range(map, start, end)) {
> > +		if (in_range(map, start, end)) {
> > +			if (blockable)
> > +				continue;
> > +
> >  			ret = -EAGAIN;
> >  			goto out_unlock;
> >  		}
> >  		unmap_if_in_range(map, start, end);
> 
> 
> (I obviously missed that too with my R-b).
> 
> This will never get anything done either. How about

Yeah. I was half way out and posted a complete garbage. Sorry about
that!

Michal repeat after me
Never post patches when in hurry! Never post patches when in hurry!
Never post patches when in hurry! Never post patches when in hurry!
Never post patches when in hurry! Never post patches when in hurry!
Never post patches when in hurry! Never post patches when in hurry!
Never post patches when in hurry! Never post patches when in hurry! 

What I really meant was this

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index e7d8bb1bee2a..6fcc5a44f29d 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -525,17 +525,25 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
 		return -EAGAIN;
 
 	list_for_each_entry(map, &priv->maps, next) {
-		if (!blockable && in_range(map, start, end)) {
+		if (!in_range(map, start, end))
+			continue;
+
+		if (!blockable) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
+
 		unmap_if_in_range(map, start, end);
 	}
 	list_for_each_entry(map, &priv->freeable_maps, next) {
-		if (!blockable && in_range(map, start, end)) {
+		if (!in_range(map, start, end))
+			continue;
+
+		if (!blockable) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
+
 		unmap_if_in_range(map, start, end);
 	}
 
-- 
Michal Hocko
SUSE Labs
