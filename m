Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84812075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84812075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIGMyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:54:44 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42316 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIGMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:54:44 -0400
Received: by mail-qt0-f178.google.com with SMTP id z8-v6so15362832qto.9;
        Fri, 07 Sep 2018 01:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS89FdKfy0eFfc3JCGt08Ga+wBVRMwStghUo7Nyjnv4=;
        b=PuFNOfrGWk5WW9DatvpaAQyU4J/6JVgxSEmIf3Ea4OHJtTW2FejLuEhfQH8j6aP2A0
         TND98l7acIZaz1kL2LfzokNeuo2pv+6QPJx2+TK/OWCGqmWn/D3EZhHk9Ca6LU8ThX/F
         90DUyZGmK6E4RwOXgtTNNB+yeSVcbutfhcE45aAl6PQkppcBoRHvzYxRsv2PwhHtgA2g
         Q2iMovI5R0jch4ajy1KsHwzCiuj7fBIvut0n7ue3Jf2otJoJl4LJM0p/adI/0zrdNIsx
         3B19qxzt4uHPJpNwCRXupxeqPlCjzQFJBInJmM7LPl0R7bA/RCI4lA0Xo7qaMC7N0Xur
         8mEQ==
X-Gm-Message-State: APzg51CjYQbw+rn5QYW4ltu/N2SRnpQEcJ/jaYM30RtxzbEy8z5SYN7z
        pEnvU/EsqbhDIduzcEyXpgBubWJsjgiyJYm481c=
X-Google-Smtp-Source: ANB0VdZGe4oow7nVO4ueFpS8SgxnCeJeFNg51ievIsDyxKS1R9yvP0nNzyUjcJJZwPKC4rqrndi1aNkxTqxQx+menZE=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr5037925qvc.161.1536308095428;
 Fri, 07 Sep 2018 01:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com> <20180907030447.GA10434@guoren-Inspiron-7460>
In-Reply-To: <20180907030447.GA10434@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Sep 2018 10:14:38 +0200
Message-ID: <CAK8P3a2K_ecCQEs840hQMrjsf4H8hHxS+HtM2TtPDYpRu8-LeQ@mail.gmail.com>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 5:04 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Can you describe how C-Sky hardware implements MMIO?
> Our mmio is uncachable and strong-order address, so there is no need
> barriers for access these io addr.
>
>  #define ioremap_wc ioremap_nocache
>  #define ioremap_wt ioremap_nocache
>
> Current ioremap_wc and ioremap_wt implementation are too simple and
> we'll improve it in future.
>
> > In particular:
> >
> > - Is a read from uncached memory always serialized with DMA, and with
> >   other CPUs doing MMIO access to a different address?
> CPU use ld.w to get data from uncached strong order memory.
> Other CPUs use the same mmio vaddr to access the uncachable strong order
> memory paddr.

Ok, but what about the DMA? The most common requirement for
serialization here is with a DMA transfer, where you first write
into a buffer in memory, then write to an MMIO register to trigger
a DMA-load, and then the device reads the data from memory.
Without a barrier before the MMIO, the data may still be in a
store queue of the CPU, and the DMA gets stale data.

Similarly, an MMIO read may be used to see if a DMA has completed
and the device register tells you that the DMA has left the device,
but without a barrier, the CPU may have prefetched the DMA
data while waiting for the MMIO-read to complete. The __io_ar()
barrier() in asm-generic/io.h prevents the compiler from reordering
the two reads, but if an weakly ordered read (in coherent DMA buffer)
can bypass a strongly ordered read (MMIO), then it's still still
broken.

> > - How does endianess work? Are there any buses that flip bytes around
> >   when running big-endian, or do you always do that in software?
> Currently we only support little-endian and soc will follow it.

Ok, that makes it easier. If you think that you won't even need big-endian
support in the long run, you could also remove your asm/byteorder.h
header. If you're not sure, it doesn't hurt to keep it of course.

        Arnd
