Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEEHm0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:42:26 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:49970 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:42:24 -0400
Subject: Re: [PATCH v2 07/10] PCI: Convert of_pci_get_host_bridge_resources()
 users to devm variant
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <ed3e6df4feca5febefa14716d62aaddd5b4a39d1.1525067324.git.jan.kiszka@siemens.com>
 <dbfa80fb-5fe8-3ccd-6886-4604ef9e058b@mentor.com>
 <20180504164401.GA17043@e107981-ln.cambridge.arm.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <0b7bf715-63dc-e2dc-a614-02d88bdc0254@mentor.com>
Date: Sat, 5 May 2018 10:42:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180504164401.GA17043@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 05/04/2018 07:44 PM, Lorenzo Pieralisi wrote:
> On Thu, May 03, 2018 at 10:18:24AM +0300, Vladimir Zapolskiy wrote:
>> Hi Jan,
>>
>> On 04/30/2018 08:48 AM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Straightforward for all of them, no more leaks afterwards.
>>>
>>> CC: Jingoo Han <jingoohan1@gmail.com>
>>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Acked-by: Jingoo Han <jingoo1han@gmail.com>
>>
>> [snip]
>>
>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>> index 6ab28f29ac6a..6eb36c924983 100644
>>> --- a/drivers/pci/host/pcie-rcar.c
>>> +++ b/drivers/pci/host/pcie-rcar.c
>>> @@ -1067,12 +1067,11 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
>>>  {
>>>  	int err;
>>>  	struct device *dev = pci->dev;
>>> -	struct device_node *np = dev->of_node;
>>>  	resource_size_t iobase;
>>>  	struct resource_entry *win, *tmp;
>>>  
>>> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
>>> -					       &iobase);
>>> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>>> +						    &pci->resources, &iobase);
>>>  	if (err)
>>>  		return err;
>>>  
>>
>> this one snippet is obsoleted by https://patchwork.ozlabs.org/patch/904326/
>>
>> If 08/10 remains a deprecation, then it is sufficient to exclude the R-Car change,
>> otherwise I hope maintainers can deal with the proper ordering.
> 
> Isn't applying your patch:
> 
> https://patchwork.ozlabs.org/patch/904326/
> 
> and dropping the rcar hunk from this patch enough ?
> 

absolutely, but it relies on any of two assumptions that
* my unmodified change is applied first, then Jan's adjusted change is applied,
* Jan's unmodified change is applied first, then my adjusted change is applied.

Otherwise there will be a trivial merge conflict, or even worse, if R-Car hunk
is removed as suggested, then of_pci_get_host_bridge_resources() is removed
instead of deprecation, and then my unmodified change is applied on top, it will
result in a window of commits, where R-Car PCIe driver won't be buildable, and
git-bisect users can be disappointed.

It makes little sense to include my change into Jan's series, thus I rely on
maintainers' awareness and smooth resolution of the issue by maintainers.

For what it's worth, I vote for of_pci_get_host_bridge_resources() removal.

--
With best wishes,
Vladimir
