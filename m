Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67A62064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67A62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeLEQ0j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:26:39 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:49953 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEQ0j (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:8:1>);
        Wed, 5 Dec 2018 11:26:39 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 05 Dec 2018 09:26:37 -0700
Message-Id: <5C07FC380200007800203394@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 05 Dec 2018 09:26:32 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Chao Gao" <chao.gao@intel.com>
Cc:     "Roger Pau Monne" <roger.pau@citrix.com>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing
 a device
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
In-Reply-To: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 05.12.18 at 03:19, <chao.gao@intel.com> wrote:
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -87,6 +87,55 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
>  	return psdev;
>  }
>  
> +/*
> + * Reset Xen internal MSI-X state by invoking PHYSDEVOP_{release, prepare}_msix.
> + */
> +int pcistub_msix_reset(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_MSI
> +	if (dev->msix_cap) {
> +		struct physdev_pci_device ppdev = {
> +			.seg = pci_domain_nr(dev->bus),
> +			.bus = dev->bus->number,
> +			.devfn = dev->devfn
> +		};
> +		int err;
> +		u16 val;
> +
> +		/*
> +		 * Do a write first to flush Xen's internal state to hardware
> +		 * such that the following read can infer whether MSI-X maskall
> +		 * bit is set by Xen.
> +		 */
> +		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
> +		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, val);
> +
> +		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
> +		if (!(val & PCI_MSIX_FLAGS_MASKALL))
> +			return 0;

I'm agreeing with prior comments: I don't see why you need
this conditional.

> +		pr_info("Reset MSI-X state for device %04x:%02x:%02x.%d\n",
> +			ppdev.seg, ppdev.bus, PCI_SLOT(ppdev.devfn),
> +			PCI_FUNC(ppdev.devfn));
> +
> +		err = HYPERVISOR_physdev_op(PHYSDEVOP_release_msix, &ppdev);
> +		if (err) {
> +			dev_warn(&dev->dev, "MSI-X release failed (%d)\n",
> +				 err);
> +			return err;
> +		}
> +
> +		err = HYPERVISOR_physdev_op(PHYSDEVOP_prepare_msix, &ppdev);
> +		if (err) {
> +			dev_err(&dev->dev, "MSI-X preparation failed (%d)\n",
> +				err);

Please can you make both log messages distinguishable from
the pre-existing ones, to aid diagnosis of possible probelms?

Jan


