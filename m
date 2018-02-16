Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeBPHoq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:44:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753694AbeBPHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:44:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69FDA60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 11/12] i2c: qup: reorganization of driver code to remove
 polling for qup v1
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-12-git-send-email-absahu@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <04839e54-02bd-b7a6-8a94-26f72c3de7b3@codeaurora.org>
Date: Fri, 16 Feb 2018 13:14:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517644697-30806-12-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
> Following are the major issues in current driver code
> 
> 1. The current driver simply assumes the transfer completion
>    whenever its gets any non-error interrupts and then simply do the
>    polling of available/free bytes in FIFO.
> 2. The block mode is not working properly since no handling in
>    being done for OUT_BLOCK_WRITE_REQ and IN_BLOCK_READ_REQ.
> 
> Because of above, i2c v1 transfers of size greater than 32 are failing
> with following error message
> 
> 	i2c_qup 78b6000.i2c: timeout for fifo out full
> 
> To make block mode working properly and move to use the interrupts
> instead of polling, major code reorganization is required. Following
> are the major changes done in this patch
> 
> 1. Remove the polling of TX FIFO free space and RX FIFO available
>    bytes and move to interrupts completely. QUP has QUP_MX_OUTPUT_DONE,
>    QUP_MX_INPUT_DONE, OUT_BLOCK_WRITE_REQ and IN_BLOCK_READ_REQ
>    interrupts to handle FIFO’s properly so check all these interrupts.
> 2. During write, For FIFO mode, TX FIFO can be directly written
>    without checking for FIFO space. For block mode, the QUP will generate
>    OUT_BLOCK_WRITE_REQ interrupt whenever it has block size of available
>    space.
> 3. During read, both TX and RX FIFO will be used. TX will be used
>    for writing tags and RX will be used for receiving the data. In QUP,
>    TX and RX can operate in separate mode so configure modes accordingly.
> 4. For read FIFO mode, wait for QUP_MX_INPUT_DONE interrupt which
>    will be generated after all the bytes have been copied in RX FIFO. For
>    read Block mode, QUP will generate IN_BLOCK_READ_REQ interrupts
>    whenever it has block size of available data.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 399 ++++++++++++++++++++++++++++---------------
>  1 file changed, 257 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index edea3b9..af6c21a 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -73,8 +73,11 @@
>  #define QUP_IN_SVC_FLAG		BIT(9)
>  #define QUP_MX_OUTPUT_DONE	BIT(10)
>  #define QUP_MX_INPUT_DONE	BIT(11)
> +#define OUT_BLOCK_WRITE_REQ	BIT(12)
> +#define IN_BLOCK_READ_REQ	BIT(13)
>  
>  /* I2C mini core related values */
> +#define QUP_NO_INPUT		BIT(7)
>  #define QUP_CLOCK_AUTO_GATE	BIT(13)
>  #define I2C_MINI_CORE		(2 << 8)
>  #define I2C_N_VAL		15
> @@ -138,13 +141,51 @@
>  #define DEFAULT_CLK_FREQ 100000
>  #define DEFAULT_SRC_CLK 20000000
>  
> +/* MAX_OUTPUT_DONE_FLAG has been received */
> +#define QUP_BLK_EVENT_TX_IRQ_DONE		BIT(0)
> +/* MAX_INPUT_DONE_FLAG has been received */
> +#define QUP_BLK_EVENT_RX_IRQ_DONE		BIT(1)
> +/* All the TX bytes have been written in TX FIFO */
> +#define QUP_BLK_EVENT_TX_DATA_DONE		BIT(2)
> +/* All the RX bytes have been read from RX FIFO */
> +#define QUP_BLK_EVENT_RX_DATA_DONE		BIT(3)
> +
> +/* All the required events to mark a QUP I2C TX transfer completed */
> +#define QUP_BLK_EVENT_TX_DONE		(QUP_BLK_EVENT_TX_IRQ_DONE | \
> +					 QUP_BLK_EVENT_TX_DATA_DONE)
> +/* All the required events to mark a QUP I2C RX transfer completed */
> +#define QUP_BLK_EVENT_RX_DONE		(QUP_BLK_EVENT_TX_DONE | \
> +					 QUP_BLK_EVENT_RX_IRQ_DONE | \
> +					 QUP_BLK_EVENT_RX_DATA_DONE)
> +
> +/*
> + * count: no of blocks
> + * pos: current block number
> + * tx_tag_len: tx tag length for current block
> + * rx_tag_len: rx tag length for current block
> + * data_len: remaining data length for current message
> + * total_tx_len: total tx length including tag bytes for current QUP transfer
> + * total_rx_len: total rx length including tag bytes for current QUP transfer
> + * tx_fifo_free: number of free bytes in current QUP block write.
> + * fifo_available: number of available bytes in RX FIFO for current
> + *		   QUP block read
> + * is_tx_blk_mode: whether tx uses block or FIFO mode in case of non BAM xfer.
> + * is_rx_blk_mode: whether rx uses block or FIFO mode in case of non BAM xfer.
> + * tags: contains tx tag bytes for current QUP transfer
> + */
>  struct qup_i2c_block {
> -	int	count;
> -	int	pos;
> -	int	tx_tag_len;
> -	int	rx_tag_len;
> -	int	data_len;
> -	u8	tags[6];
> +	int		count;
> +	int		pos;
> +	int		tx_tag_len;
> +	int		rx_tag_len;
> +	int		data_len;
> +	int		total_tx_len;
> +	int		total_rx_len;
> +	int		tx_fifo_free;
> +	int		fifo_available;
> +	bool		is_tx_blk_mode;
> +	bool		is_rx_blk_mode;
> +	u8		tags[6];
>  };
>  
>  struct qup_i2c_tag {
> @@ -187,6 +228,7 @@ struct qup_i2c_dev {
>  
>  	/* To check if this is the last msg */
>  	bool			is_last;
> +	bool			is_qup_v1;
>  
>  	/* To configure when bus is in run state */
>  	int			config_run;
> @@ -195,6 +237,10 @@ struct qup_i2c_dev {
>  	bool			is_dma;
>  	/* To check if the current transfer is using DMA */
>  	bool			use_dma;
> +	/* Required events to mark QUP transfer as completed */
> +	u32			blk_events;
> +	/* Already completed events in QUP transfer */
> +	u32			cur_blk_events;
>  	/* The threshold length above which DMA will be used */
>  	unsigned int		dma_threshold;
>  	unsigned int		max_xfer_sg_len;
> @@ -205,11 +251,18 @@ struct qup_i2c_dev {
>  	struct			qup_i2c_bam btx;
>  
>  	struct completion	xfer;
> +	/* function to write data in tx fifo */
> +	void (*write_tx_fifo)(struct qup_i2c_dev *qup);
> +	/* function to read data from rx fifo */
> +	void (*read_rx_fifo)(struct qup_i2c_dev *qup);
> +	/* function to write tags in tx fifo for i2c read transfer */
> +	void (*write_rx_tags)(struct qup_i2c_dev *qup);
>  };
>  
>  static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
>  {
>  	struct qup_i2c_dev *qup = dev;
> +	struct qup_i2c_block *blk = &qup->blk;
>  	u32 bus_err;
>  	u32 qup_err;
>  	u32 opflags;
> @@ -256,12 +309,54 @@ static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
>  		goto done;
>  	}
>  
> -	if (opflags & QUP_IN_SVC_FLAG)
> -		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> +	if (!qup->is_qup_v1)
> +		goto done;
>  
> -	if (opflags & QUP_OUT_SVC_FLAG)
> +	if (opflags & QUP_OUT_SVC_FLAG) {
>  		writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
>  
> +		/*
> +		 * Ideally, would like to check QUP_MAX_OUTPUT_DONE_FLAG.
> +		 * However, QUP_MAX_OUTPUT_DONE_FLAG is lagging behind
> +		 * QUP_OUTPUT_SERVICE_FLAG. The only reason for
> +		 * QUP_OUTPUT_SERVICE_FLAG to be set in FIFO mode is
> +		 * QUP_MAX_OUTPUT_DONE_FLAG condition. The code checking
> +		 * here QUP_OUTPUT_SERVICE_FLAG and assumes that
> +		 * QUP_MAX_OUTPUT_DONE_FLAG.
> +		 */
> +		if (!blk->is_tx_blk_mode)
> +			qup->cur_blk_events |= QUP_BLK_EVENT_TX_IRQ_DONE;
> +
> +		if (opflags & OUT_BLOCK_WRITE_REQ) {
> +			blk->tx_fifo_free += qup->out_blk_sz;
> +			if (qup->msg->flags & I2C_M_RD)
> +				qup->write_rx_tags(qup);
> +			else
> +				qup->write_tx_fifo(qup);
> +		}
> +	}
> +
> +	if (opflags & QUP_IN_SVC_FLAG) {
> +		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> +
> +		if (!blk->is_rx_blk_mode) {
> +			blk->fifo_available += qup->in_fifo_sz;
> +			qup->read_rx_fifo(qup);
> +		} else if (opflags & IN_BLOCK_READ_REQ) {
> +			blk->fifo_available += qup->in_blk_sz;
> +			qup->read_rx_fifo(qup);
> +		}
> +	}
> +
> +	if (opflags & QUP_MX_OUTPUT_DONE)
> +		qup->cur_blk_events |= QUP_BLK_EVENT_TX_IRQ_DONE;
> +
> +	if (opflags & QUP_MX_INPUT_DONE)
> +		qup->cur_blk_events |= QUP_BLK_EVENT_RX_IRQ_DONE;
> +
> +	if (qup->cur_blk_events != qup->blk_events)
> +		return IRQ_HANDLED;

  Is it correct that if we do a complete in above case, i mean
  for TX -> based on QUP_MX_OUTPUT_DONE and for RX -> based on
  QUP_MX_INPUT_DONE, would that simplify things by getting rid of
  QUP_BLK_EVENT_RX/TX_DONE and QUP_BLK_EVENT_RX/TX_IRQ_DONE
  altogether ?

Regards,
 Sricharan

  
> +
>  done:
>  	qup->qup_err = qup_err;
>  	qup->bus_err = bus_err;
> @@ -327,6 +422,28 @@ static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
>  	return 0;
>  }
>  
> +/* Check if I2C bus returns to IDLE state */
> +static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
> +{
> +	unsigned long timeout;
> +	u32 status;
> +	int ret = 0;
> +
> +	timeout = jiffies + len * 4;
> +	for (;;) {
> +		status = readl(qup->base + QUP_I2C_STATUS);
> +		if (!(status & I2C_STATUS_BUS_ACTIVE))
> +			break;
> +
> +		if (time_after(jiffies, timeout))
> +			ret = -ETIMEDOUT;
> +
> +		usleep_range(len, len * 2);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * qup_i2c_wait_ready - wait for a give number of bytes in tx/rx path
>   * @qup: The qup_i2c_dev device
> @@ -397,23 +514,6 @@ static void qup_i2c_set_write_mode_v2(struct qup_i2c_dev *qup,
>  	}
>  }
>  
> -static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> -{
> -	/* Number of entries to shift out, including the start */
> -	int total = msg->len + 1;
> -
> -	if (total < qup->out_fifo_sz) {
> -		/* FIFO mode */
> -		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
> -		writel(total, qup->base + QUP_MX_WRITE_CNT);
> -	} else {
> -		/* BLOCK mode (transfer data on chunks) */
> -		writel(QUP_OUTPUT_BLK_MODE | QUP_REPACK_EN,
> -		       qup->base + QUP_IO_MODE);
> -		writel(total, qup->base + QUP_MX_OUTPUT_CNT);
> -	}
> -}
> -
>  static int check_for_fifo_space(struct qup_i2c_dev *qup)
>  {
>  	int ret;
> @@ -446,28 +546,25 @@ static int check_for_fifo_space(struct qup_i2c_dev *qup)
>  	return ret;
>  }
>  
> -static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
>  {
> +	struct qup_i2c_block *blk = &qup->blk;
> +	struct i2c_msg *msg = qup->msg;
>  	u32 addr = msg->addr << 1;
>  	u32 qup_tag;
>  	int idx;
>  	u32 val;
> -	int ret = 0;
>  
>  	if (qup->pos == 0) {
>  		val = QUP_TAG_START | addr;
>  		idx = 1;
> +		blk->tx_fifo_free--;
>  	} else {
>  		val = 0;
>  		idx = 0;
>  	}
>  
> -	while (qup->pos < msg->len) {
> -		/* Check that there's space in the FIFO for our pair */
> -		ret = check_for_fifo_space(qup);
> -		if (ret)
> -			return ret;
> -
> +	while (blk->tx_fifo_free && qup->pos < msg->len) {
>  		if (qup->pos == msg->len - 1)
>  			qup_tag = QUP_TAG_STOP;
>  		else
> @@ -484,11 +581,11 @@ static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  
>  		qup->pos++;
>  		idx++;
> +		blk->tx_fifo_free--;
>  	}
>  
> -	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> -
> -	return ret;
> +	if (qup->pos == msg->len)
> +		qup->cur_blk_events |= QUP_BLK_EVENT_TX_DATA_DONE;
>  }
>  
>  static void qup_i2c_set_blk_data(struct qup_i2c_dev *qup,
> @@ -1009,64 +1106,6 @@ static int qup_i2c_write_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  	return ret;
>  }
>  
> -static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> -{
> -	int ret;
> -
> -	qup->msg = msg;
> -	qup->pos = 0;
> -
> -	enable_irq(qup->irq);
> -
> -	qup_i2c_set_write_mode(qup, msg);
> -
> -	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> -	if (ret)
> -		goto err;
> -
> -	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
> -
> -	do {
> -		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
> -		if (ret)
> -			goto err;
> -
> -		ret = qup_i2c_issue_write(qup, msg);
> -		if (ret)
> -			goto err;
> -
> -		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
> -		if (ret)
> -			goto err;
> -
> -		ret = qup_i2c_wait_for_complete(qup, msg);
> -		if (ret)
> -			goto err;
> -	} while (qup->pos < msg->len);
> -
> -	/* Wait for the outstanding data in the fifo to drain */
> -	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT, ONE_BYTE);
> -err:
> -	disable_irq(qup->irq);
> -	qup->msg = NULL;
> -
> -	return ret;
> -}
> -
> -static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
> -{
> -	if (len < qup->in_fifo_sz) {
> -		/* FIFO mode */
> -		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
> -		writel(len, qup->base + QUP_MX_READ_CNT);
> -	} else {
> -		/* BLOCK mode (transfer data on chunks) */
> -		writel(QUP_INPUT_BLK_MODE | QUP_REPACK_EN,
> -		       qup->base + QUP_IO_MODE);
> -		writel(len, qup->base + QUP_MX_INPUT_CNT);
> -	}
> -}
> -
>  static void qup_i2c_set_read_mode_v2(struct qup_i2c_dev *qup, int len)
>  {
>  	int tx_len = qup->blk.tx_tag_len;
> @@ -1089,44 +1128,27 @@ static void qup_i2c_set_read_mode_v2(struct qup_i2c_dev *qup, int len)
>  	}
>  }
>  
> -static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> -{
> -	u32 addr, len, val;
> -
> -	addr = i2c_8bit_addr_from_msg(msg);
> -
> -	/* 0 is used to specify a length 256 (QUP_READ_LIMIT) */
> -	len = (msg->len == QUP_READ_LIMIT) ? 0 : msg->len;
> -
> -	val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START | addr;
> -	writel(val, qup->base + QUP_OUT_FIFO_BASE);
> -}
> -
> -
> -static int qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +static void qup_i2c_read_rx_fifo_v1(struct qup_i2c_dev *qup)
>  {
> +	struct qup_i2c_block *blk = &qup->blk;
> +	struct i2c_msg *msg = qup->msg;
>  	u32 val = 0;
>  	int idx;
> -	int ret = 0;
>  
> -	for (idx = 0; qup->pos < msg->len; idx++) {
> +	while (blk->fifo_available && qup->pos < msg->len) {
>  		if ((idx & 1) == 0) {
> -			/* Check that FIFO have data */
> -			ret = qup_i2c_wait_ready(qup, QUP_IN_NOT_EMPTY,
> -						 SET_BIT, 4 * ONE_BYTE);
> -			if (ret)
> -				return ret;
> -
>  			/* Reading 2 words at time */
>  			val = readl(qup->base + QUP_IN_FIFO_BASE);
> -
>  			msg->buf[qup->pos++] = val & 0xFF;
>  		} else {
>  			msg->buf[qup->pos++] = val >> QUP_MSW_SHIFT;
>  		}
> +		idx++;
> +		blk->fifo_available--;
>  	}
>  
> -	return ret;
> +	if (qup->pos == msg->len)
> +		qup->cur_blk_events |= QUP_BLK_EVENT_RX_DATA_DONE;
>  }
>  
>  static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
> @@ -1227,49 +1249,137 @@ static int qup_i2c_read_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  	return ret;
>  }
>  
> -static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +static void qup_i2c_set_blk_event(struct qup_i2c_dev *qup, bool is_rx)
>  {
> +	qup->cur_blk_events = 0;
> +	qup->blk_events = is_rx ? QUP_BLK_EVENT_RX_DONE : QUP_BLK_EVENT_TX_DONE;
> +}
> +
> +static void qup_i2c_write_rx_tags_v1(struct qup_i2c_dev *qup)
> +{
> +	struct i2c_msg *msg = qup->msg;
> +	u32 addr, len, val;
> +
> +	addr = i2c_8bit_addr_from_msg(msg);
> +
> +	/* 0 is used to specify a length 256 (QUP_READ_LIMIT) */
> +	len = (msg->len == QUP_READ_LIMIT) ? 0 : msg->len;
> +
> +	val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START | addr;
> +	writel(val, qup->base + QUP_OUT_FIFO_BASE);
> +	qup->cur_blk_events |= QUP_BLK_EVENT_TX_DATA_DONE;
> +}
> +
> +static void qup_i2c_conf_v1(struct qup_i2c_dev *qup)
> +{
> +	struct qup_i2c_block *blk = &qup->blk;
> +	u32 qup_config = I2C_MINI_CORE | I2C_N_VAL;
> +	u32 io_mode = QUP_REPACK_EN;
> +
> +	blk->is_tx_blk_mode =
> +		blk->total_tx_len > qup->out_fifo_sz ? true : false;
> +	blk->is_rx_blk_mode =
> +		blk->total_rx_len > qup->in_fifo_sz ? true : false;
> +
> +	if (blk->is_tx_blk_mode) {
> +		io_mode |= QUP_OUTPUT_BLK_MODE;
> +		writel(0, qup->base + QUP_MX_WRITE_CNT);
> +		writel(blk->total_tx_len, qup->base + QUP_MX_OUTPUT_CNT);
> +	} else {
> +		writel(0, qup->base + QUP_MX_OUTPUT_CNT);
> +		writel(blk->total_tx_len, qup->base + QUP_MX_WRITE_CNT);
> +	}
> +
> +	if (blk->total_rx_len) {
> +		if (blk->is_rx_blk_mode) {
> +			io_mode |= QUP_INPUT_BLK_MODE;
> +			writel(0, qup->base + QUP_MX_READ_CNT);
> +			writel(blk->total_rx_len, qup->base + QUP_MX_INPUT_CNT);
> +		} else {
> +			writel(0, qup->base + QUP_MX_INPUT_CNT);
> +			writel(blk->total_rx_len, qup->base + QUP_MX_READ_CNT);
> +		}
> +	} else {
> +		qup_config |= QUP_NO_INPUT;
> +	}
> +
> +	writel(qup_config, qup->base + QUP_CONFIG);
> +	writel(io_mode, qup->base + QUP_IO_MODE);
> +}
> +
> +static void qup_i2c_clear_blk_v1(struct qup_i2c_block *blk)
> +{
> +	blk->tx_fifo_free = 0;
> +	blk->fifo_available = 0;
> +}
> +
> +static int qup_i2c_conf_xfer_v1(struct qup_i2c_dev *qup, bool is_rx)
> +{
> +	struct qup_i2c_block *blk = &qup->blk;
>  	int ret;
>  
> -	qup->msg = msg;
> -	qup->pos  = 0;
> -
> -	enable_irq(qup->irq);
> -	qup_i2c_set_read_mode(qup, msg->len);
> -
> +	qup_i2c_clear_blk_v1(blk);
> +	qup_i2c_conf_v1(qup);
>  	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
>  
>  	ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
> -	qup_i2c_issue_read(qup, msg);
> +	qup_i2c_set_blk_event(qup, is_rx);
> +	reinit_completion(&qup->xfer);
> +	enable_irq(qup->irq);
> +	if (!blk->is_tx_blk_mode) {
> +		blk->tx_fifo_free = qup->out_fifo_sz;
> +
> +		if (is_rx)
> +			qup_i2c_write_rx_tags_v1(qup);
> +		else
> +			qup_i2c_write_tx_fifo_v1(qup);
> +	}
>  
>  	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
>  	if (ret)
>  		goto err;
>  
> -	do {
> -		ret = qup_i2c_wait_for_complete(qup, msg);
> -		if (ret)
> -			goto err;
> +	ret = qup_i2c_wait_for_complete(qup, qup->msg);
> +	if (ret)
> +		goto err;
>  
> -		ret = qup_i2c_read_fifo(qup, msg);
> -		if (ret)
> -			goto err;
> -	} while (qup->pos < msg->len);
> +	ret = qup_i2c_bus_active(qup, ONE_BYTE);
>  
>  err:
>  	disable_irq(qup->irq);
> -	qup->msg = NULL;
> -
>  	return ret;
>  }
>  
> +static int qup_i2c_write_one(struct qup_i2c_dev *qup)
> +{
> +	struct i2c_msg *msg = qup->msg;
> +	struct qup_i2c_block *blk = &qup->blk;
> +
> +	qup->pos = 0;
> +	blk->total_tx_len = msg->len +  1;
> +	blk->total_rx_len = 0;
> +
> +	return qup_i2c_conf_xfer_v1(qup, false);
> +}
> +
> +static int qup_i2c_read_one(struct qup_i2c_dev *qup)
> +{
> +	struct qup_i2c_block *blk = &qup->blk;
> +
> +	qup->pos = 0;
> +	blk->total_tx_len = 2;
> +	blk->total_rx_len = qup->msg->len;
> +
> +	return qup_i2c_conf_xfer_v1(qup, true);
> +}
> +
>  static int qup_i2c_xfer(struct i2c_adapter *adap,
>  			struct i2c_msg msgs[],
>  			int num)
> @@ -1308,10 +1418,11 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
>  			goto out;
>  		}
>  
> +		qup->msg = &msgs[idx];
>  		if (msgs[idx].flags & I2C_M_RD)
> -			ret = qup_i2c_read_one(qup, &msgs[idx]);
> +			ret = qup_i2c_read_one(qup);
>  		else
> -			ret = qup_i2c_write_one(qup, &msgs[idx]);
> +			ret = qup_i2c_write_one(qup);
>  
>  		if (ret)
>  			break;
> @@ -1489,6 +1600,10 @@ static int qup_i2c_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
>  		qup->adap.algo = &qup_i2c_algo;
>  		qup->adap.quirks = &qup_i2c_quirks;
> +		qup->is_qup_v1 = true;
> +		qup->write_tx_fifo = qup_i2c_write_tx_fifo_v1;
> +		qup->read_rx_fifo = qup_i2c_read_rx_fifo_v1;
> +		qup->write_rx_tags = qup_i2c_write_rx_tags_v1;
>  	} else {
>  		qup->adap.algo = &qup_i2c_algo_v2;
>  		ret = qup_i2c_req_dma(qup);
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
