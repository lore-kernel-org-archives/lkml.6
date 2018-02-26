Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBZN5B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:57:01 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:54249 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751530AbeBZN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:56:56 -0500
Subject: Re: [PATCH v2] media: stm32-dcmi: fix lock scheme
To: Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>
References: <1519292954-19733-1-git-send-email-hugues.fruchet@st.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8cc69501-40a4-c6ba-e526-9abd2d938acb@xs4all.nl>
Date: Mon, 26 Feb 2018 14:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519292954-19733-1-git-send-email-hugues.fruchet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCQiSe4CREmmXFPmMpA0Abk2Qr14Mndu34grybZaezwBG6QaLdCNb8463FFHE6soe6QTvueMF05YHvkaj2LjOvoZo6r4zCeBsLyVtZtp6ew3bi+pmzfY
 ndGlkiufLYBDLZMAZ88YjHtzn18BzEKRMehL7Hw/pp+4GU8kcA9vjo22MKHwqZju42kJryhhWk2GDaQ5WhUqPhbsbjFkP/hDAESbuJVPa2pWCqiBWNkqw/an
 v80vty9nQzJVs5k9vtSHPQTHrYn4st9retns5r5x6iu0hnHZmt/7QIygrPPltXsjSxHRKZHYXRDlFwWyNXCYJ0pMQGtgZFc/zsCzvoh2sEH5cHo08511566M
 /ohKwi/pMN+7zVjc5Rs71tZTj8rnud2Vj2s3EwwCLpJtkd7FblTNo9KQ+UUHqg8eUhTyZRrngTP+ygTQYbiHF2CxzhuJog==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 10:49 AM, Hugues Fruchet wrote:
> Fix lock scheme leading to spurious freeze.

Can you elaborate a bit more? It's hard to review since you don't
describe what was wrong and why this fixes the problem.

Regards,

	Hans

> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> ---
> version 2:
>   - dcmi_buf_queue() refactor to avoid to have "else" after "return"
>     (warning detected by checkpatch.pl --strict -f stm32-dcmi.c)
> 
>  drivers/media/platform/stm32/stm32-dcmi.c | 57 +++++++++++++------------------
>  1 file changed, 24 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 2fd8bed..5de18ad 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -197,7 +197,7 @@ static void dcmi_dma_callback(void *param)
>  	struct dma_tx_state state;
>  	enum dma_status status;
>  
> -	spin_lock(&dcmi->irqlock);
> +	spin_lock_irq(&dcmi->irqlock);
>  
>  	/* Check DMA status */
>  	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
> @@ -239,7 +239,7 @@ static void dcmi_dma_callback(void *param)
>  				dcmi->errors_count++;
>  				dcmi->active = NULL;
>  
> -				spin_unlock(&dcmi->irqlock);
> +				spin_unlock_irq(&dcmi->irqlock);
>  				return;
>  			}
>  
> @@ -248,13 +248,11 @@ static void dcmi_dma_callback(void *param)
>  
>  			list_del_init(&dcmi->active->list);
>  
> -			if (dcmi_start_capture(dcmi)) {
> +			spin_unlock_irq(&dcmi->irqlock);
> +			if (dcmi_start_capture(dcmi))
>  				dev_err(dcmi->dev, "%s: Cannot restart capture on DMA complete\n",
>  					__func__);
> -
> -				spin_unlock(&dcmi->irqlock);
> -				return;
> -			}
> +			return;
>  		}
>  
>  		break;
> @@ -263,7 +261,7 @@ static void dcmi_dma_callback(void *param)
>  		break;
>  	}
>  
> -	spin_unlock(&dcmi->irqlock);
> +	spin_unlock_irq(&dcmi->irqlock);
>  }
>  
>  static int dcmi_start_dma(struct stm32_dcmi *dcmi,
> @@ -360,7 +358,7 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>  {
>  	struct stm32_dcmi *dcmi = arg;
>  
> -	spin_lock(&dcmi->irqlock);
> +	spin_lock_irq(&dcmi->irqlock);
>  
>  	/* Stop capture is required */
>  	if (dcmi->state == STOPPING) {
> @@ -370,7 +368,7 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>  
>  		complete(&dcmi->complete);
>  
> -		spin_unlock(&dcmi->irqlock);
> +		spin_unlock_irq(&dcmi->irqlock);
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -383,35 +381,34 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>  			 __func__);
>  
>  		dcmi->errors_count++;
> -		dmaengine_terminate_all(dcmi->dma_chan);
> -
>  		dev_dbg(dcmi->dev, "Restarting capture after DCMI error\n");
>  
> -		if (dcmi_start_capture(dcmi)) {
> +		spin_unlock_irq(&dcmi->irqlock);
> +		dmaengine_terminate_all(dcmi->dma_chan);
> +
> +		if (dcmi_start_capture(dcmi))
>  			dev_err(dcmi->dev, "%s: Cannot restart capture on overflow or error\n",
>  				__func__);
> -
> -			spin_unlock(&dcmi->irqlock);
> -			return IRQ_HANDLED;
> -		}
> +		return IRQ_HANDLED;
>  	}
>  
> -	spin_unlock(&dcmi->irqlock);
> +	spin_unlock_irq(&dcmi->irqlock);
>  	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t dcmi_irq_callback(int irq, void *arg)
>  {
>  	struct stm32_dcmi *dcmi = arg;
> +	unsigned long flags;
>  
> -	spin_lock(&dcmi->irqlock);
> +	spin_lock_irqsave(&dcmi->irqlock, flags);
>  
>  	dcmi->misr = reg_read(dcmi->regs, DCMI_MIS);
>  
>  	/* Clear interrupt */
>  	reg_set(dcmi->regs, DCMI_ICR, IT_FRAME | IT_OVR | IT_ERR);
>  
> -	spin_unlock(&dcmi->irqlock);
> +	spin_unlock_irqrestore(&dcmi->irqlock, flags);
>  
>  	return IRQ_WAKE_THREAD;
>  }
> @@ -490,9 +487,8 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
>  	struct stm32_dcmi *dcmi =  vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  	struct dcmi_buf *buf = container_of(vbuf, struct dcmi_buf, vb);
> -	unsigned long flags = 0;
>  
> -	spin_lock_irqsave(&dcmi->irqlock, flags);
> +	spin_lock_irq(&dcmi->irqlock);
>  
>  	if ((dcmi->state == RUNNING) && (!dcmi->active)) {
>  		dcmi->active = buf;
> @@ -500,19 +496,15 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
>  		dev_dbg(dcmi->dev, "Starting capture on buffer[%d] queued\n",
>  			buf->vb.vb2_buf.index);
>  
> -		if (dcmi_start_capture(dcmi)) {
> +		spin_unlock_irq(&dcmi->irqlock);
> +		if (dcmi_start_capture(dcmi))
>  			dev_err(dcmi->dev, "%s: Cannot restart capture on overflow or error\n",
>  				__func__);
> -
> -			spin_unlock_irqrestore(&dcmi->irqlock, flags);
> -			return;
> -		}
>  	} else {
>  		/* Enqueue to video buffers list */
>  		list_add_tail(&buf->list, &dcmi->buffers);
> +		spin_unlock_irq(&dcmi->irqlock);
>  	}
> -
> -	spin_unlock_irqrestore(&dcmi->irqlock, flags);
>  }
>  
>  static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
> @@ -598,20 +590,17 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>  
>  	dev_dbg(dcmi->dev, "Start streaming, starting capture\n");
>  
> +	spin_unlock_irq(&dcmi->irqlock);
>  	ret = dcmi_start_capture(dcmi);
>  	if (ret) {
>  		dev_err(dcmi->dev, "%s: Start streaming failed, cannot start capture\n",
>  			__func__);
> -
> -		spin_unlock_irq(&dcmi->irqlock);
>  		goto err_subdev_streamoff;
>  	}
>  
>  	/* Enable interruptions */
>  	reg_set(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
>  
> -	spin_unlock_irq(&dcmi->irqlock);
> -
>  	return 0;
>  
>  err_subdev_streamoff:
> @@ -654,7 +643,9 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
>  		dev_err(dcmi->dev, "%s: Failed to stop streaming, subdev streamoff error (%d)\n",
>  			__func__, ret);
>  
> +	spin_lock_irq(&dcmi->irqlock);
>  	dcmi->state = STOPPING;
> +	spin_unlock_irq(&dcmi->irqlock);
>  
>  	timeout = wait_for_completion_interruptible_timeout(&dcmi->complete,
>  							    time_ms);
> 
