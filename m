Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA7B218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546634033;
	bh=HFbeVEBBH8mHHg9ByR8e4NrlYagJDAu1k42UFOLaS+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x5EPrUu5iDeil3lAeGr8pMUN1OqEQhfSQ79gnrRHMostR5SHkoNwjgKN227+nqG+t
	 d/mNociSAcxs780SBRXAjTCenU2j653l8mlYCNOfVWfmpDipIYfPYUdQxkOTRHKrxC
	 2EW2pA9AmADQ+i1kkhuJmHnvBT8Dbg5h+qa1VXp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfADUdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfADUdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:33:51 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42EF218D3;
        Fri,  4 Jan 2019 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546634030;
        bh=HFbeVEBBH8mHHg9ByR8e4NrlYagJDAu1k42UFOLaS+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oiu5zLxTn1xDlydaCv00IrMh42Cz5knadOVbQQXus2gIYbmkNkaQ2zr8yFIVTnGBH
         wMZN/kRYSK7udd8LojikEk4Lipqo/36KSDDvinqtatYF8Ve9e8sghqxlfX13FmRFJO
         Yog46IARnEHzlNpkQSn8PV3NMEONPsCw4Ail8hoI=
Date:   Fri, 4 Jan 2019 12:33:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: export pin_file flag to user
Message-ID: <20190104203350.GB57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104041945.31802-1-jaegeuk@kernel.org>
 <444eef3d-78eb-7c17-b44c-0ab310fb7c7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444eef3d-78eb-7c17-b44c-0ab310fb7c7b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Chao Yu wrote:
> On 2019/1/4 12:19, Jaegeuk Kim wrote:
> > This exports pin_file status to user.
> 
> Semantics of pin_file flag is the same as nocow flag which is more widely
> used in lsattr/chattr and vfs now.
> 
> #define FS_NOCOW_FL                     0x00800000 /* Do not cow file */
> 
> lsattr/chattr
> no copy on write (C)
> 
> How about exporting it via F2FS_NOCOW_FL(0x00800000)?

Yeah, let me send v2.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 3 ++-
> >  fs/f2fs/file.c | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 12fabd6735dd..036fd62010c1 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2303,9 +2303,10 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
> >  #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> >  #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> >  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > +#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
> >  #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
> >  
> > -#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
> > +#define F2FS_FL_USER_VISIBLE		0x704BDFFF /* User visible flags */
> >  #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
> >  
> >  /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index ae2b45e75847..eb099f1ee937 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
> >  		flags |= F2FS_ENCRYPT_FL;
> >  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
> >  		flags |= F2FS_INLINE_DATA_FL;
> > +	if (is_inode_flag_set(inode, FI_PIN_FILE))
> > +		flags |= F2FS_PIN_FILE_FL;
> >  
> >  	flags &= F2FS_FL_USER_VISIBLE;
> >  
> > 
