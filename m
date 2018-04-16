Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbeDPNjU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:39:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755015AbeDPNjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:39:19 -0400
Subject: Re: [PATCH v2 4/5] ALSA: xen-front: Implement handling of shared
 buffers
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-5-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <6ab76dd7-ec6b-0756-5490-f5b5805998d6@suse.com>
Date: Mon, 16 Apr 2018 15:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416062453.24743-5-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Implement shared buffer handling according to the
> para-virtualized sound device protocol at xen/interface/io/sndif.h:
>   - manage buffer memory
>   - handle granted references
>   - handle page directories
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  sound/xen/Makefile              |   3 +-
>  sound/xen/xen_snd_front.c       |   8 ++
>  sound/xen/xen_snd_front_shbuf.c | 193 ++++++++++++++++++++++++++++++++++++++++
>  sound/xen/xen_snd_front_shbuf.h |  36 ++++++++
>  4 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 sound/xen/xen_snd_front_shbuf.c
>  create mode 100644 sound/xen/xen_snd_front_shbuf.h
> 
> diff --git a/sound/xen/Makefile b/sound/xen/Makefile
> index 03c669984000..f028bc30af5d 100644
> --- a/sound/xen/Makefile
> +++ b/sound/xen/Makefile
> @@ -2,6 +2,7 @@
>  
>  snd_xen_front-objs := xen_snd_front.o \
>  		      xen_snd_front_cfg.o \
> -		      xen_snd_front_evtchnl.o
> +		      xen_snd_front_evtchnl.o \
> +		      xen_snd_front_shbuf.o
>  
>  obj-$(CONFIG_SND_XEN_FRONTEND) += snd_xen_front.o
> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
> index eb46bf4070f9..0569c6c596a3 100644
> --- a/sound/xen/xen_snd_front.c
> +++ b/sound/xen/xen_snd_front.c
> @@ -11,6 +11,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  
> +#include <xen/page.h>
>  #include <xen/platform_pci.h>
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -186,6 +187,13 @@ static struct xenbus_driver xen_driver = {
>  
>  static int __init xen_drv_init(void)
>  {
> +	/* At the moment we only support case with XEN_PAGE_SIZE == PAGE_SIZE */
> +	if (XEN_PAGE_SIZE != PAGE_SIZE) {
> +		pr_err(XENSND_DRIVER_NAME ": different kernel and Xen page sizes are not supported: XEN_PAGE_SIZE (%lu) != PAGE_SIZE (%lu)\n",
> +		       XEN_PAGE_SIZE, PAGE_SIZE);
> +		return -ENODEV;
> +	}

Do you really want to print that error message on bare metal?

> +
>  	if (!xen_domain())
>  		return -ENODEV;
>  
> diff --git a/sound/xen/xen_snd_front_shbuf.c b/sound/xen/xen_snd_front_shbuf.c
> new file mode 100644
> index 000000000000..6845dbc7fdf5
> --- /dev/null
> +++ b/sound/xen/xen_snd_front_shbuf.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +/*
> + * Xen para-virtual sound device
> + *
> + * Copyright (C) 2016-2018 EPAM Systems Inc.
> + *
> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> + */
> +
> +#include <xen/xen.h>
> +#include <xen/xenbus.h>
> +
> +#include "xen_snd_front_shbuf.h"
> +
> +grant_ref_t xen_snd_front_shbuf_get_dir_start(struct xen_snd_front_shbuf *buf)
> +{
> +	if (!buf->grefs)
> +		return GRANT_INVALID_REF;
> +
> +	return buf->grefs[0];
> +}
> +
> +void xen_snd_front_shbuf_clear(struct xen_snd_front_shbuf *buf)
> +{
> +	memset(buf, 0, sizeof(*buf));
> +}
> +
> +void xen_snd_front_shbuf_free(struct xen_snd_front_shbuf *buf)
> +{
> +	int i;
> +
> +	if (buf->grefs) {
> +		for (i = 0; i < buf->num_grefs; i++)
> +			if (buf->grefs[i] != GRANT_INVALID_REF)
> +				gnttab_end_foreign_access(buf->grefs[i],
> +							  0, 0UL);
> +		kfree(buf->grefs);
> +	}
> +	kfree(buf->directory);
> +	free_pages_exact(buf->buffer, buf->buffer_sz);
> +	xen_snd_front_shbuf_clear(buf);
> +}
> +
> +/*
> + * number of grant references a page can hold with respect to the
> + * xensnd_page_directory header
> + */
> +#define XENSND_NUM_GREFS_PER_PAGE ((XEN_PAGE_SIZE - \
> +		offsetof(struct xensnd_page_directory, gref)) / \
> +		sizeof(grant_ref_t))
> +
> +static void fill_page_dir(struct xen_snd_front_shbuf *buf,
> +			  int num_pages_dir)
> +{
> +	struct xensnd_page_directory *page_dir;
> +	unsigned char *ptr;
> +	int i, cur_gref, grefs_left, to_copy;
> +
> +	ptr = buf->directory;
> +	grefs_left = buf->num_grefs - num_pages_dir;
> +	/*
> +	 * skip grant references at the beginning, they are for pages granted
> +	 * for the page directory itself
> +	 */
> +	cur_gref = num_pages_dir;
> +	for (i = 0; i < num_pages_dir; i++) {
> +		page_dir = (struct xensnd_page_directory *)ptr;
> +		if (grefs_left <= XENSND_NUM_GREFS_PER_PAGE) {
> +			to_copy = grefs_left;
> +			page_dir->gref_dir_next_page = GRANT_INVALID_REF;
> +		} else {
> +			to_copy = XENSND_NUM_GREFS_PER_PAGE;
> +			page_dir->gref_dir_next_page = buf->grefs[i + 1];
> +		}
> +
> +		memcpy(&page_dir->gref, &buf->grefs[cur_gref],
> +		       to_copy * sizeof(grant_ref_t));
> +
> +		ptr += XEN_PAGE_SIZE;
> +		grefs_left -= to_copy;
> +		cur_gref += to_copy;
> +	}
> +}
> +
> +static int grant_references(struct xenbus_device *xb_dev,
> +			    struct xen_snd_front_shbuf *buf,
> +			    int num_pages_dir, int num_pages_buffer,
> +			    int num_grefs)
> +{
> +	grant_ref_t priv_gref_head;
> +	unsigned long frame;
> +	int ret, i, j, cur_ref;
> +	int otherend_id;
> +
> +	ret = gnttab_alloc_grant_references(num_grefs, &priv_gref_head);
> +	if (ret)
> +		return ret;
> +
> +	buf->num_grefs = num_grefs;
> +	otherend_id = xb_dev->otherend_id;
> +	j = 0;
> +
> +	for (i = 0; i < num_pages_dir; i++) {
> +		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
> +		if (cur_ref < 0) {
> +			ret = cur_ref;
> +			goto fail;
> +		}
> +
> +		frame = xen_page_to_gfn(virt_to_page(buf->directory +
> +						     XEN_PAGE_SIZE * i));
> +		gnttab_grant_foreign_access_ref(cur_ref, otherend_id, frame, 0);
> +		buf->grefs[j++] = cur_ref;
> +	}
> +
> +	for (i = 0; i < num_pages_buffer; i++) {
> +		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
> +		if (cur_ref < 0) {
> +			ret = cur_ref;
> +			goto fail;
> +		}
> +
> +		frame = xen_page_to_gfn(virt_to_page(buf->buffer +
> +						     XEN_PAGE_SIZE * i));
> +		gnttab_grant_foreign_access_ref(cur_ref, otherend_id, frame, 0);
> +		buf->grefs[j++] = cur_ref;
> +	}
> +
> +	gnttab_free_grant_references(priv_gref_head);
> +	fill_page_dir(buf, num_pages_dir);
> +	return 0;
> +
> +fail:
> +	gnttab_free_grant_references(priv_gref_head);
> +	return ret;
> +}
> +
> +static int alloc_int_buffers(struct xen_snd_front_shbuf *buf,
> +			     int num_pages_dir, int num_pages_buffer,
> +			     int num_grefs)
> +{
> +	buf->grefs = kcalloc(num_grefs, sizeof(*buf->grefs), GFP_KERNEL);
> +	if (!buf->grefs)
> +		return -ENOMEM;
> +
> +	buf->directory = kcalloc(num_pages_dir, XEN_PAGE_SIZE, GFP_KERNEL);
> +	if (!buf->directory)
> +		goto fail;
> +
> +	buf->buffer_sz = num_pages_buffer * XEN_PAGE_SIZE;
> +	buf->buffer = alloc_pages_exact(buf->buffer_sz, GFP_KERNEL);
> +	if (!buf->buffer)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	kfree(buf->grefs);
> +	buf->grefs = NULL;
> +	kfree(buf->directory);

Why do you need to free those here? Shouldn't that be done via
xen_snd_front_shbuf_free() in case of an error?


Juergen
