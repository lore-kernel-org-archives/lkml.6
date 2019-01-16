Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BBC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547649960;
	bh=RpxCb7uIWRRnSDY18jtHaRcDC4JxCs48Xtr9FHci1pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MwEdzM8wKC+lLPJBHGPAkZb4rwPzkFrvtWw7joIRVvp4utv9PcOD6PkyeTCQ2DGR1
	 lSr98acVqj9stFg0w2rDfT2C5H3NortbYJ3osNX0RgfFvQ5S9EEUBhhhdy2pGgX61E
	 khheecQpHnquKhzmkGbdYn4HUpLM2c36w8D/DES4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfAPOp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbfAPOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:45:58 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F72520657;
        Wed, 16 Jan 2019 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547649958;
        bh=RpxCb7uIWRRnSDY18jtHaRcDC4JxCs48Xtr9FHci1pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cR/DhM8fX69O18yQo6C4R4q1WzitweTNFkCofTQiA4aGLy0Gh18x97b+adlHkewQc
         3/WLhtWa1yHvP9aYeMhMrcitAgof465jSeVxkHx+Ttnq/1Uh0imMB1TUPA9WOzKdD7
         9Bh3ON1HQnPneSShoSJvkq5VvDEPvqlID4TKgMiY=
Date:   Wed, 16 Jan 2019 15:45:47 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Message-ID: <20190116154547.711d7087@bbrezillon>
In-Reply-To: <e35d6894-fd62-efd1-38f7-cc5cbdbbacbb@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
        <20190110151020.30468-5-peda@axentia.se>
        <20190110182904.5efd08f2@bbrezillon>
        <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
        <20190110202522.10206f2d@bbrezillon>
        <e35d6894-fd62-efd1-38f7-cc5cbdbbacbb@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 14:29:28 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-10 20:25, Boris Brezillon wrote:
> > On Thu, 10 Jan 2019 18:51:21 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On 2019-01-10 18:29, Boris Brezillon wrote:  
> >>> On Thu, 10 Jan 2019 15:10:48 +0000
> >>> Peter Rosin <peda@axentia.se> wrote:
> >>>     
> >>>> The A2Q and UPDATE bits have no effect in the channel disable registers.
> >>>> However, since they are present, assume that the intention is to disable
> >>>> planes, not immediately as indicated by the RST bit, but on the next
> >>>> frame shift since that is what A2Q and UPDATE means in the channel enable
> >>>> registers.
> >>>>
> >>>> Disabling the plane on the next frame shift is done with the EN bit,
> >>>> so use that.    
> >>>
> >>> It's been a long time, but I think I had a good reason for forcing a
> >>> reset. IIRC, when you don't do that and the CRTC is disabled before the
> >>> plane, the EN bit stays around, and next time you queue a plane update,
> >>> you'll start with an invalid buf pointer.    
> >>
> >> It might be possible to clear the EN bit in ...CHDR before enabling the
> >> plane in ...CHER. Or is that too late?  
> > 
> > I think I tried that, but I'm not sure (BTW, this change was done in
> > bd4248bb5e8b ("drm: atmel-hlcdc: reset layer A2Q and UPDATE bits when  
> 
> That patch is a big fat NOP if you read the documentation. Those bits
> are marked with a '-' for all LCDC channel disable registers, for all
> supported chips IIUC. Are the effects of those bits mentioned in any
> errata?

IIRC, it was not documented in the datasheet, but this came out during
a discussion with the IP designer.

> 
> It would be good with a comment that the present undocumented disable
> method is intentional.

Yes, I should have added a comment about that, my bad.

> That would have kept me from assuming the whole
> thing was just copy-paste junk from ..._enable that happened to work.
> 
> >> disabling it")). Anyway, I'm not even sure this is still needed now
> >> that atomic updates have a wait_for_flip_done/vblank() in the commit
> >> path.  
> 
> The documentation for the RST bit states "Resets the layer immediately.
> The frame is aborted." which sounds a bit scary and heavy-handed. But
> again, I don't know what that actually means and what the effects are
> but that was the reason for me wanting to avoid the RST bit.

As I said, I'm not even sure the problem I was trying to fix still
exists.
