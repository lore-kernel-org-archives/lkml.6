Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B189C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A83024DFD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A83024DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeFXHNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:13:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFXHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:13:07 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWzCO-0002f1-9O; Sun, 24 Jun 2018 09:12:36 +0200
Date:   Sun, 24 Jun 2018 09:12:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
In-Reply-To: <20180624071105.GA29407@gmail.com>
Message-ID: <alpine.DEB.2.21.1806240911520.8650@nanos.tec.linutronix.de>
References: <20180507213755.GA32406@avx2> <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org> <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic> <1529242717.4472.3.camel@gmx.de> <1529244178.4674.1.camel@gmx.de> <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de> <20180623103622.GA2760@zn.tnic> <20180624071105.GA29407@gmail.com>
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

On Sun, 24 Jun 2018, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > Lemme send a proper patch now...
> > 
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > Date: Sun, 17 Jun 2018 13:57:42 +0200
> > Subject: [PATCH] x86/crypto: Add missing RETs
> > 
> > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > otherwise they run into INT3 padding due to
> > 
> >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > 
> > leading to spurious debug exceptions.
> > 
> > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> 
> Note that 51bad67ffbce has been zapped because it caused too many problems like 
> this, but the explicit RETs make sense nevertheless. When applying the patch 
> please don't include the SHA1 of the non-upstream (and probably never-upstream) 
> commit.

We should really have something like that exactly to catch cases like this.

Thanks,

	tglx
