Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3120873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544673394;
	bh=oOTa3ZHq/2F+kjTtx5ZijAQLE2SD9yD2OSl/0Zz/G5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bnz4g4Goto/98nvTuYisDWAZWU2SI/bYIZtwN/jPtKaHzelLrsCgtN2Mfg/XVO8aZ
	 ekE218Nl6JJOvp8KjpkCBF68WliizA/Rzl0YFB4uIKa3xxnPzWSLyIgtfvxeHUjHBM
	 HS5ZMWHbH84YLow45SzFoSFU8fVB4FFRDVrW7EKA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD3120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLMD4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeLMD4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:56:33 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC0F20870;
        Thu, 13 Dec 2018 03:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544673391;
        bh=oOTa3ZHq/2F+kjTtx5ZijAQLE2SD9yD2OSl/0Zz/G5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw+UkAS+gj5SSU758K+9L4f8OXYZ8XWTcwAqc1suI0HTb83GJBib4AHINVhdWloOq
         SLO65HIjJR/Iz06uIEaHNkOR6Pf2wBDmhZKlBNfEPFXFrHqbzIlJQJRroqyqjtBb11
         yLqjBBvOx8F05mNZNjVYYr7mhT+QRkrTic7N04H4=
Date:   Wed, 12 Dec 2018 19:56:31 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add an ioctl() to explicitly trigger
 fsck later
Message-ID: <20181213035631.GB33959@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181129015257.95036-1-jaegeuk@kernel.org>
 <16b92898-0d8b-8edf-17f4-36b112b25add@huawei.com>
 <20181130203611.GC71781@jaegeuk-macbookpro.roam.corp.google.com>
 <a50a7612-7429-4cc7-c9bb-56a054826a03@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50a7612-7429-4cc7-c9bb-56a054826a03@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Chao Yu wrote:
> On 2018/12/1 4:36, Jaegeuk Kim wrote:
> > On 11/30, Chao Yu wrote:
> >> On 2018/11/29 9:52, Jaegeuk Kim wrote:
> >>> This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
> >>> setting a NEED_FSCK flag.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/f2fs.h | 1 +
> >>>  fs/f2fs/file.c | 7 +++++++
> >>>  2 files changed, 8 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index aa500239baf2..7cec897146a3 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >>>  #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
> >>>  #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
> >>>  #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
> >>> +#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
> >>
> >> Why not add a new ioctl interface for this? F2FS_GOING_DOWN_ prefix implies
> >> filesystem will shutdown, IMO, we'd better to keep all sub-interfaces being
> >> consistent in f2fs_ioc_shutdown().
> > 
> > I'm thinking to use this for QA as device shutdown tests.
> > 
> >>
> >>>  
> >>>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> >>>  /*
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index ff82350a2c55..ca9bdbb8651b 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> >>>  		f2fs_stop_checkpoint(sbi, false);
> >>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >>>  		break;
> >>> +	case F2FS_GOING_DOWN_NEED_FSCK:
> >>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>> +		/* do checkpoint only */
> >>> +		ret = f2fs_sync_fs(sb, 1);
> >>> +		if (ret)
> >>> +			goto out;
> >>
> >> In large-sized image, it may take long time to trigger full scan during
> >> boot, so I'd like to ask how often we set this flag?
> > 
> > Based on the use of shutdown ioctl, I'll use this for testing purpose, so it
> > won't be used for regular cases.
> 
> How about adding some commit messages or comments on
> F2FS_GOING_DOWN_NEED_FSCK marco definition to give a bit hint for f2fs
> developers to know the usage of the interface?

Done. :P

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>> +		break;
> >>>  	default:
> >>>  		ret = -EINVAL;
> >>>  		goto out;
> >>>
> > 
> > .
> > 
