Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A7821473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pulffLmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A7821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLCJPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:15:10 -0500
Received: from m12-12.163.com ([220.181.12.12]:46139 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeLCJPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Qpbfx
        09WsH0vUx9H/ZJVpKs7ntILqCAHmG4x4+GbK1E=; b=pulffLmJJjzQNiSl0ODUd
        GlelITUZbC3ZJbxi5YLcVIfTGKHvCozRVmOKeyVTk096WFEUkyn2MYxOdsF1mb8D
        i/OMFbyLHrY+SnbNDq5n0bepkU7PWEQDqFLTuX3wnVX8sd11x8OXiqh/y7tshx52
        2tvqpqRpD/qtw+PxXqXADM=
Received: from bp (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowAAHHtIO9ARcclOlDA--.48858S2;
        Mon, 03 Dec 2018 17:14:54 +0800 (CST)
Date:   Mon, 3 Dec 2018 17:14:55 +0800
From:   PanBian <bianpan2016@163.com>
To:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: fix potential use after free
Message-ID: <20181203091455.GA9038@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543201709-53191-1-git-send-email-bianpan2016@163.com>
 <20181203.181051.1348099310050315226.konishi.ryusuke@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203.181051.1348099310050315226.konishi.ryusuke@lab.ntt.co.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DMCowAAHHtIO9ARcclOlDA--.48858S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryUKF48Xr1UtFy5Zw43KFg_yoW8Ar1rpr
        WfK3W3CanYqa4vgF1Igr15Zw1Fqa9rtr4DGFyDG3WFyr43t3Z7KFyxKrnF9a4UAr93CrZY
        vrWjgF9F9wn5JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPKsUUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVA4SclUMGPz94AAAsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 06:10:51PM +0900, Ryusuke Konishi wrote:
> Hi, Pan Bian
> 
> Thank you for feeding back this patch.
> I reviewed this and am thinking this must be sent to upstream.
> 
> Did you see any kernel oops on this bug ?

Not yet. In fact, I found it with a static method.

Best regards,
Pan Bian

> 
> Regards,
> Ryusuke Konishi
> 
> On Mon, 26 Nov 2018 11:08:29 +0800, Pan Bian <bianpan2016@163.com> wrote:
> > brelse(bh) is called to drop the reference count of bh when the call
> > to nilfs_dat_translate fails. If the reference count hits 0, bh may be
> > freed. However, bh->b_page is unlocked and put after that, which may
> > result in a use-after-free bug. This patch moves the release operation
> > after unlocking and putting the page.
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  fs/nilfs2/gcinode.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> > index aa3c328..a24bb29 100644
> > --- a/fs/nilfs2/gcinode.c
> > +++ b/fs/nilfs2/gcinode.c
> > @@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
> >  		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
> >  
> >  		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
> > -		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
> > -			brelse(bh);
> > +		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
> >  			goto failed;
> > -		}
> >  	}
> >  
> >  	lock_buffer(bh);
> > @@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
> >   failed:
> >  	unlock_page(bh->b_page);
> >  	put_page(bh->b_page);
> > +	if (unlikely(err))
> > +		brelse(bh);
> >  	return err;
> >  }
> >  
> > -- 
> > 2.7.4
> > 
> > 

