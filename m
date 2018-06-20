Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C51AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F56208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F56208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeFTIdb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44107 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752750AbeFTId2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E1FD20750; Wed, 20 Jun 2018 09:38:15 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4C29C203EC;
        Wed, 20 Jun 2018 09:38:05 +0200 (CEST)
Date:   Wed, 20 Jun 2018 09:38:05 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ivan Djelic <ivan.djelic@parrot.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/bch: Remove VLA usage
Message-ID: <20180620093805.6d9c602e@bbrezillon>
In-Reply-To: <CAGXu5jJVX5tk3w5etreTPJpoEzXfF9bFD4GNNW69yRHZTEBYiA@mail.gmail.com>
References: <20180531184525.GA11068@beast>
        <20180601110921.GC4695@parrot.com>
        <CAGXu5jJVX5tk3w5etreTPJpoEzXfF9bFD4GNNW69yRHZTEBYiA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, 19 Jun 2018 16:48:17 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Fri, Jun 1, 2018 at 4:09 AM, Ivan Djelic <ivan.djelic@parrot.com> wrote:
> > On Thu, May 31, 2018 at 11:45:25AM -0700, Kees Cook wrote:  
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> allocates a fixed size stack array to cover the range needed for
> >> bch. This was done instead of a preallocation on the SLAB due to
> >> performance reasons, shown by Ivan Djelic:
> >>
> >>  little-endian, type sizes: int=4 long=8 longlong=8
> >>  cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
> >>  calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4
> >>
> >>    Buffer allocation |  Encoding throughput (Mbit/s)
> >>  ---------------------------------------------------
> >>   on-stack, VLA      |   3988
> >>   on-stack, fixed    |   4494
> >>   kmalloc            |   1967
> >>
> >> So this change actually improves performance too, it seems.
> >>
> >> The resulting stack allocation can get rather large; without
> >> CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
> >> trips the stack size checking:
> >>
> >> lib/bch.c: In function ‘encode_bch’:
> >> lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >>
> >> Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=14 and
> >> CONFIG_BCH_CONST_T=4) would have started throwing a warning:
> >>
> >> lib/bch.c: In function ‘encode_bch’:
> >> lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >>
> >> But this is how large it's always been; it was just hidden from
> >> the checker because it was a VLA. So the Makefile has been adjusted to
> >> silence this warning for anything smaller than 4500 bytes, which should
> >> provide room for normal cases, but still low enough to catch any future
> >> pathological situations.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >> v3: fix r_bytes to whole-word size
> >> v2: switch to fixed-size stack array
> >> ---
> >>  lib/Makefile |  1 +
> >>  lib/bch.c    | 23 +++++++++++++++--------
> >>  2 files changed, 16 insertions(+), 8 deletions(-)  
> >
> >
> > The patch looks good to me. It also passed my regression tests.
> >
> > Reviewed-by: Ivan Djelic <ivan.djelic@parrot.com>
> > Tested-by: Ivan Djelic <ivan.djelic@parrot.com>  
> 
> Thanks for the review and testing!
> 
> Who's the best person to carry this patch?

Looks like all users of this lib are in drivers/mtd, so I can take the
patches if you want, but I can also let you take them if you prefer.

Here is my

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

in case you were waiting for it.

Regards,

Boris
