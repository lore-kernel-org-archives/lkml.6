Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D69C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D5218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392940AbeLVXDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:03:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39560 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392911AbeLVXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:03:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BF7E927C55;
        Sat, 22 Dec 2018 18:03:15 -0500 (EST)
Date:   Sun, 23 Dec 2018 10:03:27 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k/mac: Use '030 reset method on SE/30
In-Reply-To: <CAMuHMdVtbnq6-6TqhnY6EKPWuupP+tCNwFj0_tJJek9qAqEoPQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812230930430.160@nippy.intranet>
References: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au> <CAMuHMdVtbnq6-6TqhnY6EKPWuupP+tCNwFj0_tJJek9qAqEoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018, Geert Uytterhoeven wrote:

> > -                       local_irq_save(flags);
> > -
> > -                       rom_reset();
> > -
> > -                       local_irq_restore(flags);
> 
> I guess you removed the call to local_irq_restore() because you never
> get there anyway?
> 

If a ROM call returns, we have a real problem, because we didn't call it 
in an execution environment that it is designed to be called in. Anything 
could happen.

Moreover, local_irq_restore() is bogus either way, given that there's 
nothing that our interrupt handlers can usefully do now.

See also commit 558d5ad276c9 ("m68k/mac: Avoid soft-lockup warning after 
mach_power_off").

-- 
