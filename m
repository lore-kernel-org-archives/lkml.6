Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF06ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FF42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FF42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeGRLGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:06:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:41889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeGRLGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:06:31 -0400
Received: from homer.simpson.net ([185.191.218.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBdv-1fr1R03Jnb-00FAyp; Wed, 18
 Jul 2018 12:28:49 +0200
Message-ID: <1531909728.6904.84.camel@gmx.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 18 Jul 2018 12:28:48 +0200
In-Reply-To: <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
         <20180522131004.3012953c@gandalf.local.home>
         <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
         <20180522132429.6f1dcf92@gandalf.local.home>
         <20180522173333.aawadhkcekzvrswp@linutronix.de>
         <20180711092555.268adf7f@gandalf.local.home>
         <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
         <20180711093346.782af07a@gandalf.local.home>
         <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
         <1531519424.23898.68.camel@gmx.de>
         <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AH4nzYdTbBseYlg0yIVqxFiMHb/CGY5mGKw6Ck0ofpr2YxuUz1X
 52uLThB+traOzZW8XC9JtTze6SsejcNw9buhsk8jwoKuz4EUqX6pPgpR6Dj9biJdpge6bwE
 WtNfLP1xGPcWsLjJDB0Hb+l+GwKPxcZdOgm8AwduTqiE+8cpYCv2PTFXSE9hvZjc9GYPxXC
 9uufNpTEhb09NinaQJ8kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o6U+KSZPrg0=:dxbnGuxbmbpUc4BW2qrJVq
 gJGdDcMdv8rHTPmHUx4fPo8EEjNGmyfZCr1wIVnOAwMN9/xhwU2KRweBt8RdyWidw5hjLTvTM
 Gd3+WWDLu+fsY7kRO+WjdTmsz6uwYLBuByVGXItaAjnTQOVHIYXUjAwh2gMZJR6uwci0VqHWV
 nTU8yRauwRN2RnMIapGcmfdVuqnEFZwz/3Wja/IVMQ5JzrUa21jABWEmdLWylDkThFPrwfy9b
 PGYEqTzM0djz3SVVdfwmwX2zZQ9DN+B6z3BVQBvcG8l0LlrC01B0nPRyGHfMn1DLgWC8iudpH
 y0VBgDDR4BsirbYU+ieqpOKUsoZa9Krj3A6/zJHKCBXWIkkGc58p0S+/S3VkP7Q4qRiocd8mi
 mDbguNp03e/vnk/uIyxBs9rPRh0wtFa54B69Nf+Hd7ZPi9GsXOqs7FB57YYRmpvhkrBXkosp9
 41c70A6krAFoeqAfHOB31GMGzDcpzSGaEaJ0mf9/4mGnJb0hQL2UFK/zmrWWkOXW7WRjWa+lw
 UCl5j7A/yZ41yrha0z2Q3j+ajzKsx/GooR3HQp/YWkclZgwaSqIhaHm4zlo1i3FXHA7tOfIkv
 576hrsNc/2u2KxaYjRO/LMnbSAmIUe0dON3XVtZvaRGVaM+kYnjggKtyhOtudr5YDv/pxhHpq
 K5vUCC4bwmoMKljU1dQc5aDx3kht4j4o0mprfciYJdc5kcmtY2QPtXWn09xohO7/pmmji1WMr
 RUOycFRawQsrAed2ImXL4sjLXibp10IQhv3R82wiZeeM6oCzB1rqQHowPe3X3OekmiDsRtLwv
 87aD3z+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 11:27 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-14 00:03:44 [+0200], Mike Galbraith wrote:
> > > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > > EFI so I have no clue if saving SIMD while calling to EFI works.
> > 
> > All is not well on cavium test box.  I'm seeing random errors ala...
> > 
> > ./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
> > ./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023
> > 
> > ...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
> > as well, which is unsurprising if it's related to fpsimd woes.  Box
> > does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.
> > 
> > To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
> > containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
> > the problem. (relevant? dunno, it may be unrelated to fpsimd.c).
> 
> Okay, so you did not test this because you can't compile.

Nope, the running kernel, the one that is doing the segfaulting etc,
has the patches applied.

It is exhibiting that symptom because those patches do not cure this
symptom, one which I verified to be present in virgin 4.14-rt as well. 
The pseudo-patch I sent, disabling preemption where it is assumed to be
disabled instead, does cure it.  With preemption so disabled, I can
beat on affected kernels (>=4.14-rt) as long as I like.

This particular 48 core Cavium is very slow, maybe that makes it easier
to reproduce, dunno.  According to pipe-test, the thing is essentially
a dozen RPi super-glued together.  pipe-test pinned to a single core
can only context switch at ~40KHz with PREEMPT_RT, or ~90 with
NOPREEMPT, comparable to measurement done in real deal RPi.

	-Mike
