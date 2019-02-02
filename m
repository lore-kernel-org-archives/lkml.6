Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53164C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D802173B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549113663;
	bh=KsuDKuKlJQAE474thXEYS0gFc9Y879d0/apCZUyA2BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=leeXLH/yj+q+vs1uMa84pwjXgsckiwA9RC8S4Dr5P3SMld7no66glaVJUIJgtNUq7
	 Cgjq3K4d5IirjaCwGTkqmaUMkg7OqHmMXJxI+hnhgcZJ9OHTjIvhyMNgOpmfdTKdjk
	 zXAz+WGKLsCPK4NOMbTJbQyjximGi0fo274KaA8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBBNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfBBNUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:20:43 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9682173B;
        Sat,  2 Feb 2019 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549113641;
        bh=KsuDKuKlJQAE474thXEYS0gFc9Y879d0/apCZUyA2BU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yvn9i/T2YxRQ61YiDLwBBRswAL47uWfTMzRseCidx4/oSP5KHtFEi4EqDwqd2vnMH
         BXlWwtA8Jn3yaPKxyNZ3MdUcPWwt7lCFAJppVeqndFKVzXmHvtyIrvHtQrAwUr3XNj
         iayI1CXdSAhgQf2EiWgoD48l/4oVA6cr2v3UFo0M=
Date:   Sat, 2 Feb 2019 14:20:29 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <bugalski.piotr@gmail.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190202142029.76ac36b6@bbrezillon>
In-Reply-To: <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-2-tudor.ambarus@microchip.com>
        <20190202080650.44becc2d@bbrezillon>
        <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 08:38:40 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:06 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:13 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Cache Serial Memory Mode (SMM) value to avoid write access when
> >> setting the controller in serial memory mode. SMM is set in
> >> exec_op() and not at probe time, to let room for future regular
> >> SPI support.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: update smm value when different. rename mr/smm
> >> v2: cache MR value instead of moving the write access at probe
> >>
> >>  drivers/spi/atmel-quadspi.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index ddc712410812..645284c6ec9a 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -155,6 +155,7 @@ struct atmel_qspi {
> >>  	struct clk		*clk;
> >>  	struct platform_device	*pdev;
> >>  	u32			pending;
> >> +	u32			smm;
> >>  	struct completion	cmd_completion;
> >>  };
> >>  
> >> @@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >>  	icr = QSPI_ICR_INST(op->cmd.opcode);
> >>  	ifr = QSPI_IFR_INSTEN;
> >>  
> >> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> >> +	/* Set the QSPI controller in Serial Memory Mode */
> >> +	if (aq->smm != QSPI_MR_SMM) {  
> > 
> > Sorry, I think I misunderstood your previous suggestion, I thought the
> > reg was called SMM. If the reg is called MR and the value you expect in
> > there is SMM, then the field should be named ->mr as it caches the
> > whole reg, not only the SMM bit. So it's actually:
> > 
> > 	if (aq->mr != QSPI_MR_SMM) {  
> 
> No worries. When keeping the reg name, and not the bit itself, I would expect to
> do the check as in v2, to let room for checking other bits too:
> 
> +	if (!(aq->mr & QSPI_MR_SMM))
> 
> I don't have any problems to keep "mr" name, but I would like to understand your
> reasons.

Either you want to only set the SMM bit and keep the other bits
untouched or you want to make sure the register contains the value you
expect for all bitfields. If you're trying to achieve the former, you
should only update SMM instead of setting SMM + clearing all other
bits. In the other hand, if you want to apply a new MR setting where
you know exactly that only SMM should be set, that means you should
test the value in the cache (->mr) against the value you expect, and
not only the check that QSPI_MR_SMM is set.

BTW, you should probably initialize ->mr at probe time (using a
readl_relaxed()).
