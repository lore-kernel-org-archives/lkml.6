Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E64C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000020880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="QRrEOPQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B000020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeLJLrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:47:32 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41201 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeLJLrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:47:32 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id CC0DD25BED1;
        Mon, 10 Dec 2018 22:47:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544442450; bh=tSVaXCukbgorCqiFxHfZ+CVrQcmhnfis+Qg8vIjvVqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRrEOPQzlXVK3FIvdlrEAvs0wTUyjC/0lqVzrZz+bGLNCcOXEBMY3zqaLp6JLzpSn
         nU3eG8FCFeZeDljOuuF9Xb8/godwXOV7Kf3fSH0/aUOUsS55cSR4OHWVIuvE2yZXMf
         KD6VENDUr3v4OVpbBf/Kq/ovdqrq4yO3v8kSCGPU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4224F9402E1; Mon, 10 Dec 2018 12:47:28 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:47:28 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] soc: renesas: rcar-sysc: Fix power domain control
 after system resume
Message-ID: <20181210114727.patvtrdtpzobzqgt@verge.net.au>
References: <20181205153945.13767-1-geert+renesas@glider.be>
 <20181205153945.13767-5-geert+renesas@glider.be>
 <20181205212112.2ls6ta27ok3yiyco@verge.net.au>
 <CAMuHMdW9kt3QyoJRkKA6c8OpCB7N-jEAo=qcxjhmy3nD2a0A9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW9kt3QyoJRkKA6c8OpCB7N-jEAo=qcxjhmy3nD2a0A9Q@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:22:24AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Dec 5, 2018 at 10:21 PM Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Dec 05, 2018 at 04:39:45PM +0100, Geert Uytterhoeven wrote:
> > > To control power to a power domain, the System Controller (SYSC) needs
> > > the corresponding interrupt source to be enabled, but masked, to prevent
> > > the CPU from receiving it.
> > >
> > > Currently this is handled in the driver's probe() routine, and set up
> > > for every domain present, even if it will not be controlled directly by
> > > SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).
> > >
> > > On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
> > > loosing any configured interrupt state.  Hence after system resume, power
> > > domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
> > > power up.
> >
> > I corrected the spelling of losing when applying this patch.
> 
> Checkpatch complained about that as well, so I did some investigation, and
> decided to keep it... Was I wrong?

I will not claim to be an expert but  at the time I thought
checkpatch was right.
