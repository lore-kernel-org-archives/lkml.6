Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA07C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69062087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549291042;
	bh=AvnNVAT8ciem9UZ+hOBYnQRHq5c1WtwKWaoN/SqJE1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R1FMuuwI56qDWOxJT2PDjsJrMiyUDV4TNTaAN/tqUb4aUQV3okIQsgdlyvM1p/UNR
	 uPp8TTSD+xQ9F51OaMZjif9h4H5lWxcWGgA3Yk7AbB/NZcoooUmraWWYtsVk4Ny1rc
	 qnD0L3ZTijOoUhUSFwZfLNl36XVxw8T+eL4YqKOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfBDOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfBDOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:37:20 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45D02083B;
        Mon,  4 Feb 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549291040;
        bh=AvnNVAT8ciem9UZ+hOBYnQRHq5c1WtwKWaoN/SqJE1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9wcUqx16D0Z44oXAovv0qLuy8bpGQs+aMSlqCZXzffcFJmKWlBUjK5ogbIGVwKg0
         g8MtQN46FSizXq4NUpNzF3mDpNvCbEJ5oL1BBmN8yk98YCq+3AteWrUZbeP/yTS5H+
         eigbPgDylxQsz8W2VCwWZwQMPKiLCAZhXxajmkmg=
Date:   Mon, 4 Feb 2019 15:37:13 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190204153713.2fd02769@bbrezillon>
In-Reply-To: <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
        <20190204100910.26701-14-tudor.ambarus@microchip.com>
        <20190204151643.0354180d@bbrezillon>
        <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 14:28:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >   
> >> +	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
> >> +}  
> > 
> > Hm, so the only difference we have is the RICR vs ICR reg and the
> > APBTFRTYP_READ vs SAMA5D2_WRITE_TRSFR bit. Not sure it deserves
> > creating 2 hooks for that. Can we have something like ->has_ricr in
> > the caps and then have an if/else block directly in
> > atmel_qspi_set_cfg()?
> >   
> 
> Correct. It is a cost of an extra if, I tried to avoid it. I like it better with
> these two hooks, but if you have a strong opinion I'll do it, just confirm it again.

The cost of an indirect call is actually higher than an extra if/else
block. I'm not against paying this extra cost when implementations are
completely different, but that does not seem to be the case here.
Moreover, if you get rid of these hooks, you can also get rid of the
cfg struct.
