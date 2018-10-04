Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD30F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJDSKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:10:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33899 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeJDSKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:10:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D6AEF207C8; Thu,  4 Oct 2018 13:17:42 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7F98220703;
        Thu,  4 Oct 2018 13:17:32 +0200 (CEST)
Date:   Thu, 4 Oct 2018 13:17:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
Message-ID: <20181004131732.4c9e2ae9@bbrezillon>
In-Reply-To: <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003212017.653e739f@bbrezillon>
        <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 16:05:36 +0530
Vignesh R <vigneshr@ti.com> wrote:

> >>
> >>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
> >>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++  
> > 
> > On a slightly different topic, do you plan to convert the Cadence
> > driver to spi-mem? And if you don't, is it because you don't have time
> > or because some features are missing in spi-mem (I remember you
> > mentioned a few things back when you were reviewing the spi-mem series)?
> >   
> 
> I do not have plans to convert cadence QSPI driver to spi-mem yet,
> mainly due to lack of time. Also, not sure if original author Marek and
> other altera people are okay with that.
> 
> I see couple of issues in the way of conversion:
> 1. I would wait to know what direction would direct mapping APIs[1] go
> before starting spi-mem conversion for Cadence QSPI driver. Else, we
> have may to re write again if direct mapping APIs are merged.

I'd suggest reviewing the proposal I posted so that you can influence
the design of this new API ;-).

> 2. New Cadence OSPI IP has an integrated PHY to support high throughput
> OSPI flashes operating up 200MHz in Octal DDR mode. In order to work
> with such flashes, PHY DLLs need to be calibrated. Highly simplified
> calibration sequence is as below(See [2] for actual sequence):
> -Read flash ID at low speed and store it.
> -Enable PHY and set DLLs to a defined initial value
> -Increment RX DLL value
> -Read flash ID and check for correctness of data read
> -repeat above two steps until a band of passing values is obtained for
> RX DLL where flash ID is correctly read.
> -DLL needs to set to middle of the passing band.

Is the Read ID operation hardcoded or do you just use it as a way to
trigger predictable transfers on the IO bus?

> 
> I am trying to figure out how to fit this into the spi-mem framework as
> controller would to need to store READ ID opcode and expected JEDEC ID
> before starting calibration sequence.

I think this should be split in 2:

- the SPI NOR framework passing the operation to use to do the
  calibration (here a READ ID)
- the SPI controller framework replaying the same operation with
  different DLL configs until it finds the best match

So, it would basically be added as a new hook:

	int (*calibrate)(struct spi_mem *mem,
			 const struct spi_mem_op *tmpl);

and a new function provided by the spi-mem API

int spi_mem_calibrate(struct spi_mem *mem,
		      const struct spi_mem_op *tmpl);

and calibration outcome would be somehow attached to the spi_mem
object.

This way we stay memory agnostic but still provide the necessary blocks
at the spi-mem level to do such callibrations.

Would that work?
