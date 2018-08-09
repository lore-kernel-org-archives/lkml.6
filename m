Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8377C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB951216FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB951216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbeHIRdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:33:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732422AbeHIRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5EA4AD02;
        Thu,  9 Aug 2018 15:07:41 +0000 (UTC)
Date:   Thu, 9 Aug 2018 17:07:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Vladimir Davydov <vdavydov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: WARNING in try_charge
Message-ID: <20180809150735.GA15611@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com>
 <e2869136-9f59-9ce8-8b9f-f75b157ee31d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2869136-9f59-9ce8-8b9f-f75b157ee31d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-08-18 22:57:43, Tetsuo Handa wrote:
> >From b1f38168f14397c7af9c122cd8207663d96e02ec Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 9 Aug 2018 22:49:40 +0900
> Subject: [PATCH] mm, oom: task_will_free_mem(current) should retry until
>  memory reserve fails
> 
> Commit 696453e66630ad45 ("mm, oom: task_will_free_mem should skip
> oom_reaped tasks") changed to select next OOM victim as soon as
> MMF_OOM_SKIP is set. But we don't need to select next OOM victim as
> long as ALLOC_OOM allocation can succeed. And syzbot is hitting WARN(1)
> caused by this race window [1].

It is not because the syzbot was exercising a completely different code
path (memcg charge rather than the page allocator).

> Since memcg OOM case uses forced charge if current thread is killed,
> out_of_memory() can return true without selecting next OOM victim.
> Therefore, this patch changes task_will_free_mem(current) to ignore
> MMF_OOM_SKIP unless ALLOC_OOM allocation failed.

And the patch is simply wrong for memcg.
-- 
Michal Hocko
SUSE Labs
