Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22F7FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8795208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8795208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeFNHb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44271 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbeFNHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57A73AE40;
        Thu, 14 Jun 2018 07:31:54 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:31:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     jing xia <jing.xia.mail@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180614073153.GB9371@dhcp22.suse.cz>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
 <20180612212007.GA22717@redhat.com>
 <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-06-18 15:18:58, jing xia wrote:
[...]
> PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
>  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
>  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
>  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
>  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
>  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
>  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40

This trace doesn't provide the full picture unfortunately. Waiting in
the direct reclaim means that the underlying bdi is congested. The real
question is why it doesn't flush IO in time.

>  #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
>  #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
>  #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
>  #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040
> #10 [ffffffc0282af8f0] do_try_to_free_pages at ffffff8008178b6c
> #11 [ffffffc0282af990] try_to_free_pages at ffffff8008178f3c
> #12 [ffffffc0282afa30] __perform_reclaim at ffffff8008169130
> #13 [ffffffc0282afab0] __alloc_pages_nodemask at ffffff800816c9b8
> #14 [ffffffc0282afbd0] __get_free_pages at ffffff800816cd6c
> #15 [ffffffc0282afbe0] alloc_buffer at ffffff8008591a94
> #16 [ffffffc0282afc20] __bufio_new at ffffff8008592e94
> #17 [ffffffc0282afc70] dm_bufio_prefetch at ffffff8008593198
> #18 [ffffffc0282afd20] verity_prefetch_io at ffffff8008598384
> #19 [ffffffc0282afd70] process_one_work at ffffff80080b5b3c
> #20 [ffffffc0282afdc0] worker_thread at ffffff80080b64fc
> #21 [ffffffc0282afe20] kthread at ffffff80080bae34
> 
> > Mikulas

-- 
Michal Hocko
SUSE Labs
