Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33645224F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33645224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbeGFT13 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:27:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934493AbeGFT12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:27:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C94F12079C; Fri,  6 Jul 2018 21:27:25 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 83EB82069C;
        Fri,  6 Jul 2018 21:27:25 +0200 (CEST)
Date:   Fri, 6 Jul 2018 21:27:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180706212720.0e9dacb8@bbrezillon>
In-Reply-To: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
References: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 10:44:42 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Hi,
> 
> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip

Hm, it's even worse than I thought. The model name does not include the
-ITE suffix (E means ECC can't be disabled), which means we have no way
to detect the version with forced on-die ECC.

I see 2 solutions to this problem:
1/ Bean provides us a solution to reliably detect when ECC can be
   de-actived and when it can't
2/ We only ever expose 64 bytes of OOB to the user and consider that
   ECC can be disabled, even if it can't in reality

I wonder when NAND vendors will care about this sort of stuff. It's
really a mess to deal with all these quirks, and it's even worse when
we have no way to detect when the quirks are needed and when they're
not. Device detection is broken in so many ways, and each new chip
brings with it its own brokenness.

> to one of our boards which uses the Marvell NFCv2 controller.
> 
> This particular chip is a bit odd in that the datasheet states support
> for ONFI 1.0 but the revision number field is 00 00. It also is marked
> ABAFA but reports internally as ABAGA. Finally it has internal 8-bit ECC
> which cannot be disabled.
> 
> The existing test in micron_supports_on_die_ecc() determines that on-die
> ECC is supported but not mandatory but I know for this chip it is
> mandatory despite what set_features returns.
> 
> In order for this to work I need to set nand-ecc-mode = "on-die" in my
> dts. Ideally I'd like it to be automatic based on what the hardware can
> support but that may be asking too much at the moment.
> 
> Here's a dump of the parameter page from the chip I have
> 
> 00000000: 4f 4e 46 49 00 00 18 00 3f 00 00 00 00 00 00 00 ONFI....?.......
> 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00000020: 4d 49 43 52 4f 4e 20 20 20 20 20 20 4d 54 32 39  MICRON MT29
> 00000030: 46 31 47 30 38 41 42 41 47 41 57 50 20 20 20 20  F1G08ABAGAWP    
> 00000040: 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ,...............
> 00000050: 00 08 00 00 80 00 00 02 00 00 20 00 40 00 00 00  ..........  .@...
> 00000060: 00 04 00 00 01 22 01 14 00 01 05 08 00 00 04 00 ....."..........
> 00000070: 08 01 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00000080: 08 3f 00 3f 00 58 02 10 27 46 00 64 00 00 00 00 .?.?.X..'F.d....
> 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 000000a0: 00 00 00 00 01 00 00 00 00 02 04 80 01 81 04 03 ................
> 000000b0: 02 01 1e 90 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 85 a6 ................
> 
> Series changes in v3:
> - No longer RFC
> - dropped "mtd: rawnand: micron: add ONFI_FEATURE_ON_DIE_ECC to supported
>   features" which Boris has already picked up
> - dropped "mtd: rawnand: marvell: Support page size of 2048 with 8-bit ECC"
>   since I can't test it.
> 
> Series changes in v4:
> - based on top of http://patchwork.ozlabs.org/patch/932006/
> 
> Series changes in v5:
> - address review comments from Boris on patches 5 and 6
> 
> Series changes in v6:
> - Update commit message on 6/6
> 
> Chris Packham (6):
>   mtd: rawnand: marvell: Handle on-die ECC
>   mtd: rawnand: add manufacturer fixup for ONFI parameter page
>   mtd: rawnand: add defines for ONFI version bits
>   mtd: rawnand: micron: add fixup for ONFI revision
>   mtd: rawnand: micron: support 8/512 on-die ECC
>   mtd: rawnand: micron: detect forced on-die ECC
> 
>  drivers/mtd/nand/raw/marvell_nand.c |   1 +
>  drivers/mtd/nand/raw/nand_base.c    |  14 +--
>  drivers/mtd/nand/raw/nand_micron.c  | 129 +++++++++++++++++++++++-----
>  include/linux/mtd/rawnand.h         |  14 +++
>  4 files changed, 131 insertions(+), 27 deletions(-)
> 

