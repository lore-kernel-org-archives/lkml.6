Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC1C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6A621736
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549114072;
	bh=l1pN7fuz+BKbmI/D8YM/7srSCmBdVjJ27CH/CyauKFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e86V2e5j6pmFB2kMsXckqf8wcF331lGZKvgggunBLKsNLKpfumnOTH2JvHxtmK5Ur
	 Jd8cmorbR+oAw1HIHv3HvwWnwuKC5L0zPejb7LAICXozvpgx0+IjGgPxo1O1vXn5a5
	 YseRhZ0UoXL74krwNjuJQ4Nsb5XQYTrYVF7o05cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfBBN1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfBBN1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:27:51 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711E520869;
        Sat,  2 Feb 2019 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549114070;
        bh=l1pN7fuz+BKbmI/D8YM/7srSCmBdVjJ27CH/CyauKFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xp1wr5/CWTOk7dRloeQtPVWS+lwH0Rq2t+VPVYyR97WS4VUo8FBuI6F0sVWDhi3Mq
         h+lPmTz/lxA5jHfAGdNtG1IbmTZ8ixIln3JZWaI6GE4h2ehpA7F0Mqswv4W3l5j9sk
         3jSJfl0RmftkaKTLNmssKDPkbGgUCLfIpR3NBKCI=
Date:   Sat, 2 Feb 2019 14:27:36 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP
 transfer macros
Message-ID: <20190202142736.5d723ed6@bbrezillon>
In-Reply-To: <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-9-tudor.ambarus@microchip.com>
        <20190202081338.01056dce@bbrezillon>
        <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 08:46:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:13 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:33 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Remove NOP when setting read transfer type. Remove useless
> >> setting of write transfer type when
> >> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
> >>
> >> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
> >> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: new patch
> >>
> >>  drivers/spi/atmel-quadspi.c | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index d26d4cd0e36b..bfa5f5e92d96 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -113,11 +113,7 @@
> >>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
> >>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
> >>  #define QSPI_IFR_ADDRL                  BIT(10)
> >> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> >> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)  
> > 
> > Can you define QSPI_IFR_TFRTYP_MEM (bit 12) even if it's not used yet?  
> 
> Shouldn't be introduced with the dir map support?

I like when all regs/reg-fields are defined, even if they're not used.
In this case, you're cleary splitting the TFRTYP_TRSFR_ bitfields in 2:
one bit encoding the mem/reg transfer type and one bit encoding the
direction of the transfer (read/write). Just think it's better to add
bit 12 definition now.
