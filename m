Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033259AbeBOOb2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:31:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033100AbeBOObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:31:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D45F60B67
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 04/12] i2c: qup: schedule EOT and FLUSH tags at the end of
 transfer
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <dcb7b543-3474-e573-cdc0-010cda5c2d67@codeaurora.org>
Date: Thu, 15 Feb 2018 20:01:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> A single BAM transfer can have multiple read and write messages.
> The EOT and FLUSH tags should be scheduled at the end of BAM HW
> descriptors. Since the READ and WRITE can be present in any order
> so for some of the cases, these tags are not being written
> correctly.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 54 ++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index bb83a2967..6357aff 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -560,7 +560,7 @@ static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
>  }
>  
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
> -			    struct i2c_msg *msg,  int is_dma)
> +			    struct i2c_msg *msg)
>  {
>  	u16 addr = i2c_8bit_addr_from_msg(msg);
>  	int len = 0;
> @@ -601,11 +601,6 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
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
> @@ -614,7 +609,7 @@ static int qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  	int data_len = 0, tag_len, index;
>  	int ret;
>  
> -	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg, 0);
> +	tag_len = qup_i2c_set_tags(qup->blk.tags, qup, msg);
>  	index = msg->len - qup->blk.data_len;
>  
>  	/* only tags are written for read */
> @@ -710,7 +705,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  			while (qup->blk.pos < blocks) {
>  				tlen = (i == (blocks - 1)) ? rem : limit;
>  				tags = &qup->start_tag.start[off + len];
> -				len += qup_i2c_set_tags(tags, qup, msg, 1);
> +				len += qup_i2c_set_tags(tags, qup, msg);
>  				qup->blk.data_len -= tlen;
>  
>  				/* scratch buf to read the start and len tags */
> @@ -738,17 +733,11 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  				return ret;
>  
>  			off += len;
> -			/* scratch buf to read the BAM EOT and FLUSH tags */
> -			ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
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
>  				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> @@ -768,26 +757,31 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  			}
>  			off += tx_len;
>  
> -			if (idx == (num - 1)) {
> -				len = 1;
> -				if (rx_buf) {
> -					qup->btx.tag.start[0] =
> -							QUP_BAM_INPUT_EOT;
> -					len++;
> -				}
> -				qup->btx.tag.start[len - 1] =
> -							QUP_BAM_FLUSH_STOP;
> -				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -						     &qup->btx.tag.start[0],
> -						     len, qup, DMA_TO_DEVICE);
> -				if (ret)
> -					return ret;
> -			}
>  		}
>  		idx++;
>  		msg++;
>  	}

 While here, can you please split above the if, else in to two separate functions ?
 and probably one more function for handling the NACK case down below. The function
 size at the moment is too big.

>  
> +	/* schedule the EOT and FLUSH I2C tags */
> +	len = 1;
> +	if (rx_buf) {
> +		qup->btx.tag.start[0] = QUP_BAM_INPUT_EOT;
> +		len++;
> +
> +		/* scratch buf to read the BAM EOT and FLUSH tags */
> +		ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
> +				     &qup->brx.tag.start[0],
> +				     2, qup, DMA_FROM_DEVICE);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	qup->btx.tag.start[len - 1] = QUP_BAM_FLUSH_STOP;
> +	ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++], &qup->btx.tag.start[0],
> +			     len, qup, DMA_TO_DEVICE);
> +	if (ret)
> +		return ret;
> +

  May be you can change the commit to make it explicit to say what is being
  fixed, like "current code is broken when there is sequence of wr,rd,wr" like that.
  Agree on this fix otherwise.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
