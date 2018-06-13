Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3491CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE074208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E1kLVJJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE074208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935882AbeFMOnN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:43:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935659AbeFMOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gCMIa6LrUFwA/fPPVQGX09Ds0bK0BxkJ0ZP5+Ww61W4=; b=E1kLVJJ/S0UiSryGTawx1bPsAc
        TTBeIqkGNCA+coXs7xySB86UEn1667R3PRNeVSK7Sh1zM6+ykMnyXAG27KLRw2san64KSigcC4+3D
        zgR0AT+fv1sjn2bedihd/btw5tRrjybocWY26lVnjhSQJKdjWiVgvII19L6VZwrMrYzKC9wGe6KA5
        06qIFFCoSVR5LwFy9yLBd3hFsPXSqBV0WfzTUy5Gw4PxItJs7ywZCalwygae8vTKl5Aytnv4tOijX
        UpScNrxq2XNBAdr+AZSUaGtgDH/zyDnyAtJm6pGAVOXx3SJuWcnXHXulcSVFsLdbhD+ficXvt6GjF
        M3YvwBtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT6z7-0004e5-DZ; Wed, 13 Jun 2018 14:42:53 +0000
Date:   Wed, 13 Jun 2018 07:42:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180613144253.GA4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
 <20180612034242.GC26412@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180612034242.GC26412@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:42:49AM +0800, Ming Lei wrote:
> On Mon, Jun 11, 2018 at 09:48:06AM -0700, Christoph Hellwig wrote:
> > І think the new naming scheme in this series is a nightmare.  It
> > confuses the heck out of me, and that is despite knowing many bits of
> > the block layer inside out, and reviewing previous series.
> 
> In V5, there isn't such issue, since bio_for_each_segment* is renamed
> into bio_for_each_page* first before doing the change.

But now we are at V6 where that isn't the case..

> Seems Jens isn't fine with the big renaming, then I follow the suggestion
> of taking 'chunk' for representing multipage bvec in V6.

Please don't use chunk.  We are iterating over bio_vec structures, while
we have the concept of a chunk size for something else in the block layer,
so this just creates confusion.  Nevermind names like
bio_for_each_chunk_segment_all which just double the confusion.

So assuming that bio_for_each_segment is set to stay as-is for now,
here is a proposal for sanity by using the vec name.

OLD:	    bio_for_each_segment
NEW(page):  bio_for_each_segment, to be renamed bio_for_each_page later
NEW(bvec):  bio_for_each_bvec

OLD:	    __bio_for_each_segment
NEW(page):  __bio_for_each_segment, to be renamed __bio_for_each_page later
NEW(bvec):  (no bvec version needed)

OLD:	    bio_for_each_segment_all
NEW(page):  bio_for_each_page_all (needs updated prototype anyway)
NEW(bvec):  (no bvec version needed once bcache is fixed up)	
