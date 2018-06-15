Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BB6CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C422F208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C422F208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965621AbeFOMry (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:47:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936188AbeFOMrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1131F818F030;
        Fri, 15 Jun 2018 12:47:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5BF1201E820;
        Fri, 15 Jun 2018 12:47:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5FClq69030824;
        Fri, 15 Jun 2018 08:47:52 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5FClq3w030820;
        Fri, 15 Jun 2018 08:47:52 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 15 Jun 2018 08:47:52 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180615115547.GH24039@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com> <20180612212007.GA22717@redhat.com> <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com> <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz> <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com> <20180615073201.GB24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 15 Jun 2018 12:47:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 15 Jun 2018 12:47:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2018, Michal Hocko wrote:

> On Fri 15-06-18 07:35:07, Mikulas Patocka wrote:
> > 
> > Because mempool uses it. Mempool uses allocations with "GFP_NOIO | 
> > __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN". An so dm-bufio uses 
> > these flags too. dm-bufio is just a big mempool.
> 
> This doesn't answer my question though. Somebody else is doing it is not
> an explanation. Prior to your 41c73a49df31 there was no GFP_NOIO
> allocation AFAICS. So why do you really need it now? Why cannot you

dm-bufio always used "GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | 
__GFP_NOWARN" since the kernel 3.2 when it was introduced.

In the kernel 4.10, dm-bufio was changed so that it does GFP_NOWAIT 
allocation, then drops the lock and does GFP_NOIO with the dropped lock 
(because someone was likely experiencing the same issue that is reported 
in this thread) - there are two commits that change it - 9ea61cac0 and 
41c73a49df31.

> simply keep retrying GFP_NOWAIT with your own throttling?
> 
> Note that I am not trying to say that 41c73a49df31, I am merely trying
> to understand why this blocking allocation is done in the first place.
>  
> > If you argue that these flags are incorrect - then fix mempool_alloc.
> 
> AFAICS there is no report about mempool_alloc stalling here. Maybe this

If the page allocator can stall dm-bufio, it can stall mempool_alloc as 
well. dm-bufio is just bigger, so it will hit this bug sooner.

> is the same class of problem, honestly, I dunno. And I've already said
> that stalling __GFP_NORETRY might be a good way around that but that
> needs much more consideration and existing users examination. I am not
> aware anybody has done that. Doing changes like that based on a single
> user is certainly risky.

Why don't you set any rules how these flags should be used?

If you use GFP_NOIO | __GFP_NORETRY in your own code and blame other 
people for doing so - you are as much evil as Linus, who praised people 
for reverse-engineering hardware and blamed them for reverse-engineering 
bitkeeper :-)

Mikulas
