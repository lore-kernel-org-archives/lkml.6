Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDQMcf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:32:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41947 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbeDQMcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:32:33 -0400
Subject: Re: [PATCH v2 5/5] ALSA: xen-front: Implement ALSA virtual sound
 driver
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-6-andr2000@gmail.com>
 <f8ec79c7-1b6f-dd00-5bd3-fc9fb8b42de1@suse.com>
 <e77fe463-68aa-b117-84c5-6dc729a3df42@gmail.com>
 <06ce3d52-5a38-dd1e-90b7-7b9414b6819d@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d29712f2-80de-203a-8246-243adcdab734@suse.com>
Date: Tue, 17 Apr 2018 14:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <06ce3d52-5a38-dd1e-90b7-7b9414b6819d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 14:26, Oleksandr Andrushchenko wrote:
> On 04/17/2018 02:32 PM, Oleksandr Andrushchenko wrote:
>> On 04/16/2018 05:09 PM, Juergen Gross wrote:
>>> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> Implement essential initialization of the sound driver:
>>>>    - introduce required data structures
>>>>    - handle driver registration
>>>>    - handle sound card registration
>>>>    - register sound driver on backend connection
>>>>    - remove sound driver on backend disconnect
>>>>
>>>> Initialize virtual sound card with streams according to the
>>>> Xen store configuration.
>>>>
>>>> Implement ALSA driver operations including:
>>>> - manage frontend/backend shared buffers
>>>> - manage Xen bus event channel states
>>>>
>>>> Implement requests from front to back for ALSA
>>>> PCM operations.
>>>>   - report ALSA period elapsed event: handle XENSND_EVT_CUR_POS
>>>>     notifications from the backend when stream position advances
>>>>     during playback/capture. The event carries a value of how
>>>>     many octets were played/captured at the time of the event.
>>>>   - implement explicit stream parameter negotiation between
>>>>     backend and frontend: handle XENSND_OP_HW_PARAM_QUERY request
>>>>     to read/update configuration space for the parameter given:
>>>>     request passes desired parameter interval and the response to
>>>>     this request returns min/max interval for the parameter to be used.
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko
>>>> <oleksandr_andrushchenko@epam.com>
>>>> ---
>>>>   sound/xen/Makefile                |   3 +-
>>>>   sound/xen/xen_snd_front.c         | 193 ++++++++-
>>>>   sound/xen/xen_snd_front.h         |  28 ++
>>>>   sound/xen/xen_snd_front_alsa.c    | 830
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>   sound/xen/xen_snd_front_alsa.h    |  23 ++
>>>>   sound/xen/xen_snd_front_evtchnl.c |   6 +-
>>>>   6 files changed, 1080 insertions(+), 3 deletions(-)
>>>>   create mode 100644 sound/xen/xen_snd_front_alsa.c
>>>>   create mode 100644 sound/xen/xen_snd_front_alsa.h
>>>>
>>>> diff --git a/sound/xen/Makefile b/sound/xen/Makefile
>>>> index f028bc30af5d..1e6470ecc2f2 100644
>>>> --- a/sound/xen/Makefile
>>>> +++ b/sound/xen/Makefile
>>>> @@ -3,6 +3,7 @@
>>>>   snd_xen_front-objs := xen_snd_front.o \
>>>>                 xen_snd_front_cfg.o \
>>>>                 xen_snd_front_evtchnl.o \
>>>> -              xen_snd_front_shbuf.o
>>>> +              xen_snd_front_shbuf.o \
>>>> +              xen_snd_front_alsa.o
>>>>     obj-$(CONFIG_SND_XEN_FRONTEND) += snd_xen_front.o
>>>> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
>>>> index 0569c6c596a3..1fef253ea21a 100644
>>>> --- a/sound/xen/xen_snd_front.c
>>>> +++ b/sound/xen/xen_snd_front.c
>>>> @@ -19,10 +19,201 @@
>>>>   #include <xen/interface/io/sndif.h>
>>>>     #include "xen_snd_front.h"
>>>> +#include "xen_snd_front_alsa.h"
>>>>   #include "xen_snd_front_evtchnl.h"
>>>> +#include "xen_snd_front_shbuf.h"
>>>> +
>>>> +static struct xensnd_req *
>>>> +be_stream_prepare_req(struct xen_snd_front_evtchnl *evtchnl, u8
>>>> operation)
>>>> +{
>>>> +    struct xensnd_req *req;
>>>> +
>>>> +    req = RING_GET_REQUEST(&evtchnl->u.req.ring,
>>>> +                   evtchnl->u.req.ring.req_prod_pvt);
>>>> +    req->operation = operation;
>>>> +    req->id = evtchnl->evt_next_id++;
>>>> +    evtchnl->evt_id = req->id;
>>>> +    return req;
>>>> +}
>>>> +
>>>> +static int be_stream_do_io(struct xen_snd_front_evtchnl *evtchnl)
>>>> +{
>>>> +    if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>>>> +        return -EIO;
>>>> +
>>>> +    reinit_completion(&evtchnl->u.req.completion);
>>>> +    xen_snd_front_evtchnl_flush(evtchnl);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int be_stream_wait_io(struct xen_snd_front_evtchnl *evtchnl)
>>>> +{
>>>> +    if (wait_for_completion_timeout(&evtchnl->u.req.completion,
>>>> +            msecs_to_jiffies(VSND_WAIT_BACK_MS)) <= 0)
>>>> +        return -ETIMEDOUT;
>>>> +
>>>> +    return evtchnl->u.req.resp_status;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_query_hw_param(struct
>>>> xen_snd_front_evtchnl *evtchnl,
>>>> +                    struct xensnd_query_hw_param *hw_param_req,
>>>> +                    struct xensnd_query_hw_param *hw_param_resp)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_HW_PARAM_QUERY);
>>>> +    req->op.hw_param = *hw_param_req;
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    if (ret == 0)
>>>> +        *hw_param_resp = evtchnl->u.req.resp.hw_param;
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_prepare(struct xen_snd_front_evtchnl
>>>> *evtchnl,
>>>> +                 struct xen_snd_front_shbuf *sh_buf,
>>>> +                 u8 format, unsigned int channels,
>>>> +                 unsigned int rate, u32 buffer_sz,
>>>> +                 u32 period_sz)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_OPEN);
>>>> +    req->op.open.pcm_format = format;
>>>> +    req->op.open.pcm_channels = channels;
>>>> +    req->op.open.pcm_rate = rate;
>>>> +    req->op.open.buffer_sz = buffer_sz;
>>>> +    req->op.open.period_sz = period_sz;
>>>> +    req->op.open.gref_directory =
>>>> xen_snd_front_shbuf_get_dir_start(sh_buf);
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_close(struct xen_snd_front_evtchnl *evtchnl)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_CLOSE);
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_write(struct xen_snd_front_evtchnl *evtchnl,
>>>> +                   unsigned long pos, unsigned long count)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_WRITE);
>>>> +    req->op.rw.length = count;
>>>> +    req->op.rw.offset = pos;
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_read(struct xen_snd_front_evtchnl *evtchnl,
>>>> +                  unsigned long pos, unsigned long count)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_READ);
>>>> +    req->op.rw.length = count;
>>>> +    req->op.rw.offset = pos;
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int xen_snd_front_stream_trigger(struct xen_snd_front_evtchnl
>>>> *evtchnl,
>>>> +                 int type)
>>>> +{
>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>> +    struct xensnd_req *req;
>>>> +    unsigned long flags;
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_TRIGGER);
>>>> +    req->op.trigger.type = type;
>>>> +
>>>> +    ret = be_stream_do_io(evtchnl);
>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +    if (ret == 0)
>>>> +        ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>> +    return ret;
>>>> +}
>>>>     static void xen_snd_drv_fini(struct xen_snd_front_info *front_info)
>>>>   {
>>>> +    xen_snd_front_alsa_fini(front_info);
>>>>       xen_snd_front_evtchnl_free_all(front_info);
>>>>   }
>>>>   @@ -45,7 +236,7 @@ static int sndback_initwait(struct
>>>> xen_snd_front_info *front_info)
>>>>     static int sndback_connect(struct xen_snd_front_info *front_info)
>>>>   {
>>>> -    return 0;
>>>> +    return xen_snd_front_alsa_init(front_info);
>>>>   }
>>>>     static void sndback_disconnect(struct xen_snd_front_info
>>>> *front_info)
>>>> diff --git a/sound/xen/xen_snd_front.h b/sound/xen/xen_snd_front.h
>>>> index 9c2ffbb4e4b8..7adbdb4d2019 100644
>>>> --- a/sound/xen/xen_snd_front.h
>>>> +++ b/sound/xen/xen_snd_front.h
>>>> @@ -13,17 +13,45 @@
>>>>     #include "xen_snd_front_cfg.h"
>>>>   +struct card_info;
>>>> +struct xen_snd_front_evtchnl;
>>>>   struct xen_snd_front_evtchnl_pair;
>>>> +struct xen_snd_front_shbuf;
>>>> +struct xensnd_query_hw_param;
>>>>     struct xen_snd_front_info {
>>>>       struct xenbus_device *xb_dev;
>>>>   +    struct card_info *card_info;
>>>> +
>>>>       /* serializer for backend IO: request/response */
>>>>       spinlock_t io_lock;
>>>> +
>>>>       int num_evt_pairs;
>>>>       struct xen_snd_front_evtchnl_pair *evt_pairs;
>>>>         struct xen_front_cfg_card cfg;
>>>>   };
>>>>   +int xen_snd_front_stream_query_hw_param(struct
>>>> xen_snd_front_evtchnl *evtchnl,
>>>> +                    struct xensnd_query_hw_param *hw_param_req,
>>>> +                    struct xensnd_query_hw_param *hw_param_resp);
>>>> +
>>>> +int xen_snd_front_stream_prepare(struct xen_snd_front_evtchnl
>>>> *evtchnl,
>>>> +                 struct xen_snd_front_shbuf *sh_buf,
>>>> +                 u8 format, unsigned int channels,
>>>> +                 unsigned int rate, u32 buffer_sz,
>>>> +                 u32 period_sz);
>>>> +
>>>> +int xen_snd_front_stream_close(struct xen_snd_front_evtchnl *evtchnl);
>>>> +
>>>> +int xen_snd_front_stream_write(struct xen_snd_front_evtchnl *evtchnl,
>>>> +                   unsigned long pos, unsigned long count);
>>>> +
>>>> +int xen_snd_front_stream_read(struct xen_snd_front_evtchnl *evtchnl,
>>>> +                  unsigned long pos, unsigned long count);
>>>> +
>>>> +int xen_snd_front_stream_trigger(struct xen_snd_front_evtchnl
>>>> *evtchnl,
>>>> +                 int type);
>>>> +
>>>>   #endif /* __XEN_SND_FRONT_H */
>>>> diff --git a/sound/xen/xen_snd_front_alsa.c
>>>> b/sound/xen/xen_snd_front_alsa.c
>>>> new file mode 100644
>>>> index 000000000000..f524b172750e
>>>> --- /dev/null
>>>> +++ b/sound/xen/xen_snd_front_alsa.c
>>>> @@ -0,0 +1,830 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>> +
>>>> +/*
>>>> + * Xen para-virtual sound device
>>>> + *
>>>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>>>> + *
>>>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>> + */
>>>> +
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#include <sound/core.h>
>>>> +#include <sound/pcm.h>
>>>> +#include <sound/pcm_params.h>
>>>> +
>>>> +#include <xen/xenbus.h>
>>>> +
>>>> +#include "xen_snd_front.h"
>>>> +#include "xen_snd_front_alsa.h"
>>>> +#include "xen_snd_front_cfg.h"
>>>> +#include "xen_snd_front_evtchnl.h"
>>>> +#include "xen_snd_front_shbuf.h"
>>>> +
>>>> +struct pcm_stream_info {
>>> Not sure how this is generally handled in the sound drivers, but when
>>> reviewing the code using those structures I repeatedly tried to find
>>> their definitions in the sound headers instead of here. Same applies to
>>> the alsa_* names.
>>>
>>> I'd prefer names which don't poison the name space.
>> I'll try to do something about naming
> One question still remains wrt alsa_* names: if this is for structures
> I have (alsa_sndif_sample_format/alsa_sndif_hw_param), then
> those already have sndif in their name which clearly says these are
> Xen related ones (sndif is a Xen protocol).
> If you also don't like the alsa_* function names then those are all
> static and defined in this same file, so see no confusion here.
> 
> I have changed other non-obvious struct names:
> 
> -struct pcm_stream_info {
> +struct xen_snd_front_pcm_stream_info {
> 
> -struct pcm_instance_info {
> +struct xen_snd_front_pcm_instance_info {
> 
> -struct card_info {
> +struct xen_snd_front_card_info {
> 
> Does the above work for you?

Yes, this seems to be okay.

Thanks,

Juergen
