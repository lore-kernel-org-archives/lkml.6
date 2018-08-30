Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59182082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGyyrN2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59182082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeH3IDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbeH3IDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:03:40 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB9820645;
        Thu, 30 Aug 2018 04:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535601812;
        bh=spXq0k/TTztPcElXFts51ibUhTyZgqwDQDyGu/Pfykg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGyyrN2IQG2nhVxhuPqkxiANmy5z7bCOL+y52VdZwAc2qHAQbz5LpEDBt+mrUFWJc
         rcav49lK5lsUsQwSEEjxJJ6/dR0eKLyGWm2qHc9y7ufZrZ6TaBrp2q5gFM81wU7GBz
         fH++ZyFQURqfpRxy/8IfzElBs4swPe/zB9cGB8YM=
Date:   Wed, 29 Aug 2018 21:03:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: avoid wrong decrypted data from disk
Message-ID: <20180830040331.GA97850@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
 <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
 <ac310f4d-8ad8-bfd9-97f3-66e786f0f51e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac310f4d-8ad8-bfd9-97f3-66e786f0f51e@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Chao Yu wrote:
> On 2018/8/30 9:48, Jaegeuk Kim wrote:
> > 1. Create a file in an encrypted directory
> > 2. Do GC & drop caches
> > 3. Read stale data before its bio for metapage was not issued yet
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > Change log from v1:
> >  - move to bio != NULL
> > 
> >  fs/f2fs/data.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 382c1ef9a9e4..159e411785e9 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1556,6 +1556,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
> >  				bio = NULL;
> >  				goto set_error_page;
> >  			}
> > +		} else if (unlikely(f2fs_encrypted_file(inode))) {
> 
> For android scenario, encryption becomes a common case now, so I think we can
> remove unlikely here.
> 
> > +			/*
> > +			 * If the page is under writeback, we need to wait for
> > +			 * its completion to see the correct decrypted data.
> > +			 */
> > +			f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
> >  		}
> 
> Look at this again, it seems f2fs_wait_on_block_writeback() is not related to
> f2fs_grab_read_bio(), so we can move it here to make code logic more clear:
> 
> if (f2fs_encrypted_file(inode)) {
> 	/* */
> 	f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
> }
> 
> Also, in f2fs_submit_page_read(), we need to adjust to:
> 
> - f2fs_grab_read_bio()
> - f2fs_wait_on_block_writeback()
> - bio_add_page()
> 
> How do you think?

Oh, yeah!

> 
> Thanks,
> 
> >  
> >  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
> > 
