Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BABC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116B125DAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116B125DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeGBNcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:32:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752381AbeGBNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:32:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADEC1AE07;
        Mon,  2 Jul 2018 13:32:49 +0000 (UTC)
Date:   Mon, 2 Jul 2018 15:32:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Message-ID: <20180702133247.GT19043@dhcp22.suse.cz>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
 <20180613125546.GB32016@infradead.org>
 <20180613133913.GD20315@dhcp22.suse.cz>
 <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 15:23:34, Marek Szyprowski wrote:
> Hi Michal,
> 
> On 2018-06-13 15:39, Michal Hocko wrote:
> > On Wed 13-06-18 05:55:46, Christoph Hellwig wrote:
> >> On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
> >>> It is not only the matter of the spinlocks. GFP_ATOMIC is not supported
> >>> by the
> >>> memory compaction code, which is used in alloc_contig_range(). Right, this
> >>> should be also noted in the documentation.
> >> Documentation is good, asserts are better.  The code should reject any
> >> flag not explicitly supported, or even better have its own flags type
> >> with the few actually supported flags.
> > Agreed. Is the cma allocator used for anything other than GFP_KERNEL
> > btw.? If not then, shouldn't we simply drop the gfp argument altogether
> > rather than give users a false hope for differen gfp modes that are not
> > really supported and grow broken code?
> 
> Nope, all cma_alloc() callers are expected to use it with GFP_KERNEL gfp 
> mask.
> The only flag which is now checked is __GFP_NOWARN. I can change the 
> function
> signature of cma_alloc to:
> struct page *cma_alloc(struct cma *cma, size_t count, unsigned int 
> align, bool no_warn);

Are there any __GFP_NOWARN users? I have quickly hit the indirection
trap and searching for alloc callback didn't tell me really much.

> What about clearing the allocated buffer? Should it be another bool
> parameter, done unconditionally or moved to the callers?

That really depends on callers. I have no idea what they actually ask
for.
-- 
Michal Hocko
SUSE Labs
