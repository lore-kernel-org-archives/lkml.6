Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247F2222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550292936;
	bh=s6BXSDzvZx9cBI2HH51THAOoHx9pAr3Qcp/4ofk4Nqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TXJ/2Ce8BrUtD/iKI0iSOLvkQHCg8o9kzE/JLrf3WzAjRDSIJcaXk4ZSEwtWTvAMo
	 NMELbH/1RK9D859NJ4sJ9YcVXB7dn8uw4VL37nFMEhNKXbfk0KQz7shI17cuDFYUC0
	 HgIEZipAMMj65PKQe5ZUBWqGglcYK196Hr1Y+gYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394549AbfBPEzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfBPEzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:55:32 -0500
Received: from localhost (c-98-234-55-98.hsd1.ca.comcast.net [98.234.55.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EAE222A1;
        Sat, 16 Feb 2019 04:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550292931;
        bh=s6BXSDzvZx9cBI2HH51THAOoHx9pAr3Qcp/4ofk4Nqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mg5yHkRxr5iX6TSWZbA0rxvizFI/LhQwnCr0gg/LCVIA3Y+UltOKB+Phd/+soMkMq
         iiEE7ka1mq/fECgEyKGpWbnDkwUse5mpqlV55qGG0LLJZuX6/MrdKyGDYiCDS/xSo8
         J5UMe++NEHWVmeRDf4wjGzIQg1TRoK+0RaQhX2CQ=
Date:   Fri, 15 Feb 2019 20:55:30 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Message-ID: <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13, Chao Yu wrote:
> On 2019/2/12 10:33, Jaegeuk Kim wrote:
> > If we met this once, let fsck.f2fs clear this only.
> > Note that, this addresses all the subtle fault injection test.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 03fea4efd64b..10a3ada28715 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> > -	else
> > -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
> I didn't get it, previously, if we didn't persist all quota file's data in
> checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
> checkpoint, we have persisted all quota file's data, quota files are consistent
> with all other files in filesystem, why we can't remove this NEED_FSCK flag..?

I said it's subtle. So, I guessed 1) set CP_QUOTA_NEED_FSCK_FLAG, 2) clear
SBI_QUOTA_SKIP_FLUSH by checkpoint, 3) clear CP_QUOTA_NEED_FSCK_FLAG by another
checkpoint?

> 
> Thanks,
> 
> >  
> >  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> > 
