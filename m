Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBE921773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550646538;
	bh=IFnUcyDuAnFNqfxqW5n/HL0IVX1vVPvJ82glCTbtQUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qlJAxHt2TZvoXGcY1rQC4AcyHGSZz6QczM8VDCNG+Zz5jyDW8Oqu3glUKKlPUXK+5
	 n+//AEh0HrqPXZROw7WYI5gowfAWXFWSRf3IQecMZRh29zricwym0m3sPzaI8Si/kk
	 SQTQMs8WkQkw917VVLsmCM/6n+57WIfdgIPwbBk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfBTHI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTHI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:08:56 -0500
Received: from localhost (c-98-234-55-98.hsd1.ca.comcast.net [98.234.55.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293BD20449;
        Wed, 20 Feb 2019 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550646536;
        bh=IFnUcyDuAnFNqfxqW5n/HL0IVX1vVPvJ82glCTbtQUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6EXB+gPf0iR9ANLnaK70E7sy8bsZsfa+0SavLIRLT4EBragvPTMkri5bXRBXANVA
         xwHyr0BL3oW7l/FZcFl9DjJRICZlmwo04Q7cq3YF8AiHHL/Fc+num/OMAeskwpobbn
         cNnAP8xHvWBrEGzh7HpojxylPaP7QtczaWqOeijQ=
Date:   Tue, 19 Feb 2019 23:08:55 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Message-ID: <20190220070855.GA91331@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
 <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
 <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18, Chao Yu wrote:
> On 2019/2/16 12:55, Jaegeuk Kim wrote:
> > On 02/13, Chao Yu wrote:
> >> On 2019/2/12 10:33, Jaegeuk Kim wrote:
> >>> If we met this once, let fsck.f2fs clear this only.
> >>> Note that, this addresses all the subtle fault injection test.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/checkpoint.c | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>> index 03fea4efd64b..10a3ada28715 100644
> >>> --- a/fs/f2fs/checkpoint.c
> >>> +++ b/fs/f2fs/checkpoint.c
> >>> @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>>  
> >>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>> -	else
> >>> -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>
> >> I didn't get it, previously, if we didn't persist all quota file's data in
> >> checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
> >> checkpoint, we have persisted all quota file's data, quota files are consistent
> >> with all other files in filesystem, why we can't remove this NEED_FSCK flag..?
> > 
> > I said it's subtle. So, I guessed 1) set CP_QUOTA_NEED_FSCK_FLAG, 2) clear
> 
> I know it's subtle... and I agreed we can fix it like this in upstream
> first, but in our product, it's not rare that we hit the
> QUOTA_SKIP_FLUSH(its value is 4) case, later we may encounter long latency
> caused by quota repairing of fsck.
> 
> > SBI_QUOTA_SKIP_FLUSH by checkpoint, 3) clear CP_QUOTA_NEED_FSCK_FLAG by another
> > checkpoint?
> 
> But later if QUOTA_NEED_REPAIR is set, we will set QUOTA_NEED_FSCK_FLAG
> again, right?
> 
> if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> 	__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
> 
> So in order to figure out whether this is caused by out-of-order execution
> of below assignments:
> 
> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 	else
> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- clear flag later
> 
> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- set flag first
> 
> 
> Could you have a try:
> 
> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR) ||
> 			is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 	else
> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);

What does this mean? I'm in doubt we have a missing case where we clear this
flag, CP_QUOTA_NEED_FSCK_FLAG.

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>  
> >>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>>
> > 
> > .
> > 
