Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeB0VvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:51:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0VvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:51:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01B5160390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=austinwc@codeaurora.org
Subject: Re: [PATCH 03/12] i2c: qup: remove redundant variables for BAM SG
 count
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
From: "Christ, Austin" <austinwc@codeaurora.org>
Message-ID: <80caf699-0680-7dbc-ef63-0cacd21ee607@codeaurora.org>
Date: Tue, 27 Feb 2018 14:51:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with Sricharan's comments about naming, otherwise looks good.

Tested on Centriq 2400

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

On 2/3/2018 12:58 AM, Abhishek Sahu wrote:
> The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
> be used for total number of SG entries.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>   drivers/i2c/busses/i2c-qup.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c68f433..bb83a2967 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -692,7 +692,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   	struct dma_async_tx_descriptor *txd, *rxd = NULL;
>   	int ret = 0, idx = 0, limit = QUP_READ_LIMIT;
>   	dma_cookie_t cookie_rx, cookie_tx;
> -	u32 rx_nents = 0, tx_nents = 0, len, blocks, rem;
> +	u32 len, blocks, rem;
>   	u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
>   	u8 *tags;
>   
> @@ -707,9 +707,6 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   		rem = msg->len - (blocks - 1) * limit;
>   
>   		if (msg->flags & I2C_M_RD) {
> -			rx_nents += (blocks * 2) + 1;
> -			tx_nents += 1;
> -
>   			while (qup->blk.pos < blocks) {
>   				tlen = (i == (blocks - 1)) ? rem : limit;
>   				tags = &qup->start_tag.start[off + len];
> @@ -748,8 +745,6 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   			if (ret)
>   				return ret;
>   		} else {
> -			tx_nents += (blocks * 2);
> -
>   			while (qup->blk.pos < blocks) {
>   				tlen = (i == (blocks - 1)) ? rem : limit;
>   				tags = &qup->start_tag.start[off + tx_len];
> @@ -775,7 +770,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   
>   			if (idx == (num - 1)) {
>   				len = 1;
> -				if (rx_nents) {
> +				if (rx_buf) {
>   					qup->btx.tag.start[0] =
>   							QUP_BAM_INPUT_EOT;
>   					len++;
> @@ -787,14 +782,13 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   						     len, qup, DMA_TO_DEVICE);
>   				if (ret)
>   					return ret;
> -				tx_nents += 1;
>   			}
>   		}
>   		idx++;
>   		msg++;
>   	}
>   
> -	txd = dmaengine_prep_slave_sg(qup->btx.dma, qup->btx.sg, tx_nents,
> +	txd = dmaengine_prep_slave_sg(qup->btx.dma, qup->btx.sg, tx_buf,
>   				      DMA_MEM_TO_DEV,
>   				      DMA_PREP_INTERRUPT | DMA_PREP_FENCE);
>   	if (!txd) {
> @@ -803,7 +797,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   		goto desc_err;
>   	}
>   
> -	if (!rx_nents) {
> +	if (!rx_buf) {
>   		txd->callback = qup_i2c_bam_cb;
>   		txd->callback_param = qup;
>   	}
> @@ -816,9 +810,9 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   
>   	dma_async_issue_pending(qup->btx.dma);
>   
> -	if (rx_nents) {
> +	if (rx_buf) {
>   		rxd = dmaengine_prep_slave_sg(qup->brx.dma, qup->brx.sg,
> -					      rx_nents, DMA_DEV_TO_MEM,
> +					      rx_buf, DMA_DEV_TO_MEM,
>   					      DMA_PREP_INTERRUPT);
>   		if (!rxd) {
>   			dev_err(qup->dev, "failed to get rx desc\n");
> @@ -853,7 +847,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   			goto desc_err;
>   		}
>   
> -		if (rx_nents)
> +		if (rx_buf)
>   			writel(QUP_BAM_INPUT_EOT,
>   			       qup->base + QUP_OUT_FIFO_BASE);
>   
> @@ -871,10 +865,10 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   	}
>   
>   desc_err:
> -	dma_unmap_sg(qup->dev, qup->btx.sg, tx_nents, DMA_TO_DEVICE);
> +	dma_unmap_sg(qup->dev, qup->btx.sg, tx_buf, DMA_TO_DEVICE);
>   
> -	if (rx_nents)
> -		dma_unmap_sg(qup->dev, qup->brx.sg, rx_nents,
> +	if (rx_buf)
> +		dma_unmap_sg(qup->dev, qup->brx.sg, rx_buf,
>   			     DMA_FROM_DEVICE);
>   
>   	return ret;
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
