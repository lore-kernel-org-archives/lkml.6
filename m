Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33120C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE682070D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546068811;
	bh=hc+00t9MXy71Ghgms+RrFGoeS/Eo4QafJvZ4RZYgXH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cWMmxZrnpsexl0Ts3ZpgDkjDf5cCSP+VDILh2UUiWM5tHalNXqyPdCv64ixCTCaH2
	 teAQ/xy6dPnOgwlrHBoe+Esj0gkm0xhOIxzgEJqvuS6K3Q8yOm1n8LlIBw3SOH7+QF
	 Pcl3WNqsgJed7PunOSy8XZvEaAkjlypD4qgNLyjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeL2Hda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:33:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:54300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729060AbeL2Hd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:33:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8225FAD8A;
        Sat, 29 Dec 2018 07:33:27 +0000 (UTC)
Date:   Sat, 29 Dec 2018 08:33:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
Message-ID: <20181229073325.GZ16738@dhcp22.suse.cz>
References: <20181229015524.222741-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229015524.222741-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> memory is already accounted to kmemcg. Do the same for ebtables. The
> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> whole system from a restricted memcg, a potential DoS.

What is the lifetime of these objects? Are they bound to any process?

> Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/bridge/netfilter/ebtables.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 491828713e0b..5e55cef0cec3 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
>  	tmp.name[sizeof(tmp.name) - 1] = 0;
>  
>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
> +			    PAGE_KERNEL);
>  	if (!newinfo)
>  		return -ENOMEM;
>  
>  	if (countersize)
>  		memset(newinfo->counters, 0, countersize);
>  
> -	newinfo->entries = vmalloc(tmp.entries_size);
> +	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
> +				     PAGE_KERNEL);
>  	if (!newinfo->entries) {
>  		ret = -ENOMEM;
>  		goto free_newinfo;
> -- 
> 2.20.1.415.g653613c723-goog
> 

-- 
Michal Hocko
SUSE Labs
