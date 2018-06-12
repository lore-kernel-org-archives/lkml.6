Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 477AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2787208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2787208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeFLHWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:22:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932944AbeFLHWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:22:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 691D520A20; Tue, 12 Jun 2018 09:22:49 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 129312073C;
        Tue, 12 Jun 2018 09:22:49 +0200 (CEST)
Date:   Tue, 12 Jun 2018 09:22:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     NeilBrown <neil@brown.name>
Cc:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Message-ID: <20180612092248.4e6a3e92@bbrezillon>
In-Reply-To: <87r2ldj7xi.fsf@notabene.neil.brown.name>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180611114916.351ed272@bbrezillon>
        <87r2ldj7xi.fsf@notabene.neil.brown.name>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, 12 Jun 2018 08:05:13 +1000
NeilBrown <neil@brown.name> wrote:

> On Mon, Jun 11 2018, Boris Brezillon wrote:
> >
> > Also, I'd prefer to have this patch split in 2:
> > 1/ one patch removing the check in spi_nor_write()
> > 2/ and the second patch removing the while() loop in m25p80_write()
> >
> > How about the following commit messages for those 2 patches:
> >
> > 1:
> > "
> > mtd: spi-nor: Support controllers with limited TX FIFO size
> >
> > Some SPI controllers can't write nor->page_size bytes in a single step
> > because their TX FIFO is too small.  
> 
> I no longer think this is good justification for changes to m25p80 or to
> anything outside the low-level SPI driver.  The size of the FIFO is not
> related to the maximum message size.
> 
> An SPI transaction involves:
>  - asserting chip-select
>  - sending/receiving a bunch of bits
>  - deasserting chip-select
> 
> That middle part of sending/receiving bits can be done:
>  - one bit at a time by bit-banging GPIOs
>  - 32 bytes at a time by filling a buffer, running the SPI engine, then
>     reading results out of the buffer (assuming a 32-byte buffer)
>  - with one single DMA operation if the SPI engine can DMA to/from
>    main memory
> 
> and there are probably other options.
> 
> If your SPI engine only handles (say) 32 bytes at a time, then call it
> repeatedly, while holding chip-select asserted the whole time.

Except you're not necessarily in control of the CS signal, and that's
most of the time the case with high-level (Q)SPI mem controllers like
the NXP/FSL QSPI controller (see the datasheet here if you want to check
[1]).

> The SPI
> clock is controlled by the host and in this case it will not have a
> stable frequency for the whole transaction (occasionally pauses), but
> that doesn't matter.  The slave just watches for the clock transitions
> and don't care when they come as long as they don't come too fast.
> 
> I recently modified the mt7621 spi driver (in drivers/staging) to work
> like this and got much better throughput when reading from spi-nor flash
> memory.  It handles writes of full pages (36 bytes at at time!) without
> problems.

Just because you managed to solve the problem in one driver does not
mean the problem does not exist for others. I read this datasheet [1]
several times and couldn't find a way to say 'I want to keep the CS
asserted between 2 transactions', so I think we really need this patch.

Regards,

Boris

[1]https://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf
