Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F27AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B915208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B915208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH0Lv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:51:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59676 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0Lv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:51:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F2B6B20795; Mon, 27 Aug 2018 10:06:24 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id A73AB206DE;
        Mon, 27 Aug 2018 10:06:14 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:06:13 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        han.xu@nxp.com, marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, liuxiang_1999@126.com,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH] mtd: spi-nor: fsl-quadspi: fix read error for flash
 size larger than 16MB
Message-ID: <20180827100613.78823993@bbrezillon>
In-Reply-To: <1534583663-2842-1-git-send-email-liu.xiang6@zte.com.cn>
References: <1534583663-2842-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 17:14:23 +0800
Liu Xiang <liu.xiang6@zte.com.cn> wrote:

> If the size of spi-nor flash is larger than 16MB, the read_opcode
> is set to SPINOR_OP_READ_1_1_4_4B, and fsl_qspi_get_seqid() will
> return -EINVAL when cmd is SPINOR_OP_READ_1_1_4_4B. This can
> cause read operation fail.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

I'm pretty sure you want to backport this fix. Can you add a Fixes tag
and CC stable?

Also, I'd like to have an Ack from someone working at NXP (Han,
Yogesh?).

Thanks,

Boris.

> ---
>  drivers/mtd/spi-nor/fsl-quadspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 7d9620c..64304a3 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -478,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
>  {
>  	switch (cmd) {
>  	case SPINOR_OP_READ_1_1_4:
> +	case SPINOR_OP_READ_1_1_4_4B:
>  		return SEQID_READ;
>  	case SPINOR_OP_WREN:
>  		return SEQID_WREN;

