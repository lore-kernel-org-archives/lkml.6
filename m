Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeDCJrj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:47:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37286 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754579AbeDCJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:47:38 -0400
X-Google-Smtp-Source: AIpwx4/yq8cD0nCrruG9R8k6F/gkK3ZM06xa10EWbPssKzUa5RX6E/UYGsCBdABiiwxJWapiAUOSeA==
Date: Tue, 3 Apr 2018 11:47:34 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 1/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
Message-ID: <20180403094734.GT3881@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <20180329131931.29957-2-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329131931.29957-2-andr2000@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 04:19:31PM +0300, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> +static int to_refs_grant_foreign_access(struct xen_gem_object *xen_obj)
> +{
> +	grant_ref_t priv_gref_head;
> +	int ret, j, cur_ref, num_pages;
> +	struct sg_page_iter sg_iter;
> +
> +	ret = gnttab_alloc_grant_references(xen_obj->num_pages,
> +			&priv_gref_head);
> +	if (ret < 0) {
> +		DRM_ERROR("Cannot allocate grant references\n");
> +		return ret;
> +	}
> +
> +	j = 0;
> +	num_pages = xen_obj->num_pages;
> +	for_each_sg_page(xen_obj->sgt->sgl, &sg_iter, xen_obj->sgt->nents, 0) {
> +		struct page *page;
> +
> +		page = sg_page_iter_page(&sg_iter);

Quick drive-by: You can't assume that an sgt is struct page backed.

And you probably want to check this at import/attach time.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
