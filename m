Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E4C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5547217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548497221;
	bh=I2UcX859a4p55FonVWiR9JFyMZvsSmLxRbyEao2efyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PGAPNfQzMtgXiWiGFbqM928ogoN/U+CDlM3GRzeApexoZ1kP9j0/4Z7k1jwUosUGs
	 sniGt/fbXXRQLl9/LpWEguia9n2gSYbu7q9J7qxdZ9c81yu4IBSQ20piha7Xur8VQQ
	 BL2z5q4Z9HPDRtwHmHuEyj/J5QVQ66E3D0Ds9+SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfAZKHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfAZKG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:06:59 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB66217D7;
        Sat, 26 Jan 2019 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548497218;
        bh=I2UcX859a4p55FonVWiR9JFyMZvsSmLxRbyEao2efyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2nZEvRXnhu32abNeMUHz2YKMqp39/ftDImfo5vijGKKyYIfehnR6l3KTxIUZAvxn4
         nIXKOpC56RcbCaOPCVMP7vhnADwX6/777YICLbQzN0s4Dg8yqEC2OxBJg9F+ZTgaF1
         r2i8ZTkeT1Af1mIxqRzX36yKyUa9XLjcmeMTnqHs=
Date:   Sat, 26 Jan 2019 11:06:48 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] eeprom: at25: Use
 spi_message_init_with_transfers() instead of open coding
Message-ID: <20190126110639.4717ec0e@bbrezillon>
In-Reply-To: <20190118140525.29189-3-geert+renesas@glider.be>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118140525.29189-3-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 15:05:25 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Reduce code duplication in at25_ee_read() by using the
> spi_message_init_with_transfers() helper.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/misc/eeprom/at25.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 2d8e5388e574710d..18a093e14517ab45 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -103,16 +103,15 @@ static int at25_ee_read(void *priv, unsigned int offset,
>  		*cp++ = offset >> 0;
>  	}
>  
> -	spi_message_init(&m);
>  	memset(t, 0, sizeof(t));
>  
>  	t[0].tx_buf = command;
>  	t[0].len = at25->addrlen + 1;
> -	spi_message_add_tail(&t[0], &m);
>  
>  	t[1].rx_buf = buf;
>  	t[1].len = count;
> -	spi_message_add_tail(&t[1], &m);
> +
> +	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
>  
>  	mutex_lock(&at25->lock);
>  

