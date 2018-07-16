Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84360ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF86208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF86208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeGPLfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:49506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbeGPLfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E80FFADC2;
        Mon, 16 Jul 2018 11:08:45 +0000 (UTC)
Date:   Mon, 16 Jul 2018 13:08:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg
 in softirq
Message-ID: <20180716110845.GK17280@dhcp22.suse.cz>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <20180716075836.GC17280@dhcp22.suse.cz>
 <CALOAHbD1+eYHDo5-q1--nsBTNj66ZX6iw2YU4koLgZD_0ZDy+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbD1+eYHDo5-q1--nsBTNj66ZX6iw2YU4koLgZD_0ZDy+w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-07-18 17:45:06, Yafang Shao wrote:
> On Mon, Jul 16, 2018 at 3:58 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Sat 14-07-18 16:32:02, Yafang Shao wrote:
> >> try_charge maybe executed in packet receive path, which is in interrupt
> >> context.
> >> In this situation, the 'current' is the interrupted task, which may has
> >> no relation to the rx softirq, So it is nonsense to use 'current'.
> >>
> >> Avoid bothering the interrupted if page_counter_try_charge failes.
> >
> > I agree with Shakeel that this changelog asks for more information about
> > "why it matters". Small inconsistencies should be tolerable because the
> > state we rely on is so rarely set that it shouldn't make a visible
> > difference in practice.
> >
> 
> HI Michal,
> 
> No, it can make a visible difference in pratice.
> The difference is in __sk_mem_raise_allocated().
> 
> Without this patch, if the random interrupted task is oom victim or
> fatal signal pending or exiting, the charge will success anyway. That
> means the cgroup limit doesn't work in this situation.
> 
> With this patch, in the same situation the charged memory will be
> uncharged as it hits the memcg limit.
> 
> That is okay if the memcg of the interrupted task is same with the
> sk->sk_memcg,  but it may not okay if they are difference.
> 
> I'm trying to prove it, but seems it's very hard to produce this issue.

So it is possible that this is so marginal that it doesn't make any
_practical_ impact after all.

-- 
Michal Hocko
SUSE Labs
