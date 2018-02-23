Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeBWHAS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:00:18 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44015 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeBWHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:00:16 -0500
X-Google-Smtp-Source: AG47ELskU+FRKOLG/aV+xIBWzEZSVGykD+apbX/jxTWE/mFXuNgWH08SeUc4mRKnpOqomPnTBLfJVw==
Subject: Re: [PATCH 4/9] drm/xen-front: Implement Xen event channel handling
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-5-git-send-email-andr2000@gmail.com>
 <395cdaef-db7e-139c-bbf1-28cb33f41f58@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5145287f-40b0-c8e2-1b37-36d7e8cac908@gmail.com>
Date: Fri, 23 Feb 2018 09:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <395cdaef-db7e-139c-bbf1-28cb33f41f58@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 01:50 AM, Boris Ostrovsky wrote:
> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>> +
>> +static irqreturn_t evtchnl_interrupt_ctrl(int irq, void *dev_id)
>> +{
>> +	struct xen_drm_front_evtchnl *evtchnl = dev_id;
>> +	struct xen_drm_front_info *front_info = evtchnl->front_info;
>> +	struct xendispl_resp *resp;
>> +	RING_IDX i, rp;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +
>> +	if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>> +		goto out;
> Do you need to check the state under lock? (in other routines too).
not really, will move out of the lock in interrupt handlers
other places (I assume you refer to be_stream_do_io)
it is set under lock as a part of atomic operation, e.g.
we get a new request pointer from the ring and reset completion
So, those places still seem to be ok
> ...
>
>> +
>> +static void evtchnl_free(struct xen_drm_front_info *front_info,
>> +		struct xen_drm_front_evtchnl *evtchnl)
>> +{
>> +	unsigned long page = 0;
>> +
>> +	if (evtchnl->type == EVTCHNL_TYPE_REQ)
>> +		page = (unsigned long)evtchnl->u.req.ring.sring;
>> +	else if (evtchnl->type == EVTCHNL_TYPE_EVT)
>> +		page = (unsigned long)evtchnl->u.evt.page;
>> +	if (!page)
>> +		return;
>> +
>> +	evtchnl->state = EVTCHNL_STATE_DISCONNECTED;
>> +
>> +	if (evtchnl->type == EVTCHNL_TYPE_REQ) {
>> +		/* release all who still waits for response if any */
>> +		evtchnl->u.req.resp_status = -EIO;
>> +		complete_all(&evtchnl->u.req.completion);
>> +	}
>> +
>> +	if (evtchnl->irq)
>> +		unbind_from_irqhandler(evtchnl->irq, evtchnl);
>> +
>> +	if (evtchnl->port)
>> +		xenbus_free_evtchn(front_info->xb_dev, evtchnl->port);
>> +
>> +	/* end access and free the page */
>> +	if (evtchnl->gref != GRANT_INVALID_REF)
>> +		gnttab_end_foreign_access(evtchnl->gref, 0, page);
>> +
>> +	if (evtchnl->type == EVTCHNL_TYPE_REQ)
>> +		evtchnl->u.req.ring.sring = NULL;
>> +	else
>> +		evtchnl->u.evt.page = NULL;
>> +
>> +	memset(evtchnl, 0, sizeof(*evtchnl));
> Since you are zeroing out the structure you don't need to set fields to
> zero.
good catch, thank you
> I also think you need to free the page.
it is freed by gnttab_end_foreign_access, please see [1]
> -boris

[1] 
https://elixir.bootlin.com/linux/v4.11-rc1/source/drivers/xen/grant-table.c#L380
