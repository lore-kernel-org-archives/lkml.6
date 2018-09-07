Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A72077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31A72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeIGSzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:55:01 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38550 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeIGSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:55:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id x7-v6so16342047qtk.5;
        Fri, 07 Sep 2018 07:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0evgYeo5X3sJ0ABpw9Rh8HyzhNeb4D+zN5TZKbuCeE=;
        b=fOVGbWiyKd8zEv37aSvPfI4BUtC3DsBlSMLHcciBfzcwAn6UgeWd8Ly/lAAxoZv8Jn
         7iq2A/+XUL3ePT4Af1O4XdgKkul4uFvi2cm1K8uYWEbW6FfnKNtMss9KSlWlhIYK8zQy
         QsVsfMcUyu6NDTwIwf6X6h7tv3+Nzy7XAiIq8heDHilgWmC6jTAHONmZzB1dRW+DQCdD
         Y7IWkN9x4SjmtQeZmT4vqZkrZ4b6BTC77ZanUz9PkWb6Ne7kLa+PYKdopRITdHup0aue
         xM3SXjQO6GbyJBLQvxTZ0Jofj6BwrVUJNkktvYUESlXNWKLpT/FGqPbrAM5LnshDselw
         gsqg==
X-Gm-Message-State: APzg51D3tyzcYF6zdCX7BqCQKaCZUTPokQ2gWUoTq5CweHPQSh8DQRdd
        IZLLo4xWihMRxXwFnBxeJR10k4Aua1mEcuQMILo=
X-Google-Smtp-Source: ANB0VdZ2virbiAbITaUFP/m/hc+LNCVebyaVqijlSrsrivvJT0h4SPOPjIQs9hWLeEP2MHmG0gwy5FUYB4Q8WG6RV+0=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr5764154qvc.180.1536329631727;
 Fri, 07 Sep 2018 07:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
 <20180907030447.GA10434@guoren-Inspiron-7460> <CAK8P3a2K_ecCQEs840hQMrjsf4H8hHxS+HtM2TtPDYpRu8-LeQ@mail.gmail.com>
 <20180907125536.GA2308@guoren>
In-Reply-To: <20180907125536.GA2308@guoren>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Sep 2018 16:13:35 +0200
Message-ID: <CAK8P3a3b+dM2kxSG7kCqTR=NmiqvZoMwOwSmQKRQLQjXqpqxYw@mail.gmail.com>
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

On Fri, Sep 7, 2018 at 2:55 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Fri, Sep 07, 2018 at 10:14:38AM +0200, Arnd Bergmann wrote:
> > On Fri, Sep 7, 2018 at 5:04 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> > Similarly, an MMIO read may be used to see if a DMA has completed
> > and the device register tells you that the DMA has left the device,
> > but without a barrier, the CPU may have prefetched the DMA
> > data while waiting for the MMIO-read to complete. The __io_ar()
> > barrier() in asm-generic/io.h prevents the compiler from reordering
> > the two reads, but if an weakly ordered read (in coherent DMA buffer)
> > can bypass a strongly ordered read (MMIO), then it's still still
> > broken.
> __io_ar() barrier()? not rmb() ?! I've defined the rmb in asm/barrier, So
> I got rmb() here not barrier().
>
> Only __io_br() is barrier().

Ah right, I misremembered the defaults. It's probably ok then.

> > > > - How does endianess work? Are there any buses that flip bytes around
> > > >   when running big-endian, or do you always do that in software?
> > > Currently we only support little-endian and soc will follow it.
> >
> > Ok, that makes it easier. If you think that you won't even need big-endian
> > support in the long run, you could also remove your asm/byteorder.h
> > header. If you're not sure, it doesn't hurt to keep it of course.
> Em... I'm not sure, so let me keep it for a while.

Ok. I think overall the trend is to be little-endian only for most
architectures: powerpc64 moved from big-endian only to little-endian
by default, ARM rarely uses big-endian (basically only for legacy
applications ported from BE MIPS or ppc), and all new architectures
we added in the last years are little-endian (OpenRISC being the
main exception).

     Arnd
