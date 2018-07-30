Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D3FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B2208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029B2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeG3QWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:22:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbeG3QWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:22:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AE2FADEF;
        Mon, 30 Jul 2018 14:46:49 +0000 (UTC)
Date:   Mon, 30 Jul 2018 16:46:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180730144647.GX24267@dhcp22.suse.cz>
References: <ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp>
 <20180726113958.GE28386@dhcp22.suse.cz>
 <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-07-18 23:34:23, Tetsuo Handa wrote:
> On 2018/07/30 18:32, Michal Hocko wrote:
[...]
> > This one is waiting for draining and we are in mm_percpu_wq WQ context
> > which has its rescuer so no other activity can block us for ever. So
> > this certainly shouldn't deadlock. It can be dead slow but well, this is
> > what you will get when your shoot your system to death.
> 
> We need schedule_timeout_*() to allow such WQ_MEM_RECLAIM workqueues to wake up. (Tejun,
> is my understanding correct?) Lack of schedule_timeout_*() does block WQ_MEM_RECLAIM
> workqueues forever.

Hmm. This doesn't match my understanding of what WQ_MEM_RECLAIM actually
guarantees. If you are right then the whole thing sounds quite fragile
to me TBH.

Anyway we would at least have an explanation for what you are seeing.
-- 
Michal Hocko
SUSE Labs
