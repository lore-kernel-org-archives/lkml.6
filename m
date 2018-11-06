Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C09C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADDD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bvUUzKWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADDD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeKGAdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:33:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51292 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbeKGAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:33:39 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 934CC526;
        Tue,  6 Nov 2018 16:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541516878;
        bh=wQWHBaBe2nYSdooMQtt6S/U+77DBdULhib+Vzkv4Tp4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bvUUzKWQm22chClIpKbld37tQKmwOvgVtEPzkzc/BvjCfKwZOMH5h/mHInH63HA4m
         sUQ+pczCzp2XsH6bs5UtywtMURZ66RQLOoQQOvhloAsx3307+e9uUm45cZZmi0FJPr
         3pVOlZxDm0nZgdVZXVKwyB17nzzpOsD5yQngDq9o=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFT PATCH v3 5/6] uvcvideo: queue: Support asynchronous buffer
 handling
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Olivier BRAUN <olivier.braun@stereolabs.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
References: <cover.30aaad9a6abac5e92d4a1a0e6634909d97cc54d8.1515748369.git-series.kieran.bingham@ideasonboard.com>
 <f72afd5e873791800bc9d5aba52c2a1952b6b770.1515748369.git-series.kieran.bingham@ideasonboard.com>
 <2758747.xKSIVS8Vp6@avalon> <3798015.Xi7JQnpzAg@avalon>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <6ce043bf-63c8-87d1-d12c-21d6e322732a@ideasonboard.com>
Date:   Tue, 6 Nov 2018 15:07:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3798015.Xi7JQnpzAg@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 30/07/2018 21:39, Laurent Pinchart wrote:
> Hi Kieran
> 
> I think your v4 doesn't take the review comments below into account.

I'm sorry for missing them.
Lets not miss it for v5 :)


> 
> On Wednesday, 17 January 2018 01:45:33 EEST Laurent Pinchart wrote:
>> On Friday, 12 January 2018 11:19:26 EET Kieran Bingham wrote:
>>> The buffer queue interface currently operates sequentially, processing
>>> buffers after they have fully completed.
>>>
>>> In preparation for supporting parallel tasks operating on the buffers,
>>> we will need to support buffers being processed on multiple CPUs.
>>>
>>> Adapt the uvc_queue_next_buffer() such that a reference count tracks the
>>> active use of the buffer, returning the buffer to the VB2 stack at
>>> completion.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>> ---
>>>
>>>  drivers/media/usb/uvc/uvc_queue.c | 61 ++++++++++++++++++++++++++------
>>>  drivers/media/usb/uvc/uvcvideo.h  |  4 ++-
>>>  2 files changed, 54 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/media/usb/uvc/uvc_queue.c
>>> b/drivers/media/usb/uvc/uvc_queue.c index ddac4d89a291..5a9987e547d3
>>> 100644
>>> --- a/drivers/media/usb/uvc/uvc_queue.c
>>> +++ b/drivers/media/usb/uvc/uvc_queue.c
>>> @@ -131,6 +131,7 @@ static void uvc_buffer_queue(struct vb2_buffer *vb)
>>>
>>>  	spin_lock_irqsave(&queue->irqlock, flags);
>>>  	if (likely(!(queue->flags & UVC_QUEUE_DISCONNECTED))) {
>>>
>>> +		kref_init(&buf->ref);
>>>
>>>  		list_add_tail(&buf->queue, &queue->irqqueue);
>>>  	
>>>  	} else {
>>>  	
>>>  		/* If the device is disconnected return the buffer to userspace
>>>
>>> @@ -424,28 +425,66 @@ struct uvc_buffer
>>> *uvc_queue_get_current_buffer(struct uvc_video_queue *queue) return
>>> nextbuf;
>>>
>>>  }
>>>
>>> -struct uvc_buffer *uvc_queue_next_buffer(struct uvc_video_queue *queue,
>>> +/*
>>> + * uvc_queue_requeue: Requeue a buffer on our internal irqqueue
>>> + *
>>> + * Reuse a buffer through our internal queue without the need to
>>> 'prepare'
>>> + * The buffer will be returned to userspace through the uvc_buffer_queue
>>> call if
>>> + * the device has been disconnected
> 
> Additionally, periods are messing at the end of sentences.


Fixed.

> 
>>> + */
>>> +static void uvc_queue_requeue(struct uvc_video_queue *queue,
>>>
>>>  		struct uvc_buffer *buf)
>>>  
>>>  {
>>>
>>> -	struct uvc_buffer *nextbuf;
>>> -	unsigned long flags;
>>> +	buf->error = 0;
>>> +	buf->state = UVC_BUF_STATE_QUEUED;
>>> +	buf->bytesused = 0;
>>> +	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, 0);
>>> +
>>> +	uvc_buffer_queue(&buf->buf.vb2_buf);
>>> +}
>>
>> You could have inlined this in uvc_queue_buffer_complete(), but the above
>> documentation is useful, so I'm fine if you prefer keeping it as a separate
>> function. Maybe you could call it uvc_queue_buffer_requeue() to be
>> consistent with the other functions ?
>>

Yes, it could be inlined - but it is as you say below it's somewhat of a
change in functionality. Instead of returning the buffer, it is
re-queued - and I felt that warranted it's own function in a way such
that this was self-documenting.

Thus, I'd like to keep the simple helper function. I'm sure the compiler
will inline it anyway - but I think it makes the code much more readable.

I've renamed it to uvc_queue_buffer_requeue() as requested.

>>> +static void uvc_queue_buffer_complete(struct kref *ref)
>>> +{
>>> +	struct uvc_buffer *buf = container_of(ref, struct uvc_buffer, ref);
>>> +	struct vb2_buffer *vb = &buf->buf.vb2_buf;
>>> +	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
>>>
>>>  	if ((queue->flags & UVC_QUEUE_DROP_CORRUPTED) && buf->error) {
>>>
>>> -		buf->error = 0;
>>> -		buf->state = UVC_BUF_STATE_QUEUED;
>>> -		buf->bytesused = 0;
>>> -		vb2_set_plane_payload(&buf->buf.vb2_buf, 0, 0);
>>> -		return buf;
>>> +		uvc_queue_requeue(queue, buf);
>>> +		return;
>>
>> This changes the behaviour of the driver. Currently when an erroneous buffer
>> is encountered, it will be immediately reused. With this patch applied it
>> will be pushed to the back of the queue for later reuse. This will result
>> in buffers being reordered, possibly causing issues later when we'll
>> implement fences support (or possibly even today).

Correct - but because the buffers can now complete asynchronously -
there is no alternative except to put it back on the queue. (I don't
think ?)

We can't even sort the buffers on the queue as that would just be racy.

I didn't think there was any guarantee on the order that buffers were
returned back to userspace ? So I didn't think this should be a problem?
(After all - isn't that why the buffers have their index values for
mapping them?)


>> I think the whole drop corrupted buffers mechanism was a bad idea in the
>> first place and I'd like to remove it at some point, buffers in the error
>> state should be handled by applications. However, until that's done, I
>> wonder whether it would be possible to keep the current order. I
>> unfortunately don't see an easy option to do so at the moment, but maybe
>> you would. Otherwise I suppose we'll have to leave it as is.

No - I'm afraid I don't see any easy option to maintain order - and keep
the buffers asynchronous.

Perhaps we could do a 'sort' at some stage in the pipeline, but I'm not
convinced this would add value yet.

Perhaps not the best way to approach this - but maybe lets think about
sort ordering if we get any bug reports.


>> I'm tempted to flip the driver to not drop corrupted buffers by default.
>> I've done so on my computer, I'll see if I run into any issue. It could be
>> useful if you could set the nodrop parameter to 1 on your systems too when
>> performing tests.
>>

Or that :) - but that's more of a policy change.

I think you're right though - the userspace applications should be able
to decide if they want to present corrupt buffers or not.

>>>  	}
>>>
>>> +	buf->state = buf->error ? UVC_BUF_STATE_ERROR : UVC_BUF_STATE_DONE;
>>> +	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, buf->bytesused);
>>> +	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
>>> +}
>>> +
>>> +/*
>>> + * Release a reference on the buffer. Complete the buffer when the last
>>> + * reference is released
>>> + */
>>> +void uvc_queue_buffer_release(struct uvc_buffer *buf)
>>> +{
>>> +	kref_put(&buf->ref, uvc_queue_buffer_complete);
>>> +}
>>> +
>>> +/*
>>> + * Remove this buffer from the queue. Lifetime will persist while async
>>> actions
>>> + * are still running (if any), and uvc_queue_buffer_release will give the
>>> buffer
>>> + * back to VB2 when all users have completed.
>>> + */
>>> +struct uvc_buffer *uvc_queue_next_buffer(struct uvc_video_queue *queue,
>>> +		struct uvc_buffer *buf)
>>> +{
>>> +	struct uvc_buffer *nextbuf;
>>> +	unsigned long flags;
>>> +
>>>
>>>  	spin_lock_irqsave(&queue->irqlock, flags);
>>>  	list_del(&buf->queue);
>>>  	nextbuf = __uvc_queue_get_current_buffer(queue);
>>>  	spin_unlock_irqrestore(&queue->irqlock, flags);
>>>
>>> -	buf->state = buf->error ? UVC_BUF_STATE_ERROR : UVC_BUF_STATE_DONE;
>>> -	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, buf->bytesused);
>>> -	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
>>> +	uvc_queue_buffer_release(buf);
>>>
>>>  	return nextbuf;
>>>  
>>>  }
>>>
>>> diff --git a/drivers/media/usb/uvc/uvcvideo.h
>>> b/drivers/media/usb/uvc/uvcvideo.h index 5caa1f4de3cb..6a18dbfc3e5b 100644
>>> --- a/drivers/media/usb/uvc/uvcvideo.h
>>> +++ b/drivers/media/usb/uvc/uvcvideo.h
>>> @@ -404,6 +404,9 @@ struct uvc_buffer {
>>>
>>>  	unsigned int bytesused;
>>>  	
>>>  	u32 pts;
>>>
>>> +
>>> +	/* asynchronous buffer handling */
>>
>> Please capitalize the first word to match other comments in the driver.

Fixed.

>>
>>> +	struct kref ref;
>>>
>>>  };
>>>  
>>>  #define UVC_QUEUE_DISCONNECTED		(1 << 0)
>>>
>>> @@ -696,6 +699,7 @@ extern struct uvc_buffer *
>>>
>>>  		uvc_queue_get_current_buffer(struct uvc_video_queue *queue);
>>>  
>>>  extern struct uvc_buffer *uvc_queue_next_buffer(struct uvc_video_queue
>>>
>>> *queue, struct uvc_buffer *buf);
>>> +extern void uvc_queue_buffer_release(struct uvc_buffer *buf);
>>
>> No need for the extern keyboard. I'll submit a patch to drop it for all
>> functions.
>>

Looks like this was successfully removed already :)


>>>  extern int uvc_queue_mmap(struct uvc_video_queue *queue,
>>>  
>>>  		struct vm_area_struct *vma);
>>>  
>>>  extern unsigned int uvc_queue_poll(struct uvc_video_queue *queue,
> 

-- 
Regards
--
Kieran
