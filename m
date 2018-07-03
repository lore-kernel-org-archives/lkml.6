Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E36C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9121A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RiiBfFSd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RiiBfFSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F9121A89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeGCPMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:12:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbeGCPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:12:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC4C560C55; Tue,  3 Jul 2018 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530630732;
        bh=YpKTwE7vKkMadfqVu0MRzF6+SSQlG5NOx7wwgmWJ+aE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiiBfFSdYt5V1EvErMWNRHGFb+JQ7+s7Dx5J226Xyhmn7TWpcpyEjDuzw7SI6c6W6
         s5qaP5GDTOrQn9Y7VK0ALr4aU/thd1cDENRGknLLXQOEexLySdxwdiWq3uSrc7hHSp
         qavf+POPVmmb7dqWDL+Wqq0Z9cmru4CfG/EMlPpI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3AA0C607DC;
        Tue,  3 Jul 2018 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530630732;
        bh=YpKTwE7vKkMadfqVu0MRzF6+SSQlG5NOx7wwgmWJ+aE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiiBfFSdYt5V1EvErMWNRHGFb+JQ7+s7Dx5J226Xyhmn7TWpcpyEjDuzw7SI6c6W6
         s5qaP5GDTOrQn9Y7VK0ALr4aU/thd1cDENRGknLLXQOEexLySdxwdiWq3uSrc7hHSp
         qavf+POPVmmb7dqWDL+Wqq0Z9cmru4CfG/EMlPpI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 20:42:12 +0530
From:   poza@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703143434.GA4086@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
Message-ID: <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 20:04, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, 
>> u32 service)
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
> 

pcie_do_fatal_recovery() calls
           reset_link()
              which calls dpc_reset_link() or aer_root_reset() depending 
on the event.

and dpc_reset_link() and aer_root_reset() do their own cleanup stuffs.
infact, aer_root_reset() is the only function which actually triggers 
pci_reset_bridge_secondary_bus().

So if we try to fit in your suggestion:

if (!pci_probe_reset_slot(dev->slot))
{
     pci_reset_slot(dev->slot)
     result = reset_link(udev, service); >> in this case aer_root_reset 
must not call pci_reset_bridge_secondary_bus()
} else
     result = reset_link(udev, service); >> in this case aer_root_reset 
must call pci_reset_bridge_secondary_bus() [since bridge is not hotplug 
capable)

Did I get your suggestion right ?

Regards,
Oza.

> (It's worth noting though that pciehp is the only hotplug driver
> implementing the ->reset_slot callback.  If hotplug is handled by
> a different driver or by the platform firmware, devices may still
> be removed and re-enumerated twice.)
> 

> Thanks,
> 
> Lukas
