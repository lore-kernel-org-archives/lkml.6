Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2638C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6541920862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6541920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeIDCpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:45:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbeIDCpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:45:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7CC040241C5;
        Mon,  3 Sep 2018 22:23:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD3E2026D6B;
        Mon,  3 Sep 2018 22:23:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w83MNIsH010112;
        Mon, 3 Sep 2018 18:23:18 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w83MNHJq010108;
        Mon, 3 Sep 2018 18:23:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 3 Sep 2018 18:23:17 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     jing xia <jing.xia.mail@gmail.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1809031816120.27063@file01.intranet.prod.int.rdu2.redhat.com>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com> <20180612212007.GA22717@redhat.com> <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com> <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz> <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 22:23:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 22:23:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Aug 2018, jing xia wrote:

> We reproduced this issue again and found out the root cause.
> dm_bufio_prefetch() with dm_bufio_lock enters the direct reclaim and
> takes a long time to do the soft_limit_reclaim, because of the huge
> number of memory excess of the memcg.
> Then, all the task who do shrink_slab() wait for  dm_bufio_lock.
> 
> Any suggestions for this?Thanks.

There's hardly any solution because Michal Hocko refuses to change 
__GFP_NORETRY behavior.

The patches 41c73a49df31151f4ff868f28fe4f129f113fa2c and 
d12067f428c037b4575aaeb2be00847fc214c24a could reduce the lock contention 
on the dm-bufio lock - the patches don't fix the high CPU consumption 
inside the memory allocation, but the kernel code should wait less on the 
bufio lock.

Mikulas


> On Thu, Jun 14, 2018 at 3:31 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Thu 14-06-18 15:18:58, jing xia wrote:
> > [...]
> >> PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
> >>  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
> >>  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
> >>  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
> >>  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
> >>  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
> >>  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
> >
> > This trace doesn't provide the full picture unfortunately. Waiting in
> > the direct reclaim means that the underlying bdi is congested. The real
> > question is why it doesn't flush IO in time.
> >
> >>  #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
> >>  #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
> >>  #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
> >>  #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040
> >> #10 [ffffffc0282af8f0] do_try_to_free_pages at ffffff8008178b6c
> >> #11 [ffffffc0282af990] try_to_free_pages at ffffff8008178f3c
> >> #12 [ffffffc0282afa30] __perform_reclaim at ffffff8008169130
> >> #13 [ffffffc0282afab0] __alloc_pages_nodemask at ffffff800816c9b8
> >> #14 [ffffffc0282afbd0] __get_free_pages at ffffff800816cd6c
> >> #15 [ffffffc0282afbe0] alloc_buffer at ffffff8008591a94
> >> #16 [ffffffc0282afc20] __bufio_new at ffffff8008592e94
> >> #17 [ffffffc0282afc70] dm_bufio_prefetch at ffffff8008593198
> >> #18 [ffffffc0282afd20] verity_prefetch_io at ffffff8008598384
> >> #19 [ffffffc0282afd70] process_one_work at ffffff80080b5b3c
> >> #20 [ffffffc0282afdc0] worker_thread at ffffff80080b64fc
> >> #21 [ffffffc0282afe20] kthread at ffffff80080bae34
> >>
> >> > Mikulas
> >
> > --
> > Michal Hocko
> > SUSE Labs
> 
