Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE51C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9211221A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9211221A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeHFNSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbeHFNSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:18:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83F10AF70;
        Mon,  6 Aug 2018 11:09:35 +0000 (UTC)
Date:   Mon, 6 Aug 2018 13:09:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: WARNING in try_charge
Message-ID: <20180806110934.GJ19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com>
 <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
 <20180806094827.GH19540@dhcp22.suse.cz>
 <CACT4Y+ZEAoPWxEJ2yAf6b5cSjAm+MPx1yrk70BWHRrnDYdyb_A@mail.gmail.com>
 <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-08-18 19:47:00, Tetsuo Handa wrote:
> On 2018/08/06 19:39, Dmitry Vyukov wrote:
> > On Mon, Aug 6, 2018 at 11:48 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >> Btw. running with the above diff on top might help us to ideantify
> >> whether this is a pre-mature warning or a valid one. Still useful to
> >> find out.
> 
> Since syzbot already found a syz reproducer, you can ask syzbot to test it.
> 
> > 
> > The bug report has a reproducer, so you can run it with the patch. Or
> > ask syzbot to test your patch:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> > Which basically boils down to saying:
> > 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master
> 
> Excuse me, but this is linux-next only problem. Therefore,

If this really is a linux-next only problem then please retest with the
current linux-next which has dropped the and replaced the group oom
code.

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4603ad75c9a9..852cd3dbdcd9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1388,6 +1388,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool ret;
>  
>  	mutex_lock(&oom_lock);
> +	pr_info("task=%s pid=%d invoked memcg oom killer. oom_victim=%d\n",
> +			current->comm, current->pid, tsk_is_oom_victim(current));
>  	ret = out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
>  	return ret;
> 
> F.Y.I. Waiting until __mmput() completes (with timeout using OOM score feedback)
> ( https://syzkaller.appspot.com/x/patch.diff?x=101e449c400000 ) solves this race.

Which just means that something else is broken. Seriously, timout is not
going to fix anything. It merely changes the picture.

-- 
Michal Hocko
SUSE Labs
