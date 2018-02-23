Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeBWPT6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:19:58 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38453 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeBWPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:19:57 -0500
X-Google-Smtp-Source: AG47ELvvUj9qtgqsPRsIpvE7+xNl78nTSspivbVPPSC2jHblam6rTqL4UKbI2q8F3JDVqs+kKJWx+Q==
Subject: Re: [PATCH 6/9] drm/xen-front: Introduce DRM/KMS virtual display
 driver
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-7-git-send-email-andr2000@gmail.com>
 <9081e140-dd0e-bb55-240f-77ff19a33f3c@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5f1d8590-8c74-ac40-896e-06405f23be3a@gmail.com>
Date: Fri, 23 Feb 2018 17:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9081e140-dd0e-bb55-240f-77ff19a33f3c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 05:12 PM, Boris Ostrovsky wrote:
> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>
>> +
>> +struct drm_driver xen_drm_driver = {
>> +	.driver_features           = DRIVER_GEM | DRIVER_MODESET |
>> +				     DRIVER_PRIME | DRIVER_ATOMIC,
>> +	.lastclose                 = lastclose,
>> +	.gem_free_object_unlocked  = free_object,
>> +	.gem_vm_ops                = &xen_drm_vm_ops,
>> +	.prime_handle_to_fd        = drm_gem_prime_handle_to_fd,
>> +	.prime_fd_to_handle        = drm_gem_prime_fd_to_handle,
>> +	.gem_prime_import          = drm_gem_prime_import,
>> +	.gem_prime_export          = drm_gem_prime_export,
>> +	.gem_prime_get_sg_table    = prime_get_sg_table,
>> +	.gem_prime_import_sg_table = prime_import_sg_table,
>> +	.gem_prime_vmap            = prime_vmap,
>> +	.gem_prime_vunmap          = prime_vunmap,
>> +	.gem_prime_mmap            = prime_mmap,
>> +	.dumb_create               = dumb_create,
>> +	.fops                      = &xendrm_fops,
>> +	.name                      = "xendrm-du",
>> +	.desc                      = "Xen PV DRM Display Unit",
>> +	.date                      = "20161109",
> You must have been working on this for a while ;-)
yes, this is true ;)
>
> I assume this needs to be updated.
It can be, but I would either stick to the current value
for historical reasons or would update it in the final version
of the driver, so it reflects the date of issuing ;)
>> +bool xen_drm_front_drv_is_used(struct platform_device *pdev)
>> +{
>> +	struct xen_drm_front_drm_info *drm_info = platform_get_drvdata(pdev);
>> +	struct drm_device *dev;
>> +
>> +	if (!drm_info)
>> +		return false;
>> +
>> +	dev = drm_info->drm_dev;
>> +	if (!dev)
>> +		return false;
>> +
>> +	/*
>> +	 * FIXME: the code below must be protected by drm_global_mutex,
>> +	 * but it is not accessible to us. Anyways there is a race condition,
>> +	 * but we will re-try.
>> +	 */
>> +	return dev->open_count != 0;
> Would it be a problem, given the race, if you report that the frontend
> is not in use, while it actually is?
no, backend will not be able to activate us again
> -boris
