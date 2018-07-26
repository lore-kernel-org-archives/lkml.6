Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8389D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8389D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeGZJfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:58074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbeGZJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:35:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68661AED4;
        Thu, 26 Jul 2018 08:19:48 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:19:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruce Merry <bmerry@ska.ac.za>
Cc:     "Singh, Balbir" <bsingharora@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some
 machines
Message-ID: <20180726081947.GA28386@dhcp22.suse.cz>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz>
 <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
 <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
 <dda7b095-db84-7e69-a03e-d8ce64fc9b8e@gmail.com>
 <CAOm-9ar2zzxZvZ9A0Yu0knn_LNcHsck72wXShFXutYvAN2qu9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOm-9ar2zzxZvZ9A0Yu0knn_LNcHsck72wXShFXutYvAN2qu9Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 08:41:35, Bruce Merry wrote:
> On 26 July 2018 at 02:55, Singh, Balbir <bsingharora@gmail.com> wrote:
> > Do you by any chance have use_hierarch=1? memcg_stat_show should just rely on counters inside the memory cgroup and the the LRU sizes for each node.
> 
> Yes, /sys/fs/cgroup/memory/memory.use_hierarchy is 1. I assume systemd
> is doing that.

And this is actually good. Non hierarchical behavior is discouraged.
The real problem is that we are keeping way too many zombie memcgs
around and waiting for memory pressure to reclaim them and so they go
away on their own.

As I've tried to explain in other email force_empty before removing the
memcg should help.

Fixing this properly would require quite some heavy lifting AFAICS. We
would basically have to move zombies out of the way which is not hard
but we do not want to hide their current memory consumption so we would
have to somehow move their stats to the parent. And then we are back to
reparenting which has been removed by b2052564e66d ("mm: memcontrol:
continue cache reclaim from offlined groups").
-- 
Michal Hocko
SUSE Labs
