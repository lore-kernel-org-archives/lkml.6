Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3222085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="J3oCes5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbfAaQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:09:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38294 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAaQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:09:47 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so4974769itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZDhNb4sVXnlVoRkQvj1z4u9Zv5cFgKlz/b2lxRaoPI=;
        b=J3oCes5OPHB+6WC7iK+6Bv/vJAn/0GRY3kTFJiC1znYpGLb6xldzpM/uW2qPALEQpZ
         Q6DAGAc/VWFUsGjie0B6CnvC3WdDL5Wx5yBNoAFH9G/xbGnTRudXOXlW7bwsV9BsStCz
         y63OK+00cx80Mef8GgK7mmbwNllr75Gh/wnfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZDhNb4sVXnlVoRkQvj1z4u9Zv5cFgKlz/b2lxRaoPI=;
        b=ZW/cgz6J2RZ/AAgkd0HrbhC2oI4aGw0AVRaxBlZiundfkZ8XBImIn9YVUgi3PbgzBk
         /syLvuNS5trk4pir9QeZxFk3O+FDSiGH6gA/C9mIf1RTbphSsqexWnpS6RWuPTM6pfJY
         ZkZZjG1XkpVxvWDkClOUmT4lrZdxuHFI2Jvww2aNv5HCSJdRJ0b5dR7UnDfyfyCgBDVG
         Oq2E+X65h/7hmS5dAKLk/d+5U3xPIk3kGdvjs6v49DRdw7wLfavgNSKWYLu4Axj/Fvev
         74mcZto3d5S4XZFpx1V7bc4J84BWAII7N/+tyJ7FJ0+rAgSgPnqRC2LNOAL8Ef6Pfol9
         VygQ==
X-Gm-Message-State: AJcUuke3w+1hc+u7hSE7uLJML2eFNF2jJiSGJgsCkINrbOuKRr4qJUdb
        OnSYgzxoRLhOMFf7qdRaf2uJQ+Z9iwQrPUJCgXwfMw==
X-Google-Smtp-Source: ALg8bN5qFLcdLOpTE2pGibV42YVQjE5QLQrQnNLCf+DjrvQhpaeRJgPXfQVNu1buofq1DYB/NxRhVXHBDAXeFOdf4rs=
X-Received: by 2002:a24:9dce:: with SMTP id f197mr19131102itd.13.1548950986086;
 Thu, 31 Jan 2019 08:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-9-gregkh@linuxfoundation.org>
 <CALZtONCjGashJkkDSxjP-E8-p67+WeAjDaYn5dQi=FomByh8Qg@mail.gmail.com> <20190129203325.GA2723@kroah.com>
In-Reply-To: <20190129203325.GA2723@kroah.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Thu, 31 Jan 2019 11:09:09 -0500
Message-ID: <CALZtONBSgcHMLZBAdc3FmGFbVrQhvdWKpKe+ATSuGk8_D=QP_A@mail.gmail.com>
Subject: Re: [PATCH] zswap: ignore debugfs_create_dir() return value
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 3:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 29, 2019 at 02:46:30PM -0500, Dan Streetman wrote:
> > On Tue, Jan 22, 2019 at 10:23 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > >
> > > Cc: Seth Jennings <sjenning@redhat.com>
> > > Cc: Dan Streetman <ddstreet@ieee.org>
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  mm/zswap.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index a4e4d36ec085..f583d08f6e24 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1262,8 +1262,6 @@ static int __init zswap_debugfs_init(void)
> > >                 return -ENODEV;
> > >
> > >         zswap_debugfs_root = debugfs_create_dir("zswap", NULL);
> > > -       if (!zswap_debugfs_root)
> > > -               return -ENOMEM;
> > >
> > >         debugfs_create_u64("pool_limit_hit", 0444,
> > >                            zswap_debugfs_root, &zswap_pool_limit_hit);
> >
> > wait, so if i'm reading the code right, in the case where
> > debugfs_create_dir() returns NULL, that will then be passed along to
> > debugfs_create_u64() as its parent directory - and the debugfs nodes
> > will then get created in the root debugfs directory.  That's not what
> > we want to happen...
>
> True, but that is such a rare thing to ever happen (hint, you have to be
> out of memory), that it's not really a bad thing.  But, you are not the
> first to mention this, which is why this patch is on its way to Linus
> for 5.0-final:
>         https://lore.kernel.org/lkml/20190123102814.GB17123@kroah.com/

Ah!  Great, in that case then definitely

Acked-by: Dan Streetman <ddstreet@ieee.org>

>
> thanks,
>
> greg k-h
