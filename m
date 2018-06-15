Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD580C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8301920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8301920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965814AbeFOLfO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:35:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965736AbeFOLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:35:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70E204023841;
        Fri, 15 Jun 2018 11:35:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F12E7111AF20;
        Fri, 15 Jun 2018 11:35:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5FBZ7m2016739;
        Fri, 15 Jun 2018 07:35:07 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5FBZ7Bg016735;
        Fri, 15 Jun 2018 07:35:07 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 15 Jun 2018 07:35:07 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180615073201.GB24039@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com> <20180612212007.GA22717@redhat.com> <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com> <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz> <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com> <20180615073201.GB24039@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 15 Jun 2018 11:35:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 15 Jun 2018 11:35:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2018, Michal Hocko wrote:

> On Thu 14-06-18 14:34:06, Mikulas Patocka wrote:
> > 
> > 
> > On Thu, 14 Jun 2018, Michal Hocko wrote:
> > 
> > > On Thu 14-06-18 15:18:58, jing xia wrote:
> > > [...]
> > > > PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
> > > >  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
> > > >  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
> > > >  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
> > > >  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
> > > >  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
> > > >  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
> > > 
> > > This trace doesn't provide the full picture unfortunately. Waiting in
> > > the direct reclaim means that the underlying bdi is congested. The real
> > > question is why it doesn't flush IO in time.
> > 
> > I pointed this out two years ago and you just refused to fix it:
> > http://lkml.iu.edu/hypermail/linux/kernel/1608.1/04507.html
> 
> Let me be evil again and let me quote the old discussion:
> : > I agree that mempool_alloc should _primarily_ sleep on their own
> : > throttling mechanism. I am not questioning that. I am just saying that
> : > the page allocator has its own throttling which it relies on and that
> : > cannot be just ignored because that might have other undesirable side
> : > effects. So if the right approach is really to never throttle certain
> : > requests then we have to bail out from a congested nodes/zones as soon
> : > as the congestion is detected.
> : >
> : > Now, I would like to see that something like that is _really_ necessary.
> :
> : Currently, it is not a problem - device mapper reports the device as
> : congested only if the underlying physical disks are congested.
> :
> : But once we change it so that device mapper reports congested state on its
> : own (when it has too many bios in progress), this starts being a problem.
> 
> So has this changed since then? If yes then we can think of a proper
> solution but that would require to actually describe why we see the
> congestion, why it does help to wait on the caller rather than the
> allocator etc...

Device mapper doesn't report congested state - but something else does 
(perhaps the user inserted a cheap slow usb stick or sdcard?). And device 
mapper is just a victim of that.

Why should device mapper sleep because some other random block device is 
congested?

> Throwing statements like ...
> 
> > I'm sure you'll come up with another creative excuse why GFP_NORETRY 
> > allocations need incur deliberate 100ms delays in block device drivers.
> 
> ... is not really productive. I've tried to explain why I am not _sure_ what
> possible side effects such a change might have and your hand waving
> didn't really convince me. MD is not the only user of the page
> allocator...
> 
> E.g. why has 41c73a49df31 ("dm bufio: drop the lock when doing GFP_NOIO
> allocation") even added GFP_NOIO request in the first place when you
> keep retrying and sleep yourself?

Because mempool uses it. Mempool uses allocations with "GFP_NOIO | 
__GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN". An so dm-bufio uses 
these flags too. dm-bufio is just a big mempool.

If you argue that these flags are incorrect - then fix mempool_alloc.

> The changelog only describes what but
> doesn't explain why. Or did I misread the code and this is not the
> allocation which is stalling due to congestion?

Mikulas
