Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06464ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B3E2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeGPVrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeGPVrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2E4C80F9E;
        Mon, 16 Jul 2018 21:17:58 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49F3D600C9;
        Mon, 16 Jul 2018 21:17:58 +0000 (UTC)
Date:   Mon, 16 Jul 2018 15:17:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH] x86/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180716151757.28206fae@t450s.home>
In-Reply-To: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
References: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 16 Jul 2018 21:17:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 13:42:25 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.
> 
> Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> instead of 0 for the PIN.
> 
> We could enforce it by default in vfio_pci_nointx.
> 
> Reported-by: Gage Eads <gage.eads@intel.com>
> Tested-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gage Eads <gage.eads@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a30..bc3f4fa 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -192,6 +192,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev);
>   */
>  static bool vfio_pci_nointx(struct pci_dev *pdev)
>  {
> +	/*
> +	 * Per PCI, no VF's should have INTx
> +	 * Simply disable it here
> +	 */
> +	if (pdev->is_virtfn)
> +		return true;
> +
>  	switch (pdev->vendor) {
>  	case PCI_VENDOR_ID_INTEL:
>  		switch (pdev->device) {

Nak, this is not what vfio_pci_nointx() is meant for, it's been tried
before and it was broken:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci.c?id=834814e80268c818f354c8f402e0c6604ed75589

This would cause *every* VF to print:

	dev_info(&pdev->dev, "Masking broken INTx support\n");

If the device is incapable of generating INTx then it's probably better
to drop it at vfio_pci_get_irq_count().  Please also note the subject is
misidentified, this is a "vfio/pci" patch, not an "x86/pci" patch.
kvm@vger is the official list for vfio patches.  Thanks,

Alex
