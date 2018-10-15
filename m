Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8105C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E989208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="khB6cqPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E989208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJPGvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeJPGvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:51:20 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FED0208E4;
        Mon, 15 Oct 2018 23:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539644638;
        bh=qzswFBWiEDSIuN1OdiXSglnTMnFg7LQ+OLFnKJ1FERA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khB6cqPEGCjCJOgWqBWlwjT1gtKVqgGsI8d/NEgN1d0F2M9Pe4/DO1c2FKxyhjHBF
         JW1zmtv+jaVPyqzMDOQ61PhEstUJpjFDI/Y1oSe1PENwakjY1gaawAylpG5YJDu8wF
         x8MfD98C2NaH6Zajcc5BJJZeJE4GGt3sF5SPy2zc=
Date:   Mon, 15 Oct 2018 16:03:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
Message-ID: <20181015230357.GA1296@jaegeuk-macbookpro.roam.corp.google.com>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
 <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
 <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15, Chao Yu wrote:
> On 2018/10/5 13:17, Sahitya Tummala wrote:
> > Update REQ_TIME in the missing path - f2fs_cross_rename().
> 
> Needs to cover f2fs_rename() as well?

Hi, I've added this in f2fs_rename().

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/namei.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index a146327..e37af23 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  
> >  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
> >  		f2fs_sync_fs(sbi->sb, 1);
> > +
> > +	f2fs_update_time(sbi, REQ_TIME);
> >  	return 0;
> >  out_new_dir:
> >  	if (new_dir_entry) {
> > 
