Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C6C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30D82124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30D82124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHQNfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48344 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeHQNfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 50681207C8; Fri, 17 Aug 2018 12:32:46 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DAB72069C;
        Fri, 17 Aug 2018 12:32:36 +0200 (CEST)
Date:   Fri, 17 Aug 2018 12:32:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheetah0585@163.com
Subject: Re: [PATCH] spi: fsl-espi: master->mem_ops is implemented in the
 controller
Message-ID: <20180817123235.08b33825@bbrezillon>
In-Reply-To: <1534500425-9977-1-git-send-email-chuanhua.han@nxp.com>
References: <1534500425-9977-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 18:07:05 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> The length of the transmitted data needs to be adjusted due to the maximum 
> length limit for espi transmission messages
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  drivers/spi/spi-fsl-espi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> index 1d332e2..4724127 100644
> --- a/drivers/spi/spi-fsl-espi.c
> +++ b/drivers/spi/spi-fsl-espi.c
> @@ -22,6 +22,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/pm_runtime.h>
>  #include <sysdev/fsl_soc.h>
> +#include <linux/spi/spi-mem.h>
>  
>  /* eSPI Controller registers */
>  #define ESPI_SPMODE	0x00	/* eSPI mode register */
> @@ -659,6 +660,29 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
>  	fsl_espi_write_reg(espi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
>  }
>  
> +static int fsl_espi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	if (!mem || !op)
> +		return -EINVAL;
> +	op->data.nbytes = min3((unsigned long)op->data.nbytes,
> +			spi_max_transfer_size(mem->spi),
> +			spi_max_message_size(mem->spi) -
> +			sizeof(op->cmd.opcode) -
> +			op->addr.nbytes -
> +			op->dummy.nbytes);

Oops! Looks like I was wrong in my initial review, this code is generic
and should be placed in spi_mem_adjust_op_size() if !ctlr->mem_ops
or !ctlr->mem_ops->exec_op:

int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
{
	struct spi_controller *ctlr = mem->spi->controller;

	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
		return ctlr->mem_ops->adjust_op_size(mem, op);

	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
		op->data.nbytes = min3((unsigned long)op->data.nbytes,
				       spi_max_transfer_size(mem->spi),
				       spi_max_message_size(mem->spi) -
				       sizeof(op->cmd.opcode) -
				       op->addr.nbytes -
				       op->dummy.nbytes);

	return 0;
}

Also, you don't seem to check spi_max_message_size(mem->spi) value
before subtracting opcode, addr and dummy bytes.


> +	return 0;
> +}
> +
> +static int fsl_espi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static const struct spi_controller_mem_ops fsl_espi_mem_ops = {
> +	.adjust_op_size = fsl_espi_adjust_op_size,
> +	.exec_op = fsl_espi_exec_op,
> +};
> +
>  static int fsl_espi_probe(struct device *dev, struct resource *mem,
>  			  unsigned int irq, unsigned int num_cs)
>  {
> @@ -682,6 +706,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
>  	master->auto_runtime_pm = true;
>  	master->max_message_size = fsl_espi_max_message_size;
>  	master->num_chipselect = num_cs;
> +	master->mem_ops = &fsl_espi_mem_ops;
>  
>  	espi = spi_master_get_devdata(master);
>  	spin_lock_init(&espi->lock);

