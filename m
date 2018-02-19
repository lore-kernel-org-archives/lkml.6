Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeBSOIe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:08:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBSOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:08:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2018 19:38:29 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] i2c: qup: reorganization of driver code to remove
 polling for qup v2
In-Reply-To: <8de4b44a-7f8b-c8ed-4282-af17c4e9a52a@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-13-git-send-email-absahu@codeaurora.org>
 <8de4b44a-7f8b-c8ed-4282-af17c4e9a52a@codeaurora.org>
Message-ID: <cbb648d395c2c216c1abf0b301e2e914@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>>  static void qup_i2c_set_blk_event(struct qup_i2c_dev *qup, bool 
>> is_rx)
>>  {
>>  	qup->cur_blk_events = 0;
>> @@ -1442,13 +1155,452 @@ static int qup_i2c_xfer(struct i2c_adapter 
>> *adap,
>>  	return ret;
>>  }
>> 
> 
>   Since this is used for both FIFO and BLK mode, might be good to call 
> it
>   qup_i2c_set_event. Same in rest of the places and macros as well.
>   But if this is going to be removed altogether, then great.
> 

   Sure. I will rename this and others.
   I will check for removing but as replied in Patch 11. We need to track 
for
   3 things in RX case. For TX case, OUTPUT_DONE should be sufficient.

>> +/*
>> + * Function to configure registers related with reconfiguration 
>> during run
>> + * and will be done before each I2C sub transfer.
>> + */
>> +static void qup_i2c_conf_count_v2(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	u32 qup_config = I2C_MINI_CORE | I2C_N_VAL_V2;
>> +
>> +	if (blk->is_tx_blk_mode)
>> +		writel(qup->config_run | blk->total_tx_len,
>> +		       qup->base + QUP_MX_OUTPUT_CNT);
>> +	else
>> +		writel(qup->config_run | blk->total_tx_len,
>> +		       qup->base + QUP_MX_WRITE_CNT);
>> +
>> +	if (blk->total_rx_len) {
>> +		if (blk->is_rx_blk_mode)
>> +			writel(qup->config_run | blk->total_rx_len,
>> +			       qup->base + QUP_MX_INPUT_CNT);
>> +		else
>> +			writel(qup->config_run | blk->total_rx_len,
>> +			       qup->base + QUP_MX_READ_CNT);
>> +	} else {
>> +		qup_config |= QUP_NO_INPUT;
>> +	}
>> +
>> +	writel(qup_config, qup->base + QUP_CONFIG);
>> +}
>> +
>> +/*
>> + * Function to configure registers related with transfer mode 
>> (FIFO/Block)
>> + * before starting of i2c transfer and will be done only once in QUP 
>> RESET
>> + * state.
>> + */
>> +static void qup_i2c_conf_mode_v2(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	u32 io_mode = QUP_REPACK_EN;
>> +
>> +	if (blk->is_tx_blk_mode) {
>> +		io_mode |= QUP_OUTPUT_BLK_MODE;
>> +		writel(0, qup->base + QUP_MX_WRITE_CNT);
>> +	} else {
>> +		writel(0, qup->base + QUP_MX_OUTPUT_CNT);
>> +	}
>> +
>> +	if (blk->is_rx_blk_mode) {
>> +		io_mode |= QUP_INPUT_BLK_MODE;
>> +		writel(0, qup->base + QUP_MX_READ_CNT);
>> +	} else {
>> +		writel(0, qup->base + QUP_MX_INPUT_CNT);
>> +	}
>> +
>> +	writel(io_mode, qup->base + QUP_IO_MODE);
>> +}
>> +
>> +/*
>> + * Function to clear required variables before starting of any QUP v2
>> + * sub transfer
>> + */
>> +static void qup_i2c_clear_blk_v2(struct qup_i2c_block *blk)
>> +{
>> +	blk->send_last_word = false;
>> +	blk->tx_tags_sent = false;
>> +	blk->tx_fifo_data = 0;
>> +	blk->tx_fifo_data_pos = 0;
>> +	blk->tx_fifo_free = 0;
>> +
>> +	blk->rx_tags_fetched = false;
>> +	blk->rx_fifo_data = 0;
>> +	blk->rx_fifo_data_pos = 0;
>> +	blk->fifo_available = 0;
>> +}
>> +
>> +/*
>> + * Function to receive data from RX FIFO for read message in QUP v2
>> + * i2c transfer.
>> + */
>> +static void qup_i2c_recv_data(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	int j;
>> +
>> +	for (j = blk->rx_fifo_data_pos;
>> +	     blk->cur_blk_len && blk->fifo_available;
>> +	     blk->cur_blk_len--, blk->fifo_available--) {
>> +		if (j == 0)
>> +			blk->rx_fifo_data = readl(qup->base + QUP_IN_FIFO_BASE);
>> +
>> +		*(blk->cur_data++) = blk->rx_fifo_data;
>> +		blk->rx_fifo_data >>= 8;
>> +
>> +		if (j == 3)
>> +			j = 0;
>> +		else
>> +			j++;
>> +	}
>> +
>> +	blk->rx_fifo_data_pos = j;
>> +}
>> +
>> +/* Function to receive tags for read message in QUP v2 i2c transfer. 
>> */
>> +static void qup_i2c_recv_tags(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +
>> +	blk->rx_fifo_data = readl(qup->base + QUP_IN_FIFO_BASE);
>> +	blk->rx_fifo_data >>= blk->rx_tag_len  * 8;
> 
>   why cant it be simply ignored ?
> 

   We need to read the data from FIFO and increment the rx_fifo_data_pos
   and decrement the fifo_available. The tag bytes are being ignored.

>> +	blk->rx_fifo_data_pos = blk->rx_tag_len;
>> +	blk->fifo_available -= blk->rx_tag_len;
>> +}
>> +
>> +/*
>> + * This function reads the data and tags from RX FIFO. Since in read 
>> case, the
>> + * tags will be preceded by received data bytes need to be written so
>> + * 1. Check if rx_tags_fetched is false i.e. the start of QUP block 
>> so receive
>> + *    all tag bytes and discard that.
>> + * 2. Read the data from RX FIFO. When all the data bytes have been 
>> read then
>> + *    mark the QUP_BLK_EVENT_RX_DATA_DONE in current block event and 
>> return.
>> + */
>> +static void qup_i2c_read_rx_fifo_v2(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +
>> +	if (!blk->rx_tags_fetched) {
>> +		qup_i2c_recv_tags(qup);
>> +		blk->rx_tags_fetched = true;
>> +	}
>> +
>> +	qup_i2c_recv_data(qup);
>> +	if (!blk->cur_blk_len)
>> +		qup->cur_blk_events |= QUP_BLK_EVENT_RX_DATA_DONE;
>> +}
>> +
>> +/*
>> + * Function to write bytes in TX FIFO for write message in QUP v2 i2c
>> + * transfer. QUP TX FIFO write works on word basis (4 bytes). New 
>> byte write to
>> + * TX FIFO will be appended in this data tx_fifo_data and will be 
>> written to TX
>> + * FIFO when all the 4 bytes are available.
>> + */
>> +static void
>> +qup_i2c_write_blk_data(struct qup_i2c_dev *qup, u8 **data, unsigned 
>> int *len)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	unsigned int j;
>> +
>> +	for (j = blk->tx_fifo_data_pos; *len && blk->tx_fifo_free;
>> +	     (*len)--, blk->tx_fifo_free--) {
>> +		blk->tx_fifo_data |= *(*data)++ << (j * 8);
>> +		if (j == 3) {
>> +			writel(blk->tx_fifo_data,
>> +			       qup->base + QUP_OUT_FIFO_BASE);
>> +			blk->tx_fifo_data = 0x0;
>> +			j = 0;
>> +		} else {
>> +			j++;
>> +		}
>> +	}
>> +
>> +	blk->tx_fifo_data_pos = j;
>> +}
>> +
>> +/* Function to transfer tags for read message in QUP v2 i2c transfer. 
>> */
>> +static void qup_i2c_write_rx_tags_v2(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +
>> +	qup_i2c_write_blk_data(qup, &blk->cur_tx_tags, &blk->tx_tag_len);
>> +	if (blk->tx_fifo_data_pos)
>> +		writel(blk->tx_fifo_data, qup->base + QUP_OUT_FIFO_BASE);
>> +
>> +	qup->cur_blk_events |= QUP_BLK_EVENT_TX_DATA_DONE;
>> +}
>> +
>> +/*
>> + * This function writes the data and tags in TX FIFO. Since in write 
>> case, both
>> + * tags and data need to be written and QUP write tags can have 
>> maximum 256 data
>> + * length, so it follows simple internal state machine to manage it.
>> + * 1. Check if tx_tags_sent is false i.e. the start of QUP block so 
>> write the
>> + *    tags to TX FIFO.
>> + * 2. Check if send_last_word is true. This will be set when last few 
>> data bytes
>> + *    less than 4 bytes are reamining to be written in FIFO because 
>> of no FIFO
>> + *    space. All this data bytes are available in tx_fifo_data so 
>> write this
>> + *    in FIFO and mark the tx done.
>> + * 3. Write the data to TX FIFO and check for cur_blk_len. If this is 
>> non zero
>> + *    then more data is pending otherwise following 3 cases can be 
>> possible
>> + *    a. if tx_fifo_data_pos is zero that means all the data bytes in 
>> this block
>> + *       have been written in TX FIFO so mark the tx done.
>> + *    b. tx_fifo_free is zero. In this case, last few bytes (less 
>> than 4
>> + *       bytes) are copied to tx_fifo_data but couldn't be sent 
>> because of
>> + *       FIFO full so make send_last_word true.
>> + *    c. tx_fifo_free is non zero i.e tx FIFO is free so copy the 
>> remaining data
>> + *       from tx_fifo_data to tx FIFO and mark the tx done. Since,
>> + *       qup_i2c_write_blk_data do write in 4 bytes and FIFO space is 
>> in
>> + *       multiple of 4 bytes so tx_fifo_free will be always greater 
>> than or
>> + *       equal to 4 bytes.
> 
>        Comments b and c should be c and b as per the code below
> 

  I Will fix that.

>> + */
>> +static void qup_i2c_write_tx_fifo_v2(struct qup_i2c_dev *qup)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +
>> +	if (!blk->tx_tags_sent) {
>> +		qup_i2c_write_blk_data(qup, &blk->cur_tx_tags,
>> +				       &blk->tx_tag_len);
>> +		blk->tx_tags_sent = true;
>> +	}
>> +
>> +	if (blk->send_last_word)
>> +		goto send_last_word;
>> +
>> +	qup_i2c_write_blk_data(qup, &blk->cur_data, &blk->cur_blk_len);
> 
>  ok, do understand, why is cur_blk_len zero and we still have pending
> bytes to be written ?
> 

  qup_i2c_write_blk_data will return if we don't have space
  in TX FIFO or these are last remaining bytes (less than 4).
  qup_i2c_write_blk_data will write to TX FIFO when the tx_fifo_data_pos
  is 3 i.e all 4 bytes.

  The following check is taking care of this case.
  If we have space available in TX FIFO then copy the data from 
tx_fifo_data
  otherwise mark send_last_word true so that when space will be
  available then this function will just sent those remaining bytes.


>> +	if (!blk->cur_blk_len) {
>> +		if (!blk->tx_fifo_data_pos)
>> +			goto tx_data_done;
>> +
>> +		if (blk->tx_fifo_free)
>> +			goto send_last_word;
>> +
>> +		blk->send_last_word = true;
>> +	}
>> +
>> +	return;
>> +
>> +send_last_word:
>> +	writel(blk->tx_fifo_data, qup->base + QUP_OUT_FIFO_BASE);
>> +tx_data_done:
>> +	qup->cur_blk_events |= QUP_BLK_EVENT_TX_DATA_DONE;
> 
>   Yes, as commented on the previous patch, if we can get rid of this 4 
> flags
>   for completion in block/fifo mode, it would simply things a bit.
> 

  It seems QUP_BLK_EVENT_TX_DATA_DONE can be removed.

>> +}
>> +
>> +/*
>> + * Main transfer function which will be used for reading or writing 
>> i2c data.
>> + * The QUP v2 supports reconfiguration during run in which multiple 
>> i2c sub
>> + * transfers can be scheduled.
>> + */
>> +static int
>> +qup_i2c_conf_xfer_v2(struct qup_i2c_dev *qup, bool is_rx, bool 
>> is_first,
>> +		     bool change_pause_state)
>> +{
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	struct i2c_msg *msg = qup->msg;
>> +	int ret;
>> +
>> +	/*
>> +	 * Check if its SMBus Block read for which the top level read will 
>> be
>> +	 * done into 2 QUP reads. One with message length 1 while other one 
>> is
>> +	 * with actual length.
>> +	 */
>> +	if (qup_i2c_check_msg_len(msg)) {
>> +		if (qup->is_smbus_read) {
>> +			/*
>> +			 * If the message length is already read in
>> +			 * the first byte of the buffer, account for
>> +			 * that by setting the offset
>> +			 */
>> +			blk->cur_data += 1;
>> +			is_first = false;
>> +		} else {
>> +			change_pause_state = false;
>> +		}
>> +	}
>> +
>> +	qup->config_run = is_first ? 0 : QUP_I2C_MX_CONFIG_DURING_RUN;
>> +
>> +	qup_i2c_clear_blk_v2(blk);
>> +	qup_i2c_conf_count_v2(qup);
>> +
>> +	/* If it is first sub transfer, then configure i2c bus clocks */
>> +	if (is_first) {
>> +		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
>> +		if (ret)
>> +			return ret;
>> +
>> +		writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
>> +
>> +		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	qup_i2c_set_blk_event(qup, is_rx);
> 
>   hmm, if the completion is changed as per the just INPUT/OUTPUT done
>   then this blk event tracking can be removed.
> 

  I will check for RX case. If adding condition for I2C_M_RD and 
remaining
  bytes to be read is zero makes code more readable then I will change
  and remove this function.

>> +	reinit_completion(&qup->xfer);
>> +	enable_irq(qup->irq);
>> +	/*
>> +	 * In FIFO mode, tx FIFO can be written directly while in block mode 
>> the
>> +	 * it will be written after getting OUT_BLOCK_WRITE_REQ interrupt
>> +	 */
>> +	if (!blk->is_tx_blk_mode) {
>> +		blk->tx_fifo_free = qup->out_fifo_sz;
>> +
>> +		if (is_rx)
>> +			qup_i2c_write_rx_tags_v2(qup);
>> +		else
>> +			qup_i2c_write_tx_fifo_v2(qup);
>> +	}
>> +
>> +	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = qup_i2c_wait_for_complete(qup, msg);
>> +	if (ret)
>> +		goto err;
>> +
>> +	/* Move to pause state for all the transfers, except last one */
>> +	if (change_pause_state) {
>> +		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +err:
>> +	disable_irq(qup->irq);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Function to transfer one read/write message in i2c transfer. It 
>> splits the
>> + * message into multiple of blk_xfer_limit data length blocks and 
>> schedule each
>> + * QUP block individually.
>> + */
>> +static int qup_i2c_xfer_v2_msg(struct qup_i2c_dev *qup, int msg_id, 
>> bool is_rx)
>> +{
>> +	int ret = 0;
>> +	unsigned int data_len, i;
>> +	struct i2c_msg *msg = qup->msg;
>> +	struct qup_i2c_block *blk = &qup->blk;
>> +	u8 *msg_buf = msg->buf;
>> +
>> +	qup->blk_xfer_limit = is_rx ? RECV_MAX_DATA_LEN : QUP_READ_LIMIT;
>> +	qup_i2c_set_blk_data(qup, msg);
>> +
>> +	for (i = 0; i < blk->count; i++) {
>> +		data_len =  qup_i2c_get_data_len(qup);
>> +		blk->pos = i;
>> +		blk->cur_tx_tags = blk->tags;
>> +		blk->cur_blk_len = data_len;
>> +		blk->tx_tag_len =
>> +			qup_i2c_set_tags(blk->cur_tx_tags, qup, qup->msg);
>> +
>> +		blk->cur_data = msg_buf;
>> +
>> +		if (is_rx) {
>> +			blk->total_tx_len = blk->tx_tag_len;
>> +			blk->rx_tag_len = 2;
>> +			blk->total_rx_len = blk->rx_tag_len + data_len;
>> +		} else {
>> +			blk->total_tx_len = blk->tx_tag_len + data_len;
>> +			blk->total_rx_len = 0;
>> +		}
>> +
>> +		ret = qup_i2c_conf_xfer_v2(qup, is_rx, !msg_id && !i,
>> +					   !qup->is_last || i < blk->count - 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Handle SMBus block read length */
>> +		if (qup_i2c_check_msg_len(msg) && msg->len == 1 &&
>> +		    !qup->is_smbus_read) {
>> +			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX)
>> +				return -EPROTO;
>> +
>> +			msg->len = msg->buf[0];
>> +			qup->is_smbus_read = true;
>> +			ret = qup_i2c_xfer_v2_msg(qup, msg_id, true);
>> +			qup->is_smbus_read = false;
>> +			if (ret)
>> +				return ret;
>> +
>> +			msg->len += 1;
>> +		}
>> +
>> +		msg_buf += data_len;
>> +		blk->data_len -= qup->blk_xfer_limit;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * QUP v2 supports 3 modes
>> + * Programmed IO using FIFO mode : Less than FIFO size
>> + * Programmed IO using Block mode : Greater than FIFO size
>> + * DMA using BAM : Appropriate for any transactio size but the 
>> address should be
>> + *		   DMA applicable
>> + *
> 
>  s/transactio/transaction
> 

  I Will fix this and qup_i2c_determine_mode.

>> + * This function determines the mode which will be used for this 
>> transfer. An
>> + * i2c transfer contains multiple message. Following are the rules to 
>> determine
>> + * the mode used.
>> + * 1. Determine the tx and rx length for each message and maximum tx 
>> and rx
>> + *    length for complete transfer
>> + * 2. If tx or rx length is greater than DMA threshold than use the 
>> DMA mode.
>> + * 3. In FIFO or block mode, TX and RX can operate in different mode 
>> so check
>> + *    for maximum tx and rx length to determine mode.
>> + */
>> +static int
>> +qup_i2c_determine_mode(struct qup_i2c_dev *qup, struct i2c_msg 
>> msgs[], int num)
> 
>    qup_i2c_determine_mode_v2
> 
>> +{
>> +	int idx;
>> +	bool no_dma = false;
>> +	unsigned int max_tx_len = 0, max_rx_len = 0;
>> +	unsigned int cur_tx_len, cur_rx_len;
>> +	unsigned int total_rx_len = 0, total_tx_len = 0;
>> +
>> +	/* All i2c_msgs should be transferred using either dma or cpu */
>> +	for (idx = 0; idx < num; idx++) {
>> +		if (msgs[idx].len == 0)
>> +			return -EINVAL;
>> +
>> +		if (msgs[idx].flags & I2C_M_RD) {
>> +			cur_tx_len = 0;
>> +			cur_rx_len = msgs[idx].len;
>> +		} else {
>> +			cur_tx_len = msgs[idx].len;
>> +			cur_rx_len = 0;
>> +		}
>> +
>> +		if (is_vmalloc_addr(msgs[idx].buf))
>> +			no_dma = true;
>> +
>> +		max_tx_len = max(max_tx_len, cur_tx_len);
>> +		max_rx_len = max(max_rx_len, cur_rx_len);
>> +		total_rx_len += cur_rx_len;
>> +		total_tx_len += cur_tx_len;
>> +	}
> 
>  why is tag length for each block not being considered here ?

  That is to avoid unnecessary calculation.
  The role of this function is to just determine mode.
  DMA and block mode will work for any xfer length.
  but FIFO won't work for > 64.

  The max tag length already we have considered in blk_mode_threshold.
  in None of the case, it will give FIFO mode for xfer greater than
  64 bytes.

> 
>> +
>> +	if (!no_dma && qup->is_dma &&
> 
>   why do we need is_dma and use_dma ?
>   Now that you have removed the need for is_dma in rest of places,
>   better to get rid of that fully.
> 

  Both are doing separate things.
  use_dma will be false if any msgs[idx].buf is vmalloc address.
  qup->is_dma will be false if the dma channels are not defined
  in dtsi or in case of some DMA channel allocation failure.


>> +	    (total_tx_len > qup->dma_threshold ||
>> +	     total_rx_len > qup->dma_threshold)) {
>> +		qup->use_dma = true;
>> +	} else {
>> +		qup->blk.is_tx_blk_mode =
>> +			max_tx_len > qup->blk_mode_threshold ? true : false;
>> +		qup->blk.is_rx_blk_mode =
>> +			max_rx_len > qup->blk_mode_threshold ? true : false;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>>  			   struct i2c_msg msgs[],
>>  			   int num)
>>  {
>>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
>>  	int ret, idx = 0;
>> -	unsigned int total_len = 0;
>> 
>>  	qup->bus_err = 0;
>>  	qup->qup_err = 0;
>> @@ -1457,6 +1609,10 @@ static int qup_i2c_xfer_v2(struct i2c_adapter 
>> *adap,
>>  	if (ret < 0)
>>  		goto out;
>> 
>> +	ret = qup_i2c_determine_mode(qup, msgs, num);
>> +	if (ret)
>> +		goto out;
>> +
>>  	writel(1, qup->base + QUP_SW_RESET);
>>  	ret = qup_i2c_poll_state(qup, QUP_RESET_STATE);
>>  	if (ret)
>> @@ -1466,59 +1622,35 @@ static int qup_i2c_xfer_v2(struct i2c_adapter 
>> *adap,
>>  	writel(I2C_MINI_CORE | I2C_N_VAL_V2, qup->base + QUP_CONFIG);
>>  	writel(QUP_V2_TAGS_EN, qup->base + QUP_I2C_MASTER_GEN);
>> 
>> -	if ((qup->is_dma)) {
>> -		/* All i2c_msgs should be transferred using either dma or cpu */
>> +	if (qup_i2c_poll_state_i2c_master(qup)) {
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	if (qup->use_dma) {
>> +		reinit_completion(&qup->xfer);
>> +		ret = qup_i2c_bam_xfer(adap, &msgs[0], num);
>> +		qup->use_dma = false;
>> +	} else {
>> +		qup_i2c_conf_mode_v2(qup);
>> +
>>  		for (idx = 0; idx < num; idx++) {
>> -			if (msgs[idx].len == 0) {
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> +			qup->msg = &msgs[idx];
>> +			qup->is_last = idx == (num - 1);
>> 
>> -			if (is_vmalloc_addr(msgs[idx].buf))
>> +			ret = qup_i2c_xfer_v2_msg(qup, idx,
>> +					!!(msgs[idx].flags & I2C_M_RD));
> 
>   why !!() is required here ?
> 

  I made it to change for boolean.
  Same thing, we are doing in other places inside i2c base driver.

  Regards,
  Abhishek
