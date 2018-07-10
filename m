Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E5820BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2F6zU+zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E5820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeGJUyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732313AbeGJUxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:53:51 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0AC208FA;
        Tue, 10 Jul 2018 20:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531255984;
        bh=DdkiVY/sJkxzFIYcqicNsyLf3Lb815x9ZXy+3gPLOvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2F6zU+zY/Mnk2jQDObLT2Zuxcsj1wUJXu8Wkr6X/qclEs4/A9zytlIjkyiD1TB8q1
         WvWmJxGrCa6c2F4TjtWBzYuafdH/FlBlb9ZrMncf17hl2kbLFmB3J2ZAi3s49zzeYb
         o+E8wUejzkkfZg4+iUjgKQXIBUWBkbto2CGeBHhk=
Date:   Tue, 10 Jul 2018 13:53:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: should check the type of end_io
 after pullback by fscrypto
Message-ID: <20180710205302.GB79040@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-4-jaegeuk@kernel.org>
 <d09dbae7-8073-1df6-e7ab-a0241c4023ff@kernel.org>
 <20180710204329.GA79040@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710204329.GA79040@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Jaegeuk Kim wrote:
> On 07/09, Chao Yu wrote:
> > On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > > This fixes to get the page type after pullback by fscrypto, since the original
> > > page is bounce page but we should need to get control page which is what we
> > > originally submitted.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/data.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index c3f9b9baf140..9a0fcec53d0e 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
> > >  
> > >  	bio_for_each_segment_all(bvec, bio, i) {
> > >  		struct page *page = bvec->bv_page;
> > > -		enum count_type type = WB_DATA_TYPE(page);
> > >  
> > >  		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> > >  			set_page_private(page, (unsigned long)NULL);
> > > @@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
> > >  
> > >  		if (unlikely(bio->bi_status)) {
> > >  			mapping_set_error(page->mapping, -EIO);
> > > -			if (type == F2FS_WB_CP_DATA)
> > > +			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
> > >  				f2fs_stop_checkpoint(sbi, true);
> > >  		}
> > >  
> > >  		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
> > >  					page->index != nid_of_node(page));
> > >  
> > > -		dec_page_count(sbi, type);
> > > +		dec_page_count(sbi, WB_DATA_TYPE(page));
> > 
> > But we account F2FS_WB_CP_DATA/F2FS_WB_DATA type page based bounce page instead
> > of original page.
> > 
> > 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> > 
> > 	/* set submitted = true as a return value */
> > 	fio->submitted = true;
> > 
> > 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> > 
> > Because for encrypted page of regular inode, we should account it with
> > F2FS_WB_DATA type:
> > 
> > static bool __is_cp_guaranteed(struct page *page)
> > {
> > ....
> > 	if (!mapping)   <---bounce page's mapping is NULL
> > 		return false;
> > }
> > 
> > So we will get F2FS_WB_DATA type from __is_cp_guaranteed below:
> > 
> > enum count_type type = WB_DATA_TYPE(page);
> > 
> > Is there any problem?
> 
> Wait a minute.
> 
> 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> 
> 1. fio->encrypted_page
> 
> 	inc_page_count(sbi, F2FS_WB_CP_DATA); // page->mapping == META_MAPPING
> 
>   In write_end_io(),
> 	type = F2FS_WB_DATA; // page->mapping == NULL
> 	fscrypt_pullback_bio_page(&page);
> 	  page = fio->encrypted_page;
> 	
> 	dec_page_count(F2FS_WB_DATA);
> 
> 2. fio->page
> 
> 	inc_page_count(sbi, F2FS_WB_DATA);
> 
>   In write_end_io(),
> 	type = F2FS_WB_DATA; // page->mapping == NULL
> 	fscrypt_pullback_bio_page(&page);
> 	  page = fio->encrypted_page;
> 	
> 	dec_page_count(F2FS_WB_DATA);
> 
> Thoughts?

Oops, nvm. I was confused. :P

> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
