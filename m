Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF8D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF8D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeIDLcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:32:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbeIDLcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:32:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53F2FAFF4;
        Tue,  4 Sep 2018 07:08:25 +0000 (UTC)
Date:   Tue, 4 Sep 2018 09:08:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180904070824.GH14951@dhcp22.suse.cz>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
 <20180612212007.GA22717@redhat.com>
 <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz>
 <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
 <alpine.LRH.2.02.1809031816120.27063@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1809031816120.27063@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-09-18 18:23:17, Mikulas Patocka wrote:
> 
> 
> On Wed, 1 Aug 2018, jing xia wrote:
> 
> > We reproduced this issue again and found out the root cause.
> > dm_bufio_prefetch() with dm_bufio_lock enters the direct reclaim and
> > takes a long time to do the soft_limit_reclaim, because of the huge
> > number of memory excess of the memcg.
> > Then, all the task who do shrink_slab() wait for  dm_bufio_lock.
> > 
> > Any suggestions for this?Thanks.
> 
> There's hardly any solution because Michal Hocko refuses to change 
> __GFP_NORETRY behavior.
> 
> The patches 41c73a49df31151f4ff868f28fe4f129f113fa2c and 
> d12067f428c037b4575aaeb2be00847fc214c24a could reduce the lock contention 
> on the dm-bufio lock - the patches don't fix the high CPU consumption 
> inside the memory allocation, but the kernel code should wait less on the 
> bufio lock.

If you actually looked at the bottom line of the problem then you would
quickly find out that dm-bufio lock is the least of the problem with the
soft limit reclaim. This is a misfeature which has been merged and we
have to live with it. All we can do is to discourage people from using
it and use much more saner low limit instead.

So please stop this stupid blaming, try to understand the reasoning
behind my arguments.
-- 
Michal Evil Hocko
SUSE Labs
