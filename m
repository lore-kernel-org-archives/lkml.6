Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E88C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB0F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osxgsmUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB0F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJZAK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:10:56 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43591 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJZAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:10:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id g75-v6so3855603yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38LYBaUL0bmQPCVz8hPbRtP0BYfGekAJhh2L8f7QJy0=;
        b=osxgsmUbVM03BwsfvtwYl39+/bfKzKSmDhUtjpxNa4NrVJ5jt2YTQzQA5L3bnj+8FE
         SVPBiP7xnurqLpjYJRpGnmKTLKWn5T40X2REITplan4ATBwY9sQ44MgddkcXvsR6wV4K
         lLbh2NGoJmUBOOd3D1/vUZv+EKaIl837KHmReOY7T4YvjXJ3tjD4+MmZHimZstJW527x
         fIp7IrEakbLhFenj3J2XO1amiwZW65sSMx0ed01ORTcVsAOnmTPdkENhEqo4s4rR64TO
         3dgEYlCEz1cw7IFFgZgB6/+bNfc3vs4BYO8HZ8NF99VhAgey8F/lb4nXSqY6II3CUrVr
         jM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=38LYBaUL0bmQPCVz8hPbRtP0BYfGekAJhh2L8f7QJy0=;
        b=DoHBVYRkjgKQ4UHZIJ1G4jW/ScoqqObyECxRXSCiKHEW+834ZnZjPiUiBOQYs04bZ0
         fbK0QBZLCLgOyfJpHGY6Iw58TG/xkdeiKMThW/bzcZar9mV6XDOv1xEoXubNme3f5EOP
         i94VqMAjmeUwJOzj608NAURcxmctKACH6PyBkjneODuyD1ps7CZsfEWnP8w2/OvFE+Cl
         J/Z0L2+H3mHF0oBITZZKsOT2HWEaW3ybAgz5Mfn2CpPvWUz8YcEcT5MqIWYl+5/TbOMK
         Zzdo9qj0xM86p4VQMHpZVB34+cpc/pW49ZMh6yySRh/FG8EpWscbbS/FaNFwbH5W3YKm
         qxhg==
X-Gm-Message-State: AGRZ1gLknzan/VcKGEdJR2jW9PUbLtFa5XhB1GB1vQgRXNm7L/9CyHqB
        ueG0YuTlrUUpglfX0h3PCZE=
X-Google-Smtp-Source: AJdET5eEjznN9qEMpg42V1Jt+PrYoDisYfOHG26E/aDZq/hKkpvAjm9ZG8OMY3kq6IQT8bBahBfEaQ==
X-Received: by 2002:a25:be91:: with SMTP id i17-v6mr1927755ybk.131.1540481857406;
        Thu, 25 Oct 2018 08:37:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:319d])
        by smtp.gmail.com with ESMTPSA id r67-v6sm1771795ywb.11.2018.10.25.08.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 08:37:36 -0700 (PDT)
Date:   Thu, 25 Oct 2018 08:37:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, tytso@mit.edu
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
Message-ID: <20181025153734.GH4182586@devbig004.ftw2.facebook.com>
References: <20181025150540.259281-1-bvanassche@acm.org>
 <20181025150540.259281-4-bvanassche@acm.org>
 <20181025153657.GG4182586@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025153657.GG4182586@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:36:57AM -0700, Tejun Heo wrote:
> Hello, Bart.
> 
> On Thu, Oct 25, 2018 at 08:05:40AM -0700, Bart Van Assche wrote:
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index 60d673e15632..375ec764f148 100644
> > --- a/include/linux/workqueue.h
> > +++ b/include/linux/workqueue.h
> > @@ -344,6 +344,7 @@ enum {
> >  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
> >  	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
> >  	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
> > +	__WQ_HAS_BEEN_USED	= 1 << 20, /* internal: work has been queued */
> >  
> >  	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
> >  	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index fc9129d5909e..0ef275fe526c 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1383,6 +1383,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> >  	if (unlikely(wq->flags & __WQ_DRAINING) &&
> >  	    WARN_ON_ONCE(!is_chained_work(wq)))
> >  		return;
> > +
> > +	if (!(wq->flags & __WQ_HAS_BEEN_USED))
> > +		wq->flags |= __WQ_HAS_BEEN_USED;
> > +
> >  retry:
> >  	if (req_cpu == WORK_CPU_UNBOUND)
> >  		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> > @@ -2889,7 +2893,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> >  	 * workqueues the deadlock happens when the rescuer stalls, blocking
> >  	 * forward progress.
> >  	 */
> > -	if (!from_cancel &&
> > +	if (!from_cancel && (pwq->wq->flags & __WQ_HAS_BEEN_USED) &&
> >  	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
> >  		lock_acquire_exclusive(&pwq->wq->lockdep_map, 0, 0, NULL,
> >  				       _THIS_IP_);
> 
> We likely wanna skip the whole drain instead of eliding lockdep
> annotation here.  Other than that, this patch looks fine to me but for
> the others, I think it'd be a better idea to listen to Johannes.  We
> wanna annotate the users for the exceptions rather than weakening the
> workqueue lockdep checks, especially because workqueue related
> deadlocks can be pretty difficult to trigger and root cause
> afterwards.

Ooh, also, please only do the HAS_BEEN_USED marking if LOCKDEP is
enabled.

Thanks.

-- 
tejun
