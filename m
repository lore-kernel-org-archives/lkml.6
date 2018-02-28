Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933620AbeB1RFa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:05:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17455 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752858AbeB1RFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:05:16 -0500
From: Hugues FRUCHET <hugues.fruchet@st.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>
Subject: Re: [PATCH v2] media: stm32-dcmi: fix lock scheme
Thread-Topic: [PATCH v2] media: stm32-dcmi: fix lock scheme
Thread-Index: AQHTrwmpSM4vnNQMJ0Knggk4gi8od6O5/aaA
Date: Wed, 28 Feb 2018 17:04:52 +0000
Message-ID: <61dbbdac-08ea-4f9b-ba01-f2e243c88df2@st.com>
References: <1519292954-19733-1-git-send-email-hugues.fruchet@st.com>
 <8cc69501-40a4-c6ba-e526-9abd2d938acb@xs4all.nl>
In-Reply-To: <8cc69501-40a4-c6ba-e526-9abd2d938acb@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9727E60C26D92D47A528B35F1DE45F6D@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SH5dJd025971

Hi Hans,

Problem was that lock was held while calling dmaengine APIs, which 
causes double lock issue when dma callback was called under context of 
dma_async_issue_pending() (see dcmi_start_dma() & below comments).
Rest of changes are around spin_lock() changed to spin_lock_irq() for 
safer lock management.

On 02/26/2018 02:56 PM, Hans Verkuil wrote:
> On 02/22/2018 10:49 AM, Hugues Fruchet wrote:
>> Fix lock scheme leading to spurious freeze.
> 
> Can you elaborate a bit more? It's hard to review since you don't
> describe what was wrong and why this fixes the problem.
> 
> Regards,
> 
> 	Hans
> 
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>> ---
>> version 2:
>>    - dcmi_buf_queue() refactor to avoid to have "else" after "return"
>>      (warning detected by checkpatch.pl --strict -f stm32-dcmi.c)
>>
>>   drivers/media/platform/stm32/stm32-dcmi.c | 57 +++++++++++++------------------
>>   1 file changed, 24 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
>> index 2fd8bed..5de18ad 100644
>> --- a/drivers/media/platform/stm32/stm32-dcmi.c
>> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
>> @@ -197,7 +197,7 @@ static void dcmi_dma_callback(void *param)
>>   	struct dma_tx_state state;
>>   	enum dma_status status;
>>   
>> -	spin_lock(&dcmi->irqlock);
>> +	spin_lock_irq(&dcmi->irqlock);
>>   
>>   	/* Check DMA status */
>>   	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
>> @@ -239,7 +239,7 @@ static void dcmi_dma_callback(void *param)
>>   				dcmi->errors_count++;
>>   				dcmi->active = NULL;
>>   
>> -				spin_unlock(&dcmi->irqlock);
>> +				spin_unlock_irq(&dcmi->irqlock);
>>   				return;
>>   			}
>>   
>> @@ -248,13 +248,11 @@ static void dcmi_dma_callback(void *param)
>>   
>>   			list_del_init(&dcmi->active->list);
>>   
>> -			if (dcmi_start_capture(dcmi)) {
>> +			spin_unlock_irq(&dcmi->irqlock);

Lock is released here before calling dcmi_start_capture() which calls 
dma_async_issue_pending()

>> +			if (dcmi_start_capture(dcmi))
>>   				dev_err(dcmi->dev, "%s: Cannot restart capture on DMA complete\n",
>>   					__func__);
>> -
>> -				spin_unlock(&dcmi->irqlock);
>> -				return;
>> -			}
>> +			return;
>>   		}
>>   
>>   		break;
>> @@ -263,7 +261,7 @@ static void dcmi_dma_callback(void *param)
>>   		break;
>>   	}
>>   
>> -	spin_unlock(&dcmi->irqlock);
>> +	spin_unlock_irq(&dcmi->irqlock);
>>   }
>>   
>>   static int dcmi_start_dma(struct stm32_dcmi *dcmi,
>> @@ -360,7 +358,7 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>>   {
>>   	struct stm32_dcmi *dcmi = arg;
>>   
>> -	spin_lock(&dcmi->irqlock);
>> +	spin_lock_irq(&dcmi->irqlock);
>>   
>>   	/* Stop capture is required */
>>   	if (dcmi->state == STOPPING) {
>> @@ -370,7 +368,7 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>>   
>>   		complete(&dcmi->complete);
>>   
>> -		spin_unlock(&dcmi->irqlock);
>> +		spin_unlock_irq(&dcmi->irqlock);
>>   		return IRQ_HANDLED;
>>   	}
>>   
>> @@ -383,35 +381,34 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
>>   			 __func__);
>>   
>>   		dcmi->errors_count++;
>> -		dmaengine_terminate_all(dcmi->dma_chan);
>> -
>>   		dev_dbg(dcmi->dev, "Restarting capture after DCMI error\n");
>>   
>> -		if (dcmi_start_capture(dcmi)) {
>> +		spin_unlock_irq(&dcmi->irqlock);
Lock is released here before calling dma APIs (terminate then 
async_issue_pending)

>> +		dmaengine_terminate_all(dcmi->dma_chan);
>> +
>> +		if (dcmi_start_capture(dcmi))
>>   			dev_err(dcmi->dev, "%s: Cannot restart capture on overflow or error\n",
>>   				__func__);
>> -
>> -			spin_unlock(&dcmi->irqlock);
>> -			return IRQ_HANDLED;
>> -		}
>> +		return IRQ_HANDLED;
>>   	}
>>   
>> -	spin_unlock(&dcmi->irqlock);
>> +	spin_unlock_irq(&dcmi->irqlock);
>>   	return IRQ_HANDLED;
>>   }
>>   
>>   static irqreturn_t dcmi_irq_callback(int irq, void *arg)
>>   {
>>   	struct stm32_dcmi *dcmi = arg;
>> +	unsigned long flags;
>>   
>> -	spin_lock(&dcmi->irqlock);
>> +	spin_lock_irqsave(&dcmi->irqlock, flags);
>>   
>>   	dcmi->misr = reg_read(dcmi->regs, DCMI_MIS);
>>   
>>   	/* Clear interrupt */
>>   	reg_set(dcmi->regs, DCMI_ICR, IT_FRAME | IT_OVR | IT_ERR);
>>   
>> -	spin_unlock(&dcmi->irqlock);
>> +	spin_unlock_irqrestore(&dcmi->irqlock, flags);
>>   
>>   	return IRQ_WAKE_THREAD;
>>   }
>> @@ -490,9 +487,8 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
>>   	struct stm32_dcmi *dcmi =  vb2_get_drv_priv(vb->vb2_queue);
>>   	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>>   	struct dcmi_buf *buf = container_of(vbuf, struct dcmi_buf, vb);
>> -	unsigned long flags = 0;
>>   
>> -	spin_lock_irqsave(&dcmi->irqlock, flags);
>> +	spin_lock_irq(&dcmi->irqlock);
>>   
>>   	if ((dcmi->state == RUNNING) && (!dcmi->active)) {
>>   		dcmi->active = buf;
>> @@ -500,19 +496,15 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
>>   		dev_dbg(dcmi->dev, "Starting capture on buffer[%d] queued\n",
>>   			buf->vb.vb2_buf.index);
>>   
>> -		if (dcmi_start_capture(dcmi)) {
>> +		spin_unlock_irq(&dcmi->irqlock);
Lock is released here before calling dma APIs (terminate then 
async_issue_pending)

>> +		if (dcmi_start_capture(dcmi))
>>   			dev_err(dcmi->dev, "%s: Cannot restart capture on overflow or error\n",
>>   				__func__);
>> -
>> -			spin_unlock_irqrestore(&dcmi->irqlock, flags);
>> -			return;
>> -		}
>>   	} else {
>>   		/* Enqueue to video buffers list */
>>   		list_add_tail(&buf->list, &dcmi->buffers);
>> +		spin_unlock_irq(&dcmi->irqlock);
>>   	}
>> -
>> -	spin_unlock_irqrestore(&dcmi->irqlock, flags);
>>   }
>>   
>>   static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>> @@ -598,20 +590,17 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>>   
>>   	dev_dbg(dcmi->dev, "Start streaming, starting capture\n");
>>   
>> +	spin_unlock_irq(&dcmi->irqlock);
>>   	ret = dcmi_start_capture(dcmi);
>>   	if (ret) {
>>   		dev_err(dcmi->dev, "%s: Start streaming failed, cannot start capture\n",
>>   			__func__);
>> -
>> -		spin_unlock_irq(&dcmi->irqlock);
>>   		goto err_subdev_streamoff;
>>   	}
>>   
>>   	/* Enable interruptions */
>>   	reg_set(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
>>   
>> -	spin_unlock_irq(&dcmi->irqlock);
>> -
>>   	return 0;
>>   
>>   err_subdev_streamoff:
>> @@ -654,7 +643,9 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
>>   		dev_err(dcmi->dev, "%s: Failed to stop streaming, subdev streamoff error (%d)\n",
>>   			__func__, ret);
>>   
>> +	spin_lock_irq(&dcmi->irqlock);
>>   	dcmi->state = STOPPING;
>> +	spin_unlock_irq(&dcmi->irqlock);
>>   
>>   	timeout = wait_for_completion_interruptible_timeout(&dcmi->complete,
>>   							    time_ms);
>>
> 

Best regards,
Hugues.
