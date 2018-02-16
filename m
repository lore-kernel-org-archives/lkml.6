Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeBPEfv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:35:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeBPEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:35:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4306D607E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 07/12] i2c: qup: use the complete transfer length to
 choose DMA mode
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4a3d98e2-c340-1a13-eaa4-dde07768e7d8@codeaurora.org>
Date: Fri, 16 Feb 2018 10:05:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> Currently each message length in complete transfer is being
> checked for determining DMA mode and if any of the message length
> is less than FIFO length then non DMA mode is being used which
> will increase overhead. DMA can be used for any length and it
> should be determined with complete transfer length. Now, this
> patch introduces DMA threshold length and the transfer will be
> done in DMA mode if the total length is greater than this
> threshold length.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 6227a5c..a91fc70 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -192,6 +192,8 @@ struct qup_i2c_dev {
>  	bool			is_dma;
>  	/* To check if the current transfer is using DMA */
>  	bool			use_dma;
> +	/* The threshold length above which DMA will be used */
> +	unsigned int		dma_threshold;
>  	struct			dma_pool *dpool;
>  	struct			qup_i2c_tag start_tag;
>  	struct			qup_i2c_bam brx;
> @@ -1294,7 +1296,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  			   int num)
>  {
>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> -	int ret, len, idx = 0;
> +	int ret, idx = 0;
> +	unsigned int total_len = 0;
>  
>  	qup->bus_err = 0;
>  	qup->qup_err = 0;
> @@ -1320,14 +1323,13 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  				goto out;
>  			}
>  
> -			len = (msgs[idx].len > qup->out_fifo_sz) ||
> -			      (msgs[idx].len > qup->in_fifo_sz);
> -
> -			if (is_vmalloc_addr(msgs[idx].buf) || !len)
> +			if (is_vmalloc_addr(msgs[idx].buf))
>  				break;
> +
> +			total_len += msgs[idx].len;
>  		}
>  
> -		if (idx == num)
> +		if (idx == num && total_len > qup->dma_threshold)
>  			qup->use_dma = true;
>  	}
>  
> @@ -1587,6 +1589,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
>  
>  	size = QUP_INPUT_FIFO_SIZE(io_mode);
>  	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
> +	qup->dma_threshold = min(qup->out_fifo_sz, qup->in_fifo_sz);

  The patch is fine. small nit, you can avoid this global dma_threshold. Instead
  have it locally in qup_i2c_xfer_v2 itself.

Regards,
 Sricharan


-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
