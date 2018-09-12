Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B5C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CBB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnKKx336"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CBB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeIMA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeIMA5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:57:03 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C8420833;
        Wed, 12 Sep 2018 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536781857;
        bh=NSC820FZYkSNQXi1kkgtpeRk7BbeFsOUBVNTgKP0YZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnKKx336Ay+DcEnS6P+m1p3Ks2TRU/OyKtMFr3k2mf+GDb2zxoMtSq2Bi+SCh+uW1
         Kvz8RQXCWoo0WwXMt/a0eQoDM2X4qnHENhsCz+4IWS7zHmvJohA7378LwGPt10QvE/
         etjUgxf+n3iaFjF5xHyh8K8vwv6yecp/HtMmnwDc=
Date:   Wed, 12 Sep 2018 12:50:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Message-ID: <20180912195056.GA8356@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
 <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
 <20180912012550.GA71953@jaegeuk-macbookpro.roam.corp.google.com>
 <ffbfbc85-f7ac-dd5c-b20f-d08868adb4ee@huawei.com>
 <20180912024601.GA75537@jaegeuk-macbookpro.roam.corp.google.com>
 <cc6216bf-a9b9-01de-b9be-5186a228d512@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6216bf-a9b9-01de-b9be-5186a228d512@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12, Chao Yu wrote:
> On 2018/9/12 10:46, Jaegeuk Kim wrote:
> > On 09/12, Chao Yu wrote:
> >> On 2018/9/12 9:25, Jaegeuk Kim wrote:
> >>> On 09/12, Chao Yu wrote:
> >>>> On 2018/9/12 8:27, Jaegeuk Kim wrote:
> >>>>> On 09/11, Jaegeuk Kim wrote:
> >>>>>> On 09/12, Chao Yu wrote:
> >>>>>>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
> >>>>>>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
> >>>>>>>> can recover it based on previous user information.
> >>>>>>>
> >>>>>>> I didn't get it, both fsck and kernel recover quota file based all inodes'
> >>>>>>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
> >>>>>>> same?
> >>>>>>
> >>>>>> I thought that, but had to add this, since I was encountering quota errors right
> >>>>>> after getting some files recovered. And, I thought it'd make it more safe to do
> >>>>>> fsck after roll-forward recovery.
> >>>>>>
> >>>>>> Anyway, let me test again without this patch for a while.
> >>>>>
> >>>>> Hmm, I just got a fsck failure right after some files recovered.
> >>>>
> >>>> To make sure, do you test with "f2fs: guarantee journalled quota data by
> >>>> checkpoint"? if not, I think there is no guarantee that f2fs can recover
> >>>> quote info into correct quote file, because, in last checkpoint, quota file
> >>>> may was corrupted/inconsistent. Right?
> >>
> >> Oh, I forget to mention that, I add a patch to fsck to let it noticing
> >> CP_QUOTA_NEED_FSCK_FLAG flag, and by default, fsck will fix corrupted quote
> >> file if the flag is set, but w/o this flag, quota file is still corrupted
> >> detected by fsck, I guess there is bug in v8.
> >>
> >> Can you add that in fsck too? so we can separate real kernel bug and quota
> >> file corruption due to dquot subsystem error caused like below case:
> > 
> > I'm testing to trigger fsck when it sees the below flag. But, when considering
> > old f2fs-tools, we may need a way to detect mkfs version in superblock in order
> 
> Oh, that will make kernel be complicated... kernel should be aware of user
> space things... if user use old tools and new kernel, how about just let
> kernel give warning on dmesg to user to upgrade f2fs tool set.
> 
> And also, even if w/o CP_FSCK_FLAG, fsck can also detect such quote file
> corruption, then do repair, right?

It requires scanning the directory tree, which doesn't make sense.

> 
> Thanks,
> 
> > to determine whether we can rely on this new flag or not.
> > 
> >>
> >> +static int f2fs_dquot_acquire(struct dquot *dquot)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = dquot_acquire(dquot);
> >> +	if (ret == -ENOSPC || ret == -EIO)
> >> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> >> +	return ret;
> >> +}
> >>
> >>>
> >>> I hit the failure with v8. And, the test scenario is 1) enable fault injection
> >>> 2) run fsstress, 3) call shutdowon, 4) kill fsstress, 5) unmount, 6) fsck, 7)
> >>> mount, 8) fsck, 9) go 1).
> >>>
> >>> So, I'm hitting failure in 8) fsck. I expect 6) fsck should fix any corruption
> >>> and 7) recovered some files on clean checkpoint.
> >>
> >> I see, I can add this case too, does this exist in your xfstest tree in github?
> > 
> > I think so.
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>>>> ---
> >>>>>>>>  fs/f2fs/recovery.c | 3 +++
> >>>>>>>>  1 file changed, 3 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >>>>>>>> index 95511ed11a22..1fde86a2107e 100644
> >>>>>>>> --- a/fs/f2fs/recovery.c
> >>>>>>>> +++ b/fs/f2fs/recovery.c
> >>>>>>>> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >>>>>>>>  
> >>>>>>>>  	need_writecp = true;
> >>>>>>>>  
> >>>>>>>> +	/* quota is not fully updated due to the lack of user information. */
> >>>>>>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>>>>>> +
> >>>>>>>>  	/* step #2: recover data */
> >>>>>>>>  	err = recover_data(sbi, &inode_list, &dir_list);
> >>>>>>>>  	if (!err)
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> _______________________________________________
> >>>>>> Linux-f2fs-devel mailing list
> >>>>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>>>>
> >>>>> .
> >>>>>
> >>>
> >>> .
> >>>
> > 
> > .
> > 
