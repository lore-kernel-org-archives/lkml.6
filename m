Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A6C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC4D2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546251125;
	bh=K6+Ag34XZcqq22UwxSAgbyXxYDLXtLye8bgwAHMYi94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TBGzF1GG3n7traseR55xDYEJ7CdOld5nfnXAiPVU52nkmCW8Q8WevzUiHP0hAXmT0
	 Rez4eCM2aD5UydcvnJKoxki9XeDTfpNWO53cJsgK1wybcuCMMbzxkTAWe13ZMoLsst
	 rKNgR2jDpaa0actcGIVe5EG++lz9bEx8P/p2uU40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeLaKME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:12:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:46100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbeLaKMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:12:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD834ADF4;
        Mon, 31 Dec 2018 10:12:00 +0000 (UTC)
Date:   Mon, 31 Dec 2018 11:11:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
Message-ID: <20181231101158.GC22445@dhcp22.suse.cz>
References: <20181229015524.222741-1-shakeelb@google.com>
 <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
 <20181229100615.GB16738@dhcp22.suse.cz>
 <CALvZod7v-CC1XipLAerFj1Zp_M=qXZq6MzDL4pubJMTRCsMFNw@mail.gmail.com>
 <20181230074513.GA22445@dhcp22.suse.cz>
 <20181230080028.GB22445@dhcp22.suse.cz>
 <CALvZod6Ty30uQjJF8KZf=RS5djULaLVggYv_1WFrKJWaYa6EHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Ty30uQjJF8KZf=RS5djULaLVggYv_1WFrKJWaYa6EHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-12-18 19:59:53, Shakeel Butt wrote:
> On Sun, Dec 30, 2018 at 12:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sun 30-12-18 08:45:13, Michal Hocko wrote:
> > > On Sat 29-12-18 11:34:29, Shakeel Butt wrote:
> > > > On Sat, Dec 29, 2018 at 2:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> > > > > > Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > > > > > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > > > > > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > > > > > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > > > > > > whole system from a restricted memcg, a potential DoS.
> > > > > > >
> > > > > > > What is the lifetime of these objects? Are they bound to any process?
> > > > > >
> > > > > > No, they are not.
> > > > > > They are free'd only when userspace requests it or the netns is
> > > > > > destroyed.
> > > > >
> > > > > Then this is problematic, because the oom killer is not able to
> > > > > guarantee the hard limit and so the excessive memory consumption cannot
> > > > > be really contained. As a result the memcg will be basically useless
> > > > > until somebody tears down the charged objects by other means. The memcg
> > > > > oom killer will surely kill all the existing tasks in the cgroup and
> > > > > this could somehow reduce the problem. Maybe this is sufficient for
> > > > > some usecases but that should be properly analyzed and described in the
> > > > > changelog.
> > > > >
> > > >
> > > > Can you explain why you think the memcg hard limit will not be
> > > > enforced? From what I understand, the memcg oom-killer will kill the
> > > > allocating processes as you have mentioned. We do force charging for
> > > > very limited conditions but here the memcg oom-killer will take care
> > > > of
> > >
> > > I was talking about the force charge part. Depending on a specific
> > > allocation and its life time this can gradually get us over hard limit
> > > without any bound theoretically.
> >
> > Forgot to mention. Since b8c8a338f75e ("Revert "vmalloc: back off when
> > the current task is killed"") there is no way to bail out from the
> > vmalloc allocation loop so if the request is really large then the memcg
> > oom will not help. Is that a problem here?
> >
> 
> Yes, I think it will be an issue here.
> 
> > Maybe it is time to revisit fatal_signal_pending check.
> 
> Yes, we will need something to handle the memcg OOM. I will think more
> on that front or if you have any ideas, please do propose.

I can see three options here:
	- do not force charge on memcg oom or introduce a limited charge
	  overflow (reserves basically).
	- revert the revert and reintroduce the fatal_signal_pending
	  check into vmalloc
	- be more specific and check tsk_is_oom_victim in vmalloc and
	  fail

-- 
Michal Hocko
SUSE Labs
