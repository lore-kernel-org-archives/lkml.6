Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5041ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4433521476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYR/+jbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4433521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIPQwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeIPQwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 12:52:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AC120867;
        Sun, 16 Sep 2018 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537097404;
        bh=5wwBxdHbMqJorPf5rINPEs/GVbT2A+SR61fz4HVjMak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fYR/+jbqgBEwq7yXyiDx8ZS5DkXfw/Igm7F/wI3A2itsf66ANyiNSHwJWyf8wUk/M
         /lkUfj8b/PuBuVCHLUfxW9j/zLnnqkm2aUhYVGrQ7bAmJSF19H1G2RdTPOmjt62sXx
         3akUtmOx08EBTQlrvg90zrpJlIFV1hORDhCPXpSM=
Date:   Sun, 16 Sep 2018 12:29:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] spi: add new SPI_CS_WORD flag
Message-ID: <20180916122959.271e4aba@archlinux>
In-Reply-To: <20180913003920.30600-2-david@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-2-david@lechnology.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 19:39:17 -0500
David Lechner <david@lechnology.com> wrote:

> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
> that a SPI device requires the chip select to be toggled after each
> word that is transferred.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Just a general patch ordering / combining comment.

Seems odd to introduce a flag that a driver might use in a patch
preceding any implementations!

I would have combined this with the next patch so the software fallback
would be in place when the ability to turn it on is added.

Jonathan
> ---
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d698f9db3484..7bb36145e2ba 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -163,6 +163,7 @@ struct spi_device {
>  #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> +#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;
> @@ -177,7 +178,6 @@ struct spi_device {
>  	 * the controller talks to each chip, like:
>  	 *  - memory packing (12 bit samples into low bits, others zeroed)
>  	 *  - priority
> -	 *  - drop chipselect after each word
>  	 *  - chipselect delays
>  	 *  - ...
>  	 */

