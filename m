Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ABC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C77F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+ZcwxDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeILF2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeILF2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:28:49 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3457B20866;
        Wed, 12 Sep 2018 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536712022;
        bh=NhiAJndirvsdt/JuZPqMjuTdkkBPWNe7HSIT4nq4xOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+ZcwxDK6ME0XC/P45Fcg4dqBq3uyX5UIV7WQe1vOaa/vbu75IaPDHIAMYej7nBmz
         Rxerez+pyhEZSvDzD8yNF7BiqoQlQdCEuv+P7+unTXgkzBCJzTxHK2MyipSQr294ml
         w+xC7r0NFx6GbrmoFltclId/cye8RDqYOAA3uKwg=
Date:   Tue, 11 Sep 2018 17:27:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Message-ID: <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Jaegeuk Kim wrote:
> On 09/12, Chao Yu wrote:
> > On 2018/9/12 4:15, Jaegeuk Kim wrote:
> > > fsck.f2fs is able to recover the quota structure, since roll-forward recovery
> > > can recover it based on previous user information.
> > 
> > I didn't get it, both fsck and kernel recover quota file based all inodes'
> > uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
> > same?
> 
> I thought that, but had to add this, since I was encountering quota errors right
> after getting some files recovered. And, I thought it'd make it more safe to do
> fsck after roll-forward recovery.
> 
> Anyway, let me test again without this patch for a while.

Hmm, I just got a fsck failure right after some files recovered.

> 
> Thanks,
> 
> 
> > 
> > Thanks,
> > 
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/recovery.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > > index 95511ed11a22..1fde86a2107e 100644
> > > --- a/fs/f2fs/recovery.c
> > > +++ b/fs/f2fs/recovery.c
> > > @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> > >  
> > >  	need_writecp = true;
> > >  
> > > +	/* quota is not fully updated due to the lack of user information. */
> > > +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > +
> > >  	/* step #2: recover data */
> > >  	err = recover_data(sbi, &inode_list, &dir_list);
> > >  	if (!err)
> > > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
