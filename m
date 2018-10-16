Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE32098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9YiBh1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DE32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJPK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbeJPK7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:59:03 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D44208D9;
        Tue, 16 Oct 2018 03:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539659453;
        bh=E/iZ0FmyrEqaF37xXTNS/sY376KEPJAx5XaAkCClr/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9YiBh1dvgc0j0vt0KcvXfhZOKW88LqMOHYkm12+uiRHspeUKqyCbPikdPzO07A/E
         DpGA32xcQVlk6Z/ESt7uGwA6Ox5q4FqD7H7Nhk4VtqKZMYDxQIbOkNk+xoQKGJAgjn
         GLCzUtYSgUp3aXB0Lv+MHDcJF5zCb0g3Cu7cYo6U=
Date:   Mon, 15 Oct 2018 20:10:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
Message-ID: <20181016031052.GA19956@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
 <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
 <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16, Chao Yu wrote:
> On 2018/10/16 7:08, Jaegeuk Kim wrote:
> > On 10/15, Chao Yu wrote:
> >> On 2018/10/11 5:22, Jaegeuk Kim wrote:
> >>> If we clear the cold data flag out of the writeback flow, we can miscount
> >>> -1 by end_io.
> >>
> >> I didn't get it, which count do you mean?
> > 
> > It's the number of dirty pages.
> > 
> > Balancing F2FS Async:
> >   - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0
> > 
> 
> So I guess the race should be:
> 
> GC thread:				IRQ
> - move_data_page()
>  - set_page_dirty()
>   - clear_cold_data()
> 					- f2fs_write_end_io()
> 					 - type = WB_DATA_TYPE(page);
> 					   here, we get wrong type
> 					 - dec_page_count(sbi, type);
>  - f2fs_wait_on_page_writeback()
> 
> How about relocate wait_writeback & set_page_dirty to avoid above race:

Well, wait_on_stable_page() doesn't guarantee its end_io. So, I'm not sure
this is the only case.

> 
> move_data_page()
> 
> retry:
> 		f2fs_wait_on_page_writeback(page, DATA, true);
> 		set_page_dirty(page);
> 
> Thanks,
> 
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/data.c | 4 ----
> >>>  1 file changed, 4 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 29a9d3b8f709..4102799b5558 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
> >>>  	if (!PageUptodate(page))
> >>>  		SetPageUptodate(page);
> >>>  
> >>> -	/* don't remain PG_checked flag which was set during GC */
> >>> -	if (is_cold_data(page))
> >>> -		clear_cold_data(page);
> >>> -
> >>>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
> >>>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
> >>>  			f2fs_register_inmem_page(inode, page);
> >>>
> > 
> > .
> > 
