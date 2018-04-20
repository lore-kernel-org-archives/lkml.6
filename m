Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755149AbeDTNno (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:43:44 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:60805 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754989AbeDTNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:43:42 -0400
Subject: Re: [PATCH v2 03/10] videobuf2-core: Add helper to get buffer private
 data from media request
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154124.17512-4-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <581bb769-acad-1050-3060-f3f11802be89@xs4all.nl>
Date: Fri, 20 Apr 2018 15:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180419154124.17512-4-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKCZGdJ9p4b+8miej94uX3rmzLD4KZOHHX1u3/Fdzh7XbbHDX1MIl1SYlUXHI+E3/INnAItbX//Qbz2J5rocVyUYNs+bIqyvzxTaxVPHFy5Ta7VrJlgi
 XorpWkJQi3Ht5+M2+mRoFURihRz2F+dOQZGbjUFoGA+fnXtvrER95A/OwJ4urboxix7z+SUNrnoDKgPS9reNHxhrjAPgPjhhhI20GMweS+hDnMzZc2yTkOja
 5BsCay4jRKZlHbryBkBcy7cN4WyvEaC8ID/6N6yoVTxEZULY/V3O1RWHeSASsm6kERdtk4GGYWTL2SnmmsoN212QIX+R+x9SBPcwkD793r++EoaCJOBVTDgD
 fVTs4seKQSuTSgfFHQh621YerCRmwNup3/VSJF04ltwbSIpd/v+pAJPIUcKRVCqdaAUyVosv+umYbWdkei2sVyEURi1sfYFSYcclrn7kmMGUnLMciKvFU13n
 r5PtyVNLgbZ0NlOJn98jJNkS3gM5eHmKj5F8Eu60JjUoAxs37B4+NIbx6JKcSdg74oONx+hxODuPQh4jNcBlS+dX3Q/rU1dykH4v/JDo/w0NpzMeCLdEuQAv
 +HNb2YdxmklWFspnwyDdhyjE7PNYjsdVqKD1QckQemtRmsfzRGHEVdNlFWy5KXInBE5OkDZzCetDrJ80A28g/OUwcFQQESWxva3c9TP2nvXO7WZUmGiJR3kG
 bilI14eV7T/iP0OaKXJiJQMZL89NsgEDewRRMwWlIQj+w1gYPNbZXs6n730M0ya8XpqhmsxHudkAkI7g23rlO5Lvk0vEMo9lBoj8Wnm1EXYdkbmcFrlM+T8W
 KBCCKXt05bNISr5rEIs8xzssYl99hw6Vymow7nJvEaOqIPpiPfrEF6cwivQzQhcq8dZFD8j2BL5oqm8lK6Fn8NfURVP8Q17mgpsZ5/l7ROnl6p57kbu8BSAV
 kTQThum2r0lFYXEDj2L10f4YnnHnv1NWM8eUDZw/IKH0FXdU2oJwq9du89RnVNanWNjG/Gx7lkE/q95r39N8ICOO4tQAjeTxKTBj7PCanGEkV5RY3ge9n3U6
 u3MR/X0c7TZ7kS9B5+gcCfE0EkkfjkmazJLp5Xf2sCnlg77MOdVt3qHf
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/18 17:41, Paul Kocialkowski wrote:
> When calling media operation driver callbacks related to media requests,
> only a pointer to the request itself is provided, which is insufficient
> to retrieve the driver's context. Since the driver context is usually
> set as vb2 queue private data and given that the core can determine
> which objects attached to the request are buffers, it is possible to
> extract the associated private data for the first buffer found.
> 
> This is required in order to access the current m2m context from m2m
> drivers' private data in the context of media request operation
> callbacks. More specifically, this allows scheduling m2m device runs
> from the newly-introduced request complete operation.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 15 +++++++++++++++
>  include/media/videobuf2-core.h                  |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 13c9d9e243dd..6fa46bfc620f 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1351,6 +1351,21 @@ bool vb2_core_request_has_buffers(struct media_request *req)
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_request_has_buffers);
>  
> +void *vb2_core_request_find_buffer_priv(struct media_request *req)
> +{
> +	struct media_request_object *obj;
> +	struct vb2_buffer *vb;
> +
> +	obj = media_request_object_find(req, &vb2_core_req_ops, NULL);

This increases the object refcount but it is never decreased here.

> +	if (!obj)
> +		return NULL;
> +
> +	vb = container_of(obj, struct vb2_buffer, req_obj);
> +
> +	return vb2_get_drv_priv(vb->vb2_queue);

You need to add a media_request_object_put(obj); before returning here.

Regards,

	Hans

> +}
> +EXPORT_SYMBOL_GPL(vb2_core_request_find_buffer_priv);
> +
>  int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb,
>  			 struct media_request *req)
>  {
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 032bd1bec555..65c0cf6afb55 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1153,4 +1153,5 @@ int vb2_verify_memory_type(struct vb2_queue *q,
>  		enum vb2_memory memory, unsigned int type);
>  
>  bool vb2_core_request_has_buffers(struct media_request *req);
> +void *vb2_core_request_find_buffer_priv(struct media_request *req);
>  #endif /* _MEDIA_VIDEOBUF2_CORE_H */
> 
