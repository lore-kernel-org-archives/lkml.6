Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA95C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592422075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592422075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI3Qgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:36:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38403 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbeI3Qgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:36:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25136207D8; Sun, 30 Sep 2018 12:04:26 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id E3F4F206A2;
        Sun, 30 Sep 2018 12:04:25 +0200 (CEST)
Date:   Sun, 30 Sep 2018 12:04:25 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, eha@deif.com
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20180930120425.7715cb29@bbrezillon>
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhua,

On Sun, 30 Sep 2018 17:25:32 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> Before we add this spi_transfer to the spi_message chain table, we need
> bits_per_word_mask based on spi_control to set the bits_per_word of
> this spi_transfer.

Let's make it clearer: this is wrong. The spi-mem protocol is just
using bytes, not custom size words. Fix the fsl-dspi driver if needed,
but don't try to adjust xfer->bits_per_word in spi-mem.c, because this
is inappropriate.

Regards,

Boris

> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
> 
>  drivers/spi/spi-mem.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index eb72dba71d83..717e711c0952 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -175,6 +175,41 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_supports_op);
>  
> +/**
> + * spi_set_xfer_bpw() - Set the bits_per_word for each transfer based on
> + *			the bits_per_word_mask of the spi controller
> + * @ctrl: the spi controller
> + * @xfer: the spi transfer
> + *
> + * This function sets the bits_per_word for each transfer based on the spi
> + * controller's bits_per_word_mask to improve the efficiency of spi transport.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int spi_set_xfer_bpw(struct spi_controller *ctlr, struct spi_transfer *xfer)
> +{
> +	if (!ctlr || !xfer) {
> +		dev_err(&ctlr->dev,
> +			"Fail to set bits_per_word for spi transfer\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ctlr->bits_per_word_mask) {
> +		if (!(xfer->len % 4)) {
> +			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(32))
> +				xfer->bits_per_word = 32;
> +		} else if (!(xfer->len % 2)) {
> +			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(16))
> +				xfer->bits_per_word = 16;
> +		} else {
> +			xfer->bits_per_word = 8;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_set_xfer_bpw);
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory
> @@ -252,6 +287,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	xfers[xferpos].tx_buf = tmpbuf;
>  	xfers[xferpos].len = sizeof(op->cmd.opcode);
>  	xfers[xferpos].tx_nbits = op->cmd.buswidth;
> +	spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  	spi_message_add_tail(&xfers[xferpos], &msg);
>  	xferpos++;
>  	totalxferlen++;
> @@ -266,6 +302,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		xfers[xferpos].tx_buf = tmpbuf + 1;
>  		xfers[xferpos].len = op->addr.nbytes;
>  		xfers[xferpos].tx_nbits = op->addr.buswidth;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->addr.nbytes;
> @@ -276,6 +313,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>  		xfers[xferpos].len = op->dummy.nbytes;
>  		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->dummy.nbytes;
> @@ -291,6 +329,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		}
>  
>  		xfers[xferpos].len = op->data.nbytes;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->data.nbytes;

