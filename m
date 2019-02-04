Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF36FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E57D2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfBDXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:12:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfBDXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:12:11 -0500
Received: from X1 (c-24-6-103-156.hsd1.ca.comcast.net [24.6.103.156])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B39878F89;
        Mon,  4 Feb 2019 23:12:10 +0000 (UTC)
Date:   Mon, 4 Feb 2019 15:12:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
Message-Id: <20190204151209.d6fae2c6466cb5c9c5814fd9@linux-foundation.org>
In-Reply-To: <20190204150916.f29d782b27f096e6c4c6d6cf@linux-foundation.org>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
        <20190204150916.f29d782b27f096e6c4c6d6cf@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 15:09:16 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun,  3 Feb 2019 20:24:00 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > BUILD_BUG_ON() is a little annoying, since it cannot be used outside
> > function scope. So one cannot put assertions about the sizeof() a
> > struct next to the struct definition, but has to hide that in some
> > more or less arbitrary function.
> > 
> > Since gcc 4.6 (which is now also the required minimum), there is
> > support for the C11 _Static_assert in all C modes, including gnu89. So
> > add a simple wrapper for that.
> > 
> > _Static_assert() requires a message argument, which is usually quite
> > redundant (and I believe that bug got fixed at least in newer C++
> > standards), but we can easily work around that with a little macro
> > magic, making it optional.
> > 
> > For example, adding
> > 
> >   static_assert(sizeof(struct printf_spec) == 8);
> > 
> > in vsprintf.c and modifying that struct to violate it, one gets
> > 
> > ./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct printf_spec) == 8"
> >  #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")
> > 
> > godbolt.org suggests that _Static_assert() has been support by clang
> > since at least 3.0.0.
> > 
> 
> It would be (very) nice to actually use this macro in a few places so
> it gets its build testing while in -next.

ie, just about every BUILD_BUG_ON in mm/ could use this.  Let's switch
a few?

