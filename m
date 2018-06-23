Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D029C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0245624CFB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0245624CFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFWUva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 16:51:30 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34118 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeFWUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 16:51:29 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so516613uao.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/jcKfi39dmwWG37Vyq1ISUMOYsGpfKlcT7iDR/Ae7o=;
        b=ZkpOlBnOo1CGP+O1MXu+wxZmIknDsOpqzZW0Owizxww3XMX7T81g9n8/bqtJ/f+VKd
         bmZ+M/Xqif73zrcM3B4mIVyVz03VFN9T/IsE5z48HfQFDlEr2rBhFMFsPGQ6wU9w54Lw
         XB7WPmKvYjPKFZgNHdc+8b1Tv8hc15XtIKDeFlhyeOWi7t7xmj57d3fvsV5volfnYyNq
         uTS2XCn4Z/BVpkiVQLJgEgD2tQvxJVZZUltBus/Uj1OhkTnnzX8AUJiqRQKn2Arfq7Nj
         gdlZxjWmoErrqk50dyl6dHjIvACc4g35a/z7+6o6r0E5J89mnpWG0Ks5WHKyFJEk8LSg
         yyhA==
X-Gm-Message-State: APt69E0JLiEAlrdhi/rMa6yBorrIxDt1zeIMZcgiZ9rIKEmi0auN6XQl
        Qx9TMtgAbgs5bUVip8XwAilLAZUdjHcJ5w3O4Sk=
X-Google-Smtp-Source: ADUXVKJ2D/44zp5RF/qB0YR30C5P2W9T+NdU/WIOZFAoF8IycSD9YBa7HexAUju3GvqEF+xPIdns2HlCr2xaqnyvgM4=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr4711714uas.26.1529787088679;
 Sat, 23 Jun 2018 13:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180622184246.GA21226@roeck-us.net> <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
In-Reply-To: <20180622223335.GA12581@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 23 Jun 2018 22:51:16 +0200
Message-ID: <CAMuHMdVa0c9Avy03sTK-DsqieXR6iovhkSYm_yRCVZofooY5hw@mail.gmail.com>
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matthew Wilcox <willy@infradead.org>, Josef Bacik <jbacik@fb.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Jun 23, 2018 at 12:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Jun 22, 2018 at 02:05:19PM -0700, Matthew Wilcox wrote:
> > On Fri, Jun 22, 2018 at 11:42:46AM -0700, Guenter Roeck wrote:
> > > a few days ago, m68k boot tests in linux-next started to crash.
> > > I bisected the problem to commit 'xarray: Replace exceptional entries'.
> > > Bisect and crash logs are attached below.
> >
> > Thank you!  I was afraid something like this might happen.
> >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
> >
> > Line 42 is:
> >
> >         if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
> >                 return -EINVAL;
> >
> > The pointer passed in to idr_alloc() is not 4-byte aligned; it's aligned
> > to a 2 byte boundary.  I'm having a little trouble seeing who it is that's
> > passing in what pointer ...
> >
> > > Call Trace: [<000180d6>] __warn+0xc0/0xc2
> > >  [<000020e8>] do_one_initcall+0x0/0x140
> > >  [<0001816a>] warn_slowpath_null+0x26/0x2c
> > >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> > >  [<002b50e4>] idr_alloc_u32+0x44/0xe8
> > >  [<002b51e4>] idr_alloc+0x5c/0x76
> > >  [<00247160>] genl_register_family+0x14c/0x54c
> >
> > It makes sense to here (other than idr_alloc being listed twice)
> >
> > >  [<000020e8>] do_one_initcall+0x0/0x140
> > >  [<003f0f02>] genl_init+0x0/0x34
> >
> > Assuming this is right, that would imply that genl_ctrl is not 4-byte
> > aligned.  Is that true?  I'm not familiar with the m68k alignment rules,
> > but it has a lot of 4-byte sized quantities in the struct, so I would
> > assume it's 4-byte aligned.
> >
> > >  [<003f0ce6>] bpf_lwt_init+0x10/0x14
> >
> > I don't think this is the caller.
> >
>
> Here is the culprit:
>
> genl_register_family(0x36dd7a) registering VFS_DQUOT
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/idr.c:42 idr_alloc_u32+0x44/0xe8
>
> It may be odd that fs/quota/netlink.c:quota_genl_family is not word
> aligned, but on the other side I don't think there is a rule that

On m68k (and a few other architectures), the alignment of int and larger
integral types is 2 bytes.

> the function parameter to genl_register_family() - or the second
> parameter of idr_alloc() - must be word aligned. Am I missing
> something ? After all, it could be a pointer to the nth element
> of a string, or the caller could on purpose allocate IDRs for
> (ptr), (ptr + 1), and so on.

Good point.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
