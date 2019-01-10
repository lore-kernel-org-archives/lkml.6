Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1707208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfAJXvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:51:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfAJXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:51:10 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDC2E123B;
        Thu, 10 Jan 2019 23:51:09 +0000 (UTC)
Date:   Thu, 10 Jan 2019 15:51:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: Re: [PATCH] lib/genalloc.c: include vmalloc.h
Message-Id: <20190110155108.a9a54ff592d00c0586691717@linux-foundation.org>
In-Reply-To: <1b876fba-28dc-ba7d-41f3-04580bc0c4b6@sony.com>
References: <20190105212118.61022-1-olof@lixom.net>
        <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
        <20190107145614.2152eb5e59248d17994759ea@linux-foundation.org>
        <1b876fba-28dc-ba7d-41f3-04580bc0c4b6@sony.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 14:13:44 +0100 peter enderborg <peter.enderborg@sony.com> wrote:

> On 1/7/19 11:56 PM, Andrew Morton wrote:
> > On Sat, 5 Jan 2019 13:35:33 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >> On Sat, Jan 5, 2019 at 1:21 PM Olof Johansson <olof@lixom.net> wrote:
> >>> Fixes build break on most ARM/ARM64 defconfigs:
> >> Interesting.
> >>
> >> Andrew, I thought ARM was one of the platforms that your tree compiled
> >> against? Or was some other change just hiding this?
> >>
> > I've become a bit lazy with the cross-compiling because linux-next's
> > build coverage is pretty broad.  But Stephen's holiday interrupted
> > things and this one fell in that window.
> >
> Is it now OK to use vmalloc in fast path's on all platforms?

I'd say not.  It is slower than kmalloc and these changes did nothing
to speed it up.

That being said, vmalloc is for "large" memory allocations and large
amounts of memory take large amount of time to utilize, so unless the
code is allocating then freeing memory without using it (don't do that)
then vmalloc() can never be a "fast path" thing?

