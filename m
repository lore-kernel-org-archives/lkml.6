Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC540C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A23217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbeLTPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:52:53 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:56289 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728172AbeLTPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:52:53 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 774FF3CB1; Thu, 20 Dec 2018 16:52:51 +0100 (CET)
Date:   Thu, 20 Dec 2018 16:52:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220155247.qbyptzk35xr7ey72@d104.suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
 <20181220130606.GG9104@dhcp22.suse.cz>
 <20181220134132.6ynretwlndmyupml@d104.suse.de>
 <20181220142124.r34fnuv6b33luj5a@d104.suse.de>
 <20181220153237.bhepsqw27mjmc4g5@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220153237.bhepsqw27mjmc4g5@master>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:32:37PM +0000, Wei Yang wrote:
> Now let's go back to see how to calculate new_iter. From the chart
> above, we can see this formula stands for all three cases:
> 
>     new_iter = round_up(iter + 1, page_size(HugePage))
> 
> So it looks the first version is correct.

Let us assume:

* iter = 0 (page first of the pageblock)
* page is a tail
* hugepage is 2mb

So we have the following:

iter = round_up(iter + 1, 1<<compound_order(head)) - 1;

which translates to:

iter = round_up(1, 512) - 1 = 511;

Then iter will be incremented to 512, and we break the loop.

The outcome of this is that ouf ot 512 pages, we only scanned 1,
and we skipped all the other 511 pages by mistake.

-- 
Oscar Salvador
SUSE L3
