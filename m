Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeEVGr7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:47:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43845 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEVGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:47:57 -0400
Date: Tue, 22 May 2018 08:47:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v2 05/14] mtd: rawnand: qcom: wait for desc completion
 in all BAM channels
Message-ID: <20180522084754.0c3a53a4@xps13>
In-Reply-To: <1525350041-22995-6-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-6-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu,  3 May 2018 17:50:32 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> The BAM has 3 channels - tx, rx and command. command channel
> is used for register read/writes, tx channel for data writes
> and rx channel for data reads. Currently, the driver assumes the
> transfer completion once it gets all the command descriptor
> completed. Sometimes, there is race condition in data channel

"Sometimes, there is a race condition between the data channel (rx/tx)
and the command channel completion. In these cases, ..."

> (tx/rx) and command channel completion and in these cases,
> the data in buffer is not valid during the small window between

           ^ present in the buffer ?

> command descriptor completion and data descriptor completion.
> 
> Now, the changes have been made to assign the callback for

It is preferable to use a descriptive tense when you expose what the
patch does. Something like "Change <this> to assign ..."

> channel's final descriptor. The DMA will generate the callback
> when all the descriptors have completed in that channel.
> The NAND transfer will be completed only when all required
> DMA channels have generated the completion callback.
> 

It looks like this is a fix that is a good candidate for stable trees,
you might want to add the relevant tags.

> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v1:
> 
>   NONE
> 
>   1. Removed the custom logic and used the helper fuction.
>  drivers/mtd/nand/raw/qcom_nandc.c | 55 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index a8d71ce..3d1ff54 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -213,6 +213,8 @@
>  #define QPIC_PER_CW_CMD_SGL		32
>  #define QPIC_PER_CW_DATA_SGL		8
>  
> +#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)

That's huge, but why not, it's a timeout anyway.

> +
>  /*
>   * Flags used in DMA descriptor preparation helper functions
>   * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
> @@ -245,6 +247,11 @@
>   * @tx_sgl_start - start index in data sgl for tx.
>   * @rx_sgl_pos - current index in data sgl for rx.
>   * @rx_sgl_start - start index in data sgl for rx.
> + * @first_chan_done - if current transfer already has got first channel
> + *		      DMA desc completion.
> + * @txn_done - completion for nand transfer.

s/nand/NAND/

> + * @last_data_desc - last DMA desc in data channel (tx/rx).
> + * @last_cmd_desc - last DMA desc in command channel.
>   */
>  struct bam_transaction {
>  	struct bam_cmd_element *bam_ce;
> @@ -258,6 +265,10 @@ struct bam_transaction {
>  	u32 tx_sgl_start;
>  	u32 rx_sgl_pos;
>  	u32 rx_sgl_start;
> +	bool first_chan_done;
> +	struct completion txn_done;
> +	struct dma_async_tx_descriptor *last_data_desc;
> +	struct dma_async_tx_descriptor *last_cmd_desc;
>  };
>  
>  /*
> @@ -504,6 +515,8 @@ static void free_bam_transaction(struct qcom_nand_controller *nandc)
>  
>  	bam_txn->data_sgl = bam_txn_buf;
>  
> +	init_completion(&bam_txn->txn_done);
> +
>  	return bam_txn;
>  }
>  
> @@ -523,11 +536,36 @@ static void clear_bam_transaction(struct qcom_nand_controller *nandc)
>  	bam_txn->tx_sgl_start = 0;
>  	bam_txn->rx_sgl_pos = 0;
>  	bam_txn->rx_sgl_start = 0;
> +	bam_txn->last_data_desc = NULL;
> +	bam_txn->first_chan_done = false;

Are you sure you don't want to reinit last_cmd_desc here?

>  
>  	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
>  		      QPIC_PER_CW_CMD_SGL);
>  	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
>  		      QPIC_PER_CW_DATA_SGL);
> +
> +	reinit_completion(&bam_txn->txn_done);
> +}
> +
> +/* Callback for DMA descriptor completion */
> +static void qpic_bam_dma_done(void *data)
> +{
> +	struct bam_transaction *bam_txn = data;
> +
> +	/*
> +	 * In case of data transfer with NAND, 2 callbacks will be generated.
> +	 * One for command channel and another one for data channel.
> +	 * If current transaction has data descriptors then check if its
> +	 * already got one DMA channel completion callback. In this case
> +	 * make the NAND transfer complete otherwise mark first_chan_done true
> +	 * and wait for next channel DMA completion callback.
> +	 */
> +	if (bam_txn->last_data_desc && !bam_txn->first_chan_done) {
> +		bam_txn->first_chan_done = true;
> +		return;
> +	}

There is a lot of new variables just to wait for two bam_dma_done().
Why not just creating a boolean like "wait_second completion",
initialize it in prepare_bam_async_desc to true when needed and
complete txn_done when it's false, that's all:

        if (bam_txn->wait_second_completion) {
                bam_txn->wait_second_completion = false;
                return;
        }

> +
> +	complete(&bam_txn->txn_done);
>  }
>  
>  static inline struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
> @@ -756,6 +794,12 @@ static int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
>  
>  	desc->dma_desc = dma_desc;
>  
> +	/* update last data/command descriptor */
> +	if (chan == nandc->cmd_chan)
> +		bam_txn->last_cmd_desc = dma_desc;
> +	else
> +		bam_txn->last_data_desc = dma_desc;
> +

Is there a reason for the "last_" prefix? why not current_*_desc or
just *_desc? (this is a real question :) ). Correct me if I'm wrong but
you have a scatter-gather list of DMA transfers that are mapped to form
one DMA descriptor, so there is no "last" descriptor, right?

Otherwise, as I told you above, why not just a:

        if (chan == nandc->data_chan)
                bam_txn->wait_second_completion = true;

>  	list_add_tail(&desc->node, &nandc->desc_list);
>  
>  	return 0;
> @@ -1273,10 +1317,19 @@ static int submit_descs(struct qcom_nand_controller *nandc)
>  		cookie = dmaengine_submit(desc->dma_desc);
>  
>  	if (nandc->props->is_bam) {
> +		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
> +		bam_txn->last_cmd_desc->callback_param = bam_txn;
> +		if (bam_txn->last_data_desc) {
> +			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
> +			bam_txn->last_data_desc->callback_param = bam_txn;
> +		}

Why don't you do this directly in prepare_bam_async_desc?

With:

        dma_desc->callback = ...
        dma_desc->callback_param = ...

> +
>  		dma_async_issue_pending(nandc->tx_chan);
>  		dma_async_issue_pending(nandc->rx_chan);
> +		dma_async_issue_pending(nandc->cmd_chan);
>  
> -		if (dma_sync_wait(nandc->cmd_chan, cookie) != DMA_COMPLETE)
> +		if (!wait_for_completion_timeout(&bam_txn->txn_done,
> +						 QPIC_NAND_COMPLETION_TIMEOUT))
>  			return -ETIMEDOUT;
>  	} else {
>  		if (dma_sync_wait(nandc->chan, cookie) != DMA_COMPLETE)



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
