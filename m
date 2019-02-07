Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13521916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="MX6TWWQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBGPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:55 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:57085 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:52 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 772D525B7E2;
        Fri,  8 Feb 2019 02:22:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549552968; bh=0Gg+/3ZS/T5JMLaXR2tKuPZLfBl6dZRemVfHwM4Rw/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MX6TWWQwhgjTNzcV8CcbAvZC1UH+MEyg+7At1XdP7APfv8YYeO67mw7ZG7bK1XR7J
         E/QyizHlAYm055380he/Vkvc6DkIKqQutLRWhr4xYIIsBldvLrGFKdOQU2CbGQrgBq
         jMgzLsg6/w8qNffmSmb7p+iacPL70OMacsfOEQso=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 816829444AA; Thu,  7 Feb 2019 16:22:46 +0100 (CET)
Date:   Thu, 7 Feb 2019 16:22:46 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] clk: renesas: rcar-gen3: Support Z and Z2 clocks
 with high frequency parents
Message-ID: <20190207152242.xzxfvojyyvsqhmtt@verge.net.au>
References: <20190207133550.13967-1-horms+renesas@verge.net.au>
 <20190207133550.13967-4-horms+renesas@verge.net.au>
 <CAMuHMdUMeGEnkVDvVk=NZMrnNXDUxDOgcqfORf+My8jkCza3SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUMeGEnkVDvVk=NZMrnNXDUxDOgcqfORf+My8jkCza3SA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:05:58PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Feb 7, 2019 at 2:36 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > Support Z and Z2 clocks with parent frequencies greater than UINT32_MAX Hz
> > (~4.29GHz).
> >
> > The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
> > divisor. This leads to truncation of the dividend, which is the Z or Z2
> 
> truncation of the divisor.
> 
> > parent clock frequency in HZ, on platforms where frequency of that clock is
> > greater than UINT32_MAX Hz.
> >
> > To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which an
> 
> which takes an
> 
> > unsigned 32bit dividend and divisor, is introduced.
> 
> 64-bit
> 
> > An earlier version of this patch made use of the existing
> > DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
> > dividend and divisor. However, this does not compile on 32bit systems, such
> > as i386 and mips, when called with the types used at this callsite, an
> > unsigned long long dividend and unsigned long divisor.
> 
> Thanks for fixing this!
> 
> > This work is in preparation for supporting the Z2 cloco on the R-Car Gen3
> > E3 (r8a77990) SoC which has a 4.8GHz parent clock.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > ---
> > v4: Add and use DIV64_U64_ROUND_CLOSEST
> >
> > v2: New patch
> > ---
> >  drivers/clk/renesas/rcar-gen3-cpg.c |  4 ++--
> >  include/linux/math64.h              | 13 +++++++++++++
> 
> While I have no issue taking this change through the clk-renesas tree if
> Andrew provides his Acked-by, I think the introduction of
> DIV64_U64_ROUND_CLOSEST() should be a separate patch.
> 
> However, given commit 68600f623d69da42 ("mm: don't miss the last page
> because of round-off error") added both DIV64_U64_ROUND_UP() and its
> user under mm/, there's precedence for not splitting it off...

I also assumed a separate patch would be better,
but I found little evidence of that practice being
recently used in math64.h.

In any case, as I need to respin I'll break it out into
a separate patch.
