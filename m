Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B575EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653CF20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="c0be2KgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653CF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbeGIM6q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:58:46 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41876 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:58:44 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 00DB725B76B;
        Mon,  9 Jul 2018 22:58:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531141123; bh=jq6WxkYh4AdntnizXkFQnMCFkgVEsACpFIug4YPdPew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0be2KgXR3yxvMncyQIPSKtZODyII9qUn0Xe6GE/7OvIjgSB6gczu6jmlphqS/Krx
         QAApRqwMtV+KyjE5jQPdxA6vxh6jKQDehUhuVomDiix0QI6IfmdbLaOU6wdgo31ae4
         2RdFmkRvR13z6eC/nWLaczZ8GArS9zj+RaA1m7l0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D537C940796; Mon,  9 Jul 2018 14:58:40 +0200 (CEST)
Date:   Mon, 9 Jul 2018 14:58:40 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: shmobile: r8a7779: hide unused
 r8a7779_platform_cpu_kill
Message-ID: <20180709125839.havdrfvk4hs4h76v@verge.net.au>
References: <20180706151528.3759312-1-arnd@arndb.de>
 <CAMuHMdXhN_Mw-Z+71LetjX2mJar-F4m3_-FjqouHgvjqtMq4OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXhN_Mw-Z+71LetjX2mJar-F4m3_-FjqouHgvjqtMq4OA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:26:40PM +0200, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Jul 6, 2018 at 5:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > After the cleanup in r8a7779_smp_prepare_cpus(), the only remaining caller of
> > r8a7779_platform_cpu_kill() is in an ifdef, which leads to a build warning
> > without CONFIG_HOTPLUG_CPU:
> >
> > arch/arm/mach-shmobile/smp-r8a7779.c:26:12: error: 'r8a7779_platform_cpu_kill' defined but not used [-Werror=unused-function]
> >
> > This moves the function inside of that #ifdef to avoid the warning.
> >
> > Fixes: 62f55ce683e3 ("ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early boot")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks, seems like I only built the R-Car Gen2 code without
> CONFIG_HOTPLUG_CPU...
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
