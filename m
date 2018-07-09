Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF489C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0E820878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeGIOKj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:10:39 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34237 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeGIOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:10:36 -0400
Received: by mail-ua0-f195.google.com with SMTP id r10-v6so11791594uao.1;
        Mon, 09 Jul 2018 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgMUvRX6XnBkbJUYmmZbc284DtxsmXgz0C/DdENXmok=;
        b=fMQSg6dHxyCWBCsoMdX78o+512GAD/Hm7AB0QjAdz9vcORODa3N2u8YNrFtmRfhC7v
         7lAdpMm9oXAzneqkqrmMrfxhGBIrgbcCGR8kYmoAZ0rZOGSSqlBpwYb5l6UexeVGufGz
         6SLGeGub2przVP8njbb6V+RY14URVcFoZlJjqgQ0l0ZcuY9bPFlEXIIRlUKecfMyKskg
         qrtyuZF515ZMfunAMFBxgbZ/1h49gKJAqRm7W9jO84T4rvptQNs0eDG/eDW67c7JKp1u
         MqhGvOuWsbas52gqAe5rXgdZWlK6eehMqfLv/rkWuJ9AAUs5pkXLcAIwwEv/jtlUnzQH
         fMhg==
X-Gm-Message-State: APt69E1vmTRIE6JHUOWGU3g6u1zDRNVk1cix2W/4TRPHTcRp9mLUDqeK
        JxfOFPNmacmwK89cs4+gX7cuyLCot9kowbtPqcc=
X-Google-Smtp-Source: AAOMgpc3dzkaF3FkqTNNeabRF3FpPBZp9MC51mMdcLxJigMyBCf1V8/YBZpaRyblfKav856zWp2wp2kV2QYNnkLkEq0=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr13834421uan.33.1531145435089;
 Mon, 09 Jul 2018 07:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180709134550.29541-1-abrodkin@synopsys.com> <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
 <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
In-Reply-To: <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 16:10:23 +0200
Message-ID: <CAMuHMdUS1QXuV8L1zadJ4XP=2g4pfoXgKByZ7Yg9PEbXOT_KVw@mail.gmail.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 09, 2018 at 03:54:09PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> > > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > > index f98a097e73f2..d65327cb83c9 100644
> > > --- a/drivers/base/devres.c
> > > +++ b/drivers/base/devres.c
> > > @@ -24,8 +24,12 @@ struct devres_node {
> > >
> > >  struct devres {
> > >     struct devres_node              node;
> > > -   /* -- 3 pointers */
> > > -   unsigned long long              data[]; /* guarantee ull alignment */
> > > +   /*
> > > +    * data[] must be 64 bit aligned even on 32 bit architectures
> > > +    * because it might be accessed by instructions that require
> > > +    * aligned memory arguments such as atomic64_t.
> > > +    */
> > > +   u8 __aligned(8)                 data[];
> > >  };
> >
> > From a quick reading in Documentation/driver-model/devres.txt this
> > devres muck is supposed to be device memory, right?
>
> It's for associating resources (e.g. memory allocations) with a struct
> device.
>
> e.g. you do:
>
>         devm_kmalloc(dev, size, GFP_KERNEL);
>
> ... and that allocates sizeof(struct devres) + size, putting some
> accounting data into that devres, and returning a pointer to the
> remaining size bytes.
>
> The data[] thing is a hack to ensure that the structure is padded to
> 64-bit alignment, in case you'd done:
>
> struct foo {
>         atomic64_t counter;
> }
>
> struct foo *f = devm_kmalloc(dev, sizeof(*f), GFP_KERNEL);

So the big issue is that the minimum alignment of a buffer allocated with
devm_kmalloc() and friends is different (lower) than when allocated with
kmalloc().

On 32-bit, it's only aligned to 4 bytes. Ugh.
I wouldn't be surprised if some callers assume it to be cacheline-aligned...

Which means blind conversions to the devm_*() versions can be dangerous.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
