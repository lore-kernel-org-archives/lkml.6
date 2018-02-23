Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeBWP0f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:26:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeBWP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:26:33 -0500
Subject: Re: [PATCH 8/9] drm/xen-front: Implement GEM operations
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-9-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <2f2c6fea-c0cb-e244-41f3-269db07986fc@oracle.com>
Date: Fri, 23 Feb 2018 10:26:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-9-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=643
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
> +static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> +{
> +	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
> +	struct xen_gem_object *xen_obj;
> +	int ret;
> +
> +	size = round_up(size, PAGE_SIZE);
> +	xen_obj = gem_create_obj(dev, size);
> +	if (IS_ERR_OR_NULL(xen_obj))
> +		return xen_obj;
> +
> +	if (drm_info->cfg->be_alloc) {
> +		/*
> +		 * backend will allocate space for this buffer, so
> +		 * only allocate array of pointers to pages
> +		 */
> +		xen_obj->be_alloc = true;

If be_alloc is a flag (which I am not sure about) --- should it be set
to true *after* you've successfully allocated your things?

> +		ret = gem_alloc_pages_array(xen_obj, size);
> +		if (ret < 0) {
> +			gem_free_pages_array(xen_obj);
> +			goto fail;
> +		}
> +
> +		ret = alloc_xenballooned_pages(xen_obj->num_pages,
> +				xen_obj->pages);

Why are you allocating balloon pages?

-boris

> +		if (ret < 0) {
> +			DRM_ERROR("Cannot allocate %zu ballooned pages: %d\n",
> +					xen_obj->num_pages, ret);
> +			goto fail;
> +		}
> +
> +		return xen_obj;
> +	}
> +	/*
> +	 * need to allocate backing pages now, so we can share those
> +	 * with the backend
> +	 */
> +	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
> +	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
> +	if (IS_ERR_OR_NULL(xen_obj->pages)) {
> +		ret = PTR_ERR(xen_obj->pages);
> +		xen_obj->pages = NULL;
> +		goto fail;
> +	}
> +
> +	return xen_obj;
> +
> +fail:
> +	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
> +	return ERR_PTR(ret);
> +}
> +
>
