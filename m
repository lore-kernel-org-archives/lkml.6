Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF63C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF0420882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF0420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGJAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:00:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeLGJAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:00:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EAAEA20711; Fri,  7 Dec 2018 10:00:19 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id A0F5E20701;
        Fri,  7 Dec 2018 10:00:09 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:00:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <Cyrille.Pitchen@microchip.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: parse SFDP 4-byte Address Instruction
 Table
Message-ID: <20181207100009.5e2bb49a@bbrezillon>
In-Reply-To: <20181206144330.30860-1-tudor.ambarus@microchip.com>
References: <20181206144330.30860-1-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Thu, 6 Dec 2018 14:43:39 +0000
<Tudor.Ambarus@microchip.com> wrote:

>  /**
>   * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
>   * @nor:		pointer to a 'struct spi_nor'
> @@ -3276,6 +3462,10 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  			err = spi_nor_parse_smpt(nor, param_header);
>  			break;
>  
> +		case SFDP_4BAIT_ID:
> +			err = spi_nor_parse_4bait(nor, param_header, params);
> +			break;
> +
>  		default:
>  			break;
>  		}
> @@ -3857,7 +4047,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	    (JEDEC_MFR(info) == SNOR_MFR_SPANSION && mtd->size > SZ_16M))
>  		nor->flags |= SNOR_F_4B_OPCODES;
>  
> -	if (nor->addr_width == 4 && nor->flags & SNOR_F_4B_OPCODES)
> +	if (nor->addr_width == 4 && nor->flags & SNOR_F_4B_OPCODES &&
> +	    !(nor->flags & SNOR_F_HAS_4BAIT))
>  		spi_nor_set_4byte_opcodes(nor);

The list of checks is growing. Maybe we could move those checks
at the beginning of spi_nor_set_4byte_opcodes() so we can
unconditionally call spi_nor_set_4byte_opcodes() here.
Not something I ask you to fix in this patch, just thinking out loud.

The rest of the patch looks good, but I'm pretty sure we'll run into
trouble as soon as we start parsing this 4BAIT section (as has been the
case for all other SFPD sections so far), just because vendors tend to
get this sort of things wrong. I don't have a solution for that other
than the proposed SFDP fixup hooks infrastructure [1] or the more
conservative "don't parse/trust SFDP" approach. Note that, even if we
go for the SFDP fixups approach, we might still break setups where the
4BAIT section of the SFDP table is broken until someone comes with a
fixup for those broken chips.

Since I don't like to block inclusion of new features for purely
theoretical issues, I'm in favor of applying this patch, but be
prepared to receive bug reports during the 4.21-rc cycle ;-).

Regards,

Boris

[1]http://patchwork.ozlabs.org/patch/1008687/
