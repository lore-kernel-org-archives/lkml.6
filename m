Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42220832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B42220832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeK2BSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:18:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33325 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeK2BSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:18:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6972120729; Wed, 28 Nov 2018 15:17:03 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 197D02039F;
        Wed, 28 Nov 2018 15:17:03 +0100 (CET)
Date:   Wed, 28 Nov 2018 15:17:02 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix erase_type array to indicate
 current map conf
Message-ID: <20181128151702.5f8b1bf2@bbrezillon>
In-Reply-To: <2ae2459e-f5e7-f621-fd63-0982a1e59e86@nokia.com>
References: <20181126124531.17548-1-tudor.ambarus@microchip.com>
        <2ae2459e-f5e7-f621-fd63-0982a1e59e86@nokia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, 26 Nov 2018 13:04:45 +0000
"Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
wrote:

> Hello Tudor and all,
> 
> On 26/11/2018 13:45, Tudor.Ambarus@microchip.com wrote:
> > From: Tudor Ambarus <tudor.ambarus@microchip.com>
> > 
> > BFPT advertises all the erase types supported by all the possible
> > map configurations. Mask out the erase types that are not supported
> > by the current map configuration.
> > 
> > Backward compatibility test done on sst26vf064b.
> > 
> > Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
> > Reported-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>  
> 
> I've verified the erasesize, partitioning and erase function of the S25FS128S
> and all the above is at least back to pre-SFDP state.
> 
> So the patch works as intended and it's
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> There is still a regression with write when S25FS128S is used with SFDP
> because SFDP of the S25FS128S is just broken. It advertises 512 bytes
> of write page size but factory delivery configuration wraps the address
> on 256 bytes boundary. I found no way to fetch this configuration in a
> vendor-neutral way (or JEDEC-conform way). Which means, S25FS128S
> could be the first user of SPI_NOR_SKIP_SFDP flag :\.

You might be interested in my work around SPI NOR fixups[1]. I added a
few fixup hooks that can be implemented by manufacturer drivers (a new
concept) or on a per-chip basis. Looks like you'd need to implement a
->post_bfpt() fixup hook for this particular chip (see what's been done
for this Macronix chip [2]).

Regards,

Boris

[1]https://github.com/bbrezillon/linux-0day/commits/spi-nor/manuf-drv
[2]https://github.com/bbrezillon/linux-0day/commit/b29625fdc55fa8ccfd4299904d727b44f8382c18
