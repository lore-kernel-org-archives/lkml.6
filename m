Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD007C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575A421531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18J+RZqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575A421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeHUAtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUAte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:49:34 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E032174D;
        Mon, 20 Aug 2018 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534800738;
        bh=zGlAdWUzqEIGFYu0VJNLj7ZwFiDxd0KRcotQjTac2Wo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=18J+RZqbuJhPqEOncQOeG86xPSsAoCrw8xodMc2QyPibo3InpCoef/A0qfueG7l7l
         RX+ByEUOV3bMgTFe0106mZ9FWWXUM+/YLzjCv3UfAtWmOnYK5rhtCKjL6VfFa5wxd/
         VA2Z0xe8C2gN5YSrixonLshKT4VhHb6ym6zvxC/M=
Received: by mail-qt0-f170.google.com with SMTP id b15-v6so17929735qtp.11;
        Mon, 20 Aug 2018 14:32:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlH8xk0MiEfDmcrGV5Q+GTynvu/yJiH5Rimg1BYlUMzfmp9kUI7L
        6yF3ryZRudP6OriJC8m+SWaUTTKiY7g75V7cUQ==
X-Google-Smtp-Source: AA+uWPxY6fLpPEj0EJ/4M4k11iY44pVRdHy7Np+ezYw9jR0F7CCjDQIBf3PG5ich+cK2Yf5XgIvqCvtDBQ+9ep2SRSM=
X-Received: by 2002:ac8:705a:: with SMTP id y26-v6mr47806787qtm.118.1534800737778;
 Mon, 20 Aug 2018 14:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com> <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
In-Reply-To: <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Aug 2018 16:32:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
Message-ID: <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 07/03/18 18:59, Masahiro Yamada wrote:
> > It is tedious to specify extra compiler options for every file.
> > HOST_EXTRACFLAGS is useful to add options to all files in a
> > directory.
> >
> > -I$(src)/libfdt is needed for all the files in this directory
> > to include libfdt_env.h etc. from scripts/dtc/libfdt/.
> >
> > On the other hand, -I$(src) is used to include check-in headers
> > from generated C files.  Thus, I added it only to dtc-lexer.lex.o
> > and dtc-parser.tab.o .
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/dtc/Makefile | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> > index 9cac65b..1c943e0 100644
> > --- a/scripts/dtc/Makefile
> > +++ b/scripts/dtc/Makefile
> > @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
> >  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
> >
> >  # Source files need to get at the userspace version of libfdt_env.h to compile
> > +HOST_EXTRACFLAGS := -I$(src)/libfdt
>
> Shouldn't that be += instead of :=?

I don't think so. The definition is local to the file (and reset
before each makefile is included).

Rob
