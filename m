Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B472054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B472054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeH3Msq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:48:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50361 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeH3Msq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:48:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A93C820711; Thu, 30 Aug 2018 10:47:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6903A203EC;
        Thu, 30 Aug 2018 10:47:30 +0200 (CEST)
Date:   Thu, 30 Aug 2018 10:47:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] spi: spi-mem: Adjust op len based on
 message/transfer size limitations
Message-ID: <20180830104729.5c7fefad@bbrezillon>
In-Reply-To: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhua,

On Thu, 30 Aug 2018 16:43:24 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> We need that to adjust the len of the 2nd transfer (called data in
> spi-mem) if it's too long to fit in a SPI message or SPI transfer.

You already sent this email a few days back. Please wait a bit before
sending it again. And when you do so and nothing changed in the patch
please use the [PATCH RESEND vX] prefix and explain why you resend it.

Thanks,

Boris

> 
> Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v5:
>   -Add the validation check after the op->data.nbytes assignment
>   -Assign the "len" variable after defining it
>   -Remove the brackets on both sides of "opt-> data.nbytes"
> Changes in v4:
>   -Rename variable name "opcode_addr_dummy_sum" to "len"
>   -The comparison of "spi_max_message_size(mem->spi)" and "len" was removed
>   -Adjust their order when comparing the sizes of "spi_max_message_size(mem->spi)" and "len"
>   -Changing the "unsigned long" type in the code to "size_t"
> Changes in v3:
>   -Rename variable name "val" to "opcode_addr_dummy_sum"
>   -Place the legitimacy of the transfer size(i.e., "spi_max_message_size(mem->spi)" and
> "opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
> structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum"
>   -Adjust the formatting alignment of the code
>   -"(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)"
> Changes in v2:
>   -Place the adjusted transfer bytes code in spi_mem_adjust_op_size() and  check
> spi_max_message_size(mem->spi) value before subtracting opcode, addr and dummy bytes
>   -Change the code from fsl-espi controller to generic code(The adjustment of spi transmission
> length was originally modified in the "drivers/spi/spi-fsl-espi.c" file, and now the adjustment
> of transfer length is made in the "drivers/spi/spi-mem.c" file)
> 
>  drivers/spi/spi-mem.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index e43842c..eb72dba 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -346,10 +346,25 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	size_t len;
> +
> +	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
>  
>  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
>  		return ctlr->mem_ops->adjust_op_size(mem, op);
>  
> +	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> +		if (len > spi_max_transfer_size(mem->spi))
> +			return -EINVAL;
> +
> +		op->data.nbytes = min3((size_t)op->data.nbytes,
> +				       spi_max_transfer_size(mem->spi),
> +				       spi_max_message_size(mem->spi) -
> +				       len);
> +		if (!op->data.nbytes)
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);

