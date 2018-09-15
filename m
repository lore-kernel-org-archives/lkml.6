Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB260ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B02F2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B02F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIPACD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:02:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeIPACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:02:02 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1FW6-0003xB-0A; Sat, 15 Sep 2018 20:42:02 +0200
Date:   Sat, 15 Sep 2018 20:42:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Subject: Re: [PATCH v2 4/5] pselect6: use __kernel_timespec
In-Reply-To: <CABeXuvoOEW9+5BPiDN+2S1boyMSg+csvSAd4ue03TB+yEO6dLg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809152039440.1650@nanos.tec.linutronix.de>
References: <20180915050843.19183-1-deepa.kernel@gmail.com> <20180915050843.19183-5-deepa.kernel@gmail.com> <CAK8P3a2Kkm2ubg_MVN_BJL=s7qpUB1-np=9zVpcJ2U-aPAJswg@mail.gmail.com> <CABeXuvoOEW9+5BPiDN+2S1boyMSg+csvSAd4ue03TB+yEO6dLg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018, Deepa Dinamani wrote:

> On Sat, Sep 15, 2018 at 8:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Sep 15, 2018 at 7:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > +#if defined(CONFIG_64BIT_TIME)
> > > +
> > > +COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
> > > +       compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
> > > +       struct __kernel_timespec __user *, tsp, void __user *, sig)
> >
> > I got a link error here since compat_sys_pselect6_time64 and
> > compat_sys_ppoll_time64 are only defined when CONFIG_64BIT_TIME
> > is set.
> >
> > I did not think we would select this symbol on arm64, is that a mistake
> > on my side, or should the #ifdef check be removed?
> 
> But, this is a compat syscall.
> When we introduced this CONFIG_64BIT_TIME we planned to use it for
> compat syscalls also is my understanding.
> 
> config 64BIT_TIME
>          def_bool ARCH_HAS_64BIT_TIME
>          help
>           This should be selected by all architectures that need to support
>            new system calls with a 64-bit time_t. This is relevant on all 32-bit
>            architectures, and 64-bit architectures as part of compat syscall
>            handling.
> 
> This means it should be set on 64 bit architechtures also right?

It's only set when 32bit compat mode is enabled on the 64bit kernel.

Thanks,

	tglx
