Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBWPL7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:11:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40722 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeBWPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:11:57 -0500
Subject: Re: [PATCH 6/9] drm/xen-front: Introduce DRM/KMS virtual display
 driver
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-7-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <9081e140-dd0e-bb55-240f-77ff19a33f3c@oracle.com>
Date: Fri, 23 Feb 2018 10:12:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-7-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:

> +
> +struct drm_driver xen_drm_driver = {
> +	.driver_features           = DRIVER_GEM | DRIVER_MODESET |
> +				     DRIVER_PRIME | DRIVER_ATOMIC,
> +	.lastclose                 = lastclose,
> +	.gem_free_object_unlocked  = free_object,
> +	.gem_vm_ops                = &xen_drm_vm_ops,
> +	.prime_handle_to_fd        = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle        = drm_gem_prime_fd_to_handle,
> +	.gem_prime_import          = drm_gem_prime_import,
> +	.gem_prime_export          = drm_gem_prime_export,
> +	.gem_prime_get_sg_table    = prime_get_sg_table,
> +	.gem_prime_import_sg_table = prime_import_sg_table,
> +	.gem_prime_vmap            = prime_vmap,
> +	.gem_prime_vunmap          = prime_vunmap,
> +	.gem_prime_mmap            = prime_mmap,
> +	.dumb_create               = dumb_create,
> +	.fops                      = &xendrm_fops,
> +	.name                      = "xendrm-du",
> +	.desc                      = "Xen PV DRM Display Unit",
> +	.date                      = "20161109",

You must have been working on this for a while ;-)

I assume this needs to be updated.

> +bool xen_drm_front_drv_is_used(struct platform_device *pdev)
> +{
> +	struct xen_drm_front_drm_info *drm_info = platform_get_drvdata(pdev);
> +	struct drm_device *dev;
> +
> +	if (!drm_info)
> +		return false;
> +
> +	dev = drm_info->drm_dev;
> +	if (!dev)
> +		return false;
> +
> +	/*
> +	 * FIXME: the code below must be protected by drm_global_mutex,
> +	 * but it is not accessible to us. Anyways there is a race condition,
> +	 * but we will re-try.
> +	 */
> +	return dev->open_count != 0;

Would it be a problem, given the race, if you report that the frontend
is not in use, while it actually is?

-boris
