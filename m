Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8870C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CB220881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="j1/p6rc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CB220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeGIMzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:55:43 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41829 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeGIMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:55:42 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5CF4225B76B;
        Mon,  9 Jul 2018 22:55:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531140940; bh=m92pa8hwGb6O+g24aFcmnTpb557/NY+gRfOeoABIuh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1/p6rc8q4OPyqocK2Tw2+PzpYwheQDqTg2Dzq32RNorclhfebDNHEWs3OjpmUIDU
         AkhZ7xokYRgRgAI6/RW2DZXKrzg4Xdc1ad7dvDcf4Q04+840CuLypwGL0zT0HV4nAh
         Bq/C0vBR3HB7MiR3LnRequM24vMV+J5eFOanbR0Y=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3D413940796; Mon,  9 Jul 2018 14:55:38 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:55:38 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: r9a06g032: don't build SMP fiiles for non-SMP config
Message-ID: <20180709125537.34534llhq4p4tqug@verge.net.au>
References: <20180706151610.3783638-1-arnd@arndb.de>
 <CAMuHMdXTF=Zfm7Dm1+_q6yhccQXYsPc=wQaHDBSsq4X7ujg4sQ@mail.gmail.com>
 <CAK8P3a3qCAxBKBs0vcr0Y9HXm0DHY7aii4S3P7M010JOkcxCvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3qCAxBKBs0vcr0Y9HXm0DHY7aii4S3P7M010JOkcxCvw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:13:14PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 6, 2018 at 5:23 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Arnd,
> >
> > On Fri, Jul 6, 2018 at 5:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> Without CONFIG_SMP, we get a build failure:
> >>
> >> In file included from include/linux/byteorder/little_endian.h:5,
> >>                  from arch/arm/include/uapi/asm/byteorder.h:22,
> >>                  from include/asm-generic/bitops/le.h:6,
> >>                  from arch/arm/include/asm/bitops.h:342,
> >>                  from include/linux/bitops.h:18,
> >>                  from include/linux/kernel.h:11,
> >>                  from include/asm-generic/bug.h:18,
> >>                  from arch/arm/include/asm/bug.h:60,
> >>                  from include/linux/bug.h:5,
> >>                  from include/linux/io.h:23,
> >>                  from drivers/soc/renesas/r9a06g032-smp.c:11:
> >> drivers/soc/renesas/r9a06g032-smp.c: In function 'r9a06g032_smp_boot_secondary':
> >> drivers/soc/renesas/r9a06g032-smp.c:43:21: error: 'secondary_startup' undeclared (first use in this function)
> >>   writel(__pa_symbol(secondary_startup), cpu_bootaddr);
> >>                      ^~~~~~~~~~~~~~~~~
> >>
> >> This makes the compilation of that file conditional on SMP support.
> >> It would probably be better for consistency to leave that file
> >> in arch/arm/mach-shmobile/, matching what we do for all other smp
> >> operations.
> >
> > Shouldn't that comment be moved below the "---"? ;-)
> 
> Maybe
> 
> > I thought the (10Y ;-) plan was to have no more code under arch/arm/mach-*/?
> > Note that the suport for the new RZ/N1D SoC doesn't use any other code in
> > mach-shmobile.
> 
> The SMP code is the main part we never figured out where else to put,
> so it's typically the only thing we still have for new platforms under
> arch/arm/.
> 
> >> Fixes: cde4f86f9249 ("arm: shmobile: Add the R9A06G032 SMP enabler driver")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I've applied this (with the full commit message).
Lets work out where the code should live and move it if necessary.
