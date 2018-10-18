Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D4ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EBF21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl9Q16J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EBF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJRUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeJRUpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:45:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFA121476;
        Thu, 18 Oct 2018 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539866651;
        bh=32fCN4xt9L4IxiR9xgCypI2wYt5Ldkouwp2PDTtkerY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kl9Q16J+RYJXqI7EBf8XpOjc7tOR6JPUIOe6T4pciyUK0O/AzmCK12bt2WXT8SzKG
         qnHzPZkm4sQqA96Yui83V45IiV+bbW+E03ic5/W0wEKz/Ero9E6V2vsCqAE5IQJ8VF
         D4knO3lRxNh3x6RJPaZlCC2NR8KOBAsSBZM+QWTo=
Date:   Thu, 18 Oct 2018 14:44:09 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: Get rid of toolchain check
Message-ID: <20181018124409.GC1451@kroah.com>
References: <20180913202428.7284-1-abrodkin@synopsys.com>
 <CABGGisxY5yLxT1QDQYOOQYJEJ+Wx8uK3ZmSvPEqvYyfAHbhScQ@mail.gmail.com>
 <4881796E12491D4BB15146FE0209CE6468174FE0@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE6468174FE0@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:28:41PM +0000, Alexey Brodkin wrote:
> Hello,
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Friday, September 14, 2018 12:04 AM
> > To: Alexey.Brodkin@synopsys.com
> > Cc: linux-snps-arc@lists.infradead.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Vineet.Gupta1@synopsys.com
> > Subject: Re: [PATCH] ARC: Get rid of toolchain check
> > 
> > On Thu, Sep 13, 2018 at 3:24 PM Alexey Brodkin
> > <Alexey.Brodkin@synopsys.com> wrote:
> > >
> > > This check is very naive: we simply test if GCC invoked without
> > > "-mcpu=XXX" has ARC700 define set. In that case we think that GCC
> > > was built with "--with-cpu=arc700" and has libgcc built for ARC700.
> > >
> > > Otherwise if ARC700 is not defined we think that everythng was built
> > > for ARCv2.
> > >
> > > But in reality our life is much more interesting.
> > >
> > > 1. Regardless of GCC configuration (i.e. what we pass in "--with-cpu"
> > >    it may generate code for any ARC core).
> > >
> > > 2. libgcc might be built with explicitly specified "--mcpu=YYY"
> > >
> > > That's exactly what happens in case of multilibbed toolchains:
> > >  - GCC is configured with default settings
> > >  - All the libs built for many different CPU flavors
> > >
> > > I.e. that check gets in the way of usage of multilibbed
> > > toolchains. And even non-multilibbed toolchains are affected.
> > > OpenEmbedded also builds GCC without "--with-cpu" because
> > > each and every target component later is compiled with explicitly
> > > set "-mcpu=ZZZ".
> > >
> > > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > > ---
> > >  arch/arc/Makefile | 14 --------------
> > >  1 file changed, 14 deletions(-)
> > 
> > +1 for this. Removing it also helps with my work to be able to build
> > all the .dts files with only a host compiler. That also needs the hunk
> > setting CROSS_COMPILE removed and not having a built-in dtb by
> > default, but this is a step in the right direction.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> May we get this one back-ported to stable trees?
> 
> Upstream commit in Linus' tree is
> 615f64458ad8 ("ARC: build: Get rid of toolchain check").
> 
> This fixes kernel configuration for ARC in case of missing
> ARC cross-tools in current PATH.

Now queued up, thanks.

greg k-h
