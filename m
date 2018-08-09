Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F53C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F021F41
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F021F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeHIWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53917 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbeHIWKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9918E804E3;
        Thu,  9 Aug 2018 19:44:18 +0000 (UTC)
Received: from t450s.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD13A4B83;
        Thu,  9 Aug 2018 19:44:18 +0000 (UTC)
Date:   Thu, 9 Aug 2018 13:44:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180809134417.50de7fe7@t450s.home>
In-Reply-To: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 09 Aug 2018 19:44:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Aug 2018 12:37:06 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.
> 
> Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> instead of 0 for the PIN.

Hi Ashok,

One question, can we identify which VFs are known to have this issue so
that users (and downstreams) can know how to prioritize this patch?
Thanks,

Alex

> Since this is a spec required value, rather than having a device specific
> quirk, we could fix it permanently in vfio.
> 
> Reworked suggestions from Alex https://lkml.org/lkml/2018/7/16/1052
> 
> Reported-by: Gage Eads <gage.eads@intel.com>
> Tested-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gage Eads <gage.eads@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c        | 12 +++++++++---
>  drivers/vfio/pci/vfio_pci_config.c |  3 ++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a30..32943dd 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -433,10 +433,16 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  {
>  	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
>  		u8 pin;
> -		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> -		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && !vdev->nointx && pin)
> -			return 1;
> +		/*
> +		 * INTx must be 0 for all VF's. Enforce that for all
> +		 * VF's since this is a spec requirement.
> +		 */
> +		if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
> +			vdev->pdev->is_virtfn)
> +			return 0;
>  
> +		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> +		return (pin ? 1 : 0);
>  	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
>  		u8 pos;
>  		u16 flags;
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 115a36f..e36b7c3 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1676,7 +1676,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
>  		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
> +	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
> +		pdev->is_virtfn)
>  		vconfig[PCI_INTERRUPT_PIN] = 0;
>  
>  	ret = vfio_cap_init(vdev);

