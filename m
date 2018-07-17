Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8DFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594C20850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2594C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeGQPzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeGQPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0A73356CB;
        Tue, 17 Jul 2018 15:22:08 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78471949D;
        Tue, 17 Jul 2018 15:22:07 +0000 (UTC)
Date:   Tue, 17 Jul 2018 09:22:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     ray.jui@broadcom.com, vikram.prakash@broadcom.com,
        scott.branden@broadcom.com, kvm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] vfio/pci: map prefetchble bars as writecombine
Message-ID: <20180717092207.775e381c@t450s.home>
In-Reply-To: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Jul 2018 15:22:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 10:26:17 +0530
Srinath Mannam <srinath.mannam@broadcom.com> wrote:

> By default all BARs map with VMA access permissions
> as pgprot_noncached.
> 
> In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
> is strongly ordered and allows aligned access.
> This type of mapping works for NON-PREFETCHABLE bars
> containing EP controller registers.
> But it restricts PREFETCHABLE bars from doing
> unaligned access.
> 
> In CMB NVMe drives PREFETCHABLE bars are required to
> map as MT_NORMAL_NC to do unaligned access.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> ---

This has been discussed before:

https://www.spinics.net/lists/kvm/msg156548.html

CC'ing the usual suspects from the previous thread.  I'm not convinced
that the patch here has considered anything other than the ARM64
implications and it's not clear that it considers compatibility with
existing users or devices at all.  Can we guarantee for all devices and
use cases that WC is semantically equivalent and preferable to UC?  If
not then we need to device an extension to the interface that allows
the user to specify WC.  Thanks,

Alex

>  drivers/vfio/pci/vfio_pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a30..eff6b65 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1142,7 +1142,10 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	}
>  
>  	vma->vm_private_data = vdev;
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	if (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
>  
>  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,

