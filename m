Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBPFVR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 00:21:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeBPFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 00:21:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 241986079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 09/12] i2c: qup: fix buffer overflow for multiple msg of
 maximum xfer len
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <246915f4-5351-c1b5-761b-45d88e4a3845@codeaurora.org>
Date: Fri, 16 Feb 2018 10:51:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> The BAM mode requires buffer for start tag data and tx, rx SG
> list. Currently, this is being taken for maximum transfer length
> (65K). But an I2C transfer can have multiple messages and each
> message can be of this maximum length so the buffer overflow will
> happen in this case. Since increasing buffer length won’t be
> feasible since an I2C transfer can contain any number of messages
> so this patch does following changes to make i2c transfers working
> for multiple messages case.
> 
> 1. Calculate the required buffers for 2 maximum length messages
>    (65K * 2).
> 2. Split the descriptor formation and descriptor scheduling.
>    The idea is to fit as many messages in one DMA transfers for 65K
>    threshold value (max_xfer_sg_len). Whenever the sg_cnt is
>    crossing this, then schedule the BAM transfer and subsequent
>    transfer will again start from zero.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 199 +++++++++++++++++++++++++------------------
>  1 file changed, 118 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 6df65ea..ba717bb 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -155,6 +155,7 @@ struct qup_i2c_bam {
>  	struct	qup_i2c_tag tag;
>  	struct	dma_chan *dma;
>  	struct	scatterlist *sg;
> +	unsigned int sg_cnt;
>  };
>  
>  struct qup_i2c_dev {
> @@ -195,6 +196,8 @@ struct qup_i2c_dev {
>  	bool			use_dma;
>  	/* The threshold length above which DMA will be used */
>  	unsigned int		dma_threshold;
> +	unsigned int		max_xfer_sg_len;
> +	unsigned int		tag_buf_pos;
>  	struct			dma_pool *dpool;
>  	struct			qup_i2c_tag start_tag;
>  	struct			qup_i2c_bam brx;
> @@ -699,86 +702,86 @@ static int qup_i2c_req_dma(struct qup_i2c_dev *qup)
>  	return 0;
>  }
>  
> -static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
> -			       int num)
> +static int qup_i2c_bam_make_desc(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +{
> +	int ret = 0, limit = QUP_READ_LIMIT;
> +	u32 len = 0, blocks, rem;
> +	u32 i = 0, tlen, tx_len = 0;
> +	u8 *tags;
> +
> +	qup_i2c_set_blk_data(qup, msg);
> +
> +	blocks = qup->blk.count;
> +	rem = msg->len - (blocks - 1) * limit;
> +
> +	if (msg->flags & I2C_M_RD) {
> +		while (qup->blk.pos < blocks) {
> +			tlen = (i == (blocks - 1)) ? rem : limit;
> +			tags = &qup->start_tag.start[qup->tag_buf_pos + len];
> +			len += qup_i2c_set_tags(tags, qup, msg);
> +			qup->blk.data_len -= tlen;
> +
> +			/* scratch buf to read the start and len tags */
> +			ret = qup_sg_set_buf(&qup->brx.sg[qup->brx.sg_cnt++],
> +					     &qup->brx.tag.start[0],
> +					     2, qup, DMA_FROM_DEVICE);
> +
> +			if (ret)
> +				return ret;
> +
> +			ret = qup_sg_set_buf(&qup->brx.sg[qup->brx.sg_cnt++],
> +					     &msg->buf[limit * i],
> +					     tlen, qup,
> +					     DMA_FROM_DEVICE);
> +			if (ret)
> +				return ret;
> +
> +			i++;
> +			qup->blk.pos = i;
> +		}
> +		ret = qup_sg_set_buf(&qup->btx.sg[qup->btx.sg_cnt++],
> +				     &qup->start_tag.start[qup->tag_buf_pos],
> +				     len, qup, DMA_TO_DEVICE);
> +		if (ret)
> +			return ret;
> +
> +		qup->tag_buf_pos += len;
> +	} else {
> +		while (qup->blk.pos < blocks) {
> +			tlen = (i == (blocks - 1)) ? rem : limit;
> +			tags = &qup->start_tag.start[qup->tag_buf_pos + tx_len];
> +			len = qup_i2c_set_tags(tags, qup, msg);
> +			qup->blk.data_len -= tlen;
> +
> +			ret = qup_sg_set_buf(&qup->btx.sg[qup->btx.sg_cnt++],
> +					     tags, len,
> +					     qup, DMA_TO_DEVICE);
> +			if (ret)
> +				return ret;
> +
> +			tx_len += len;
> +			ret = qup_sg_set_buf(&qup->btx.sg[qup->btx.sg_cnt++],
> +					     &msg->buf[limit * i],
> +					     tlen, qup, DMA_TO_DEVICE);
> +			if (ret)
> +				return ret;
> +			i++;
> +			qup->blk.pos = i;
> +		}
> +
> +		qup->tag_buf_pos += tx_len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qup_i2c_bam_schedule_desc(struct qup_i2c_dev *qup)
>  {
>  	struct dma_async_tx_descriptor *txd, *rxd = NULL;
> -	int ret = 0, idx = 0, limit = QUP_READ_LIMIT;
> +	int ret = 0;
>  	dma_cookie_t cookie_rx, cookie_tx;
> -	u32 len, blocks, rem;
> -	u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
> -	u8 *tags;
> -
> -	while (idx < num) {
> -		tx_len = 0, len = 0, i = 0;
> -
> -		qup->is_last = (idx == (num - 1));
> -
> -		qup_i2c_set_blk_data(qup, msg);
> -
> -		blocks = qup->blk.count;
> -		rem = msg->len - (blocks - 1) * limit;
> -
> -		if (msg->flags & I2C_M_RD) {
> -			while (qup->blk.pos < blocks) {
> -				tlen = (i == (blocks - 1)) ? rem : limit;
> -				tags = &qup->start_tag.start[off + len];
> -				len += qup_i2c_set_tags(tags, qup, msg);
> -				qup->blk.data_len -= tlen;
> -
> -				/* scratch buf to read the start and len tags */
> -				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
> -						     &qup->brx.tag.start[0],
> -						     2, qup, DMA_FROM_DEVICE);
> -
> -				if (ret)
> -					return ret;
> -
> -				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
> -						     &msg->buf[limit * i],
> -						     tlen, qup,
> -						     DMA_FROM_DEVICE);
> -				if (ret)
> -					return ret;
> -
> -				i++;
> -				qup->blk.pos = i;
> -			}
> -			ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -					     &qup->start_tag.start[off],
> -					     len, qup, DMA_TO_DEVICE);
> -			if (ret)
> -				return ret;
> -
> -			off += len;
> -		} else {
> -			while (qup->blk.pos < blocks) {
> -				tlen = (i == (blocks - 1)) ? rem : limit;
> -				tags = &qup->start_tag.start[off + tx_len];
> -				len = qup_i2c_set_tags(tags, qup, msg);
> -				qup->blk.data_len -= tlen;
> -
> -				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -						     tags, len,
> -						     qup, DMA_TO_DEVICE);
> -				if (ret)
> -					return ret;
> -
> -				tx_len += len;
> -				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -						     &msg->buf[limit * i],
> -						     tlen, qup, DMA_TO_DEVICE);
> -				if (ret)
> -					return ret;
> -				i++;
> -				qup->blk.pos = i;
> -			}
> -			off += tx_len;
> -
> -		}
> -		idx++;
> -		msg++;
> -	}
> +	u32 len = 0;
> +	u32 tx_buf = qup->btx.sg_cnt, rx_buf = qup->brx.sg_cnt;
>  
>  	/* schedule the EOT and FLUSH I2C tags */
>  	len = 1;
> @@ -878,11 +881,19 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>  	return ret;
>  }
>  
> +static void qup_i2c_bam_clear_tag_buffers(struct qup_i2c_dev *qup)
> +{
> +	qup->btx.sg_cnt = 0;
> +	qup->brx.sg_cnt = 0;
> +	qup->tag_buf_pos = 0;
> +}
> +
>  static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
>  			    int num)
>  {
>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
>  	int ret = 0;
> +	int idx = 0;
>  
>  	enable_irq(qup->irq);
>  	ret = qup_i2c_req_dma(qup);
> @@ -905,9 +916,34 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
>  		goto out;
>  
>  	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
> +	qup_i2c_bam_clear_tag_buffers(qup);
> +
> +	for (idx = 0; idx < num; idx++) {
> +		qup->msg = msg + idx;
> +		qup->is_last = idx == (num - 1);
> +
> +		ret = qup_i2c_bam_make_desc(qup, qup->msg);
> +		if (ret)
> +			break;
> +
> +		/*
> +		 * Make DMA descriptor and schedule the BAM transfer if its
> +		 * already crossed the maximum length. Since the memory for all
> +		 * tags buffers have been taken for 2 maximum possible
> +		 * transfers length so it will never cross the buffer actual
> +		 * length.
> +		 */
> +		if (qup->btx.sg_cnt > qup->max_xfer_sg_len ||
> +		    qup->brx.sg_cnt > qup->max_xfer_sg_len ||
> +		    qup->is_last) {
> +			ret = qup_i2c_bam_schedule_desc(qup);
> +			if (ret)
> +				break;
> +
> +			qup_i2c_bam_clear_tag_buffers(qup);
> +		}
> +	}
>  

  hmm, is this because of only stress tests or was there any device which
  was using i2c for multiple messages exceeding 64k bytes ?

  Infact we are trying to club two separate messages together across 64k
  boundaries. Not sure if its really correct. So either we club all messages
  fully or club only up to the length that would cover the whole message < 64K
  and send the remaining whole messages in next transfer.

Regards,
  Sricharan
 

> -	qup->msg = msg;
> -	ret = qup_i2c_bam_do_xfer(qup, qup->msg, num);
>  out:
>  	disable_irq(qup->irq);
>  
> @@ -1459,7 +1495,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
>  		else if (ret != 0)
>  			goto nodma;
>  
> -		blocks = (MX_BLOCKS << 1) + 1;
> +		qup->max_xfer_sg_len = (MX_BLOCKS << 1);
> +		blocks = 2 * qup->max_xfer_sg_len + 1;
>  		qup->btx.sg = devm_kzalloc(&pdev->dev,
>  					   sizeof(*qup->btx.sg) * blocks,
>  					   GFP_KERNEL);
> @@ -1603,7 +1640,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
>  	one_bit_t = (USEC_PER_SEC / clk_freq) + 1;
>  	qup->one_byte_t = one_bit_t * 9;
>  	qup->xfer_timeout = TOUT_MIN * HZ +
> -			    usecs_to_jiffies(MX_TX_RX_LEN * qup->one_byte_t);
> +		usecs_to_jiffies(2 * MX_TX_RX_LEN * qup->one_byte_t);
>  
>  	dev_dbg(qup->dev, "IN:block:%d, fifo:%d, OUT:block:%d, fifo:%d\n",
>  		qup->in_blk_sz, qup->in_fifo_sz,
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
