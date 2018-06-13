Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B9552C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE5A208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE5A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935547AbeFMNjS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:39:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46943 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934987AbeFMNjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:39:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0AC38AE1B;
        Wed, 13 Jun 2018 13:39:16 +0000 (UTC)
Date:   Wed, 13 Jun 2018 15:39:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Message-ID: <20180613133913.GD20315@dhcp22.suse.cz>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
 <20180613125546.GB32016@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613125546.GB32016@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-06-18 05:55:46, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
> > It is not only the matter of the spinlocks. GFP_ATOMIC is not supported 
> > by the
> > memory compaction code, which is used in alloc_contig_range(). Right, this
> > should be also noted in the documentation.
> 
> Documentation is good, asserts are better.  The code should reject any
> flag not explicitly supported, or even better have its own flags type
> with the few actually supported flags.

Agreed. Is the cma allocator used for anything other than GFP_KERNEL
btw.? If not then, shouldn't we simply drop the gfp argument altogether
rather than give users a false hope for differen gfp modes that are not
really supported and grow broken code?

-- 
Michal Hocko
SUSE Labs
