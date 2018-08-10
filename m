Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EE0C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D44223B8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz0Irsot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D44223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHJENu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeHJENu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:13:50 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15346223B7;
        Fri, 10 Aug 2018 01:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533865575;
        bh=kU7wd235Scz+aeV7FoBSwpuBjvwQgvRLEp3RECV+Bek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz0IrsotO9QOSnKj9AHeDN1u7KVbpdTO0s/3Oz36/MJvgdCgdvj4NuBWA8T+MGJAO
         dvgZIrDmjRQOhgb232QGDu75lpkdRmRuOXXt0CYJscOvF3UPYlW1EHsQM4SkmaebyS
         7CfxguKgqY6GRxL2CWHUsQYN4BUBJsOk7a/F/szU=
Date:   Thu, 9 Aug 2018 18:46:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
Message-ID: <20180810014614.GA44979@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
 <20180805163450.GB55836@jaegeuk-macbookpro.roam.corp.google.com>
 <16d7f719-268f-99f4-c5b2-fc893b557f11@huawei.com>
 <20180809195917.GA27087@jaegeuk-macbookpro.roam.corp.google.com>
 <b09cdcf8-f8cd-98b6-54c1-82b2fb0f8b81@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09cdcf8-f8cd-98b6-54c1-82b2fb0f8b81@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10, Chao Yu wrote:
> On 2018/8/10 3:59, Jaegeuk Kim wrote:
> > Yup, how about this?
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index d816c328f02b..cb510fb36523 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1052,6 +1052,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
> >  	};
> >  	unsigned long long last_skipped = sbi->skipped_atomic_files[FG_GC];
> > +	unsigned long long first_skipped;
> >  	unsigned int skipped_round = 0, round = 0;
> >  
> >  	trace_f2fs_gc_begin(sbi->sb, sync, background,
> > @@ -1064,8 +1065,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  				prefree_segments(sbi));
> >  
> >  	cpc.reason = __get_cp_reason(sbi);
> > -	sbi->skipped_gc_rwsem = 0;
> >  gc_more:
> > +	sbi->skipped_gc_rwsem = 0;
> > +	first_skipped = last_skipped;
> > +
> >  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
> >  		ret = -EINVAL;
> >  		goto stop;
> > @@ -1126,8 +1129,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  			goto gc_more;
> >  		}
> >  
> > -		if (sbi->skipped_atomic_files[FG_GC] == last_skipped &&
> > -				sbi->skipped_atomic_files[FG_GC] >
> > +		if (first_skipped < last_skipped &&
> > +				(last_skipped - first_skipped) >
> 
> IMO, it would be better to judge the condition with skipped number in all round
> of FGGC instead of last round, since number in last round may not very accurate.

Yup, moved before gc_more.

> 
> Thoughts?
> 
> Thanks,
> 
> >  						sbi->skipped_gc_rwsem) {
> >  			f2fs_drop_inmem_pages_all(sbi, true);
> >  			segno = NULL_SEGNO;
> > 
> > .
> > 
