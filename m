Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A123C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548794011;
	bh=DPvH4a8NS+v9FXY+mtxhNvQwoYBsLvv8TgIPjWa/rig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=APNSUTnFoEo7fnhXrfuMz5OXdsX225wr1Q2xF0TdRUtCE5rH/aGEuaM64B9D41RrY
	 /Iunx/ujneAlAe4NHRe6zi72cOzRWmAumqVcAma1w6y1gXnKt0k7/pdgCufdEnpDsl
	 zOpP/5B0DdQ75P16JXH35/CTh/yz/YushVGpzWvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfA2Ud3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfA2Ud3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:33:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67A720881;
        Tue, 29 Jan 2019 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548794008;
        bh=DPvH4a8NS+v9FXY+mtxhNvQwoYBsLvv8TgIPjWa/rig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbHcsDb9z/t9SFcX7zbJvN0Y70JVgtoHVnofc5ApZrRHDseOF/6LXOxzrZT/DaNos
         DorLlUrMHz7AexuNH3hg/+0h8VKG6kaC1S+aSGG36dshtPMM1cb/HFR5bCuFQ7/dEt
         W2YU8l6kBJBV36AAypIa1G/iJw1Owiz1BwyS+NR8=
Date:   Tue, 29 Jan 2019 21:33:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Streetman <ddstreet@ieee.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] zswap: ignore debugfs_create_dir() return value
Message-ID: <20190129203325.GA2723@kroah.com>
References: <20190122152151.16139-9-gregkh@linuxfoundation.org>
 <CALZtONCjGashJkkDSxjP-E8-p67+WeAjDaYn5dQi=FomByh8Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALZtONCjGashJkkDSxjP-E8-p67+WeAjDaYn5dQi=FomByh8Qg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:46:30PM -0500, Dan Streetman wrote:
> On Tue, Jan 22, 2019 at 10:23 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: Seth Jennings <sjenning@redhat.com>
> > Cc: Dan Streetman <ddstreet@ieee.org>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  mm/zswap.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index a4e4d36ec085..f583d08f6e24 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1262,8 +1262,6 @@ static int __init zswap_debugfs_init(void)
> >                 return -ENODEV;
> >
> >         zswap_debugfs_root = debugfs_create_dir("zswap", NULL);
> > -       if (!zswap_debugfs_root)
> > -               return -ENOMEM;
> >
> >         debugfs_create_u64("pool_limit_hit", 0444,
> >                            zswap_debugfs_root, &zswap_pool_limit_hit);
> 
> wait, so if i'm reading the code right, in the case where
> debugfs_create_dir() returns NULL, that will then be passed along to
> debugfs_create_u64() as its parent directory - and the debugfs nodes
> will then get created in the root debugfs directory.  That's not what
> we want to happen...

True, but that is such a rare thing to ever happen (hint, you have to be
out of memory), that it's not really a bad thing.  But, you are not the
first to mention this, which is why this patch is on its way to Linus
for 5.0-final:
	https://lore.kernel.org/lkml/20190123102814.GB17123@kroah.com/

thanks,

greg k-h
