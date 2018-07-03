Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BDB24A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CBbuax/a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CBbuax/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BDB24A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeGCPnc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:43:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeGCPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:43:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5692607DC; Tue,  3 Jul 2018 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632609;
        bh=Tel0E+6NOVVbWI2hucG36ospR09Nzv9WQkOje8IDNLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CBbuax/a6wfgEqQlxRForl8c2kv6+TajsedS0bLHPyNfqOs97IkCb4mmRdnGNySxU
         fabQtJjFdBEtW3m+Bo03hbgQZu+ADGRpQVbumn1R0VpGc/oBha8fgMZ3KK/O/q14Ec
         nMpzoOoxy+ydVhJAb4cvf9FLCoPmfZYHDXMLngkM=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBBD260290;
        Tue,  3 Jul 2018 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632609;
        bh=Tel0E+6NOVVbWI2hucG36ospR09Nzv9WQkOje8IDNLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CBbuax/a6wfgEqQlxRForl8c2kv6+TajsedS0bLHPyNfqOs97IkCb4mmRdnGNySxU
         fabQtJjFdBEtW3m+Bo03hbgQZu+ADGRpQVbumn1R0VpGc/oBha8fgMZ3KK/O/q14Ec
         nMpzoOoxy+ydVhJAb4cvf9FLCoPmfZYHDXMLngkM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBBD260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
Date:   Tue, 3 Jul 2018 11:43:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703143434.GA4086@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 10:34 AM, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>  		pci_dev_put(pdev);
>>  	}
>>  
>> +	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
>> +	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
>> +
>> +	if (hpdev && hpsvc)
>> +		hpsvc->mask_irq(to_pcie_device(hpdev));
>> +
>>  	result = reset_link(udev, service);
>>  
>> +	if (hpdev && hpsvc)
>> +		hpsvc->unmask_irq(to_pcie_device(hpdev));
>> +
> 
> We've already got the ->reset_slot callback in struct hotplug_slot_ops,
> I'm wondering if we really need additional ones for this use case.
> 
> If you just do...
> 
> 	if (!pci_probe_reset_slot(dev->slot))
> 		pci_reset_slot(dev->slot)
> 	else {
> 		/* regular code path */
> 	}
> 
> would that not be equivalent?

As I have informed you before on my previous reply, the pdev->slot is
only valid for children objects such as endpoints not for a bridge when
using pciehp.

The pointer is NULL for the host bridge itself.

I reached out to reset_slot() callback in v4 of this implementation.

https://patchwork.kernel.org/patch/10494971/

However, as Oza explained FATAL error handling gets called from two different
paths as AER and DPC.

If the link goes down due to DPC, calling pci_reset_slot() would be a mistake
as DPC has its own recovery mechanism by programming the DPC capabilities.
pci_reset_slot() performs a secondary bus reset following hotplug interrupt
mask.

Issuing a secondary bus reset to a DPC event would be a mistake for recovery.

That's why, I extracted the hotplug mask and unmask IRQ calls into service
layer so that I can mask hotplug interrupts regardless of the source of the
FATAL error whether it is DPC or AER.

If error source is DPC, it still goes to DPC driver's reset_link() callback
for DPC specific clean up.

If error source is AER, it still goes to AER driver's reset_link() callback
for secondary bus reset.

Remember that AER driver completely bypasses pci_reset_slot() today. The lock
mechanism you are putting will not be useful for FATAL error case where
pci_secondary_bus_reset() is called directly.

pci_reset_slot() only gets called from external drivers such as VFIO to initiate
a reset to the slot if hotplug is supported.

> 
> (It's worth noting though that pciehp is the only hotplug driver
> implementing the ->reset_slot callback.  If hotplug is handled by
> a different driver or by the platform firmware, devices may still
> be removed and re-enumerated twice.)
> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
