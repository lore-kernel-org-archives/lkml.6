Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23975C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083C020652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfAKSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:22 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:58497 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389780AbfAKSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:06:19 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6EF702800F982;
        Fri, 11 Jan 2019 19:06:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 28CB111AF6A; Fri, 11 Jan 2019 19:06:17 +0100 (CET)
Date:   Fri, 11 Jan 2019 19:06:17 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kash Pande <kash@tripleback.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190111180617.2k5uundov6hf4m7h@wunner.de>
References: <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <20190111050407.4k7pkir3jqtyn22o@wunner.de>
 <20190111054058.GA27966@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111054058.GA27966@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc += Ingo]

On Fri, Jan 11, 2019 at 06:40:58AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 11, 2019 at 06:04:07AM +0100, Lukas Wunner wrote:
> > On Thu, Jan 10, 2019 at 07:24:13PM +0100, Greg Kroah-Hartman wrote:
> > > My tolerance for ZFS is pretty non-existant.  Sun explicitly did not
> > > want their code to work on Linux, so why would we do extra work to get
> > > their code to work properly?
> > 
> > ZoL facilitates seamless r/w cross-mounting with macOS, something no
> > other filesystem allows, and that feature is critical for me to work
> > on Linux drivers for Mac hardware.  Please don't make life harder than
> > necessary for developers like me.  Your "extra work" argument seems
> > disingenuous to me, Sebastian's patch is causing extra work for
> > ZFS developers, not the kernel community.  The maintenance burden
> > for the kernel community to retain the export is zero.
> 
> Sorry, no, we do not keep symbols exported for no in-kernel users.

AFAICS the only other alternative would be to remove the _GPL from
the export of kernel_fpu_begin()/end().  Those functions were static
inlines until v4.2 when Ingo uninlined them with commit d63e79b114c0
(x86/fpu: Uninline kernel_fpu_begin()/end()).

Ingo, why did you choose _GPL back then, given that the functions
were not restricted to GPL before?  Any objections to making them
available to non-GPL again?

As it stands, v5.0 removes the ability from non-GPL modules to use
the FPU or SIMD instructions and that kills ZFS on Linux.  This isn't
hurting Oracle, they're not using OpenZFS, it's only hurting ZoL users.

Thanks,

Lukas
