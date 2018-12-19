Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6C6217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeLSQoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbeLSQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:44:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE2C7796F6;
        Wed, 19 Dec 2018 16:44:00 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A3D95DA67;
        Wed, 19 Dec 2018 16:43:59 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:43:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v6 18/20] vfio_pci: Allow mapping extra regions
Message-ID: <20181219094358.1bcd03a5@x1.home>
In-Reply-To: <20181219085232.103441-19-aik@ozlabs.ru>
References: <20181219085232.103441-1-aik@ozlabs.ru>
        <20181219085232.103441-19-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 16:44:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc +kvm, +lkml]

Sorry, just noticed these are only visible on ppc lists or for those
directly cc'd.  vfio's official development list is the kvm list.  I'll
let spapr specific changes get away without copying this list, but
changes like this really need to be visible to everyone.  Thanks,

Alex

On Wed, 19 Dec 2018 19:52:30 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> So far we only allowed mapping of MMIO BARs to the userspace. However
> there are GPUs with on-board coherent RAM accessible via side
> channels which we also want to map to the userspace. The first client
> for this is NVIDIA V100 GPU with NVLink2 direct links to a POWER9
> NPU-enabled CPU; such GPUs have 16GB RAM which is coherently mapped
> to the system address space, we are going to export these as an extra
> PCI region.
> 
> We already support extra PCI regions and this adds support for mapping
> them to the userspace.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v2:
> * reverted one of mistakenly removed error checks
> ---
>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>  drivers/vfio/pci/vfio_pci.c         | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index cde3b5d..86aab05 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -59,6 +59,9 @@ struct vfio_pci_regops {
>  		      size_t count, loff_t *ppos, bool iswrite);
>  	void	(*release)(struct vfio_pci_device *vdev,
>  			   struct vfio_pci_region *region);
> +	int	(*mmap)(struct vfio_pci_device *vdev,
> +			struct vfio_pci_region *region,
> +			struct vm_area_struct *vma);
>  };
>  
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index fef5002..4a6f7c0 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1130,6 +1130,15 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
> +	if (index >= VFIO_PCI_NUM_REGIONS) {
> +		int regnum = index - VFIO_PCI_NUM_REGIONS;
> +		struct vfio_pci_region *region = vdev->region + regnum;
> +
> +		if (region && region->ops && region->ops->mmap &&
> +		    (region->flags & VFIO_REGION_INFO_FLAG_MMAP))
> +			return region->ops->mmap(vdev, region, vma);
> +		return -EINVAL;
> +	}
>  	if (index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -EINVAL;
>  	if (!vdev->bar_mmap_supported[index])

