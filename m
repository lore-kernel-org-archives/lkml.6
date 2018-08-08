Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C440C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7A8216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7A8216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeHHKnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:43:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:32806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHKnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E8FDAD49;
        Wed,  8 Aug 2018 08:25:12 +0000 (UTC)
Date:   Wed, 8 Aug 2018 10:25:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Florian Westphal <fw@strlen.de>,
        Georgi Nikolov <gnikolov@icdsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] netfilter/x_tables: do not fail xt_alloc_table_info too
 easilly
Message-ID: <20180808082511.GF27972@dhcp22.suse.cz>
References: <20180807195400.23687-1-mhocko@kernel.org>
 <a060e57c-dbcd-d3bc-c975-ac8a66468666@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a060e57c-dbcd-d3bc-c975-ac8a66468666@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 10:16:01, Vlastimil Babka wrote:
> On 08/07/2018 09:54 PM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc()
> > in xt_alloc_table_info()") has unintentionally fortified
> > xt_alloc_table_info allocation when __GFP_RETRY has been dropped from
> > the vmalloc fallback. Later on there was a syzbot report that this
> > can lead to OOM killer invocations when tables are too large and
> > 0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
> > has been merged to restore the original behavior. Georgi Nikolov however
> > noticed that he is not able to install his iptables anymore so this can
> > be seen as a regression.
> > 
> > The primary argument for 0537250fdc6c was that this allocation path
> > shouldn't really trigger the OOM killer and kill innocent tasks. On the
> > other hand the interface requires root and as such should allow what the
> > admin asks for. Root inside a namespaces makes this more complicated
> > because those might be not trusted in general. If they are not then such
> > namespaces should be restricted anyway. Therefore drop the __GFP_NORETRY
> > and replace it by __GFP_ACCOUNT to enfore memcg constrains on it.
> > 
> > Fixes: 0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
> > Reported-by: Georgi Nikolov <gnikolov@icdsoft.com>
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> IIRC According to Florian there are more places like this in the
> netfilter code?

Well, this is more for netfilter guys. I can only give a general
guidance that generally untrusted allocations triggered from userspace
should be a subject of kmem accounting.

-- 
Michal Hocko
SUSE Labs
