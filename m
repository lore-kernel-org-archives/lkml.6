Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5B21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548700956;
	bh=taewOz7zxs0tcf8S7TTKEYdIgOSkzra6lP+wnzdDF58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=17Ww/g6txH7mNO5BsUsIe2kS3szDS11vIc3oWg5bqnpWfJfW2oWtFhmmKWjYhmQXh
	 /gWogmvhtCVJq6A9UB+Y99Sl5Wjrc67oMrpdxDeXcz9sJvjijlVwXnTLVUI2MZh+Ol
	 gZpjUvFExqevCjJoMoPHh1UrAsuMHHOfC3CDHb7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfA1Sme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:42:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:55996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfA1Sme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:42:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FB8EB017;
        Mon, 28 Jan 2019 18:42:32 +0000 (UTC)
Date:   Mon, 28 Jan 2019 19:42:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arkadiusz =?utf-8?Q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
Message-ID: <20190128184231.GS18811@dhcp22.suse.cz>
References: <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
 <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
 <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
 <20190127083724.GA18811@dhcp22.suse.cz>
 <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
 <20190127114021.GB18811@dhcp22.suse.cz>
 <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
 <20190128101513.f35752d6210f0781d0de8d17@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128101513.f35752d6210f0781d0de8d17@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 10:15:13, Andrew Morton wrote:
> On Sun, 27 Jan 2019 23:57:38 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
> > Arkadiusz reported that enabling memcg's group oom killing causes
> > strange memcg statistics where there is no task in a memcg despite
> > the number of tasks in that memcg is not 0. It turned out that there
> > is a bug in wake_oom_reaper() which allows enqueuing same task twice
> > which makes impossible to decrease the number of tasks in that memcg
> > due to a refcount leak.
> > 
> > This bug existed since the OOM reaper became invokable from
> > task_will_free_mem(current) path in out_of_memory() in Linux 4.7,
> > but memcg's group oom killing made it easier to trigger this bug by
> > calling wake_oom_reaper() on the same task from one out_of_memory()
> > request.
> > 
> > Fix this bug using an approach used by commit 855b018325737f76
> > ("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task").
> > As a side effect of this patch, this patch also avoids enqueuing
> > multiple threads sharing memory via task_will_free_mem(current) path.
> > 
> 
> Do we think this is serious enough to warrant a -stable backport?

Yes, I would go with stable backport.

-- 
Michal Hocko
SUSE Labs
