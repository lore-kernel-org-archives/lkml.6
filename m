Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 57777C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28D2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756270AbeFOOfF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:35:05 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:45166 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756224AbeFOOfD (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Fri, 15 Jun 2018 10:35:03 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 15 Jun 2018 08:35:02 -0600
Message-Id: <5B23CE9502000078001CBA36@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Fri, 15 Jun 2018 08:35:01 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: add new hypercall buffer mapping
 device
References: <20180615131740.5037-1-jgross@suse.com>
In-Reply-To: <20180615131740.5037-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 15.06.18 at 15:17, <jgross@suse.com> wrote:
> --- /dev/null
> +++ b/drivers/xen/privcmd-buf.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +/******************************************************************************
> + * privcmd-buf.c
> + *
> + * Mmap of hypercall buffers.
> + *
> + * Copyright (c) 2018 Juergen Gross
> + */
> +
> +#define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +
> +#include "privcmd.h"
> +
> +MODULE_LICENSE("GPL");
> +
> +static int limit = 64;
> +module_param(limit, int, 0644);

Can this go negative? If not - "unsigned int" and "uint" prehaps?

> +static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct privcmd_buf_private *file_priv = file->private_data;
> +	struct privcmd_buf_vma_private *vma_priv;
> +	unsigned int count = vma_pages(vma);
> +	unsigned int i;
> +	int ret = 0;
> +
> +	if (!(vma->vm_flags & VM_SHARED)) {
> +		pr_err("Mapping must be shared\n");
> +		return -EINVAL;
> +	}
> +
> +	if (file_priv->allocated + count > limit) {
> +		pr_err("Mapping limit reached!\n");

For both error messages - if you really want them, I think they should be
made more helpful such that it is possible to identify the offender. Log at
least process name and pid, or drop the messages?

> +		return -ENOSPC;
> +	}
> +
> +	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
> +			   GFP_KERNEL);
> +	if (!vma_priv)
> +		return -ENOMEM;
> +
> +	vma_priv->n_pages = count;
> +	count = 0;
> +	for (i = 0; i < vma_priv->n_pages; i++) {
> +		vma_priv->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!vma_priv->pages[i])
> +			break;
> +		count++;
> +	}
> +
> +	mutex_lock(&file_priv->lock);
> +
> +	file_priv->allocated += count;
> +
> +	vma_priv->file_priv = file_priv;
> +	vma_priv->users = 1;
> +
> +	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_ops = &privcmd_buf_vm_ops;
> +	vma->vm_private_data = vma_priv;
> +
> +	list_add(&vma_priv->list, &file_priv->list);
> +
> +	if (vma_priv->n_pages != count)
> +		ret = -ENOMEM;
> +	else
> +		for (i = 0; i < vma_priv->n_pages; i++) {
> +			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
> +					     vma_priv->pages[i]);
> +			if (ret)
> +				break;
> +		}
> +
> +	if (ret)
> +		privcmd_buf_vmapriv_free(vma_priv);

Don't you also need to undo the partially successful insertion?

> +struct miscdevice xen_privcmdbuf_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,

While dynamic minors are of course much better than fixed ones (as
we used to use many years ago), but aren't they still a relatively
limited resource? By setting a "mode" on a handle to the original
privcmd interface, no new minor would be needed.

> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -1007,12 +1007,21 @@ static int __init privcmd_init(void)
>  		pr_err("Could not register Xen privcmd device\n");
>  		return err;
>  	}
> +
> +	err = misc_register(&xen_privcmdbuf_dev);
> +	if (err != 0) {
> +		pr_err("Could not register Xen hypercall-buf device\n");
> +		misc_deregister(&privcmd_dev);
> +		return err;

Wouldn't this better be a warning only, without failing driver init?

Jan


