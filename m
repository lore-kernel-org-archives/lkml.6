Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB3625EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB3625EAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeGBOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752390AbeGBOsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:48:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A09E6AFAD;
        Mon,  2 Jul 2018 14:48:31 +0000 (UTC)
Date:   Mon, 2 Jul 2018 16:48:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180702144827.GC19043@dhcp22.suse.cz>
References: <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
 <20180627145718.GB20171@ziepe.ca>
 <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
 <1f6e79c5-5801-16d2-18a6-66bd0712b5b8@nvidia.com>
 <20180628091743.khhta7nafuwstd3m@quack2.suse.cz>
 <20180702055251.GV3014@mtr-leonro.mtl.com>
 <235a23e3-6e02-234c-3e20-b2dddc93e568@nvidia.com>
 <20180702070227.jj5udrdk3rxzjj4t@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702070227.jj5udrdk3rxzjj4t@quack2.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 09:02:27, Jan Kara wrote:
> On Sun 01-07-18 23:10:04, John Hubbard wrote:
[...]
> > That is an interesting point. 
> > 
> > Holding off page writeback of this region does seem like it could cause
> > problems under memory pressure. Maybe adjusting the watermarks so that we
> > tell the writeback  system, "all is well, just ignore this region until
> > we're done with it" might help? Any ideas here are welcome...
> > 
> > Longer term, maybe some additional work could allow the kernel to be able
> > to writeback the gup-pinned pages (while DMA is happening--snapshots), but
> > that seems like a pretty big overhaul.
> 
> We could use bounce pages to safely writeback pinned pages. However I don't
> think it would buy us anything. From MM point of view these pages are
> impossible-to-get-rid-of (page refcount is increased) and pernamently-dirty
> when GUP was for write (we don't know when dirty data arrives there). So
> let's not just fool MM by pretending we can make them clean. That's going
> to lead to just more problems down the road.

Absolutely agreed! We really need to have means to identify those pages
first. Only then we can make an educated guess what to do about them.
Adding kludges here and there is a wrong way about dealing with this
whole problem. So try to focus on a) a reliable way to detect a longterm
pin and b) provide an API that would tell the page to be released by its
current owner (ideally in two modes, async to kick the process in the
background and continue with something else and sync if there is no
other way than waiting for the pin.

-- 
Michal Hocko
SUSE Labs
