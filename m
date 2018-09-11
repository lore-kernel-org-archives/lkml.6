Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B757C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA3420854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA3420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIKOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:07:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41300 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:07:52 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzefe-0001im-98; Tue, 11 Sep 2018 11:09:18 +0200
Date:   Tue, 11 Sep 2018 11:09:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Samuel Neves <sneves@dei.uc.pt>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
In-Reply-To: <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com> <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de> <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
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

On Tue, 11 Sep 2018, Samuel Neves wrote:

> On Tue, Sep 11, 2018 at 9:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, 10 Sep 2018, Jason A. Donenfeld wrote:
> >>  lib/zinc/Makefile                        |    4 +
> >>  lib/zinc/chacha20/chacha20-x86_64-glue.h |  102 +
> >>  lib/zinc/chacha20/chacha20-x86_64.S      | 2632 ++++++++++++++++++++++
> >
> > Just a stupid question. What's the rationale of putting that into lib/zinc
> > instead of having it in arch/x86/crypto?
> >
> 
> This is covered on the 02/17 commit message, whose relevant paragraph follows:

Well, being only cc'ed on only half of the patches does not really help.

> > It also organizes the implementations in a simple, straight-forward,
> > and direct manner, making it enjoyable and intuitive to work on.
> > Rather than moving optimized assembly implementations into arch/, it
> > keeps them all together in lib/zinc/, making it simple and obvious to
> > compare and contrast what's happening. This is, notably, exactly what
> > the lib/raid6/ tree does, and that seems to work out rather well. It's
> > also the pattern of most successful crypto libraries. The architecture-
> > specific glue-code is made a part of each translation unit, rather than
> > being in a separate one, so that generic and architecture-optimized code
> > are combined at compile-time, and incompatibility branches compiled out by
> > the optimizer.

Fair enough.


