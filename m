Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC12C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CDB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CDB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeJ2Sew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:34:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46304 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2Sew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:34:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id q1so2764272qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liAqJLJGFsBm+A0XHV4bBFa1jJiQYVDJE/SAKnGqDX8=;
        b=qtzvIo88n2ExP6BVV62Cm3X5B1Yn3d3xNB0PjNkwnLYPl77bweYJDYIwSBY92qCPXU
         UkemeXag0TyAP9OZGZGHJmj2fxixEMQNWc2wkwJokM493SrZFDqovJvkSyZbmeHP0zRD
         Cnnwy3exGVOStSzWTxDu4Bxyl99LKzXDULtJhGXpkVwRsIIqnypqOfpwd6Xex7W0FxFh
         g64uzZh4c1xjk3QYqWIZDC6e2NxOgjf36eKQKSsRI3g85XtDMMU2APnTiOmrWOL3iqI0
         xH/yW+N5koULnJ9VmnhZORsd1axFOHnXMECTlCDpX18EqWQ7xNTyNVIVnjX03UdN5cXi
         HyAQ==
X-Gm-Message-State: AGRZ1gKVJclRLYfSTTltbUuh5H/TmvHLhbnlXa2TbicQmc0+iCIx8PSg
        sQDbEaUjkgowMTyer8M6TQyUTGQjaajj3FqfhKU=
X-Google-Smtp-Source: AJdET5efo+Bbfdjg6mpRVn0HJD4kLB/VLkzKyXCcknmfgxSHuAyuFWQjR8RYIqEZy7H7A11Dp19LuihyUkmryw+Y2nI=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr11647081qke.173.1540806417916;
 Mon, 29 Oct 2018 02:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181010184533.691620-1-arnd@arndb.de> <20181012111603.0d03e043@bbrezillon>
 <CAK8P3a1zYoGtfe6PVEM-oLNxXQAt12iiNR1ZLiaGvrY5LFKwwA@mail.gmail.com>
 <20181012112259.56f3c44f@bbrezillon> <CAGXu5jLS5sEFgM1Vzri+cAONYKUqdXbahyNUU1xvRF0cbZrX1w@mail.gmail.com>
 <20181029083004.54d535d2@bbrezillon>
In-Reply-To: <20181029083004.54d535d2@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 10:46:41 +0100
Message-ID: <CAK8P3a0Tu-dayaHMjUf1Cfo=2gn7Djphj8w7iamBPdcYC78ATA@mail.gmail.com>
Subject: Re: [PATCH] mtd: sa1100: avoid VLA in sa1100_setup_mtd
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 8:30 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Sun, 28 Oct 2018 19:13:26 -0700 Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Oct 12, 2018 at 2:22 AM, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > On Fri, 12 Oct 2018 11:19:52 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Oct 12, 2018 at 11:16 AM Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > Oh, I thought I'd let you send a v2, but I can do it if you prefer.
> >
> > Olof just pointed out to me that neither fix landed for this? What's
> > needed for this?
>
> Nothing in particular, I was planning on sending a new version after
> -rc1 is out and then queue it for 4.21 (5.1?) (this patch came in a bit
> late, and I had already stopped taking patches for 4.20).
>
> If you consider this a fix or want to have it in 4.20 for other reasons,
> just let me know and I'll queue it to the -fixes branch.

We generally try to have a kernel that can be built in any configuration
without warnings, so please add it for v4.20.

        Arnd
