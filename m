Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25864C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69DE20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69DE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJHPs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:48:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeJHPs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:48:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D84B207F3; Mon,  8 Oct 2018 10:38:22 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id C0F142072D;
        Mon,  8 Oct 2018 10:38:11 +0200 (CEST)
Date:   Mon, 8 Oct 2018 10:38:12 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v4 1/2] spi: Add MXIC controller driver
Message-ID: <20181008103812.106389c1@bbrezillon>
In-Reply-To: <1538965532-8908-2-git-send-email-masonccyang@mxic.com.tw>
References: <1538965532-8908-1-git-send-email-masonccyang@mxic.com.tw>
        <1538965532-8908-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon,  8 Oct 2018 10:25:31 +0800
masonccyang@mxic.com.tw wrote:

> +static int mxic_spi_clk_enable(struct mxic_spi *mxic)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(mxic->send_clk);
> +	if (ret)
> +		goto out;

Please don't use gotos when it's not necessary, just do

		return ret;

> +
> +	ret = clk_prepare_enable(mxic->send_dly_clk);
> +	if (ret)
> +		goto err_send_dly_clk;
> +
> +	return ret;
> +
> +err_send_dly_clk:
> +	clk_disable_unprepare(mxic->send_clk);
> +out:

and you can get rid of the out label.

> +	return ret;
> +}
> +


> +static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> +				const struct spi_mem_op *op)
> +{
> +	struct spi_master *master = spi_master_get(mem->spi->master);
> +	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
> +	int nio = 1, i, ret;
> +	u32 ss_ctrl;
> +	u8 addr[8];
> +
> +	if (master->prepare_transfer_hardware)
> +		master->prepare_transfer_hardware(master);

Move the mxic_prepare_transfer_hardware() at the top of the file and
call it directly from there.

> +
> +	if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
> +		nio = 4;
> +	else if (mem->spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
> +		nio = 2;
> +
> +	writel(HC_CFG_NIO(nio) |
> +	       HC_CFG_TYPE(mem->spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
> +	       HC_CFG_SLV_ACT(mem->spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1) |
> +	       HC_CFG_MAN_CS_EN,
> +	       mxic->regs + HC_CFG);
> +	writel(HC_EN_BIT, mxic->regs + HC_EN);
> +
> +	ss_ctrl = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
> +
> +	if (op->addr.nbytes)
> +		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
> +			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
> +
> +	if (op->dummy.nbytes)
> +		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
> +
> +	if (op->data.nbytes) {
> +		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
> +		if (op->data.dir == SPI_MEM_DATA_IN)
> +			ss_ctrl |= OP_READ;
> +	}
> +
> +	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
> +
> +	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> +	       mxic->regs + HC_CFG);
> +
> +	ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < op->addr.nbytes; i++)
> +		addr[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
> +	ret = mxic_spi_data_xfer(mxic, addr, NULL, op->addr.nbytes);
> +	if (ret)
> +		goto out;
> +
> +	ret = mxic_spi_data_xfer(mxic, NULL, NULL, op->dummy.nbytes);
> +	if (ret)
> +		goto out;
> +
> +	ret = mxic_spi_data_xfer(mxic,
> +				 op->data.dir == SPI_MEM_DATA_OUT ?
> +				 op->data.buf.out : NULL,
> +				 op->data.dir == SPI_MEM_DATA_IN ?
> +				 op->data.buf.in : NULL,
> +				 op->data.nbytes);
> +
> +out:
> +	writel(readl(mxic->regs + HC_CFG) & ~HC_CFG_MAN_CS_ASSERT,
> +	       mxic->regs + HC_CFG);
> +	writel(0, mxic->regs + HC_EN);
> +
> +	return ret;
> +}

[...]

> +
> +static int mxic_spi_setup(struct spi_device *spi)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +
> +	mxic->cur_speed_hz = spi->max_speed_hz;

This is wrong, ->cur_speed_hz should be updated in
mxic_prepare_transfer_hardware() or mxic_spi_clk_check(), not when
->setup() is called. Also, you seem to ignore the xfer->speed_hz value,
which might be different from spi->max_speed_hz. Maybe the
->prepare_transfer() hook is not the right place to do this
->cur_speed_hz selection in the end.

Can you instead create the following function:

static int mxic_spi_set_freq(struct mxic_spi *mxic, unsigned long freq)
{
	if (mxic->cur_speed_hz == freq)
		return 0;

	mxic_spi_clk_disable(mxic);
	ret = mxic_spi_clk_setup(mxic, master->max_speed_hz);
	if (ret)
		return ret;

	ret = mxic_spi_clk_enable(mxic);
	if (ret)
		return ret;

	mxic->cur_speed_hz = freq;
	return 0;
}

and then call it from mxic_spi_transfer_one() and
mxic_spi_mem_exec_op():

static int mxic_spi_mem_exec_op(struct spi_mem *mem,
				const struct spi_mem_op *op)
{
	...
	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
	...
}

static int mxic_spi_transfer_one(struct spi_master *master,
				 struct spi_device *spi,
				 struct spi_transfer *t)
{
	...
	ret = mxic_spi_set_freq(mxic, t->speed_hz);
	...
}

> +
> +	return 0;
> +}
> +

[...]

> +
> +static int mxic_unprepare_transfer_hardware(struct spi_master *master)
> +{
> +	return 0;
> +}

If the function does nothing, just leave ->unprepare_transfer to NULL.


> +
> +static int mxic_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct mxic_spi *mxic = spi_master_get_devdata(master);
> +
> +	mxic_spi_clk_disable(mxic);
> +	clk_disable_unprepare(mxic->ps_clk);
> +	pm_runtime_disable(&pdev->dev);

Are you sure you still have to call mxic_spi_clk_disable() and
clk_disable_unprepare() here? Shouldn't it be handled when you call
pm_runtime_disable()?

> +
> +	spi_unregister_master(master);
> +
> +	return 0;
> +}
> +

Regards,

Boris
