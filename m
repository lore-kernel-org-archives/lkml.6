Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A75CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDF620856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeL1AZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:25:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeL1AZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:25:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3B5B14E0982C;
        Thu, 27 Dec 2018 16:25:07 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:25:07 -0800 (PST)
Message-Id: <20181227.162507.1378702299026670300.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wan: fix a missing check of spi_write_then_read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226043443.74229-1-kjlu@umn.edu>
References: <20181226043443.74229-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:25:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 22:34:41 -0600

> When spi_write_then_read() fails, "data" can be uninitialized and thus
> may contain a random value; the following execution checks "data" with a
> mask, the result could be random.
> 
> The fix inserts a check of spi_write_then_read(): if it fails, always
> returns -1.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/wan/slic_ds26522.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/slic_ds26522.c b/drivers/net/wan/slic_ds26522.c
> index 1f6bc8791d51..89681910d875 100644
> --- a/drivers/net/wan/slic_ds26522.c
> +++ b/drivers/net/wan/slic_ds26522.c
> @@ -64,8 +64,9 @@ static u8 slic_read(struct spi_device *spi, u16 addr)
>  	temp[0] = (u8)(((addr >> 8) & 0x7f) | 0x80);
>  	temp[1] = (u8)(addr & 0xfe);
>  
> -	spi_write_then_read(spi, &temp[0], SLIC_TWO_LEN, &data,
> -			    SLIC_TRANS_LEN);
> +	if (spi_write_then_read(spi, &temp[0], SLIC_TWO_LEN, &data,
> +			    SLIC_TRANS_LEN))
> +		return -1;

This makes no sense, all callers use the data value as-is and perform
no error checking.

You have to either accept this code to stay as it is, or adjust all of
the call sites to do error handling.

And that's not easy, -1 is a valud return value.
