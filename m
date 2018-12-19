Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D47218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeLSQoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbeLSQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:44:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0791A74F06;
        Wed, 19 Dec 2018 16:44:09 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F21AE4148;
        Wed, 19 Dec 2018 16:44:07 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:44:07 -0700
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
Subject: Re: [PATCH kernel v6 19/20] vfio_pci: Allow regions to add own
 capabilities
Message-ID: <20181219094407.5583dfbf@x1.home>
In-Reply-To: <20181219085232.103441-20-aik@ozlabs.ru>
References: <20181219085232.103441-1-aik@ozlabs.ru>
        <20181219085232.103441-20-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Dec 2018 16:44:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc +kvm, +lkml]

Ditto list cc comment from 18/20

On Wed, 19 Dec 2018 19:52:31 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> VFIO regions already support region capabilities with a limited set of
> fields. However the subdriver might have to report to the userspace
> additional bits.
> 
> This adds an add_capability() hook to vfio_pci_regops.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v3:
> * removed confusing rationale for the patch, the next patch makes
> use of it anyway
> ---
>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>  drivers/vfio/pci/vfio_pci.c         | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 86aab05..93c1738 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -62,6 +62,9 @@ struct vfio_pci_regops {
>  	int	(*mmap)(struct vfio_pci_device *vdev,
>  			struct vfio_pci_region *region,
>  			struct vm_area_struct *vma);
> +	int	(*add_capability)(struct vfio_pci_device *vdev,
> +				  struct vfio_pci_region *region,
> +				  struct vfio_info_cap *caps);
>  };
>  
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 4a6f7c0..6cb70cf 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -763,6 +763,12 @@ static long vfio_pci_ioctl(void *device_data,
>  			if (ret)
>  				return ret;
>  
> +			if (vdev->region[i].ops->add_capability) {
> +				ret = vdev->region[i].ops->add_capability(vdev,
> +						&vdev->region[i], &caps);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  		}
>  

