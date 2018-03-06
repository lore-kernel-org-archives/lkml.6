Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeCFJpc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:45:32 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34497 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeCFJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:45:28 -0500
X-Google-Smtp-Source: AG47ELtJlzWyNl0kSNVHC0aNvCckUayY4k2iMK/QJ8S+zc9e9ZcgvJG7xS9NYeIlqGBHmtgX41g5ZA==
Subject: Re: [PATCH 9/9] drm/xen-front: Implement communication with backend
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-10-git-send-email-andr2000@gmail.com>
 <20180305092515.GJ22212@phenom.ffwll.local>
 <7a6d19be-a740-dae4-551b-17740171aedf@epam.com>
 <20180306092659.GN22212@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a790e577-96ce-34f4-3f07-e1a7bab88e54@gmail.com>
Date: Tue, 6 Mar 2018 11:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306092659.GN22212@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 11:26 AM, Daniel Vetter wrote:
> On Mon, Mar 05, 2018 at 11:30:35AM +0200, Oleksandr Andrushchenko wrote:
>> On 03/05/2018 11:25 AM, Daniel Vetter wrote:
>>> On Wed, Feb 21, 2018 at 10:03:42AM +0200, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>
>>>> Handle communication with the backend:
>>>>    - send requests and wait for the responses according
>>>>      to the displif protocol
>>>>    - serialize access to the communication channel
>>>>    - time-out used for backend communication is set to 3000 ms
>>>>    - manage display buffers shared with the backend
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>> After the demidlayering it probably makes sense to merge this with the
>>> overall kms/basic-drm-driver patch. Up to you really.
>> The reason for such partitioning here and before was that
>> I can have Xen/DRM parts separate, so those are easier for
>> review by Xen/DRM communities. So, I would prefer to have it
>> as it is
> Well for reviewing the kms parts I need to check what the xen parts are
> doing (at least sometimes), since semantics of what you're doing matter,
> and there's a few cases which new drivers tend to get wrong. So for me,
> this splitting makes stuff actually harder to review.
>
> And I guess for the xen folks it won't hurt if they see a bit clearer how
> it's used on the drm side (even if they might not really understand what's
> going on). If we have some superficial abstraction in between each of the
> subsystem maintainers might make assumptions about what the other side of
> the code is doing which turn out to be wrong, and that's not good.
>
> Just explaining my motivation for why I don't like abstractions and
> splitting stuff up into patches that don't make much sense on their own
> (because the code is just hanging out there without being wired up
> anywhere).
Ok, no problem here. Will squash relevant patches then
> -Daniel
>>> -Daniel
>>>> ---
>>>>    drivers/gpu/drm/xen/xen_drm_front.c | 327 +++++++++++++++++++++++++++++++++++-
>>>>    drivers/gpu/drm/xen/xen_drm_front.h |   5 +
>>>>    2 files changed, 327 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>>>> index 8de88e359d5e..5ad546231d30 100644
>>>> --- a/drivers/gpu/drm/xen/xen_drm_front.c
>>>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>>>> @@ -31,12 +31,146 @@
>>>>    #include "xen_drm_front_evtchnl.h"
>>>>    #include "xen_drm_front_shbuf.h"
>>>> +/* timeout in ms to wait for backend to respond */
>>>> +#define VDRM_WAIT_BACK_MS	3000
>>>> +
>>>> +struct xen_drm_front_dbuf {
>>>> +	struct list_head list;
>>>> +	uint64_t dbuf_cookie;
>>>> +	uint64_t fb_cookie;
>>>> +	struct xen_drm_front_shbuf *shbuf;
>>>> +};
>>>> +
>>>> +static int dbuf_add_to_list(struct xen_drm_front_info *front_info,
>>>> +		struct xen_drm_front_shbuf *shbuf, uint64_t dbuf_cookie)
>>>> +{
>>>> +	struct xen_drm_front_dbuf *dbuf;
>>>> +
>>>> +	dbuf = kzalloc(sizeof(*dbuf), GFP_KERNEL);
>>>> +	if (!dbuf)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dbuf->dbuf_cookie = dbuf_cookie;
>>>> +	dbuf->shbuf = shbuf;
>>>> +	list_add(&dbuf->list, &front_info->dbuf_list);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct xen_drm_front_dbuf *dbuf_get(struct list_head *dbuf_list,
>>>> +		uint64_t dbuf_cookie)
>>>> +{
>>>> +	struct xen_drm_front_dbuf *buf, *q;
>>>> +
>>>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>>>> +		if (buf->dbuf_cookie == dbuf_cookie)
>>>> +			return buf;
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static void dbuf_flush_fb(struct list_head *dbuf_list, uint64_t fb_cookie)
>>>> +{
>>>> +	struct xen_drm_front_dbuf *buf, *q;
>>>> +
>>>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>>>> +		if (buf->fb_cookie == fb_cookie)
>>>> +			xen_drm_front_shbuf_flush(buf->shbuf);
>>>> +}
>>>> +
>>>> +static void dbuf_free(struct list_head *dbuf_list, uint64_t dbuf_cookie)
>>>> +{
>>>> +	struct xen_drm_front_dbuf *buf, *q;
>>>> +
>>>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>>>> +		if (buf->dbuf_cookie == dbuf_cookie) {
>>>> +			list_del(&buf->list);
>>>> +			xen_drm_front_shbuf_unmap(buf->shbuf);
>>>> +			xen_drm_front_shbuf_free(buf->shbuf);
>>>> +			kfree(buf);
>>>> +			break;
>>>> +		}
>>>> +}
>>>> +
>>>> +static void dbuf_free_all(struct list_head *dbuf_list)
>>>> +{
>>>> +	struct xen_drm_front_dbuf *buf, *q;
>>>> +
>>>> +	list_for_each_entry_safe(buf, q, dbuf_list, list) {
>>>> +		list_del(&buf->list);
>>>> +		xen_drm_front_shbuf_unmap(buf->shbuf);
>>>> +		xen_drm_front_shbuf_free(buf->shbuf);
>>>> +		kfree(buf);
>>>> +	}
>>>> +}
>>>> +
>>>> +static struct xendispl_req *be_prepare_req(
>>>> +		struct xen_drm_front_evtchnl *evtchnl, uint8_t operation)
>>>> +{
>>>> +	struct xendispl_req *req;
>>>> +
>>>> +	req = RING_GET_REQUEST(&evtchnl->u.req.ring,
>>>> +			evtchnl->u.req.ring.req_prod_pvt);
>>>> +	req->operation = operation;
>>>> +	req->id = evtchnl->evt_next_id++;
>>>> +	evtchnl->evt_id = req->id;
>>>> +	return req;
>>>> +}
>>>> +
>>>> +static int be_stream_do_io(struct xen_drm_front_evtchnl *evtchnl,
>>>> +		struct xendispl_req *req)
>>>> +{
>>>> +	reinit_completion(&evtchnl->u.req.completion);
>>>> +	if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>>>> +		return -EIO;
>>>> +
>>>> +	xen_drm_front_evtchnl_flush(evtchnl);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int be_stream_wait_io(struct xen_drm_front_evtchnl *evtchnl)
>>>> +{
>>>> +	if (wait_for_completion_timeout(&evtchnl->u.req.completion,
>>>> +			msecs_to_jiffies(VDRM_WAIT_BACK_MS)) <= 0)
>>>> +		return -ETIMEDOUT;
>>>> +
>>>> +	return evtchnl->u.req.resp_status;
>>>> +}
>>>> +
>>>>    static int be_mode_set(struct xen_drm_front_drm_pipeline *pipeline, uint32_t x,
>>>>    		uint32_t y, uint32_t width, uint32_t height, uint32_t bpp,
>>>>    		uint64_t fb_cookie)
>>>>    {
>>>> -	return 0;
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xen_drm_front_info *front_info;
>>>> +	struct xendispl_req *req;
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	front_info = pipeline->drm_info->front_info;
>>>> +	evtchnl = &front_info->evt_pairs[pipeline->index].req;
>>>> +	if (unlikely(!evtchnl))
>>>> +		return -EIO;
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_SET_CONFIG);
>>>> +	req->op.set_config.x = x;
>>>> +	req->op.set_config.y = y;
>>>> +	req->op.set_config.width = width;
>>>> +	req->op.set_config.height = height;
>>>> +	req->op.set_config.bpp = bpp;
>>>> +	req->op.set_config.fb_cookie = fb_cookie;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret == 0)
>>>> +		ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	return ret;
>>>>    }
>>>>    static int be_dbuf_create_int(struct xen_drm_front_info *front_info,
>>>> @@ -44,7 +178,69 @@ static int be_dbuf_create_int(struct xen_drm_front_info *front_info,
>>>>    		uint32_t bpp, uint64_t size, struct page **pages,
>>>>    		struct sg_table *sgt)
>>>>    {
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xen_drm_front_shbuf *shbuf;
>>>> +	struct xendispl_req *req;
>>>> +	struct xen_drm_front_shbuf_cfg buf_cfg;
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>>>> +	if (unlikely(!evtchnl))
>>>> +		return -EIO;
>>>> +
>>>> +	memset(&buf_cfg, 0, sizeof(buf_cfg));
>>>> +	buf_cfg.xb_dev = front_info->xb_dev;
>>>> +	buf_cfg.pages = pages;
>>>> +	buf_cfg.size = size;
>>>> +	buf_cfg.sgt = sgt;
>>>> +	buf_cfg.be_alloc = front_info->cfg.be_alloc;
>>>> +
>>>> +	shbuf = xen_drm_front_shbuf_alloc(&buf_cfg);
>>>> +	if (!shbuf)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ret = dbuf_add_to_list(front_info, shbuf, dbuf_cookie);
>>>> +	if (ret < 0) {
>>>> +		xen_drm_front_shbuf_free(shbuf);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_DBUF_CREATE);
>>>> +	req->op.dbuf_create.gref_directory =
>>>> +			xen_drm_front_shbuf_get_dir_start(shbuf);
>>>> +	req->op.dbuf_create.buffer_sz = size;
>>>> +	req->op.dbuf_create.dbuf_cookie = dbuf_cookie;
>>>> +	req->op.dbuf_create.width = width;
>>>> +	req->op.dbuf_create.height = height;
>>>> +	req->op.dbuf_create.bpp = bpp;
>>>> +	if (buf_cfg.be_alloc)
>>>> +		req->op.dbuf_create.flags |= XENDISPL_DBUF_FLG_REQ_ALLOC;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret < 0)
>>>> +		goto fail;
>>>> +
>>>> +	ret = be_stream_wait_io(evtchnl);
>>>> +	if (ret < 0)
>>>> +		goto fail;
>>>> +
>>>> +	ret = xen_drm_front_shbuf_map(shbuf);
>>>> +	if (ret < 0)
>>>> +		goto fail;
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>>    	return 0;
>>>> +
>>>> +fail:
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>>>> +	return ret;
>>>>    }
>>>>    static int be_dbuf_create_from_sgt(struct xen_drm_front_info *front_info,
>>>> @@ -66,26 +262,144 @@ static int be_dbuf_create_from_pages(struct xen_drm_front_info *front_info,
>>>>    static int be_dbuf_destroy(struct xen_drm_front_info *front_info,
>>>>    		uint64_t dbuf_cookie)
>>>>    {
>>>> -	return 0;
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xendispl_req *req;
>>>> +	unsigned long flags;
>>>> +	bool be_alloc;
>>>> +	int ret;
>>>> +
>>>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>>>> +	if (unlikely(!evtchnl))
>>>> +		return -EIO;
>>>> +
>>>> +	be_alloc = front_info->cfg.be_alloc;
>>>> +
>>>> +	/*
>>>> +	 * for the backend allocated buffer release references now, so backend
>>>> +	 * can free the buffer
>>>> +	 */
>>>> +	if (be_alloc)
>>>> +		dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_DBUF_DESTROY);
>>>> +	req->op.dbuf_destroy.dbuf_cookie = dbuf_cookie;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret == 0)
>>>> +		ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +	/*
>>>> +	 * do this regardless of communication status with the backend:
>>>> +	 * if we cannot remove remote resources remove what we can locally
>>>> +	 */
>>>> +	if (!be_alloc)
>>>> +		dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	return ret;
>>>>    }
>>>>    static int be_fb_attach(struct xen_drm_front_info *front_info,
>>>>    		uint64_t dbuf_cookie, uint64_t fb_cookie, uint32_t width,
>>>>    		uint32_t height, uint32_t pixel_format)
>>>>    {
>>>> -	return 0;
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xen_drm_front_dbuf *buf;
>>>> +	struct xendispl_req *req;
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>>>> +	if (unlikely(!evtchnl))
>>>> +		return -EIO;
>>>> +
>>>> +	buf = dbuf_get(&front_info->dbuf_list, dbuf_cookie);
>>>> +	if (!buf)
>>>> +		return -EINVAL;
>>>> +
>>>> +	buf->fb_cookie = fb_cookie;
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_FB_ATTACH);
>>>> +	req->op.fb_attach.dbuf_cookie = dbuf_cookie;
>>>> +	req->op.fb_attach.fb_cookie = fb_cookie;
>>>> +	req->op.fb_attach.width = width;
>>>> +	req->op.fb_attach.height = height;
>>>> +	req->op.fb_attach.pixel_format = pixel_format;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret == 0)
>>>> +		ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	return ret;
>>>>    }
>>>>    static int be_fb_detach(struct xen_drm_front_info *front_info,
>>>>    		uint64_t fb_cookie)
>>>>    {
>>>> -	return 0;
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xendispl_req *req;
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>>>> +	if (unlikely(!evtchnl))
>>>> +		return -EIO;
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_FB_DETACH);
>>>> +	req->op.fb_detach.fb_cookie = fb_cookie;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret == 0)
>>>> +		ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	return ret;
>>>>    }
>>>>    static int be_page_flip(struct xen_drm_front_info *front_info, int conn_idx,
>>>>    		uint64_t fb_cookie)
>>>>    {
>>>> -	return 0;
>>>> +	struct xen_drm_front_evtchnl *evtchnl;
>>>> +	struct xendispl_req *req;
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	if (unlikely(conn_idx >= front_info->num_evt_pairs))
>>>> +		return -EINVAL;
>>>> +
>>>> +	dbuf_flush_fb(&front_info->dbuf_list, fb_cookie);
>>>> +	evtchnl = &front_info->evt_pairs[conn_idx].req;
>>>> +
>>>> +	mutex_lock(&front_info->req_io_lock);
>>>> +
>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_PG_FLIP);
>>>> +	req->op.pg_flip.fb_cookie = fb_cookie;
>>>> +
>>>> +	ret = be_stream_do_io(evtchnl, req);
>>>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> +
>>>> +	if (ret == 0)
>>>> +		ret = be_stream_wait_io(evtchnl);
>>>> +
>>>> +	mutex_unlock(&front_info->req_io_lock);
>>>> +	return ret;
>>>>    }
>>>>    static void xen_drm_drv_unload(struct xen_drm_front_info *front_info)
>>>> @@ -183,6 +497,7 @@ static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
>>>>    {
>>>>    	xen_drm_drv_deinit(front_info);
>>>>    	xen_drm_front_evtchnl_free_all(front_info);
>>>> +	dbuf_free_all(&front_info->dbuf_list);
>>>>    }
>>>>    static int backend_on_initwait(struct xen_drm_front_info *front_info)
>>>> @@ -310,6 +625,8 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>>>>    	front_info->xb_dev = xb_dev;
>>>>    	spin_lock_init(&front_info->io_lock);
>>>> +	mutex_init(&front_info->req_io_lock);
>>>> +	INIT_LIST_HEAD(&front_info->dbuf_list);
>>>>    	front_info->drm_pdrv_registered = false;
>>>>    	dev_set_drvdata(&xb_dev->dev, front_info);
>>>>    	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
>>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
>>>> index c6f52c892434..db32d00145d1 100644
>>>> --- a/drivers/gpu/drm/xen/xen_drm_front.h
>>>> +++ b/drivers/gpu/drm/xen/xen_drm_front.h
>>>> @@ -137,6 +137,8 @@ struct xen_drm_front_info {
>>>>    	struct xenbus_device *xb_dev;
>>>>    	/* to protect data between backend IO code and interrupt handler */
>>>>    	spinlock_t io_lock;
>>>> +	/* serializer for backend IO: request/response */
>>>> +	struct mutex req_io_lock;
>>>>    	bool drm_pdrv_registered;
>>>>    	/* virtual DRM platform device */
>>>>    	struct platform_device *drm_pdev;
>>>> @@ -144,6 +146,9 @@ struct xen_drm_front_info {
>>>>    	int num_evt_pairs;
>>>>    	struct xen_drm_front_evtchnl_pair *evt_pairs;
>>>>    	struct xen_drm_front_cfg cfg;
>>>> +
>>>> +	/* display buffers */
>>>> +	struct list_head dbuf_list;
>>>>    };
>>>>    #endif /* __XEN_DRM_FRONT_H_ */
>>>> -- 
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
