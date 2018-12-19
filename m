Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0E20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeLSXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:39:21 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:51527 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbeLSXjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:39:21 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 746393C94; Thu, 20 Dec 2018 00:39:19 +0100 (CET)
Date:   Thu, 20 Dec 2018 00:39:18 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219142528.yx6ravdyzcqp5wtd@master>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:25:28PM +0000, Wei Yang wrote:
> >-			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
> >+			skip_pages = (1 << compound_order(head)) - (page - head);
> >+			iter = round_up(iter + 1, skip_pages) - 1;
> 
> The comment of round_up says round up to next specified power of 2.  And
> second parameter must be a power of 2.
> 
> Look skip_pages not satisfy this.

I thought that gigantic pages were always allocated on 1GB aligned.
At least alloc_gigantic_page() looks for 1GB range, aligned to that.
But I see that in alloc_contig_range(), the boundaries can differ.

Anyway, unless I am missing something, I think that we could just
get rid of the round_up() and do something like:

<--
skip_pages = (1 << compound_order(head)) - (page - head);
iter = skip_pages - 1;
-->

which looks more simple IMHO.

It should just work for 2MB and 1GB Hugepages.
-- 
Oscar Salvador
SUSE L3
