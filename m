Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F7222502
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F7222502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbeFVQZI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:25:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934341AbeFVQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B70081A4EBA;
        Fri, 22 Jun 2018 16:25:03 +0000 (UTC)
Received: from redhat.com (ovpn-120-43.rdu2.redhat.com [10.10.120.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 248551C71D;
        Fri, 22 Jun 2018 16:25:03 +0000 (UTC)
Date:   Fri, 22 Jun 2018 12:25:01 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] [RFC PATCH] mm, oom: distinguish blockable mode for
 mmu notifiers
Message-ID: <20180622162501.GB3497@redhat.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <152968180950.11773.3374981930722769733@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152968180950.11773.3374981930722769733@mail.alporthouse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 16:25:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 16:25:03 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:36:49PM +0100, Chris Wilson wrote:
> Quoting Michal Hocko (2018-06-22 16:02:42)
> > Hi,
> > this is an RFC and not tested at all. I am not very familiar with the
> > mmu notifiers semantics very much so this is a crude attempt to achieve
> > what I need basically. It might be completely wrong but I would like
> > to discuss what would be a better way if that is the case.
> > 
> > get_maintainers gave me quite large list of people to CC so I had to trim
> > it down. If you think I have forgot somebody, please let me know
> 
> > diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
> > index 854bd51b9478..5285df9331fa 100644
> > --- a/drivers/gpu/drm/i915/i915_gem_userptr.c
> > +++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
> > @@ -112,10 +112,11 @@ static void del_object(struct i915_mmu_object *mo)
> >         mo->attached = false;
> >  }
> >  
> > -static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
> > +static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
> >                                                        struct mm_struct *mm,
> >                                                        unsigned long start,
> > -                                                      unsigned long end)
> > +                                                      unsigned long end,
> > +                                                      bool blockable)
> >  {
> >         struct i915_mmu_notifier *mn =
> >                 container_of(_mn, struct i915_mmu_notifier, mn);
> > @@ -124,7 +125,7 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
> >         LIST_HEAD(cancelled);
> >  
> >         if (RB_EMPTY_ROOT(&mn->objects.rb_root))
> > -               return;
> > +               return 0;
> 
> The principle wait here is for the HW (even after fixing all the locks
> to be not so coarse, we still have to wait for the HW to finish its
> access). The first pass would be then to not do anything here if
> !blockable.
> 
> Jerome keeps on shaking his head and telling us we're doing it all
> wrong, so maybe it'll all fall out of HMM before we have to figure out
> how to differentiate between objects that can be invalidated immediately
> and those that need to acquire locks and/or wait.

Intel and AMD are doing it right nowadays (IIRC AMD had a bug a while
back). What i want is to replace GUP and notifier with HMM, with the
intention that we can mitigate in more clever way thing like OOM or
other mm aspect inside HMM and thus isolating mm folks from ever having
to decipher GPU or other weird drivers :)

I also want to do that for optimization purposes to allow to share
more thing accross multiple GPU that mirror same range of address.

Finaly another motiviation is to avoid the pin GUP implies and only
rely on mmu notification. This would unlock some memory migration
from ever backing of early when they see the pin.

I intend to post patches sometime before XDC this year and discuss
them at XDC see how people on driver side feel about that. I also
want to use that as an excuse to gather features request and other
Santa wishlist for HMM ;)

Cheers,
Jérôme
