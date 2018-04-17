Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDQI6S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:58:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33004 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeDQI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:58:16 -0400
X-Google-Smtp-Source: AIpwx49/kt1Z2kOl0WeAtc9LBqWgG/PIgLPBdqYntU0Qk7xSdY1HefyRO17LRDkKcGdlOatGM4wtTg==
Subject: Re: [PATCH v2 3/5] ALSA: xen-front: Implement Xen event channel
 handling
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-4-andr2000@gmail.com>
 <f9d307ea-9464-252e-2a5a-11ac0b3163f4@suse.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <2e06f714-ebc2-11bb-078b-8a453ea8464c@gmail.com>
Date: Tue, 17 Apr 2018 11:58:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f9d307ea-9464-252e-2a5a-11ac0b3163f4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 04:12 PM, Juergen Gross wrote:
> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Handle Xen event channels:
>>    - create for all configured streams and publish
>>      corresponding ring references and event channels in Xen store,
>>      so backend can connect
>>    - implement event channels interrupt handlers
>>    - create and destroy event channels with respect to Xen bus state
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   sound/xen/Makefile                |   3 +-
>>   sound/xen/xen_snd_front.c         |  10 +-
>>   sound/xen/xen_snd_front.h         |   7 +
>>   sound/xen/xen_snd_front_evtchnl.c | 474 ++++++++++++++++++++++++++++++++++++++
>>   sound/xen/xen_snd_front_evtchnl.h |  92 ++++++++
>>   5 files changed, 584 insertions(+), 2 deletions(-)
>>   create mode 100644 sound/xen/xen_snd_front_evtchnl.c
>>   create mode 100644 sound/xen/xen_snd_front_evtchnl.h
>>
>> diff --git a/sound/xen/Makefile b/sound/xen/Makefile
>> index 06705bef61fa..03c669984000 100644
>> --- a/sound/xen/Makefile
>> +++ b/sound/xen/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0 OR MIT
>>   
>>   snd_xen_front-objs := xen_snd_front.o \
>> -		      xen_snd_front_cfg.o
>> +		      xen_snd_front_cfg.o \
>> +		      xen_snd_front_evtchnl.o
>>   
>>   obj-$(CONFIG_SND_XEN_FRONTEND) += snd_xen_front.o
>> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
>> index 65d2494a9d14..eb46bf4070f9 100644
>> --- a/sound/xen/xen_snd_front.c
>> +++ b/sound/xen/xen_snd_front.c
>> @@ -18,9 +18,11 @@
>>   #include <xen/interface/io/sndif.h>
>>   
>>   #include "xen_snd_front.h"
>> +#include "xen_snd_front_evtchnl.h"
> Does it really make sense to have multiple driver-private headers?
>
> I think those can be merged.
I would really like to keep it separate as it clearly
shows which stuff belongs to which modules.
At least for me it is easier to maintain it this way.
>
>>   
>>   static void xen_snd_drv_fini(struct xen_snd_front_info *front_info)
>>   {
>> +	xen_snd_front_evtchnl_free_all(front_info);
>>   }
>>   
>>   static int sndback_initwait(struct xen_snd_front_info *front_info)
>> @@ -32,7 +34,12 @@ static int sndback_initwait(struct xen_snd_front_info *front_info)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	return 0;
>> +	/* create event channels for all streams and publish */
>> +	ret = xen_snd_front_evtchnl_create_all(front_info, num_streams);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return xen_snd_front_evtchnl_publish_all(front_info);
>>   }
>>   
>>   static int sndback_connect(struct xen_snd_front_info *front_info)
>> @@ -122,6 +129,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>>   		return -ENOMEM;
>>   
>>   	front_info->xb_dev = xb_dev;
>> +	spin_lock_init(&front_info->io_lock);
>>   	dev_set_drvdata(&xb_dev->dev, front_info);
>>   
>>   	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
>> diff --git a/sound/xen/xen_snd_front.h b/sound/xen/xen_snd_front.h
>> index b52226cb30bc..9c2ffbb4e4b8 100644
>> --- a/sound/xen/xen_snd_front.h
>> +++ b/sound/xen/xen_snd_front.h
>> @@ -13,9 +13,16 @@
>>   
>>   #include "xen_snd_front_cfg.h"
>>   
>> +struct xen_snd_front_evtchnl_pair;
>> +
>>   struct xen_snd_front_info {
>>   	struct xenbus_device *xb_dev;
>>   
>> +	/* serializer for backend IO: request/response */
>> +	spinlock_t io_lock;
>> +	int num_evt_pairs;
>> +	struct xen_snd_front_evtchnl_pair *evt_pairs;
>> +
>>   	struct xen_front_cfg_card cfg;
>>   };
>>   
>> diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
>> new file mode 100644
>> index 000000000000..9ece39f938f8
>> --- /dev/null
>> +++ b/sound/xen/xen_snd_front_evtchnl.c
>> @@ -0,0 +1,474 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +
>> +/*
>> + * Xen para-virtual sound device
>> + *
>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>> + *
>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> + */
>> +
>> +#include <xen/events.h>
>> +#include <xen/grant_table.h>
>> +#include <xen/xen.h>
>> +#include <xen/xenbus.h>
>> +
>> +#include "xen_snd_front.h"
>> +#include "xen_snd_front_cfg.h"
>> +#include "xen_snd_front_evtchnl.h"
>> +
>> +static irqreturn_t evtchnl_interrupt_req(int irq, void *dev_id)
>> +{
>> +	struct xen_snd_front_evtchnl *channel = dev_id;
>> +	struct xen_snd_front_info *front_info = channel->front_info;
>> +	struct xensnd_resp *resp;
>> +	RING_IDX i, rp;
>> +	unsigned long flags;
>> +
>> +	if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>> +		return IRQ_HANDLED;
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +
>> +again:
>> +	rp = channel->u.req.ring.sring->rsp_prod;
>> +	/* ensure we see queued responses up to rp */
>> +	rmb();
>> +
>> +	for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
>> +		resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
>> +		if (resp->id != channel->evt_id)
>> +			continue;
>> +		switch (resp->operation) {
>> +		case XENSND_OP_OPEN:
>> +			/* fall through */
>> +		case XENSND_OP_CLOSE:
>> +			/* fall through */
>> +		case XENSND_OP_READ:
>> +			/* fall through */
>> +		case XENSND_OP_WRITE:
>> +			/* fall through */
>> +		case XENSND_OP_TRIGGER:
>> +			channel->u.req.resp_status = resp->status;
>> +			complete(&channel->u.req.completion);
>> +			break;
>> +		case XENSND_OP_HW_PARAM_QUERY:
>> +			channel->u.req.resp_status = resp->status;
>> +			channel->u.req.resp.hw_param =
>> +					resp->resp.hw_param;
>> +			complete(&channel->u.req.completion);
>> +			break;
>> +
>> +		default:
>> +			dev_err(&front_info->xb_dev->dev,
>> +				"Operation %d is not supported\n",
>> +				resp->operation);
>> +			break;
>> +		}
>> +	}
>> +
>> +	channel->u.req.ring.rsp_cons = i;
>> +	if (i != channel->u.req.ring.req_prod_pvt) {
>> +		int more_to_do;
>> +
>> +		RING_FINAL_CHECK_FOR_RESPONSES(&channel->u.req.ring,
>> +					       more_to_do);
>> +		if (more_to_do)
>> +			goto again;
>> +	} else {
>> +		channel->u.req.ring.sring->rsp_event = i + 1;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t evtchnl_interrupt_evt(int irq, void *dev_id)
>> +{
>> +	struct xen_snd_front_evtchnl *channel = dev_id;
>> +	struct xen_snd_front_info *front_info = channel->front_info;
>> +	struct xensnd_event_page *page = channel->u.evt.page;
>> +	u32 cons, prod;
>> +	unsigned long flags;
>> +
>> +	if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>> +		return IRQ_HANDLED;
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +
>> +	prod = page->in_prod;
>> +	/* ensure we see ring contents up to prod */
>> +	virt_rmb();
>> +	if (prod == page->in_cons)
>> +		goto out;
>> +
>> +	for (cons = page->in_cons; cons != prod; cons++) {
>> +		struct xensnd_evt *event;
>> +
>> +		event = &XENSND_IN_RING_REF(page, cons);
>> +		if (unlikely(event->id != channel->evt_id++))
>> +			continue;
>> +
>> +		switch (event->type) {
>> +		case XENSND_EVT_CUR_POS:
>> +			/* do nothing at the moment */
>> +			break;
>> +		}
>> +	}
>> +
>> +	page->in_cons = cons;
>> +	/* ensure ring contents */
>> +	virt_wmb();
>> +
>> +out:
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +void xen_snd_front_evtchnl_flush(struct xen_snd_front_evtchnl *channel)
>> +{
>> +	int notify;
>> +
>> +	channel->u.req.ring.req_prod_pvt++;
>> +	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&channel->u.req.ring, notify);
>> +	if (notify)
>> +		notify_remote_via_irq(channel->irq);
>> +}
>> +
>> +static void evtchnl_free(struct xen_snd_front_info *front_info,
>> +			 struct xen_snd_front_evtchnl *channel)
>> +{
>> +	unsigned long page = 0;
>> +
>> +	if (channel->type == EVTCHNL_TYPE_REQ)
>> +		page = (unsigned long)channel->u.req.ring.sring;
>> +	else if (channel->type == EVTCHNL_TYPE_EVT)
>> +		page = (unsigned long)channel->u.evt.page;
>> +
>> +	if (!page)
>> +		return;
>> +
>> +	channel->state = EVTCHNL_STATE_DISCONNECTED;
>> +	if (channel->type == EVTCHNL_TYPE_REQ) {
>> +		/* release all who still waits for response if any */
>> +		channel->u.req.resp_status = -EIO;
>> +		complete_all(&channel->u.req.completion);
>> +	}
>> +
>> +	if (channel->irq)
>> +		unbind_from_irqhandler(channel->irq, channel);
>> +
>> +	if (channel->port)
>> +		xenbus_free_evtchn(front_info->xb_dev, channel->port);
>> +
>> +	/* end access and free the page */
>> +	if (channel->gref != GRANT_INVALID_REF)
>> +		gnttab_end_foreign_access(channel->gref, 0, page);
> Free page?
According to [1] if page is provided to gnttab_end_foreign_access
it will be freed. So, no need to free it manually
>> +
>> +	memset(channel, 0, sizeof(*channel));
>> +}
>> +
>> +void xen_snd_front_evtchnl_free_all(struct xen_snd_front_info *front_info)
>> +{
>> +	int i;
>> +
>> +	if (!front_info->evt_pairs)
>> +		return;
>> +
>> +	for (i = 0; i < front_info->num_evt_pairs; i++) {
>> +		evtchnl_free(front_info, &front_info->evt_pairs[i].req);
>> +		evtchnl_free(front_info, &front_info->evt_pairs[i].evt);
>> +	}
>> +
>> +	kfree(front_info->evt_pairs);
>> +	front_info->evt_pairs = NULL;
>> +}
>> +
>> +static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
>> +			 struct xen_snd_front_evtchnl *channel,
>> +			 enum xen_snd_front_evtchnl_type type)
>> +{
>> +	struct xenbus_device *xb_dev = front_info->xb_dev;
>> +	unsigned long page;
>> +	grant_ref_t gref;
>> +	irq_handler_t handler;
>> +	char *handler_name = NULL;
>> +	int ret;
>> +
>> +	memset(channel, 0, sizeof(*channel));
>> +	channel->type = type;
>> +	channel->index = index;
>> +	channel->front_info = front_info;
>> +	channel->state = EVTCHNL_STATE_DISCONNECTED;
>> +	channel->gref = GRANT_INVALID_REF;
>> +	page = get_zeroed_page(GFP_NOIO | __GFP_HIGH);
> Why GFP_NOIO | __GFP_HIGH? Could it be you copied that from blkfront
> driver?
It can be net-front, I guess, which has the same for rx/tx rings
>   I believe swapping via sound card is rather uncommon.
Indeed, will use GFP_KERNEL here
>> +	if (!page) {
>> +		ret = -ENOMEM;
>> +		goto fail;
>> +	}
>> +
>> +	handler_name = kasprintf(GFP_KERNEL, "%s-%s", XENSND_DRIVER_NAME,
>> +				 type == EVTCHNL_TYPE_REQ ?
>> +				 XENSND_FIELD_RING_REF :
>> +				 XENSND_FIELD_EVT_RING_REF);
>> +	if (!handler_name) {
>> +		ret = -ENOMEM;
> Missing free_page(page)? Maybe you rather add it in the common
> fail path instead of the numerous instances below?
>
yes, will move it under the common fail: label
> Juergen
[1] 
https://elixir.bootlin.com/linux/v4.17-rc1/source/include/xen/grant_table.h#L96
