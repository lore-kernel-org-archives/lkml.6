Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeBTEcN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 23:32:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeBTEcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 23:32:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B264602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 11/12] i2c: qup: reorganization of driver code to remove
 polling for qup v1
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-12-git-send-email-absahu@codeaurora.org>
 <04839e54-02bd-b7a6-8a94-26f72c3de7b3@codeaurora.org>
 <420a228111f0a71b9d5c3245c42d9148@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <e0009777-f185-e580-a1a2-13f283eb77ee@codeaurora.org>
Date: Tue, 20 Feb 2018 10:02:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <420a228111f0a71b9d5c3245c42d9148@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/19/2018 6:51 PM, Abhishek Sahu wrote:
> On 2018-02-16 13:14, Sricharan R wrote:
>> Hi Abhishek,
>>
>> On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
>>> Following are the major issues in current driver code
>>>
>>> 1. The current driver simply assumes the transfer completion
>>>    whenever its gets any non-error interrupts and then simply do the
>>>    polling of available/free bytes in FIFO.
>>> 2. The block mode is not working properly since no handling in
>>>    being done for OUT_BLOCK_WRITE_REQ and IN_BLOCK_READ_REQ.
>>>
>>> Because of above, i2c v1 transfers of size greater than 32 are failing
>>> with following error message
>>>
>>>     i2c_qup 78b6000.i2c: timeout for fifo out full
>>>
>>> To make block mode working properly and move to use the interrupts
>>> instead of polling, major code reorganization is required. Following
>>> are the major changes done in this patch
>>>
>>> 1. Remove the polling of TX FIFO free space and RX FIFO available
>>>    bytes and move to interrupts completely. QUP has QUP_MX_OUTPUT_DONE,
>>>    QUP_MX_INPUT_DONE, OUT_BLOCK_WRITE_REQ and IN_BLOCK_READ_REQ
>>>    interrupts to handle FIFO’s properly so check all these interrupts.
>>> 2. During write, For FIFO mode, TX FIFO can be directly written
>>>    without checking for FIFO space. For block mode, the QUP will generate
>>>    OUT_BLOCK_WRITE_REQ interrupt whenever it has block size of available
>>>    space.
>>> 3. During read, both TX and RX FIFO will be used. TX will be used
>>>    for writing tags and RX will be used for receiving the data. In QUP,
>>>    TX and RX can operate in separate mode so configure modes accordingly.
>>> 4. For read FIFO mode, wait for QUP_MX_INPUT_DONE interrupt which
>>>    will be generated after all the bytes have been copied in RX FIFO. For
>>>    read Block mode, QUP will generate IN_BLOCK_READ_REQ interrupts
>>>    whenever it has block size of available data.
>>>
>>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>>> ---
>>>  drivers/i2c/busses/i2c-qup.c | 399 ++++++++++++++++++++++++++++---------------
>>>  1 file changed, 257 insertions(+), 142 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>>> index edea3b9..af6c21a 100644
>>> --- a/drivers/i2c/busses/i2c-qup.c
>>> +++ b/drivers/i2c/busses/i2c-qup.c
>>> @@ -73,8 +73,11 @@
>>>  #define QUP_IN_SVC_FLAG        BIT(9)
>>>  #define QUP_MX_OUTPUT_DONE    BIT(10)
>>>  #define QUP_MX_INPUT_DONE    BIT(11)
>>> +#define OUT_BLOCK_WRITE_REQ    BIT(12)
>>> +#define IN_BLOCK_READ_REQ    BIT(13)
>>>
>>>  /* I2C mini core related values */
>>> +#define QUP_NO_INPUT        BIT(7)
>>>  #define QUP_CLOCK_AUTO_GATE    BIT(13)
>>>  #define I2C_MINI_CORE        (2 << 8)
>>>  #define I2C_N_VAL        15
>>> @@ -138,13 +141,51 @@
>>>  #define DEFAULT_CLK_FREQ 100000
>>>  #define DEFAULT_SRC_CLK 20000000
>>>
>>> +/* MAX_OUTPUT_DONE_FLAG has been received */
>>> +#define QUP_BLK_EVENT_TX_IRQ_DONE        BIT(0)
>>> +/* MAX_INPUT_DONE_FLAG has been received */
>>> +#define QUP_BLK_EVENT_RX_IRQ_DONE        BIT(1)
>>> +/* All the TX bytes have been written in TX FIFO */
>>> +#define QUP_BLK_EVENT_TX_DATA_DONE        BIT(2)
>>> +/* All the RX bytes have been read from RX FIFO */
>>> +#define QUP_BLK_EVENT_RX_DATA_DONE        BIT(3)
>>> +
>>> +/* All the required events to mark a QUP I2C TX transfer completed */
>>> +#define QUP_BLK_EVENT_TX_DONE        (QUP_BLK_EVENT_TX_IRQ_DONE | \
>>> +                     QUP_BLK_EVENT_TX_DATA_DONE)
>>> +/* All the required events to mark a QUP I2C RX transfer completed */
>>> +#define QUP_BLK_EVENT_RX_DONE        (QUP_BLK_EVENT_TX_DONE | \
>>> +                     QUP_BLK_EVENT_RX_IRQ_DONE | \
>>> +                     QUP_BLK_EVENT_RX_DATA_DONE)
>>> +
>>> +/*
>>> + * count: no of blocks
>>> + * pos: current block number
>>> + * tx_tag_len: tx tag length for current block
>>> + * rx_tag_len: rx tag length for current block
>>> + * data_len: remaining data length for current message
>>> + * total_tx_len: total tx length including tag bytes for current QUP transfer
>>> + * total_rx_len: total rx length including tag bytes for current QUP transfer
>>> + * tx_fifo_free: number of free bytes in current QUP block write.
>>> + * fifo_available: number of available bytes in RX FIFO for current
>>> + *           QUP block read
>>> + * is_tx_blk_mode: whether tx uses block or FIFO mode in case of non BAM xfer.
>>> + * is_rx_blk_mode: whether rx uses block or FIFO mode in case of non BAM xfer.
>>> + * tags: contains tx tag bytes for current QUP transfer
>>> + */
>>>  struct qup_i2c_block {
>>> -    int    count;
>>> -    int    pos;
>>> -    int    tx_tag_len;
>>> -    int    rx_tag_len;
>>> -    int    data_len;
>>> -    u8    tags[6];
>>> +    int        count;
>>> +    int        pos;
>>> +    int        tx_tag_len;
>>> +    int        rx_tag_len;
>>> +    int        data_len;
>>> +    int        total_tx_len;
>>> +    int        total_rx_len;
>>> +    int        tx_fifo_free;
>>> +    int        fifo_available;
>>> +    bool        is_tx_blk_mode;
>>> +    bool        is_rx_blk_mode;
>>> +    u8        tags[6];
>>>  };
>>>
>>>  struct qup_i2c_tag {
>>> @@ -187,6 +228,7 @@ struct qup_i2c_dev {
>>>
>>>      /* To check if this is the last msg */
>>>      bool            is_last;
>>> +    bool            is_qup_v1;
>>>
>>>      /* To configure when bus is in run state */
>>>      int            config_run;
>>> @@ -195,6 +237,10 @@ struct qup_i2c_dev {
>>>      bool            is_dma;
>>>      /* To check if the current transfer is using DMA */
>>>      bool            use_dma;
>>> +    /* Required events to mark QUP transfer as completed */
>>> +    u32            blk_events;
>>> +    /* Already completed events in QUP transfer */
>>> +    u32            cur_blk_events;
>>>      /* The threshold length above which DMA will be used */
>>>      unsigned int        dma_threshold;
>>>      unsigned int        max_xfer_sg_len;
>>> @@ -205,11 +251,18 @@ struct qup_i2c_dev {
>>>      struct            qup_i2c_bam btx;
>>>
>>>      struct completion    xfer;
>>> +    /* function to write data in tx fifo */
>>> +    void (*write_tx_fifo)(struct qup_i2c_dev *qup);
>>> +    /* function to read data from rx fifo */
>>> +    void (*read_rx_fifo)(struct qup_i2c_dev *qup);
>>> +    /* function to write tags in tx fifo for i2c read transfer */
>>> +    void (*write_rx_tags)(struct qup_i2c_dev *qup);
>>>  };
>>>
>>>  static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
>>>  {
>>>      struct qup_i2c_dev *qup = dev;
>>> +    struct qup_i2c_block *blk = &qup->blk;
>>>      u32 bus_err;
>>>      u32 qup_err;
>>>      u32 opflags;
>>> @@ -256,12 +309,54 @@ static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
>>>          goto done;
>>>      }
>>>
>>> -    if (opflags & QUP_IN_SVC_FLAG)
>>> -        writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
>>> +    if (!qup->is_qup_v1)
>>> +        goto done;
>>>
>>> -    if (opflags & QUP_OUT_SVC_FLAG)
>>> +    if (opflags & QUP_OUT_SVC_FLAG) {
>>>          writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
>>>
>>> +        /*
>>> +         * Ideally, would like to check QUP_MAX_OUTPUT_DONE_FLAG.
>>> +         * However, QUP_MAX_OUTPUT_DONE_FLAG is lagging behind
>>> +         * QUP_OUTPUT_SERVICE_FLAG. The only reason for
>>> +         * QUP_OUTPUT_SERVICE_FLAG to be set in FIFO mode is
>>> +         * QUP_MAX_OUTPUT_DONE_FLAG condition. The code checking
>>> +         * here QUP_OUTPUT_SERVICE_FLAG and assumes that
>>> +         * QUP_MAX_OUTPUT_DONE_FLAG.
>>> +         */
>>> +        if (!blk->is_tx_blk_mode)
>>> +            qup->cur_blk_events |= QUP_BLK_EVENT_TX_IRQ_DONE;
>>> +
>>> +        if (opflags & OUT_BLOCK_WRITE_REQ) {
>>> +            blk->tx_fifo_free += qup->out_blk_sz;
>>> +            if (qup->msg->flags & I2C_M_RD)
>>> +                qup->write_rx_tags(qup);
>>> +            else
>>> +                qup->write_tx_fifo(qup);
>>> +        }
>>> +    }
>>> +
>>> +    if (opflags & QUP_IN_SVC_FLAG) {
>>> +        writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
>>> +
>>> +        if (!blk->is_rx_blk_mode) {
>>> +            blk->fifo_available += qup->in_fifo_sz;
>>> +            qup->read_rx_fifo(qup);
>>> +        } else if (opflags & IN_BLOCK_READ_REQ) {
>>> +            blk->fifo_available += qup->in_blk_sz;
>>> +            qup->read_rx_fifo(qup);
>>> +        }
>>> +    }
>>> +
>>> +    if (opflags & QUP_MX_OUTPUT_DONE)
>>> +        qup->cur_blk_events |= QUP_BLK_EVENT_TX_IRQ_DONE;
>>> +
>>> +    if (opflags & QUP_MX_INPUT_DONE)
>>> +        qup->cur_blk_events |= QUP_BLK_EVENT_RX_IRQ_DONE;
>>> +
>>> +    if (qup->cur_blk_events != qup->blk_events)
>>> +        return IRQ_HANDLED;
>>
>>   Is it correct that if we do a complete in above case, i mean
>>   for TX -> based on QUP_MX_OUTPUT_DONE and for RX -> based on
>>   QUP_MX_INPUT_DONE, would that simplify things by getting rid of
>>   QUP_BLK_EVENT_RX/TX_DONE and QUP_BLK_EVENT_RX/TX_IRQ_DONE
>>   altogether ?
> 
>  We can get rid of QUP_BLK_EVENT_TX_DONE.
>  For RX, the QUP_MX_INPUT_DONE will be triggered when QUP copies all
>  the data in FIFO from external i2c slave. So if 64 bytes read has been
>  scheduled then  following is the behaviour
> 
>  IRQ with QUP_MX_INPUT_DONE and IN_BLOCK_READ_REQ -> read 16 bytes
>  IRQ with IN_BLOCK_READ_REQ -> read next 16 bytes
>  IRQ with IN_BLOCK_READ_REQ  -> read next 16 bytes
>  IRQ with IN_BLOCK_READ_REQ -> read last 16 bytes
> 
>  So for RX, we can't trigger complete by checking QUP_BLK_EVENT_RX_DONE alone.
>  We need to track the number of bytes read from FIFO. Instead of putting
>  this check, I am taking one extra event bit QUP_BLK_EVENT_RX_DONE which
>  will be set when all the bytes has been read.
> 
>  I am not sure if checking QUP_MX_INPUT_DONE will always work since
>  there may be some case, when for small transfers the QUP_MX_INPUT_DONE
>  will come before QUP_MX_OUTPUT_DONE so checking for both will work
>  always.

Looking in to the code and the above case,
  RX -> complete when the required len bytes are read from FIFO in to the msg buffer.
  TX -> complete just when QUP_MX_OUTPUT_DONE is set.

Tf this helps of getting rid of 3 of the above 4 flags tracking and all your stress/testing
continues to work then fine.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
