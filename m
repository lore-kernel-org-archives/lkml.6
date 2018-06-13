Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9142FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52293208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52293208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbeFMOCe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:02:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935662AbeFMOCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC63B400739D;
        Wed, 13 Jun 2018 14:02:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E27178BC;
        Wed, 13 Jun 2018 14:02:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5DE2S6G007286;
        Wed, 13 Jun 2018 10:02:28 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5DE2SHh007282;
        Wed, 13 Jun 2018 10:02:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Jun 2018 10:02:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <snitzer@redhat.com>
cc:     Jing Xia <jing.xia.mail@gmail.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180612212007.GA22717@redhat.com>
Message-ID: <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com> <20180612212007.GA22717@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 13 Jun 2018 14:02:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 13 Jun 2018 14:02:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2018, Mike Snitzer wrote:

> On Tue, Jun 12 2018 at  4:03am -0400,
> Jing Xia <jing.xia.mail@gmail.com> wrote:
> 
> > Performance test in android reports that the phone sometimes gets
> > hanged and shows black screen for about several minutes.The sysdump shows:
> > 1. kswapd and other tasks who enter the direct-reclaim path are waiting
> > on the dm_bufio_lock;
> 
> Do you have an understanding of where they are waiting?  Is it in
> dm_bufio_shrink_scan()?
> 
> > 2. the task who gets the dm_bufio_lock is stalled for IO completions,
> > the relevant stack trace as :
> > 
> > PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
> >  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
> >  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
> >  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
> >  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
> >  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
> >  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
> >  #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
> >  #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
> >  #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
> >  #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040

Please send the full stacktrace of this task.

Then, we can see, why is it waiting here.

Mikulas
