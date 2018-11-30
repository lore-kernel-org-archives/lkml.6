Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4FCC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4E2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0fuZqNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLAHqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeLAHqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:46:44 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FCC2082F;
        Fri, 30 Nov 2018 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543610172;
        bh=42oEnyhTsitoKWDxQeTGoLYiMOJMtMLrI1gdEw/1HHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0fuZqNcD7wd1b03wIJO6/KFld8MUDWDazq8IQ5j9EcNspOQQsk0kcJQCfieDmcqc
         vzdD0g9Ed9c0OOktvqbSTk1lIlkMJo3S2LGfxRLcrqPqDlZfs0D4Spf0QV0swnFCuL
         1S7hJtzWwHEzr2gsXWO4dBFvz8mmqiqKx8+XWIN8=
Date:   Fri, 30 Nov 2018 12:36:11 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add an ioctl() to explicitly trigger
 fsck later
Message-ID: <20181130203611.GC71781@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181129015257.95036-1-jaegeuk@kernel.org>
 <16b92898-0d8b-8edf-17f4-36b112b25add@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b92898-0d8b-8edf-17f4-36b112b25add@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30, Chao Yu wrote:
> On 2018/11/29 9:52, Jaegeuk Kim wrote:
> > This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
> > setting a NEED_FSCK flag.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 1 +
> >  fs/f2fs/file.c | 7 +++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index aa500239baf2..7cec897146a3 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >  #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
> >  #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> >  #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
> > +#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
> 
> Why not add a new ioctl interface for this? F2FS_GOING_DOWN_ prefix implies
> filesystem will shutdown, IMO, we'd better to keep all sub-interfaces being
> consistent in f2fs_ioc_shutdown().

I'm thinking to use this for QA as device shutdown tests.

> 
> >  
> >  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> >  /*
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index ff82350a2c55..ca9bdbb8651b 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> >  		f2fs_stop_checkpoint(sbi, false);
> >  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >  		break;
> > +	case F2FS_GOING_DOWN_NEED_FSCK:
> > +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +		/* do checkpoint only */
> > +		ret = f2fs_sync_fs(sb, 1);
> > +		if (ret)
> > +			goto out;
> 
> In large-sized image, it may take long time to trigger full scan during
> boot, so I'd like to ask how often we set this flag?

Based on the use of shutdown ioctl, I'll use this for testing purpose, so it
won't be used for regular cases.

> 
> Thanks,
> 
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  		goto out;
> > 
