Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DA72070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpNL3RAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBSM4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:56:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBSM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dNnoJF5z3YPMcWSyBEpmYmJYxRPnyE5bqoQcnXKlBxk=; b=HpNL3RAHgekvGBpoVraNsM2Zb
        Mu2RxvHy1PMkUNEQTOAfvHd42wifxahAOU/cLmja0FsxUAOoW9TZrMvAhuEykwqxEEojC02ekMzoG
        qIGKNyeLp7q8XEsrDeXfWm4kibkXUZm8Wimgu532uAVvRafwcM6RBsEf2FZTQwjtRZZkWO6GdPhEA
        ouhtIH4Qe5Zy5LtHrpiT2Cj5z1RSdupe39mc8IYnj+X6aKPyzU7ob738qG6Hkuxyv2wJ48VeEpv/1
        GRJ0PBua69SP1ajzfcv8l+GeKe+xLk8v8//mK7CdoqZcsvCP2fWqARRzom+HI/2zgM0LqWmu1FOoH
        pWhs6vbeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw4wd-0002QY-Rl; Tue, 19 Feb 2019 12:56:19 +0000
Date:   Tue, 19 Feb 2019 04:56:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange
 two lists of pages.
Message-ID: <20190219125619.GA12668@bombadil.infradead.org>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
 <20190217112943.GP12668@bombadil.infradead.org>
 <65A1FFA0-531C-4078-9704-3F44819C3C07@nvidia.com>
 <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
 <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
 <20190218175224.GT12668@bombadil.infradead.org>
 <C84D2490-B6C6-4C7C-870F-945E31719728@nvidia.com>
 <1ce6ae99-4865-df62-5f20-cb07ebb95327@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce6ae99-4865-df62-5f20-cb07ebb95327@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:12:07PM +0530, Anshuman Khandual wrote:
> But the location of this temp page matters as well because you would like to
> saturate the inter node interface. It needs to be either of the nodes where
> the source or destination page belongs. Any other node would generate two
> internode copy process which is not what you intend here I guess.

That makes no sense.  It should be allocated on the local node of the CPU
performing the copy.  If the CPU is in node A, the destination is in node B
and the source is in node C, then you're doing 4k worth of reads from node C,
4k worth of reads from node B, 4k worth of writes to node C followed by
4k worth of writes to node B.  Eventually the 4k of dirty cachelines on
node A will be written back from cache to the local memory (... or not,
if that page gets reused for some other purpose first).

If you allocate the page on node B or node C, that's an extra 4k of writes
to be sent across the inter-node link.
