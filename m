Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAAEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609720855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2nXbAMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeL3Mgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:36:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36799 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeL3Mgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:36:38 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so31723599itj.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1mq4t38uYbLqxlD5aox2nT0EoBqfFO/XvxILpGueIg=;
        b=O2nXbAMtEChqjNQlq6mXIhMRYh+OvxNVj7TnS62gVZJ6RTaU/fYMaKB/lZMYwB/6wq
         56Sh4kQRoC5/R3AP8wlStBcHeaoFIZcyY2WtqAu0OLA2bGnL6JCOQPBMppe2TgXuyTn6
         xb/V5zIOja//0/e6YvzbrXP/jDWD1PmyYPb8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1mq4t38uYbLqxlD5aox2nT0EoBqfFO/XvxILpGueIg=;
        b=UOte/TseGj2iSi0cWZ488j0+XpgAlrSLgeq5N8F2J8xHEMKQu/ThccSKKBsMF0PSyY
         VXmBoBzpA2Xa/47lQg8tll1WMnZ1wrkBPLOoMelOFoq7siiHQuDPw1d3/TquFddO0w0x
         wqwrlDQ0XBsq4x6VuNB3sm4Me1Th2fnRVDzVzkkdutYtKVhkkkm6AU0NZLaGSmt2EGMa
         4v1LTKJZ3SZkh8poCZkknXk7hc0wI8T19tMQNsIe9WLvPSaOeH/6MDginv3KT4D7E2IG
         xZ6IxoUnz4lt/mKeMv7sE9ATqoP1mDoIzwUa50U7ckVPu+Yb9uR+YiwqYeIjMCesnDRk
         rcYQ==
X-Gm-Message-State: AA+aEWZCDJ5NrO8Ck2ZsoI8+5HQ/XvVZpWkQCDKNNp0zMDkNrshFzAa/
        bZqvgCptavWCtcb4dy2eUSvUr7AyBapahxz6x2xApg==
X-Google-Smtp-Source: AFSGD/UXmFbY+k3WtI3XRU0lK1BQPBSdGJp4g6uAWoSAtdzqstugpVc1BZE2JRYGLKQ08CsTjxQXk0xAPi1oJLXHkF0=
X-Received: by 2002:a02:7f08:: with SMTP id r8mr23127713jac.20.1546173397523;
 Sun, 30 Dec 2018 04:36:37 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com> <20181230120435.GA17231@gmail.com>
In-Reply-To: <20181230120435.GA17231@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 30 Dec 2018 13:36:25 +0100
Message-ID: <CAKfTPtA2ibYVJdqdWbEVjjCYueSCzc15Jwt9RNo=D=3kUFpEFw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Xie XiuQi <xiexiuqi@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2018 at 13:04, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > Cc: Bin Li <huawei.libin@huawei.com>
> > > Cc: <stable@vger.kernel.org>        [4.10+]
> > > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
> >
> > If it only happens in update_blocked_averages(), the del leaf has been added by:
> > a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)
>
> So I think until we are confident in the proposed fixes, how about
> applying Linus's patch that reverts a9e7f6544b9c and simplifies the list
> manipulation?

looks good to me

Thanks
Vincent
>
> That way we can re-introduce the O(nr_cgroups) optimization without
> pressure.
>
> I'll prepare a commit for sched/urgent that does this, please holler if
> any of you disagrees!
>
> Thanks,
>
>         Ingo
