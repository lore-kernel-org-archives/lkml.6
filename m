Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FE321486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE0GNSme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FE321486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJTHUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeJTHUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:20:19 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5722A2098A;
        Fri, 19 Oct 2018 23:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539990733;
        bh=ewrgquPRzYvGDCPzyPdiJDETsx27Z22pQlDIH30xTMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE0GNSme0bg6ohEVd6mKwSvDiKk2y+HrG4K0PQGQEx1bIuET8bEMyvyssigfMa2Ju
         WGjipbySO30e6X0PdekSlrVH/kGt6OTyr1UUcQ9CWjcGjpUkca02HdsNbUwtMnluVf
         qsOV+2t1BtZ9lu2eqpSGm3PcITj4fG3PfFpJ0NW4=
Date:   Fri, 19 Oct 2018 16:12:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to account IO correctly
Message-ID: <20181019231212.GB11541@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181017094954.67547-1-yuchao0@huawei.com>
 <20181018190612.GD50556@jaegeuk-macbookpro.roam.corp.google.com>
 <9e586616-5cfa-5515-008c-e7bba1e3c4a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e586616-5cfa-5515-008c-e7bba1e3c4a1@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19, Chao Yu wrote:
> On 2018/10/19 3:06, Jaegeuk Kim wrote:
> > 
> > On 10/17, Chao Yu wrote:
> >> Below race can cause reversed reference on F2FS_RD_DATA, there is
> >> the same issue in f2fs_submit_page_bio(), fix them by relocate
> >> __submit_bio() and inc_page_count.
> >>
> >> Thread A			Thread B
> >> - f2fs_write_begin
> >>  - f2fs_submit_page_read
> >>  - __submit_bio
> >> 				- f2fs_read_end_io
> >> 				 - __read_end_io
> >> 				 - dec_page_count(, F2FS_RD_DATA)
> >>  - inc_page_count(, F2FS_RD_DATA)
> > 
> > Let me integrate the change into the original patch and test a bit.
> 
> IMO, it will be better to split this change into two, we can fix the
> location of inc_page_count(, F2FS_RD_DATA) directly in your patch,
> meanwhile we can add one more patch to fix the same issue in
> f2fs_submit_page_bio(), in where the problem exists for long time, it needs
> to send fixing patch to stable kernel mailing list.

How about this?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=3cca724d115fc1590c46585e264a391da06c345a
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=8e3eed6f80c9c4cfe875f995b38dde590e444dc6

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/data.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index c03bd0c2ed22..8b9240762156 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -480,10 +480,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> >>  	}
> >>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
> >>  
> >> -	__submit_bio(fio->sbi, bio, fio->type);
> >> -
> >>  	inc_page_count(fio->sbi, is_read_io(fio->op) ?
> >>  			__read_io_type(page): WB_DATA_TYPE(fio->page));
> >> +
> >> +	__submit_bio(fio->sbi, bio, fio->type);
> >>  	return 0;
> >>  }
> >>  
> >> @@ -612,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
> >>  		return -EFAULT;
> >>  	}
> >>  	ClearPageError(page);
> >> -	__submit_bio(F2FS_I_SB(inode), bio, DATA);
> >>  	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> >> +	__submit_bio(F2FS_I_SB(inode), bio, DATA);
> >>  	return 0;
> >>  }
> >>  
> >> -- 
> >> 2.18.0.rc1
> > 
> > .
> > 
