Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B55DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554792184E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeL2Jw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:52:27 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:38040 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbeL2Jw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:52:26 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gdBHz-0001Uo-Km; Sat, 29 Dec 2018 10:52:15 +0100
Date:   Sat, 29 Dec 2018 10:52:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
Message-ID: <20181229095215.nbcijqacw5b6aho7@breakpoint.cc>
References: <20181229015524.222741-1-shakeelb@google.com>
 <20181229073325.GZ16738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229073325.GZ16738@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> > The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> > memory is already accounted to kmemcg. Do the same for ebtables. The
> > syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> > whole system from a restricted memcg, a potential DoS.
> 
> What is the lifetime of these objects? Are they bound to any process?

No, they are not.
They are free'd only when userspace requests it or the netns is
destroyed.
