Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9616DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B382083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TEP7M/AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B382083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeIZCWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:22:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46369 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbeIZCWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:22:23 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id deddc221;
        Tue, 25 Sep 2018 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=1L9KXjlrygRhsUzF+BzFa1+/YG4=; b=TEP7M/
        AUQR8MZ58AFCxnZcYboPp0ou9RhWhT5R6TQAlvCK8zf3lKABV5GTRfFIsQ/sGbUx
        oIbQnVBSxdc/vRHwReLRQy26U+jZRHAzg+VEtIZdqI1jF7AH37m5cA6S7chVLuQV
        WWl4MGDavrluOz1mW+GtERve8iiaW3qWBIdjnPqsUupxU3vIFin19m3Zfpyob0XY
        7xO5oTLiMb7ZNrtuv7SPOY4mFC+3BG5ZcQZyt95cfGGBRQt01s5dEhKwXZppe+Lr
        /bRyH+1KyYJqEHvTbj6dFnpI/Peu8PXZTDmJ6c/TVaadkCgxcfOY1lfbgoAowgZw
        pDsXJFtM82Z0uYnw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cc6b236e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 19:54:39 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id c12-v6so25780444otl.6;
        Tue, 25 Sep 2018 13:13:07 -0700 (PDT)
X-Gm-Message-State: ABuFfohaxRIDKj6klfDb2VoKgpb7f8dVQ1Ojw4JduCMleM7BX2QBrXNK
        irgQmdfiTPKHk+cwg4GH9P363LHoxuATDS211hA=
X-Google-Smtp-Source: ACcGV61r9xz8lYiBqOgXq8Ltozp5dowBKWcgfyyIw249ZUOi/1vxh2VNHGqTYgmQulTJCJEQtZwNnbfTY97Lo79UthI=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr1821874oth.250.1537906386458;
 Tue, 25 Sep 2018 13:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com>
 <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
 <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com> <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
In-Reply-To: <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 22:12:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9peVqXDq7hmFZ+4cus+Y97NHS-TyBKF9GkdLvixdmq6hw@mail.gmail.com>
Message-ID: <CAHmME9peVqXDq7hmFZ+4cus+Y97NHS-TyBKF9GkdLvixdmq6hw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography library
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Sep 25, 2018 at 10:05 PM Joe Perches <joe@perches.com> wrote:
> As far as I can tell, zinc doesn't use pr_err, just
> pr_info

Yes, pr_info, not pr_err. Apologies for my imprecision. But the
distinction does not matter at all, since they both use pr_fmt in
exactly the same way, which is sufficient for the purposes of this
discussion.

> >  why can't I just do this from the makefile, since
> > I want that same pr_fmt to copy the whole directory?
>
> Ideally all of those
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> uses will be removed one day soon and the default
> will change.
>
> https://lore.kernel.org/patchwork/cover/904507/
>
> This slightly odd use might complicate that.

Oh, that's good to see. In this case, I'm prefixing all of them with
zinc: instead of zinc_chacha20: (the modname), but I wouldn't object
to that changing to KBUILD_MODNAME if your patch lands. IOW, once your
patch lands, I'm happy to revisit this discussion and fall back to
using the sane defaults you're in the process of setting up for
everyone.

Jason
