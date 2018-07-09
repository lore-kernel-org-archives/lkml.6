Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92118C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4220842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="njG3K6LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeGIUl1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbeGIUl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:41:26 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F812083C;
        Mon,  9 Jul 2018 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531168885;
        bh=JkY0i1ZWRxIRK5qBFHyBeBTQYYhQCYucHKPa3OxxMxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njG3K6LVUGK89/dbjdcohIpndSnUCoW1CnmsQBZeGMRaDc/OzlVl1UTQd45UhmrC+
         sObo5KmvbRCGJTUDheeiCovSHhSm8HyxRqZiH/0PyWDobscuQkCYDtamqAAavMzyis
         ifS69GliqMK/lNeone+ID7FUdPLBpJ+eIhN5vKrU=
Date:   Mon, 9 Jul 2018 13:41:25 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
Message-ID: <20180709204125.GC24534@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09, Chao Yu wrote:
> On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > This fixes to support unaligned dio as buffered writes.
> 
> Should we return -EINVAL as manual of write said:
> 
> EINVAL fd is attached to an object which is unsuitable for writing; or the file
> was opened with the O_DIRECT flag,  and  either  the  address
> specified in buf, the value specified in count, or the current file offset is
> not suitably aligned.

I came from many xfstests failures regarding to direct IO error. It seems other
filesystems allow buffered writes as well.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index e66379961804..6e8e78bb64a7 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >  
> >  	err = check_direct_IO(inode, iter, offset);
> >  	if (err)
> > -		return err;
> > +		return 0;
> >  
> >  	if (f2fs_force_buffered_io(inode, rw))
> >  		return 0;
> > 
