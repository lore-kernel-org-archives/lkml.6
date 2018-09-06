Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E269C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE42206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE42206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeIFSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:18:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbeIFSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:18:30 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxuYW-0008OH-Kx; Thu, 06 Sep 2018 15:42:44 +0200
Date:   Thu, 6 Sep 2018 15:42:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809061542330.1570@nanos.tec.linutronix.de>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
 <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com> <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com> <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2018, Jason A. Donenfeld wrote:
> On Sat, Sep 1, 2018 at 2:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> > I tend to think the right approach is to merge Jason's code and then
> > make it better later.  Even with a totally perfect lazy FPU restore
> > implementation on x86, we'll probably still need some way of dealing
> > with SIMD contexts.  I think we're highly unlikely to ever a allow
> > SIMD usage in all NMI contexts, for example, and there will always be
> > cases where we specifically don't want to use all available SIMD
> > capabilities even if we can.  For example, generating random numbers
> > does crypto, but we probably don't want to do *SIMD* crypto, since
> > that will force a save and restore and will probably fire up the
> > AVX512 unit, and that's not worth it unless we're already using it for
> > some other reason.
> >
> > Also, as Rik has discovered, lazy FPU restore is conceptually
> > straightforward but isn't entirely trivial :)
> 
> Sounds good. I'll move ahead on this basis.

Fine with me.

