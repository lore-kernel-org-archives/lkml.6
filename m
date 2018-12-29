Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0509FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B542145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546077979;
	bh=gfc7cOOR/YtYmNUTd+fvS2PT1omyyEzHa2t6wSjfy/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AMzGLTdQJNBcy975mPyOGs6/W8JLtN+ckyYqlbYJmG6gKuHQsjEPUIwqHuEWyUXMG
	 nxMAClWCxxS8aKaslH54YOhBduMkTSQHsaBml8A2PR9nIqhn5hDgKTehYIqIaeuXPc
	 vfWMRk/9HpBNQaw3vXhUBG1vtcI/VBlU5mIg52mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeL2KGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 05:06:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726737AbeL2KGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 05:06:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDB0FAA5C;
        Sat, 29 Dec 2018 10:06:16 +0000 (UTC)
Date:   Sat, 29 Dec 2018 11:06:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
Message-ID: <20181229100615.GB16738@dhcp22.suse.cz>
References: <20181229015524.222741-1-shakeelb@google.com>
 <20181229073325.GZ16738@dhcp22.suse.cz>
 <20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 29-12-18 10:52:15, Florian Westphal wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > > memory is already accounted to kmemcg. Do the same for ebtables. The
> > > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > > whole system from a restricted memcg, a potential DoS.
> > 
> > What is the lifetime of these objects? Are they bound to any process?
> 
> No, they are not.
> They are free'd only when userspace requests it or the netns is
> destroyed.

Then this is problematic, because the oom killer is not able to
guarantee the hard limit and so the excessive memory consumption cannot
be really contained. As a result the memcg will be basically useless
until somebody tears down the charged objects by other means. The memcg
oom killer will surely kill all the existing tasks in the cgroup and
this could somehow reduce the problem. Maybe this is sufficient for
some usecases but that should be properly analyzed and described in the
changelog.

-- 
Michal Hocko
SUSE Labs
