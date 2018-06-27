Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098812587B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098812587B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeF0U74 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:59:56 -0400
Received: from mailoutvs16.siol.net ([185.57.226.207]:58381 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933133AbeF0U74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:59:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1C87B52075C;
        Wed, 27 Jun 2018 22:59:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6JQYWWHNhrij; Wed, 27 Jun 2018 22:59:53 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 82380520858;
        Wed, 27 Jun 2018 22:59:53 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id DAF1552075C;
        Wed, 27 Jun 2018 22:59:52 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
Date:   Wed, 27 Jun 2018 22:58:28 +0200
Message-ID: <8012754.crdjCMeE0H@jernej-laptop>
In-Reply-To: <20180627182500.eanqagmcfmsgzos2@flea>
References: <20180627164514.4777-1-jernej.skrabec@siol.net> <20180627182500.eanqagmcfmsgzos2@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a):
> Hi!
> 
> On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > Initial implementation of DE2 planes only supported fixed zpos.
> > 
> > Expand implementation with configurable zpos property.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Thanks for that work. I guess you should expand a bit on the exact
> setup you're doing here.

OK.

> 
> Are the pipes working the same way on the DE2 than on DE1, ie does the
> pipe blending applies before the alpha blending, and therefore you
> need to make sure that there's not two planes with alpha going to the
> same pipe?

I'm not familiar with DE1 and I'm not sure what the problem is.

However, there is an issue in DE2 when alpha blending multiple planes if 
bottom-most plane doesn't cover all screen. In this case alpha blending 
produce weird result on screen. Fortunately, there is elegant solution. Black 
opaque fill color is enabled for pipe 0 (always at the bottom), which covers 
any "undefined region" and that makes alpha blending happy again.

Alternatively, blending modes between planes could be tweaked or disabled, but 
I found aforementioned solution is much simpler and you set it only once.

> 
> Also, you seem to use the pipe and channels indifferently now, why is
> that?

Why do you think so?

Channel always represents HW unit, for example, on H3, mixer0, channel 0 
always represents VI plane, channel 1, represents first UI, plane, channel 2, 
second UI plane, etc.

Pipe 0 always represent channel at the bottom, pipe 1 channel on top pipe 0, 
etc. Initial, fixed zpos implementation really had 1:1 mapping, but now it can 
be different.

Register SUN8I_MIXER_BLEND_ROUTE holds pipe <-> channel mappings.
Bits 3:0 represents pipe 0 and holds channel number. Bits 7:4 represents pipe 
1, etc.

Additionaly,  there can be holes, for example, pipe 3 and pipe 0 are enabled 
and pipe 1 and 2 are disabled.

I hope I answered your questions.

Best regards,
Jernej



