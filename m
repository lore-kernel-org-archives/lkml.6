Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B234C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A303214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547113306;
	bh=QkpOKZED+EoVNZjrk+9WaIdlNyzMQ3nOD/KwAM6mZ/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1KPPEX8qtFWA+H20VDOITMOJh2rtTDNrAmsddO9eqNstMOWHck6I99D628ZIaUwR
	 TurtByP7+gnkzTh84dqv/haXAqS68ndjL9wBIXGVpdHlj7dN2ZLEQeQK7fI+vChDER
	 Sgsf+rW3LYsDnCkNQUrh9RVexh6Zw9rmwDK/sP04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAJJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbfAJJlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:41:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95F89ADBD;
        Thu, 10 Jan 2019 09:41:43 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:41:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
Message-ID: <20190110094142.GI31793@dhcp22.suse.cz>
References: <20190103031431.247970-1-shakeelb@google.com>
 <5cc8efad-9d3d-3136-3ddc-1f8a640cb1f8@virtuozzo.com>
 <2d8f28cb-8620-be05-21bc-dcf3009b2774@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8f28cb-8620-be05-21bc-dcf3009b2774@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-01-19 12:22:09, Kirill Tkhai wrote:
[...]
> >> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> >> index 491828713e0b..5e55cef0cec3 100644
> >> --- a/net/bridge/netfilter/ebtables.c
> >> +++ b/net/bridge/netfilter/ebtables.c
> >> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
> >>  	tmp.name[sizeof(tmp.name) - 1] = 0;
> >>  
> >>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> >> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
> >> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> >> +			    PAGE_KERNEL);
> 
> Do we need GFP_HIGHMEM here?

No. vmalloc adds __GPF_HIGHMEM implicitly (see __vmalloc_area_node).

-- 
Michal Hocko
SUSE Labs
