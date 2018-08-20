Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D174D21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D174D21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHTNar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:30:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35586 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTNar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:30:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C57CB20DEC; Mon, 20 Aug 2018 12:15:44 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 86FA820703;
        Mon, 20 Aug 2018 12:15:44 +0200 (CEST)
Date:   Mon, 20 Aug 2018 12:15:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jiafei.pan@nxp.com, zhiqiang.hou@nxp.com
Subject: Re: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Message-ID: <20180820121544.5dfaf802@bbrezillon>
In-Reply-To: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
References: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhua,

On Mon, 20 Aug 2018 17:43:26 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

Subject prefix should be "spi: spi-mem: " not "mtd: m25p80: ", and you
need a commit message explaining what this patch does and why it's
needed.

> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>

> ---
> Changes in v2:
> 	- Place the adjusted transfer bytes code in spi_mem_adjust_op_size()
> 	and  check spi_max_message_size(mem->spi) value before subtracting 
> 	opcode, addr and dummy bytes.
> *fixes:
> 	spi: Extend the core to ease integration of SPI memory controllers
> ---
>  drivers/spi/spi-mem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 990770d..f5e75d1 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -328,10 +328,21 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	unsigned long val =	sizeof(op->cmd.opcode) +
> +							  op->addr.nbytes +
> +							  op->dummy.nbytes;

Not properly aligned, and you should find a better name for this variable.

>  
>  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
>  		return ctlr->mem_ops->adjust_op_size(mem, op);
>  
> +	if (spi_max_message_size(mem->spi) < val)
> +		return -EINVAL;

This should be enclosed in the if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
block and you should check that spi_max_transfer_size(mem->spi) >= val too.

> +
> +	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
> +		op->data.nbytes = min3((unsigned long)op->data.nbytes,
> +				spi_max_transfer_size(mem->spi),
> +				spi_max_message_size(mem->spi) - val);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);

Regards,

Boris
