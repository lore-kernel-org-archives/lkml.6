Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0493121773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549182419;
	bh=sPnfI1HNhCXOHLUc8pSc16PhXZwrm6oKPdZf9ZEUWbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WqU3WdFIQU2o7qYa2PfVpdIIGPwYhLZio+HYLWa/1Z4cwsWnjj6qnru1mtYawm4y4
	 ZN591KagJNHM4nyckQa8b6/QbpUupbh5CE+eo/5w6i0mmGvU0i7uOglWl+erCcIzDF
	 lptituXXJl8bbBg1X0wXOceRM2SSUq6re+04wzlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBCI05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfBCI05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:26:57 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E872082F;
        Sun,  3 Feb 2019 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549182416;
        bh=sPnfI1HNhCXOHLUc8pSc16PhXZwrm6oKPdZf9ZEUWbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RO18rxKkk+tXgeBB3Qmx0XUEp/h2wGbITtZ4Vkm1Dkl2EQij+Fh65Agjv9AQr9ZqP
         IrgXD/N6Va0vME2yEJ2/iytGgdhUmCHD7kmmH1Nr5lSB3kNM/IJKyBOHZK6yVGtRyz
         wfGd5PGfh2LArdn1N0OI+8++gHK2GvzQa6qWOEEA=
Date:   Sun, 3 Feb 2019 09:26:45 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <joakim.tjernlund@infinera.com>, <ikegami@allied-telesis.co.jp>,
        <keescook@chromium.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Przemyslaw Sobon <psobon@amazon.com>
Subject: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Message-ID: <20190203092645.18d1495b@bbrezillon>
In-Reply-To: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Przemyslaw

On Fri, 1 Feb 2019 07:30:39 +0800
Liu Jian <liujian56@huawei.com> wrote:

> In function do_write_buffer(), in the for loop, there is a case
> chip_ready() returns 1 while chip_good() returns 0, so it never
> break the loop.
> To fix this, chip_good() is enough and it should timeout if it stay
> bad for a while.

Looks like Przemyslaw reported and fixed the same problem.

> 
> Fixes: dfeae1073583(mtd: cfi_cmdset_0002: Change write buffer to check
> correct value)

Can you put the Fixes tag on a single, and the format is

Fixes: <hash> ("message")

> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> Signed-off-by: Liu Jian <liujian56@huawei.com>

[1]http://patchwork.ozlabs.org/patch/1025566/

> ---
>  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> index 72428b6..818e94b 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -1876,14 +1876,14 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
>  			continue;
>  		}
>  
> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> -			break;
> -
>  		if (chip_good(map, adr, datum)) {
>  			xip_enable(map, chip, adr);
>  			goto op_done;
>  		}
>  
> +		if (time_after(jiffies, timeo))
> +			break;
> +
>  		/* Latency issues. Drop the lock, wait a while and retry */
>  		UDELAY(map, chip, adr, 1);
>  	}

