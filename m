Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59598C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D402087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549299577;
	bh=dOQ/GgSznbfCaSbOEp5h0wJVN9uLWyKcj4S7kNNB/9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kAhm8uxUSeq7b74XBmmGrvBsAkv9XpZMyUZxHr+d/2yNlhnKFYfc99L3COr5Z8je6
	 KWWEDaLE0SCcaRf2c3X+0TxkvTSJrw23s4JjgHNfUSheRN9Fkhg3oKCPo06LKD7+AW
	 KY9MGJElRpLTKSs0kAkokHjrkiaRVGLPiilDHx5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfBDQ7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfBDQ7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:59:35 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02A220815;
        Mon,  4 Feb 2019 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549299574;
        bh=dOQ/GgSznbfCaSbOEp5h0wJVN9uLWyKcj4S7kNNB/9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWKWcv9iHLxL1w2JWH4q1PUZhRkULfON/H1iuKGeCsANvp9c6/beqZb0ekgqU4F3b
         XxOrbm773KudJBzF1lqrDF8Bzrhuv8Z8WZHlGx2dPg+XTDK0eddu1B62az3CqVWQW4
         vAQTIWKsoSq9/H50+yy4keLhqKMnfgOt0Fdyw4Y0=
Date:   Mon, 4 Feb 2019 08:59:34 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 6/7] f2fs: flush quota blocks after turnning
 it off
Message-ID: <20190204165934.GB15646@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-6-jaegeuk@kernel.org>
 <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02, Chao Yu wrote:
> On 2019-1-29 7:47, Jaegeuk Kim wrote:
> > After quota_off, we'll get some dirty blocks. If put_super don't have a chance
> > to flush them by checkpoint, it causes NULL pointer exception in end_io after
> > iput(node_inode). (e.g., by checkpoint=disable)
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/super.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 5e1f8573a17f..7694cb350734 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2026,6 +2026,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
> >  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> >  		}
> >  	}
> > +	/*
> > +	 * In case of checkpoint=disable, we must flush quota blocks.
> 
> checkpoint=disable is one of the cases, right? e.g. IO error can be another case?
> 
> So here I guess we need to change the comments a bit for that.

I didn't test other cases, but checkpoint=disable could give real errors through
some tests. So, basically, I'd like to keep known cases only here.

> 
> Thanks,
> 
> > +	 * This can cause NULL exception for node_inode in end_io, since
> > +	 * put_super already dropped it.
> > +	 */
> > +	sync_filesystem(sb);
> >  }
> >  
> >  static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
> > 
