Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9D9208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9D9208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeHZRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:49:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHZRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:49:29 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftvgh-0005hr-5t; Sun, 26 Aug 2018 16:06:43 +0200
Date:   Sun, 26 Aug 2018 16:06:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
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

Jason,

On Sun, 26 Aug 2018, Jason A. Donenfeld wrote:
> On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > I'm not too fond of this simply because it requires that relax() step in
> > all code pathes. I'd rather make that completely transparent by just
> > marking the task as FPU using and let the context switch code deal with it
> > in case that it gets preempted. I'll let one of my engineers look into
> > that next week.
> 
> Do you mean to say you intend to make kernel_fpu_end() and
> kernel_neon_end() only actually do something upon context switch, but
> not when it's actually called? So that multiple calls to
> kernel_fpu_begin() and kernel_neon_begin() can be made without
> penalty?

On context switch and exit to user. That allows to keep those code pathes
fully preemptible. Still twisting my brain around the details.

> If so, that'd be great, and I'd certainly prefer this to the
> simd_context_t passing. I consider the simd_get/put/relax API a
> stopgap measure until something like that is implemented.

I really want to avoid this stopgap^Wducttape thing.

Thanks,

	tglx
