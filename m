Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeBVXuJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:50:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeBVXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:50:08 -0500
Subject: Re: [PATCH 4/9] drm/xen-front: Implement Xen event channel handling
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-5-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <395cdaef-db7e-139c-bbf1-28cb33f41f58@oracle.com>
Date: Thu, 22 Feb 2018 18:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-5-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802220296
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
> +
> +static irqreturn_t evtchnl_interrupt_ctrl(int irq, void *dev_id)
> +{
> +	struct xen_drm_front_evtchnl *evtchnl = dev_id;
> +	struct xen_drm_front_info *front_info = evtchnl->front_info;
> +	struct xendispl_resp *resp;
> +	RING_IDX i, rp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&front_info->io_lock, flags);
> +
> +	if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
> +		goto out;

Do you need to check the state under lock? (in other routines too).

...

> +
> +static void evtchnl_free(struct xen_drm_front_info *front_info,
> +		struct xen_drm_front_evtchnl *evtchnl)
> +{
> +	unsigned long page = 0;
> +
> +	if (evtchnl->type == EVTCHNL_TYPE_REQ)
> +		page = (unsigned long)evtchnl->u.req.ring.sring;
> +	else if (evtchnl->type == EVTCHNL_TYPE_EVT)
> +		page = (unsigned long)evtchnl->u.evt.page;
> +	if (!page)
> +		return;
> +
> +	evtchnl->state = EVTCHNL_STATE_DISCONNECTED;
> +
> +	if (evtchnl->type == EVTCHNL_TYPE_REQ) {
> +		/* release all who still waits for response if any */
> +		evtchnl->u.req.resp_status = -EIO;
> +		complete_all(&evtchnl->u.req.completion);
> +	}
> +
> +	if (evtchnl->irq)
> +		unbind_from_irqhandler(evtchnl->irq, evtchnl);
> +
> +	if (evtchnl->port)
> +		xenbus_free_evtchn(front_info->xb_dev, evtchnl->port);
> +
> +	/* end access and free the page */
> +	if (evtchnl->gref != GRANT_INVALID_REF)
> +		gnttab_end_foreign_access(evtchnl->gref, 0, page);
> +
> +	if (evtchnl->type == EVTCHNL_TYPE_REQ)
> +		evtchnl->u.req.ring.sring = NULL;
> +	else
> +		evtchnl->u.evt.page = NULL;
> +
> +	memset(evtchnl, 0, sizeof(*evtchnl));

Since you are zeroing out the structure you don't need to set fields to
zero.

I also think you need to free the page.

-boris
