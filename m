Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83005C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442DD208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442DD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeLFCOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:14:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:7048 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeLFCOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:14:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 18:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,320,1539673200"; 
   d="scan'208";a="98447451"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2018 18:14:36 -0800
Date:   Thu, 6 Dec 2018 10:18:17 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Message-ID: <20181206021815.GA8252@gao-cwp>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
 <20181205093223.dncg4nq4dh6xmrhk@mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205093223.dncg4nq4dh6xmrhk@mac>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:32:23AM +0100, Roger Pau Monné wrote:
>On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
>> I find some pass-thru devices don't work any more across guest reboot.
>> Assigning it to another guest also meets the same issue. And the only
>> way to make it work again is un-binding and binding it to pciback.
>> Someone reported this issue one year ago [1]. More detail also can be
>> found in [2].
>> 
>> The root-cause is Xen's internal MSI-X state isn't reset properly
>> during reboot or re-assignment. In the above case, Xen set maskall bit
>> to mask all MSI interrupts after it detected a potential security
>> issue. Even after device reset, Xen didn't reset its internal maskall
>> bit. As a result, maskall bit would be set again in next write to
>> MSI-X message control register.
>> 
>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
>> internal state of a device, we employ it to fix this issue rather than
>> introducing another dedicated sub-hypercall.
>> 
>> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
>> the device's msix and pirq has been created. This limitation prevents
>> us calling this function when detaching a device from a guest during
>> guest shutdown. Thus it is called right before calling
>> PHYSDEVOPS_prepare_msix().
>
>s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
>() at the end of the hypercall name since it's not a function.

Will do.

>
>I'm also wondering why the release can't be done when the device is
>detached from the guest (or the guest has been shut down). This makes
>me worry about the raciness of the attach/detach procedure: if there's
>a state where pciback assumes the device has been detached from the
>guest, but there are still pirqs bound, an attempt to attach to
>another guest in such state will fail.

I think your concern is valid. This is the exact case in which Xen sets
maskall flag. Qemu didn't do msix cleanup (it crashed or guest didn't
request qemu to do this. Anyway, we couldn't rely on qemu), leaving
pirqs bound. pciback doesn't manage pirqs so it doesn't know how to do
cleanup for msix. Then pciback does device reset and disables
memory decoding. After detaching a device from the domain, Xen can do
further cleanup for a closing VM, including freeing pirqs of the VM, but
saw memory decoding disabled. Hence, the maskall flag is set.

>
>> [1]: https://lists.xenproject.org/archives/html/xen-devel/2017-09/
>>      msg02520.html
>> [2]: https://lists.xen.org/archives/html/xen-devel/2018-11/msg01616.html
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> ---
>>  drivers/xen/xen-pciback/pci_stub.c | 49 ++++++++++++++++++++++++++++++++++++++
>>  drivers/xen/xen-pciback/pciback.h  |  1 +
>>  drivers/xen/xen-pciback/xenbus.c   | 10 ++++++++
>>  3 files changed, 60 insertions(+)
>> 
>> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
>> index 59661db..f8623d0 100644
>> --- a/drivers/xen/xen-pciback/pci_stub.c
>> +++ b/drivers/xen/xen-pciback/pci_stub.c
>> @@ -87,6 +87,55 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
>>  	return psdev;
>>  }
>>  
>> +/*
>> + * Reset Xen internal MSI-X state by invoking PHYSDEVOP_{release, prepare}_msix.
>> + */
>> +int pcistub_msix_reset(struct pci_dev *dev)
>> +{
>> +#ifdef CONFIG_PCI_MSI
>> +	if (dev->msix_cap) {
>> +		struct physdev_pci_device ppdev = {
>> +			.seg = pci_domain_nr(dev->bus),
>> +			.bus = dev->bus->number,
>> +			.devfn = dev->devfn
>> +		};
>> +		int err;
>> +		u16 val;
>> +
>> +		/*
>> +		 * Do a write first to flush Xen's internal state to hardware
>> +		 * such that the following read can infer whether MSI-X maskall
>> +		 * bit is set by Xen.
>> +		 */
>> +		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
>> +		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, val);
>> +
>> +		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
>> +		if (!(val & PCI_MSIX_FLAGS_MASKALL))
>> +			return 0;
>
>I would just perform a reset regardless of the maskall value, which
>would also allow you to skip the read/write dance that you do above.
>
>ATM we are only concerned about the maskall bit, but there's no reason
>why prepare/release couldn't do more stuff in the future.
>
>> +
>> +		pr_info("Reset MSI-X state for device %04x:%02x:%02x.%d\n",
>> +			ppdev.seg, ppdev.bus, PCI_SLOT(ppdev.devfn),
>> +			PCI_FUNC(ppdev.devfn));
>> +
>> +		err = HYPERVISOR_physdev_op(PHYSDEVOP_release_msix, &ppdev);
>> +		if (err) {
>> +			dev_warn(&dev->dev, "MSI-X release failed (%d)\n",
>> +				 err);
>
>This is a warn, while the message below is an err, any reason for
>the difference in log level?
>

Will fix this. I just copy code snippte from the existing call site.
and also make them distinguishable per Jan's suggestion.

Thanks
Chao
