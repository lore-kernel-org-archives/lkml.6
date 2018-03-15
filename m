Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeCOGxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:53:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeCOGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:53:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0BB760452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 05/13] i2c: qup: schedule EOT and FLUSH tags at the end
 of transfer
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <1520860502-14886-6-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <2411c3ca-5da2-de43-f2dc-a74930a49a22@codeaurora.org>
Date: Thu, 15 Mar 2018 12:23:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520860502-14886-6-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/2018 6:44 PM, Abhishek Sahu wrote:
> The role of FLUSH and EOT tag is to flush already scheduled
> descriptors in BAM HW in case of error. EOT is required only
> when descriptors are scheduled in RX FIFO. If all the messages
> are WRITE, then only FLUSH tag will be used.
> 
> A single BAM transfer can have multiple read and write messages.
> The EOT and FLUSH tags should be scheduled at the end of BAM HW
> descriptors. Since the READ and WRITE can be present in any order
> so for some of the cases, these tags are not being written
> correctly.
> 
> Following is one of the example
> 
>    READ, READ, READ, READ
> 
> Currently EOT and FLUSH tags are being written after each READ.
> If QUP gets NACK for first READ itself, then flush will be
> triggered. It will look for first FLUSH tag in TX FIFO and will
> stop there so only descriptors for first READ descriptors be
> flushed. All the scheduled descriptors should be cleared to
> generate BAM DMA completion.
> 
> Now this patch is scheduling FLUSH and EOT only once after all the
> descriptors. So, flush will clear all the scheduled descriptors and
> BAM will generate the completion interrupt.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> 

Reviewed-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan





> * Changes from v1:
> 
> 1. Modified commit message with more details
> 
>  drivers/i2c/busses/i2c-qup.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index d970458..b2e8f57 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -551,7 +551,7 @@ static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
>  }
>  
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
> -			    struct i2c_msg *msg,  int is_dma)
> +			    struct i2c_msg *msg)
>  {
>  	u16 addr = i2c_8bit_addr_from_msg(msg);
>  	int len = 0;
> @@ -592,11 +592,6 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>  	else
>  		tags[len++] = data_len;
>  
> -	if ((msg->flags & I2C_M_RD) && last && is_dma) {
> -		tags[len++] = QUP_BAM_INPUT_EOT;
> -		tags[len++] = QUP_BAM_FLUSH_STOP;
> -	}
> -
>  	return len;
>  }
>  
> @@ -605,7 +600,7 @@ static int qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  	int data_len = 0, tag_len, index;
>  	int ret;
>  
> -	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg, 0);
> +	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg);
>  	index = msg->len - qup->blk.data_len;
>  
>  	/* only tags are written for read */
> @@ -701,7 +696,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  			while (qup->blk.pos < blocks) {
>  				tlen = (i == (blocks - 1)) ? rem : limit;
>  				tags = &qup->start_tag.start[off + len];
> -				len += qup_i2c_set_tags(tags, qup, msg, 1);
> +				len += qup_i2c_set_tags(tags, qup, msg);
>  				qup->blk.data_len -= tlen;
>  
>  				/* scratch buf to read the start and len tags */
> @@ -729,17 +724,11 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  				return ret;
>  
>  			off += len;
> -			/* scratch buf to read the BAM EOT and FLUSH tags */
> -			ret = qup_sg_set_buf(&qup->brx.sg[rx_cnt++],
> -					     &qup->brx.tag.start[0],
> -					     2, qup, DMA_FROM_DEVICE);
> -			if (ret)
> -				return ret;
>  		} else {
>  			while (qup->blk.pos < blocks) {
>  				tlen = (i == (blocks - 1)) ? rem : limit;
>  				tags = &qup->start_tag.start[off + tx_len];
> -				len = qup_i2c_set_tags(tags, qup, msg, 1);
> +				len = qup_i2c_set_tags(tags, qup, msg);
>  				qup->blk.data_len -= tlen;
>  
>  				ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++],
> @@ -779,6 +768,26 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  		msg++;
>  	}
>  
> +	/* schedule the EOT and FLUSH I2C tags */
> +	len = 1;
> +	if (rx_cnt) {
> +		qup->btx.tag.start[0] = QUP_BAM_INPUT_EOT;
> +		len++;
> +
> +		/* scratch buf to read the BAM EOT and FLUSH tags */
> +		ret = qup_sg_set_buf(&qup->brx.sg[rx_cnt++],
> +				     &qup->brx.tag.start[0],
> +				     2, qup, DMA_FROM_DEVICE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	qup->btx.tag.start[len - 1] = QUP_BAM_FLUSH_STOP;
> +	ret = qup_sg_set_buf(&qup->btx.sg[tx_cnt++], &qup->btx.tag.start[0],
> +			     len, qup, DMA_TO_DEVICE);
> +	if (ret)
> +		return ret;
> +
>  	txd = dmaengine_prep_slave_sg(qup->btx.dma, qup->btx.sg, tx_cnt,
>  				      DMA_MEM_TO_DEV,
>  				      DMA_PREP_INTERRUPT | DMA_PREP_FENCE);
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
