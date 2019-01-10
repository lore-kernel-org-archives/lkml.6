Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01569C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15A4213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547148333;
	bh=/vR7LskhHHSTMwzevIJBqkXpkfEf+ABm3ogsIzBsb7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fnI+5Zn70jKiWeFcwqWPcaWv5994PnZjIqq5/MKtckKyQwCAWfQxOlZJnAbEhAYwN
	 NBtY1P9GVmMp0FbAgOmGxcE+6jIXfP1bPyXfEavrgTFY4SVvIXFFd9MpAjzFygTGrW
	 /03F3i/nb1h1NHZ/pPcRJ4BjSUpGhiFBEX8gbP+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfAJTZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfAJTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:25:32 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8C220651;
        Thu, 10 Jan 2019 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547148331;
        bh=/vR7LskhHHSTMwzevIJBqkXpkfEf+ABm3ogsIzBsb7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fIJpWIzwCdjQEVAZMDq4Sh4f4Spa7TVjYDR++txQnfi9dt8G1NrWTnSCC1pXE1Wz6
         kCe+BtkENC9yf+/aKLqxIFroKdM6mQkex7hzm3e0NGbrPp1sFTNuX1cpuQgZqf74Zd
         ZQFaqlTSB/hfEdogklntQVSZCa3sSBn2T1IPHfBc=
Date:   Thu, 10 Jan 2019 20:25:22 +0100
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
Message-ID: <20190110202522.10206f2d@bbrezillon>
In-Reply-To: <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
        <20190110151020.30468-5-peda@axentia.se>
        <20190110182904.5efd08f2@bbrezillon>
        <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 18:51:21 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2019-01-10 18:29, Boris Brezillon wrote:
> > On Thu, 10 Jan 2019 15:10:48 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> The A2Q and UPDATE bits have no effect in the channel disable registers.
> >> However, since they are present, assume that the intention is to disable
> >> planes, not immediately as indicated by the RST bit, but on the next
> >> frame shift since that is what A2Q and UPDATE means in the channel enable
> >> registers.
> >>
> >> Disabling the plane on the next frame shift is done with the EN bit,
> >> so use that.  
> > 
> > It's been a long time, but I think I had a good reason for forcing a
> > reset. IIRC, when you don't do that and the CRTC is disabled before the
> > plane, the EN bit stays around, and next time you queue a plane update,
> > you'll start with an invalid buf pointer.  
> 
> It might be possible to clear the EN bit in ...CHDR before enabling the
> plane in ...CHER. Or is that too late?

I think I tried that, but I'm not sure (BTW, this change was done in
bd4248bb5e8b ("drm: atmel-hlcdc: reset layer A2Q and UPDATE bits when
disabling it")). Anyway, I'm not even sure this is still needed now
that atomic updates have a wait_for_flip_done/vblank() in the commit
path.

> But this patch is not overly
> important, I just wanted to avoid the resulting "black hole" when the
> plane DMA is disabled mid-frame. But disabling planes is probably not
> something that happens frequently and will perhaps not be noticed at
> all...

Okay. Other patches look good to me, I'm just waiting for Nicolas
feedback before applying them.
