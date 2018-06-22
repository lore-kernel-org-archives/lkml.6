Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17670241F1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17670241F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFVMo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751364AbeFVMo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 502E068803;
        Fri, 22 Jun 2018 12:44:56 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 066DC1C71B;
        Fri, 22 Jun 2018 12:44:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5MCiq3J010927;
        Fri, 22 Jun 2018 08:44:52 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5MCiqgC010923;
        Fri, 22 Jun 2018 08:44:52 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 22 Jun 2018 08:44:52 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180622090151.GS10465@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806220828040.8072@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180614073153.GB9371@dhcp22.suse.cz> <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com> <20180615073201.GB24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com> <20180615130925.GI24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
 <20180619104312.GD13685@dhcp22.suse.cz> <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com> <20180622090151.GS10465@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 12:44:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 12:44:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2018, Michal Hocko wrote:

> On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
> [...]
> > > But seriously, isn't the best way around the throttling issue to use
> > > PF_LESS_THROTTLE?
> > 
> > Yes - it could be done by setting PF_LESS_THROTTLE. But I think it would 
> > be better to change it just in one place than to add PF_LESS_THROTTLE to 
> > every block device driver (because adding it to every block driver results 
> > in more code).
> 
> Why would every block device need this? I thought we were talking about
> mempool allocator and the md variant of it. They are explicitly doing
> their own back off so PF_LESS_THROTTLE sounds appropriate to me.

Because every block driver is suspicible to this problem. Two years ago, 
there was a bug that when the user was swapping to dm-crypt device, memory 
management would stall the allocations done by dm-crypt by 100ms - that 
slowed down swapping rate and made the machine unuseable.

Then, people are complaining about the same problem in dm-bufio.

Next time, it will be something else.

(you will answer : "we will not fix bugs unless people are reporting them" :-)

> > What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> > request comes from a block device driver or a filesystem), we should not 
> > sleep.
> 
> Why? How are you going to audit all the callers that the behavior makes
> sense and moreover how are you going to ensure that future usage will
> still make sense. The more subtle side effects gfp flags have the harder
> they are to maintain.

I did audit them - see the previous email in this thread: 
https://www.redhat.com/archives/dm-devel/2018-June/thread.html

Mikulas

> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> > 
> > Index: linux-2.6/mm/vmscan.c
> > ===================================================================
> > --- linux-2.6.orig/mm/vmscan.c
> > +++ linux-2.6/mm/vmscan.c
> > @@ -2674,6 +2674,7 @@ static bool shrink_node(pg_data_t *pgdat
> >  		 * the LRU too quickly.
> >  		 */
> >  		if (!sc->hibernation_mode && !current_is_kswapd() &&
> > +		   (sc->gfp_mask & (__GFP_NORETRY | __GFP_FS)) != __GFP_NORETRY &&
> >  		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> >  			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> >  
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
