Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A82DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FF42082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FF42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeLEJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:33:09 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:9887 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:33:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,317,1539648000"; 
   d="scan'208";a="82813116"
Date:   Wed, 5 Dec 2018 10:32:23 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Chao Gao <chao.gao@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <xen-devel@lists.xenproject.org>, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Message-ID: <20181205093223.dncg4nq4dh6xmrhk@mac>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
> I find some pass-thru devices don't work any more across guest reboot.
> Assigning it to another guest also meets the same issue. And the only
> way to make it work again is un-binding and binding it to pciback.
> Someone reported this issue one year ago [1]. More detail also can be
> found in [2].
> 
> The root-cause is Xen's internal MSI-X state isn't reset properly
> during reboot or re-assignment. In the above case, Xen set maskall bit
> to mask all MSI interrupts after it detected a potential security
> issue. Even after device reset, Xen didn't reset its internal maskall
> bit. As a result, maskall bit would be set again in next write to
> MSI-X message control register.
> 
> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
> internal state of a device, we employ it to fix this issue rather than
> introducing another dedicated sub-hypercall.
> 
> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
> the device's msix and pirq has been created. This limitation prevents
> us calling this function when detaching a device from a guest during
> guest shutdown. Thus it is called right before calling
> PHYSDEVOPS_prepare_msix().

s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
() at the end of the hypercall name since it's not a function.

I'm also wondering why the release can't be done when the device is
detached from the guest (or the guest has been shut down). This makes
me worry about the raciness of the attach/detach procedure: if there's
a state where pciback assumes the device has been detached from the
guest, but there are still pirqs bound, an attempt to attach to
another guest in such state will fail.

> [1]: https://lists.xenproject.org/archives/html/xen-devel/2017-09/
>      msg02520.html
> [2]: https://lists.xen.org/archives/html/xen-devel/2018-11/msg01616.html
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  drivers/xen/xen-pciback/pci_stub.c | 49 ++++++++++++++++++++++++++++++++++++++
>  drivers/xen/xen-pciback/pciback.h  |  1 +
>  drivers/xen/xen-pciback/xenbus.c   | 10 ++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 59661db..f8623d0 100644
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

I would just perform a reset regardless of the maskall value, which
would also allow you to skip the read/write dance that you do above.

ATM we are only concerned about the maskall bit, but there's no reason
why prepare/release couldn't do more stuff in the future.

> +
> +		pr_info("Reset MSI-X state for device %04x:%02x:%02x.%d\n",
> +			ppdev.seg, ppdev.bus, PCI_SLOT(ppdev.devfn),
> +			PCI_FUNC(ppdev.devfn));
> +
> +		err = HYPERVISOR_physdev_op(PHYSDEVOP_release_msix, &ppdev);
> +		if (err) {
> +			dev_warn(&dev->dev, "MSI-X release failed (%d)\n",
> +				 err);

This is a warn, while the message below is an err, any reason for
the difference in log level?

> +			return err;
> +		}
> +
> +		err = HYPERVISOR_physdev_op(PHYSDEVOP_prepare_msix, &ppdev);
> +		if (err) {
> +			dev_err(&dev->dev, "MSI-X preparation failed (%d)\n",
> +				err);
> +			return err;

Thanks, Roger.
