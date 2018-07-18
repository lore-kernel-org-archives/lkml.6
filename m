Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDCECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70F42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70F42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGRPZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbeGRPZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:25:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6472AED5;
        Wed, 18 Jul 2018 14:47:10 +0000 (UTC)
Date:   Wed, 18 Jul 2018 16:47:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruce Merry <bmerry@ska.ac.za>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some
 machines
Message-ID: <20180718144710.GI7193@dhcp22.suse.cz>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz>
 <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-07-18 16:29:20, Bruce Merry wrote:
> On 18 July 2018 at 12:42, Michal Hocko <mhocko@kernel.org> wrote:
> > [CC some more people]
> >
> > On Tue 17-07-18 21:23:07, Andrew Morton wrote:
> >> (cc linux-mm)
> >>
> >> On Tue, 3 Jul 2018 08:43:23 +0200 Bruce Merry <bmerry@ska.ac.za> wrote:
> >>
> >> > Hi
> >> >
> >> > I've run into an odd performance issue in the kernel, and not being a
> >> > kernel dev or knowing terribly much about cgroups, am looking for
> >> > advice on diagnosing the problem further (I discovered this while
> >> > trying to pin down high CPU load in cadvisor).
> >> >
> >> > On some machines in our production system, cat
> >> > /sys/fs/cgroup/memory/memory.stat is extremely slow (500ms on one
> >> > machine), while on other nominally identical machines it is fast
> >> > (2ms).
> >
> > Could you try to use ftrace to see where the time is spent?
> 
> Thanks for looking into this. I'm not familiar with ftrace. Can you
> give me a specific command line to run? Based on "perf record cat
> /sys/fs/cgroup/memory/memory.stat"/"perf report", I see the following:
> 
>   42.09%  cat      [kernel.kallsyms]  [k] memcg_stat_show
>   29.19%  cat      [kernel.kallsyms]  [k] memcg_sum_events.isra.22
>   12.41%  cat      [kernel.kallsyms]  [k] mem_cgroup_iter
>    5.42%  cat      [kernel.kallsyms]  [k] _find_next_bit
>    4.14%  cat      [kernel.kallsyms]  [k] css_next_descendant_pre
>    3.44%  cat      [kernel.kallsyms]  [k] find_next_bit
>    2.84%  cat      [kernel.kallsyms]  [k] mem_cgroup_node_nr_lru_pages

I would just use perf record as you did. How long did the call take?
Also is the excessive time an outlier or a more consistent thing? If the
former does perf record show any difference?

> > memory_stat_show should only scale with the depth of the cgroup
> > hierarchy for memory.stat to get cumulative numbers. All the rest should
> > be simply reads of gathered counters. There is no locking involved in
> > the current kernel. What is the kernel version you are using, btw?
> 
> Ubuntu 16.04 with kernel 4.13.0-41-generic (so presumably includes
> some Ubuntu special sauce).

Do you see the same whe running with the vanilla kernel?
-- 
Michal Hocko
SUSE Labs
