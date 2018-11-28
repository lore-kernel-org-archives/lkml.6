Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50736C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1705F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1705F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeK1TGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:06:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40152 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeK1TGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:06:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E775320731; Wed, 28 Nov 2018 09:05:26 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id A93CC206D8;
        Wed, 28 Nov 2018 09:05:16 +0100 (CET)
Date:   Wed, 28 Nov 2018 09:05:16 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubi: put MTD device after it is not used
Message-ID: <20181128090516.16e89c94@bbrezillon>
In-Reply-To: <1543373853-80379-1-git-send-email-bianpan2016@163.com>
References: <1543373853-80379-1-git-send-email-bianpan2016@163.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 10:57:33 +0800
Pan Bian <bianpan2016@163.com> wrote:

> The MTD device reference is dropped via put_mtd_device, however its
> field ->index is read and passed to ubi_msg. To fix this, the patch
> moves the reference dropping after calling ubi_msg.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/ubi/build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index a4e3454..09170b7 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1101,10 +1101,10 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>  	ubi_wl_close(ubi);
>  	ubi_free_internal_volumes(ubi);
>  	vfree(ubi->vtbl);
> -	put_mtd_device(ubi->mtd);
>  	vfree(ubi->peb_buf);
>  	vfree(ubi->fm_buf);
>  	ubi_msg(ubi, "mtd%d is detached", ubi->mtd->index);
> +	put_mtd_device(ubi->mtd);

Maybe we should move some of these to the dev->release() or
class->dev_release() hook.

>  	put_device(&ubi->dev);
>  	return 0;
>  }

