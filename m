Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B33C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513BA20C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513BA20C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392557AbeHPTkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:40:53 -0400
Received: from mail.us.es ([193.147.175.20]:49780 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbeHPTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:40:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1F9BE249FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 18:38:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0B6EDDA729
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 18:38:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DE9CBDA7E9; Thu, 16 Aug 2018 18:38:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A0377DA794;
        Thu, 16 Aug 2018 18:38:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Aug 2018 18:38:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6E595426CC47;
        Thu, 16 Aug 2018 18:38:48 +0200 (CEST)
Date:   Thu, 16 Aug 2018 18:41:10 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Vlastimil Babka <vbabka@suse.cz>,
        Georgi Nikolov <gnikolov@icdsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] netfilter/x_tables: do not fail xt_alloc_table_info too
 easilly
Message-ID: <20180816164110.g2dedcm7nh75zjms@salvia>
References: <20180807195400.23687-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807195400.23687-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:54:00PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc()
> in xt_alloc_table_info()") has unintentionally fortified
> xt_alloc_table_info allocation when __GFP_RETRY has been dropped from
> the vmalloc fallback. Later on there was a syzbot report that this
> can lead to OOM killer invocations when tables are too large and
> 0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
> has been merged to restore the original behavior. Georgi Nikolov however
> noticed that he is not able to install his iptables anymore so this can
> be seen as a regression.
> 
> The primary argument for 0537250fdc6c was that this allocation path
> shouldn't really trigger the OOM killer and kill innocent tasks. On the
> other hand the interface requires root and as such should allow what the
> admin asks for. Root inside a namespaces makes this more complicated
> because those might be not trusted in general. If they are not then such
> namespaces should be restricted anyway. Therefore drop the __GFP_NORETRY
> and replace it by __GFP_ACCOUNT to enfore memcg constrains on it.

Applied, thanks.
