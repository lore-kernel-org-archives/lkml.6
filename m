Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FDAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF62422B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DF62422B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFVMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:52:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751345AbeFVMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11466406C757;
        Fri, 22 Jun 2018 12:52:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F008F2026D6B;
        Fri, 22 Jun 2018 12:52:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5MCq9Kh012494;
        Fri, 22 Jun 2018 08:52:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5MCq9aJ012490;
        Fri, 22 Jun 2018 08:52:09 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 22 Jun 2018 08:52:09 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180622090935.GT10465@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806220845190.8072@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com> <20180615073201.GB24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com> <20180615115547.GH24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com> <20180615130925.GI24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com> <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com> <20180622090151.GS10465@dhcp22.suse.cz> <20180622090935.GT10465@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 12:52:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 12:52:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2018, Michal Hocko wrote:

> On Fri 22-06-18 11:01:51, Michal Hocko wrote:
> > On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
> [...]
> > > What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> > > request comes from a block device driver or a filesystem), we should not 
> > > sleep.
> > 
> > Why? How are you going to audit all the callers that the behavior makes
> > sense and moreover how are you going to ensure that future usage will
> > still make sense. The more subtle side effects gfp flags have the harder
> > they are to maintain.
> 
> So just as an excercise. Try to explain the above semantic to users. We
> currently have the following.
> 
>  * __GFP_NORETRY: The VM implementation will try only very lightweight
>  *   memory direct reclaim to get some memory under memory pressure (thus
>  *   it can sleep). It will avoid disruptive actions like OOM killer. The
>  *   caller must handle the failure which is quite likely to happen under
>  *   heavy memory pressure. The flag is suitable when failure can easily be
>  *   handled at small cost, such as reduced throughput
> 
>  * __GFP_FS can call down to the low-level FS. Clearing the flag avoids the
>  *   allocator recursing into the filesystem which might already be holding
>  *   locks.
> 
> So how are you going to explain gfp & (__GFP_NORETRY | ~__GFP_FS)? What
> is the actual semantic without explaining the whole reclaim or force
> users to look into the code to understand that? What about GFP_NOIO |
> __GFP_NORETRY? What does it mean to that "should not sleep". Do all
> shrinkers have to follow that as well?

My reasoning was that there is broken code that uses __GFP_NORETRY and 
assumes that it can't fail - so conditioning the change on !__GFP_FS would 
minimize the diruption to the broken code.

Anyway - if you want to test only on __GFP_NORETRY (and fix those 16 
broken cases that assume that __GFP_NORETRY can't fail), I'm OK with that.

Mikulas


Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -2674,6 +2674,7 @@ static bool shrink_node(pg_data_t *pgdat
 		 * the LRU too quickly.
 		 */
 		if (!sc->hibernation_mode && !current_is_kswapd() &&
+		   !(sc->gfp_mask & __GFP_NORETRY) &&
 		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
 			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
