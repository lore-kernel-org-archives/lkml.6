Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C5208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A/oohrNS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A/oohrNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0C5208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHBINE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:13:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeHBIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:13:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D665860B11; Thu,  2 Aug 2018 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533191008;
        bh=pKfVQiftJ2G0BnBipB69+c+IunCEWkR6FePG9JTw3+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A/oohrNSque0vaQD+EYG+eDFRkIwaKTu3ZOY2DmS7y/+8qcIJzfbHAH3MvEa7wKYj
         mhuTjRbTV58VXdUsLg6PyS2QNGbiAwf2U3INL5zDl4pg9ls37GBdL7lXuMZwjXYMm5
         MaA+u+OD13YICOFF2SrkzOMIaPhIjhaWbJcHuWfU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 190456063A;
        Thu,  2 Aug 2018 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533191008;
        bh=pKfVQiftJ2G0BnBipB69+c+IunCEWkR6FePG9JTw3+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A/oohrNSque0vaQD+EYG+eDFRkIwaKTu3ZOY2DmS7y/+8qcIJzfbHAH3MvEa7wKYj
         mhuTjRbTV58VXdUsLg6PyS2QNGbiAwf2U3INL5zDl4pg9ls37GBdL7lXuMZwjXYMm5
         MaA+u+OD13YICOFF2SrkzOMIaPhIjhaWbJcHuWfU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 11:53:28 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <6a1266c49a5be0d598dd7f1ded94e93d@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 04:17, Bjorn Helgaas wrote:
> On Thu, Jul 12, 2018 at 08:15:19PM +0530, Bharat Kumar Gogada wrote:
>> Currently PCI_BRIDGE_CTL_SERR is being enabled only in
>> ACPI flow.
>> This bit is required for forwarding errors reported
>> by EP devices to upstream device.
>> This patch enables SERR# for Type-1 PCI device.
> 
> This does seem broken.
> 
> Figure 6-3 in PCIe r4.0, sec 6.2.6, would be a helpful reference to
> include in the commit log.
> 
> Semi-related question: there are about 40 drivers that call
> pci_enable_pcie_error_reporting() and
> pci_disable_pcie_error_reporting().  I see that the PCI core
> calls pci_enable_pcie_error_reporting() for Root Ports and Switch
> Ports in this path:
> 
>   aer_probe                     # for root ports only
>     aer_enable_rootport
>       set_downstream_devices_error_reporting
>         set_device_error_reporting
>           if (ROOT_PORT || UPSTREAM || DOWNSTREAM)
>             pci_enable_pcie_error_reporting
>         pci_walk_bus(..., set_device_error_reporting)
> 
> But the core doesn't call pci_enable_pcie_error_reporting() for
> endpoints.  I wonder why not.  Could we?  And then remove the calls
> from those drivers?  If PCI_EXP_AER_FLAGS should only be set if the
> driver is prepared, the pci_driver.err_handler would be a good hint.
> But I suspect we could do something sensible and at least report
> errors even if the driver doesn't have err_handler callbacks.
> 

what about hot-plug case ?
should not aer_init() call pci_enable_pcie_error_reporting() for all the 
downstream pci_dev ?
and remove all the calls from drivers..

> On MIPS Octeon, it looks like pcibios_plat_dev_init() does already set
> PCI_EXP_AER_FLAGS for every device.
> 
> But this question is obviously far beyond the scope of this current
> patch.
> 
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> ---
>>  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e8838..943e084 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct 
>> pci_dev *dev)
>>  	if (!dev->aer_cap)
>>  		return -EIO;
>> 
>> +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> 
> I think this test needs to be refined a little bit.  If the kernel
> happens to be built with CONFIG_ACPI=y but the current platform
> doesn't support ACPI, we still want to set PCI_BRIDGE_CTL_SERR,
> don't we?
> 
>> +		u16 control;
>> +
>> +		/*
>> +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
>> +		 * from an endpoint if SERR# forwarding is not enabled.
>> +		 */
>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>> +		control |= PCI_BRIDGE_CTL_SERR;
>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> +	}
>> +
>>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, 
>> PCI_EXP_AER_FLAGS);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>> @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct 
>> pci_dev *dev)
>>  	if (pcie_aer_get_firmware_first(dev))
>>  		return -EIO;
>> 
>> +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> +		u16 control;
>> +
>> +		/* Clear SERR Forwarding */
>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>> +		control &= ~PCI_BRIDGE_CTL_SERR;
>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> +	}
>> +
>>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>>  					  PCI_EXP_AER_FLAGS);
>>  }
>> --
>> 1.7.1
>> 
