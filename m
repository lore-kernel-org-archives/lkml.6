Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B35C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF0120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCMr4esE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF0120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeK0KVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeK0KVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:21:17 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35F2208E4;
        Mon, 26 Nov 2018 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543274730;
        bh=PF7iB6C2AhXKF3kqUaQXYATUPxfZ3B0YbXdWF+vWhwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCMr4esE3ob7kG+XTxtzfP4BNWbUsJmnNuJFybjvyk9YwK6CSXxodlhVa+OuBNCTL
         3Fhqor8TBrQYhUi9wQey0SrwAWe2rlg6eOcw+tLza1bbItiFE5FkfSMrsKom23jCZK
         aRcVHq5GE2dmtfMYrFmfRbgGekL9piwbQE0LkBzk=
Date:   Mon, 26 Nov 2018 15:25:29 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        "gongchen (E)" <gongchen4@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check memory boundary by insane namelen
Message-ID: <20181126232529.GC55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181115075040.83500-1-jaegeuk@kernel.org>
 <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Sheng Yong wrote:
> Hi, Jaegeuk and Chao,
> 
> On 2018/11/15 15:50, Jaegeuk Kim wrote:
> > If namelen is corrupted to have very long value, fill_dentries can copy
> > wrong memory area.
> > 
> Is there any scenario that could hit this corruption? Or this is triggered
> by fuzzing injection?

Hi Sheng,

It's from a fuzzing test.

Thanks,

> 
> thanks,
> Sheng Yong
> 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/dir.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index bacc667950b6..c0c845da12fa 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -808,6 +808,17 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
> >   		de_name.name = d->filename[bit_pos];
> >   		de_name.len = le16_to_cpu(de->name_len);
> > +		/* check memory boundary before moving forward */
> > +		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> > +		if (unlikely(bit_pos > d->max)) {
> > +			f2fs_msg(sbi->sb, KERN_WARNING,
> > +				"%s: corrupted namelen=%d, run fsck to fix.",
> > +				__func__, le16_to_cpu(de->name_len));
> > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> >   		if (f2fs_encrypted_inode(d->inode)) {
> >   			int save_len = fstr->len;
> > @@ -830,7 +841,6 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
> >   		if (readdir_ra)
> >   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
> > -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> >   		ctx->pos = start_pos + bit_pos;
> >   	}
> >   out:
> > 
