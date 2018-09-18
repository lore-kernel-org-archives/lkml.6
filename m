Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C93ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36310214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFIO+mMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36310214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeIRGtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbeIRGtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:49:06 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF8A214C5;
        Tue, 18 Sep 2018 01:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537233545;
        bh=D+PphTMl8ClUhKhmvgPCQfbIyFTLrRbekFCfNmxwVf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFIO+mMYXmk/cwQp7NXyWQrV69u5c8aspJeiqT6SZP7LlZ4ZJmMlCNThp6OvdSHSK
         ipc+fU6JgklJlDMwscyd8BaC856HSkqclRZgksGdArvb96rkaM6B/9dhwocater+ks
         jn9rHjlC957XtV2MVC8Ye7shB/nZZyqajpmnwnxg=
Date:   Mon, 17 Sep 2018 18:19:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Message-ID: <20180918011904.GB79604@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
 <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
 <20180912012550.GA71953@jaegeuk-macbookpro.roam.corp.google.com>
 <ffbfbc85-f7ac-dd5c-b20f-d08868adb4ee@huawei.com>
 <24ee1c19-ccc1-31db-12d0-30ac76fd645e@huawei.com>
 <20180912195406.GB8356@jaegeuk-macbookpro.roam.corp.google.com>
 <bbdc2ae6-591a-ffaf-ff51-e0884ef475ca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdc2ae6-591a-ffaf-ff51-e0884ef475ca@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13, Chao Yu wrote:
> On 2018/9/13 3:54, Jaegeuk Kim wrote:
> > On 09/12, Chao Yu wrote:
> >> On 2018/9/12 9:40, Chao Yu wrote:
> >>> On 2018/9/12 9:25, Jaegeuk Kim wrote:
> >>>> On 09/12, Chao Yu wrote:
> >>>>> On 2018/9/12 8:27, Jaegeuk Kim wrote:
> >>>>>> On 09/11, Jaegeuk Kim wrote:
> >>>>>>> On 09/12, Chao Yu wrote:
> >>>>>>>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
> >>>>>>>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
> >>>>>>>>> can recover it based on previous user information.
> >>>>>>>>
> >>>>>>>> I didn't get it, both fsck and kernel recover quota file based all inodes'
> >>>>>>>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
> >>>>>>>> same?
> >>>>>>>
> >>>>>>> I thought that, but had to add this, since I was encountering quota errors right
> >>>>>>> after getting some files recovered. And, I thought it'd make it more safe to do
> >>>>>>> fsck after roll-forward recovery.
> >>>>>>>
> >>>>>>> Anyway, let me test again without this patch for a while.
> >>>>>>
> >>>>>> Hmm, I just got a fsck failure right after some files recovered.
> >>>>>
> >>>>> To make sure, do you test with "f2fs: guarantee journalled quota data by
> >>>>> checkpoint"? if not, I think there is no guarantee that f2fs can recover
> >>>>> quote info into correct quote file, because, in last checkpoint, quota file
> >>>>> may was corrupted/inconsistent. Right?
> >>>
> >>> Oh, I forget to mention that, I add a patch to fsck to let it noticing
> >>> CP_QUOTA_NEED_FSCK_FLAG flag, and by default, fsck will fix corrupted quote
> >>> file if the flag is set, but w/o this flag, quota file is still corrupted
> >>> detected by fsck, I guess there is bug in v8.
> >>
> >> In v8, there are two cases we didn't guarantee quota file's consistence:
> >> 1. flush time in block_operation exceed a threshold.
> >> 2. dquot subsystem error occurs.
> >>
> >> For above case, fsck should repair the quota file by default.
> > 
> > Okay, I got another failure and it seems CP_QUOTA_NEED_FSCK_FLAG was not set
> > during the recovery. So, we have something missing in the recovery in terms
> > of quota updates.
> 
> Yeah, I checked the code, just found one suspected place:
> 
> find_fsync_dnodes()
>  - f2fs_recover_inode_page
>   - inc_valid_node_count
>    - dquot_reserve_block  dquot info is not initialized now
>  - add_fsync_inode
>   - dquot_initialize
> 
> I think we should reserve block for inode block after dquot_initialize(), can
> you confirm this?

Let me test this.

From b90260bc577fe87570b1ef7b134554a8295b1f6c Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 17 Sep 2018 18:14:41 -0700
Subject: [PATCH] f2fs: count inode block for recovered files

If a new file is recovered, we missed to reserve its inode block.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 56d34193a74b..bff5cf730e13 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -84,6 +84,11 @@ static struct fsync_inode_entry *add_fsync_inode(struct f2fs_sb_info *sbi,
 		err = dquot_alloc_inode(inode);
 		if (err)
 			goto err_out;
+		err = dquot_reserve_block(inode, 1);
+		if (err) {
+			dquot_drop(inode);
+			goto err_out;
+		}
 	}
 
 	entry = f2fs_kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
-- 
2.17.0.441.gb46fe60e1d-goog

