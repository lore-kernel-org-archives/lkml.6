Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A242C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B12214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dCPQRyhE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kP3BdMoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLZE0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:26:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeLZE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:26:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E3AE460559; Wed, 26 Dec 2018 04:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545798374;
        bh=INBWUfgDEqnv0qQWLbF8qeORUOix08sGObdoIpB188c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCPQRyhEUYPgtGbe+2FaSDwrnkCzmqQK+Gj7UzmMORmlIB9+4kES1GfSvsjNxEYa1
         azO3O5hLEaDKambVA0XltuZbC84yNlmxh+rM4s3IgPH7x1WSW+Xl33zPLbLHkMJS9g
         Q82ncz6Ve6cspWoJ5Q4XTgBr02SjoaXEdtxVVZEg=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECC62604BE;
        Wed, 26 Dec 2018 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545798365;
        bh=INBWUfgDEqnv0qQWLbF8qeORUOix08sGObdoIpB188c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kP3BdMoyrSCsh+6EOyVB2Bj97FDVO2J+lBWxFjfZk6RzKIrg4sOcF/Y/cJfMWKguj
         OPVGiGW1QuRAvNEZ3GvQA1Rq5qXRk0Z35Blw4uORz6b2Rdfpkc/Jz/XVk7f+mfBy+O
         U31ZgPRdJRWZa3v9T/PpRo/XTsE7Z3hg7TJ1INrs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECC62604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 26 Dec 2018 09:56:00 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix use-after-free issue with sbi->stat_info
Message-ID: <20181226042600.GA29190@codeaurora.org>
References: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
 <0938f41e-53ed-6290-9b79-d221b1e64db6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0938f41e-53ed-6290-9b79-d221b1e64db6@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 11:06:45AM +0800, Chao Yu wrote:
> On 2018/12/24 21:06, Sahitya Tummala wrote:
> > iput() on sbi->node_inode can update sbi->stat_info
> > in the below context, if the f2fs_write_checkpoint()
> > has failed with error.
> > 
> > f2fs_balance_fs_bg+0x1ac/0x1ec
> > f2fs_write_node_pages+0x4c/0x260
> > do_writepages+0x80/0xbc
> > __writeback_single_inode+0xdc/0x4ac
> > writeback_single_inode+0x9c/0x144
> > write_inode_now+0xc4/0xec
> > iput+0x194/0x22c
> > f2fs_put_super+0x11c/0x1e8
> > generic_shutdown_super+0x70/0xf4
> > kill_block_super+0x2c/0x5c
> > kill_f2fs_super+0x44/0x50
> > deactivate_locked_super+0x60/0x8c
> > deactivate_super+0x68/0x74
> > cleanup_mnt+0x40/0x78
> > 
> > Fix this by moving f2fs_destroy_stats() further below iput().
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/super.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index e184ad4e..df41a3a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1058,9 +1058,6 @@ static void f2fs_put_super(struct super_block *sb)
> >  		f2fs_write_checkpoint(sbi, &cpc);
> >  	}
> >  
> > -	/* f2fs_write_checkpoint can update stat informaion */
> > -	f2fs_destroy_stats(sbi);
> 
> The code order in error path of fill_super is almost the same as the one of
> put_super, could you please check that as well?
> 

Thanks Chao, for pointing it out. Yes, the same issue exists in error path of
fill_super as well. I will fix it.

> Thanks,
> 
> > -
> >  	/*
> >  	 * normally superblock is clean, so we need to release this.
> >  	 * In addition, EIO will skip do checkpoint, we need this as well.
> > @@ -1080,6 +1077,12 @@ static void f2fs_put_super(struct super_block *sb)
> >  	iput(sbi->node_inode);
> >  	iput(sbi->meta_inode);
> >  
> > +	/*
> > +	 * iput() can update stat information, if f2fs_write_checkpoint()
> > +	 * above failed with error.
> > +	 */
> > +	f2fs_destroy_stats(sbi);
> > +
> >  	/* destroy f2fs internal modules */
> >  	f2fs_destroy_node_manager(sbi);
> >  	f2fs_destroy_segment_manager(sbi);
> > 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
