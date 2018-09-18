Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B1ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08D20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H32i6pp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE08D20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeIRXdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbeIRXdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:20 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7532150B;
        Tue, 18 Sep 2018 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537293576;
        bh=7vVisbRMCYP1MJO580mq9JPVWUdCtXsngIMmRps12zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H32i6pp/HWA8GNVd79JqtLIb+3JrO0xowMaLrPQ3Al1VPeamFO9SEE23YrwOBKLvA
         brgI1mWbEmulvOaCcZ/8lAgCJdhqOag6NA0GeX5WNZnT4q0ToaoQjxvqJ8Sif3/A2Y
         aurRsQp9YZO8nq/qCp2obE23aCuQP7YHEhMnDS58=
Date:   Tue, 18 Sep 2018 10:59:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Message-ID: <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18, Chao Yu wrote:
> On 2018/9/18 10:18, Jaegeuk Kim wrote:
> > This fixes wrong error report in f2fs_rename.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 98d3ab7c3ce6..d653be777529 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  	struct f2fs_dir_entry *old_entry;
> >  	struct f2fs_dir_entry *new_entry;
> >  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
> > -	int err = -ENOENT;
> > +	int err;
> >  
> >  	if (unlikely(f2fs_cp_error(sbi)))
> >  		return -EIO;
> > @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  	if (err)
> >  		goto out;
> >  
> > +	err = -ENOENT;
> 
> I didn't get what's the difference after moving initialization of 'err' here...

One example,

        old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
        if (!old_entry) {
                if (IS_ERR(old_page))
                        err = PTR_ERR(old_page);

--> need to return ENOENT instead of 0.

                goto out;
        }

> 
> Thanks,
> 
> >  	if (new_inode) {
> >  		err = dquot_initialize(new_inode);
> >  		if (err)
> > 
