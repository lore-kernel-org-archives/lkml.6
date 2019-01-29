Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF10C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A813D20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfA2THq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:07:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfA2THp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:07:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BE87A78;
        Tue, 29 Jan 2019 11:07:45 -0800 (PST)
Received: from [10.1.35.17] (e110479-lin.cambridge.arm.com [10.1.35.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2C883F557;
        Tue, 29 Jan 2019 11:07:42 -0800 (PST)
Subject: Re: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for display
 buffers
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, kraxel@redhat.com,
        noralf@tronnes.org, hch@infradead.org
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190129150422.19867-1-andr2000@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
Date:   Tue, 29 Jan 2019 19:07:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129150422.19867-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On 1/29/19 3:04 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> When GEM backing storage is allocated those are normal pages,
> so there is no point using pgprot_writecombine while mmaping.
> This fixes mismatch of buffer pages' memory attributes between
> the frontend and backend which may cause screen artifacts.
> 
> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Suggested-by: Julien Grall <julien.grall@arm.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index d303a2e17f5e..9d5c03d7668d 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -235,8 +235,7 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>   	vma->vm_flags &= ~VM_PFNMAP;
>   	vma->vm_flags |= VM_MIXEDMAP;
>   	vma->vm_pgoff = 0;
> -	vma->vm_page_prot =
> -			pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);

The patch looks good to me. It would be worth expanding the comment a 
bit before to explain that we overwrite vm_page_prot to use cacheable 
attribute as required by the Xen ABI.

With the comment updated:

Acked-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
