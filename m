Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeBPEsy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:48:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeBPEsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:48:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A46A560385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 08/12] i2c: qup: change completion timeout according to
 transfer length
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-9-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <7dcbac1f-edaf-aecf-8e58-04d243384758@codeaurora.org>
Date: Fri, 16 Feb 2018 10:18:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-9-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> Currently the completion timeout is being taken according to
> maximum transfer length which is too high if SCL is operating in
> high frequency. This patch calculates timeout on the basis of
> one-byte transfer time and uses the same for completion timeout.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index a91fc70..6df65ea 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -130,8 +130,8 @@
>  #define MX_TX_RX_LEN			SZ_64K
>  #define MX_BLOCKS			(MX_TX_RX_LEN / QUP_READ_LIMIT)
>  
> -/* Max timeout in ms for 32k bytes */
> -#define TOUT_MAX			300
> +/* Min timeout for i2c transfers */
> +#define TOUT_MIN			2
>  

 may be you can mention, why is this 2 ?

Regards,
 Sricharan


>  /* Default values. Use these if FW query fails */
>  #define DEFAULT_CLK_FREQ 100000
> @@ -172,6 +172,7 @@ struct qup_i2c_dev {
>  	int			in_blk_sz;
>  
>  	unsigned long		one_byte_t;
> +	unsigned long		xfer_timeout;
>  	struct qup_i2c_block	blk;
>  
>  	struct i2c_msg		*msg;
> @@ -845,7 +846,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  		dma_async_issue_pending(qup->brx.dma);
>  	}
>  
> -	if (!wait_for_completion_timeout(&qup->xfer, TOUT_MAX * HZ)) {
> +	if (!wait_for_completion_timeout(&qup->xfer, qup->xfer_timeout)) {
>  		dev_err(qup->dev, "normal trans timed out\n");
>  		ret = -ETIMEDOUT;
>  	}
> @@ -1601,6 +1602,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
>  	 */
>  	one_bit_t = (USEC_PER_SEC / clk_freq) + 1;
>  	qup->one_byte_t = one_bit_t * 9;
> +	qup->xfer_timeout = TOUT_MIN * HZ +
> +			    usecs_to_jiffies(MX_TX_RX_LEN * qup->one_byte_t);
>  
>  	dev_dbg(qup->dev, "IN:block:%d, fifo:%d, OUT:block:%d, fifo:%d\n",
>  		qup->in_blk_sz, qup->in_fifo_sz,
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
