Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31423C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B37208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B37208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGaGr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:47:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeGaGrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:47:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12CF5ACEF;
        Tue, 31 Jul 2018 05:09:30 +0000 (UTC)
Date:   Tue, 31 Jul 2018 07:09:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180731050928.GA4557@dhcp22.suse.cz>
References: <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
 <20180730144647.GX24267@dhcp22.suse.cz>
 <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
 <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
 <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz>
 <20180730191005.GC24267@dhcp22.suse.cz>
 <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 06:01:48, Tetsuo Handa wrote:
> On 2018/07/31 4:10, Michal Hocko wrote:
> > Since should_reclaim_retry() should be a natural reschedule point,
> > let's do the short sleep for PF_WQ_WORKER threads unconditionally in
> > order to guarantee that other pending work items are started. This will
> > workaround this problem and it is less fragile than hunting down when
> > the sleep is missed. E.g. we used to have a sleeping point in the oom
> > path but this has been removed recently because it caused other issues.
> > Having a single sleeping point is more robust.
> 
> linux.git has not removed the sleeping point in the OOM path yet. Since removing the
> sleeping point in the OOM path can mitigate CVE-2016-10723, please do so immediately.

is this an {Acked,Reviewed,Tested}-by?

I will send the patch to Andrew if the patch is ok. 

> (And that change will conflict with Roman's cgroup aware OOM killer patchset. But it
> should be easy to rebase.)

That is still a WIP so I would lose sleep over it.
-- 
Michal Hocko
SUSE Labs
