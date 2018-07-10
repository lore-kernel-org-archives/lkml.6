Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86420A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D86420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeGJVUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:20:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56601 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbeGJVUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:20:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8034207AB; Tue, 10 Jul 2018 23:19:46 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6AEAA203D9;
        Tue, 10 Jul 2018 23:19:46 +0200 (CEST)
Date:   Tue, 10 Jul 2018 23:19:45 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Message-ID: <20180710231945.4672a18c@bbrezillon>
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
        <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Girish,

On Thu,  5 Jul 2018 15:46:42 -0600
Girish Mahadevan <girishm@codeaurora.org> wrote:

> +
> +static int process_data(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
> +{
> +	int ret;
> +
> +	ctrl->xfer.dir = (op->data.dir == SPI_MEM_DATA_IN) ?
> +					QSPI_READ : QSPI_WRITE;
> +	ctrl->xfer.mode = op->data.buswidth;
> +	ctrl->xfer.is_last = true;
> +	ctrl->xfer.rem_bytes = op->data.nbytes;
> +
> +	if (ctrl->xfer.dir == QSPI_WRITE)
> +		ctrl->xfer.tx_buf = op->data.buf.out;
> +	else
> +		ctrl->xfer.rx_buf = op->data.buf.in;
> +	ret = qcom_qspi_pio_xfer(ctrl);
> +	if (ret)
> +		return ret;

Looks like you are converting the spi_mem_op into several regular SPI
transfers. Any good reasons for not relying on the core logic to do
that? In this case, all you'd have to do is implement ->transfer_one()
and be done with it. 

> +	ret = wait_for_xfer(ctrl);
> +	return ret;
> +}
 
Regards,

Boris
