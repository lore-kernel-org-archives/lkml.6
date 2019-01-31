Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3AB218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935649;
	bh=QpLIguEH8m4MosZoyWdCwaIXLHvAWhHxdFGEz9spBGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vFIuPBTBOnjJ3TyYjAbvHbx+A528Fo9s2WB6018p+5+sSLdMWi3q6hWRK2pttEd99
	 AaxrhQJ/CMvjuySb04aQnou3ECfVZGL6Po59YebC6kugLV3ZHFp1lRQnvhbXfukYeE
	 0H5i8LGymZeyFLN4+2hPqgWGqzzO9P+DUXPBaXM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfAaLyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732584AbfAaLyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:54:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C262B2087F;
        Thu, 31 Jan 2019 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548935643;
        bh=QpLIguEH8m4MosZoyWdCwaIXLHvAWhHxdFGEz9spBGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVR2qN19Vms8H0gujhx/flDplZm+AUBQ9aWNlTIZhspeaqb8MoBepvR4ABqF8tGpL
         41S4kzpNEya7V4wasC/Bo/Xc2TRcKLTdObXH1X9K5jByk924Ox/E7mNRxbxpVQHuiR
         BvEqyx/YWzCnFOhBJVTJsLwZ/XhmbTVBUJ4DaDXs=
Date:   Thu, 31 Jan 2019 12:54:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in relay_open_buf
Message-ID: <20190131115401.GA19697@kroah.com>
References: <00000000000074cbc30580b16bc3@google.com>
 <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
 <f3347711-fc72-a356-0802-4c9c3ce5eb9c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3347711-fc72-a356-0802-4c9c3ce5eb9c@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:29:37PM +0900, Tetsuo Handa wrote:
> On 2019/01/31 19:51, Greg KH wrote:
> > Can you test the patch below?
> 
> You can ask syzbot to test the patch. But
> 
> > @@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
> >  		dentry = chan->cb->create_buf_file(NULL, NULL,
> >  						   S_IRUSR, buf,
> >  						   &chan->is_global);
> > -		if (WARN_ON(dentry))
> > +		if (IS_ERR_OR_NULL(dentry))
> >  			goto free_buf;
> 
> are you trying to fix a different bug together that old code was by error bailing
> out when chan->cb->create_buf_file() returned a valid "struct dentry *" ?
> I don't know what WARN_ON() due to a valid "struct dentry *" means...

I don't either, I'm guessing that's a code path that has never been
taken, or everyone just ignores it :)

Anyway, I fixed it up to be safe.  And the reproducer shows it now works
properly too.

thanks,

greg k-h
