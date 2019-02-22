Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E40C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C4120836
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550803262;
	bh=zgZODAaN3JFe/+ySn9/5dnZavkUPHoDISxeUU0mz/Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JKkPdiOUtjw/qWY9ssgeleiFc7XatO/Ki6NmhsnDerSd+FhNuc+uy56R828f7QG3n
	 sMcITMsm2Gqac5NuRurJdlvl3QyeHO305Dw1MJhuuzM5duoeJZ/lxjvdVaHYndd4p5
	 oBWqjRQg0U7OrWTGmyOt/c+h62Cx6C1fXQruofl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBVClB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfBVClA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:41:00 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555CA207E0;
        Fri, 22 Feb 2019 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550803259;
        bh=zgZODAaN3JFe/+ySn9/5dnZavkUPHoDISxeUU0mz/Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTItYop3fBCrD+rGkddHl2Esidl1U5F0vvGK319u7Ypk43fpUet41JX+OX4Jn3HGv
         vH61XT7eHmp7TS0E10HCoc1MFzqMWEUdkLsu/T9vR09gjVtfLXrI3wiZT1jei2CYPK
         6qUEK5RBIEqopBCmu7wyIT4MXPaG1CFgO8fcQwTE=
Date:   Thu, 21 Feb 2019 18:40:58 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Message-ID: <20190222024058.GA6093@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
 <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
 <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
 <20190220070855.GA91331@jaegeuk-macbookpro.roam.corp.google.com>
 <c39a995f-9bfd-e68a-7d04-11bd8c0f8e64@huawei.com>
 <7580aa2e-b2eb-a686-a19d-4e82a713944a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7580aa2e-b2eb-a686-a19d-4e82a713944a@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20, Chao Yu wrote:
> On 2019/2/20 15:25, Chao Yu wrote:
> > On 2019/2/20 15:08, Jaegeuk Kim wrote:
> >> On 02/18, Chao Yu wrote:
> >>> On 2019/2/16 12:55, Jaegeuk Kim wrote:
> >>>> On 02/13, Chao Yu wrote:
> >>>>> On 2019/2/12 10:33, Jaegeuk Kim wrote:
> >>>>>> If we met this once, let fsck.f2fs clear this only.
> >>>>>> Note that, this addresses all the subtle fault injection test.
> >>>>>>
> >>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>> ---
> >>>>>>  fs/f2fs/checkpoint.c | 2 --
> >>>>>>  1 file changed, 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>>>>> index 03fea4efd64b..10a3ada28715 100644
> >>>>>> --- a/fs/f2fs/checkpoint.c
> >>>>>> +++ b/fs/f2fs/checkpoint.c
> >>>>>> @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>>>>>  
> >>>>>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >>>>>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>>>>> -	else
> >>>>>> -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>>>>
> >>>>> I didn't get it, previously, if we didn't persist all quota file's data in
> >>>>> checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
> >>>>> checkpoint, we have persisted all quota file's data, quota files are consistent
> >>>>> with all other files in filesystem, why we can't remove this NEED_FSCK flag..?
> >>>>
> >>>> I said it's subtle. So, I guessed 1) set CP_QUOTA_NEED_FSCK_FLAG, 2) clear
> >>>
> >>> I know it's subtle... and I agreed we can fix it like this in upstream
> >>> first, but in our product, it's not rare that we hit the
> >>> QUOTA_SKIP_FLUSH(its value is 4) case, later we may encounter long latency
> >>> caused by quota repairing of fsck.
> >>>
> >>>> SBI_QUOTA_SKIP_FLUSH by checkpoint, 3) clear CP_QUOTA_NEED_FSCK_FLAG by another
> >>>> checkpoint?
> >>>
> >>> But later if QUOTA_NEED_REPAIR is set, we will set QUOTA_NEED_FSCK_FLAG
> >>> again, right?
> >>>
> >>> if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >>> 	__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>>
> >>>
> >>> So in order to figure out whether this is caused by out-of-order execution
> >>> of below assignments:
> >>>
> >>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>> 	else
> >>> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- clear flag later
> >>>
> >>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- set flag first
> >>>
> >>>
> >>> Could you have a try:
> >>>
> >>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR) ||
> >>> 			is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>> 	else
> >>> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>
> >> What does this mean? I'm in doubt we have a missing case where we clear this
> > 
> > Cpu pipeline / compiler can make code out-of-order execution, which means:
> > 
> > a = 1;
> > b = 2;
> > 
> > may actually be executed as the order of:
> > 
> > b = 2;
> > a = 1;
> > 
> > So I doubt that below two line codes can be executed out-of-order:
> > 
> > else
> > 	__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- clear flag later
> > 
> > if ()
> > 	__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- set flag first

In spin_lock_irqsave()?

> > 
> >> flag, CP_QUOTA_NEED_FSCK_FLAG.
> > 
> > Agreed, I've checked each operation in f2fs_quota_operations yesterday, and
> > didn't find any missing places yet...
> 
> Oh, I mean the place where set SBI_QUOTA_NEED_REPAIR, I also doubt we
> missed to set the flag.

So, I may need to keep this patch untill we find the missing case. I'll keep an
eye on this.

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>>>  
> >>>>>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> >>>>>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> >>>>>>
> >>>>
> >>>> .
> >>>>
> >>
> >> .
> >>
> > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 
