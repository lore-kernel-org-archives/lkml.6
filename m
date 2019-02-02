Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AE92086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549113839;
	bh=YYuVGPM0JmRr/Umuc+MgJly7841AA9DjCf5V59+o7Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fozkM5ucZZpDa+HaFZH/4KyDMo2t+vV33axyYtHN/75KVi7/6qs2hUzuCC5LvdDIf
	 16NAIMRzZ0sOvRZKXjSQsfSLgQ/bRrmGwg/4aL0CxrE/NIYAjkOS52GtLCC3Qkz19n
	 llU1lhwk/7OY8mSsr8dPhnmKI9o5qYV/Mw5XfRTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBBNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfBBNXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:23:51 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653382173B;
        Sat,  2 Feb 2019 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549113829;
        bh=YYuVGPM0JmRr/Umuc+MgJly7841AA9DjCf5V59+o7Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=se9hoaNHQ2E7qpQ4RKfZDAbyUs+bv2e+UQx+UgS9jh14h0ym6ZBgDUwFLiBiv1BA4
         6inOl6dlMW/yKZ6MNceWGJN0Rtga5JZNSbIGMuym3Fkz+J1icASXDPRygX7Fx1p92h
         EyZCeGIuz4tgZEb+E8nwKIwuEbYt9JdJzs6p2jNY=
Date:   Sat, 2 Feb 2019 14:23:37 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Message-ID: <20190202142337.3c51947e@bbrezillon>
In-Reply-To: <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-4-tudor.ambarus@microchip.com>
        <20190202081111.0bbc4443@bbrezillon>
        <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 08:44:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:11 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:19 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> The wrappers hid that the accesses are relaxed. Drop them.
> >>
> >> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: no change
> >> v2: new patch
> >>
> >>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
> >>  1 file changed, 20 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index feeddcb25e1f..131374db0db4 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
> >>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
> >>  };
> >>  
> >> -/* Register access functions */
> >> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> >> -{
> >> -	return readl_relaxed(aq->regs + reg);
> >> -}
> >> -
> >> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> >> -{
> >> -	writel_relaxed(value, aq->regs + reg);
> >> -}
> >> -
> >>  static inline bool is_compatible(const struct spi_mem_op *op,
> >>  				 const struct qspi_mode *mode)
> >>  {
> >> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
> >>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >>  {
> >>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> >> +	void __iomem *base = aq->regs;  
> > 
> > Can we name this variable regs instead of base or even get rid of it
> > and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
> > the lines would be over 80 chars even when doing that). With this
> > addressed, you can add:
> > 
> > Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>  
> 
> I chose to introduce the "base" variable when I have at least 2 dereferences in
> a function, as an optimization. In exec_op() for example, there are 6
> dereferences of aq->reqs. Why do you prefer keeping aq->regs?

I tend to not add local variables unless they help improve readability
or optimize things. In this case, I'd expect the compiler to be smart
enough to detect that aq->reqs is used several times and store it in a
register. When it comes to readability, I don't think it improve
things, but that's probably a matter of taste.
