Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF55204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF55204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeJMNlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:41:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeJMNlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:41:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65747207A3; Sat, 13 Oct 2018 08:05:42 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D41520717;
        Sat, 13 Oct 2018 08:05:42 +0200 (CEST)
Date:   Sat, 13 Oct 2018 08:05:42 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: rawnand: ams-delta: Use ->exec_op()
Message-ID: <20181013080542.2ae9b199@bbrezillon>
In-Reply-To: <20181012204101.26274-2-jmkrzyszt@gmail.com>
References: <20181003120028.9257-1-jmkrzyszt@gmail.com>
        <20181012204101.26274-1-jmkrzyszt@gmail.com>
        <20181012204101.26274-2-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Fri, 12 Oct 2018 22:41:01 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Replace legacy callbacks with ->select_chip() and ->exec_op().
> 
> In order to remove any references to legacy structure members, use of 
> .IO_ADDR_R/W has been replaced wit runtime calculations based on

				 ^ with

> priv->io_base.

Can we do that in 2 steps?

1/ Stop using .IO_ADDR_R/W
2/ Convert the driver to ->exec_op()

> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---

[...]

> -static int ams_delta_nand_ready(struct nand_chip *this)
> +static int ams_delta_exec_op(struct nand_chip *this,
> +			     const struct nand_operation *op, bool check_only)
>  {
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +	const struct nand_op_instr *instr;
> +	int ret = 0;
> +

You should have:

	if (check_only)
		return 0;

Other than that, the conversion looks good, so you can add

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com> once you've
addressed my comments.

Regards,

Boris

> +	for (instr = op->instrs; instr < op->instrs + op->ninstrs; instr++) {
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			gpiod_set_value(priv->gpiod_cle, 1);
> +			ams_delta_write_buf(priv, &instr->ctx.cmd.opcode, 1);
> +			gpiod_set_value(priv->gpiod_cle, 0);
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			gpiod_set_value(priv->gpiod_ale, 1);
> +			ams_delta_write_buf(priv, instr->ctx.addr.addrs,
> +					    instr->ctx.addr.naddrs);
> +			gpiod_set_value(priv->gpiod_ale, 0);
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			ams_delta_read_buf(priv, instr->ctx.data.buf.in,
> +					   instr->ctx.data.len);
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			ams_delta_write_buf(priv, instr->ctx.data.buf.out,
> +					    instr->ctx.data.len);
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			ret = priv->gpiod_rdy ?
> +			      nand_gpio_waitrdy(this, priv->gpiod_rdy,
> +						instr->ctx.waitrdy.timeout_ms) :
> +			      nand_soft_waitrdy(this,
> +						instr->ctx.waitrdy.timeout_ms);
> +			break;
> +		}
> +
> +		if (ret)
> +			break;
> +	}
>  
> -	return gpiod_get_value(priv->gpiod_rdy);
> +	return ret;
>  }
