Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E536C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC02F22BD0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC02F22BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bfs.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933999AbeGCQ5P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:57:15 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:52627 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932559AbeGCQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx01-sz.bfs.de (Postfix) with ESMTP id 5397460197;
        Tue,  3 Jul 2018 18:57:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at bfs.de
Received: from mx01-sz.bfs.de ([127.0.0.1])
        by localhost (mx01-sz.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bR1WhiJkttS2; Tue,  3 Jul 2018 18:57:11 +0200 (CEST)
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS;
        Tue,  3 Jul 2018 18:57:11 +0200 (CEST)
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id 639817F45D;
        Tue,  3 Jul 2018 18:57:06 +0200 (CEST)
Date:   Tue, 3 Jul 2018 18:57:06 +0200 (CEST)
From:   Walter Harms <wharms@bfs.de>
To:     Joe Perches <joe@perches.com>, "Hook, Gary" <ghook@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1540588259.84011.1530637026831@ox-groupware.bfs.de>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev31
X-Originating-Client: com.openexchange.ox.gui.dhtml
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 03.07.2018 18:38, schrieb Joe Perches:
> On Tue, 2018-07-03 at 11:27 -0500, Hook, Gary wrote:
>> On 7/3/2018 11:24 AM, Colin Ian King wrote:
>>> On 03/07/18 17:21, Hook, Gary wrote:
>>>> On 7/3/2018 10:55 AM, Joe Perches wrote:
>>>>> On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
>>>>>> On 07/03/2018 05:07 AM, Joe Perches wrote:
>>>>>>> On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
>>>>>>>> Currently tag is being assigned but not used, it is missing from
>>>>>>>> the dev_err message, so add it in.
>>>>>>>>
>>>>>>>> Cleans up clang warning:
>>>>>>>> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
>>>>>>>
>>>>>>> []
>>>>>>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>>>>>>
>>>>>>> []
>>>>>>>> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu
>>>>>>>> *iommu, void *__evt)
>>>>>>>>             pasid = ((event[0] >> 16) & 0xFFFF)
>>>>>>>>                 | ((event[1] << 6) & 0xF0000);
>>>>>>>>             tag = event[1] & 0x03FF;
>>>>>>>> -        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
>>>>>>>> pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>>>>>>> +        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
>>>>>>>> pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>>>>>>>>                 PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>>>>>>> -            pasid, address, flags);
>>>>>>>> +            pasid, address, flags, tag);
>>>>>>>
>>>>>>> Seems to have a superfluous ] that should be removed.
>>>>>>
>>>>>> Yeah, I pretty much messed up all of the log messages in that function.
>>>>>> My apologies. I'll create a patch for that problem; it shouldn't be
>>>>>> fixed here.
>>>>
>>>> Well, no, I misremembered. The extraneous square brace has been there
>>>> forever. Needs fixin', though.
>>>>
>>>
>>> The opening square bracket is much earlier:
>>>
>>> dev_err(dev, "AMD-Vi: Event logged [");
>>>
>>> ..and all the subsequent dev_err messages have the trailing square bracket.
>>
>> Gah! Mystery solved. I'd forgotten about that.
>>
>> "Never mind."
>>

It is only cosmetics but even the author got lost about the loose bracket.
I would suggest to remove all the brackets or if needed to move the [ in the
message. We have enought memory this days.

> -               printk(KERN_ERR "AMD-Vi: Event logged [");
> +               dev_err(dev, "AMD-Vi: Event logged [");

just my 2 cents,

re,
 wh

> 
> It stems from the misconversion from printk to dev_err
> 
> The initial dev_err is fine but all the dev_err uses
> in the switch/case should use pr_cont, not dev_err
> 
> (there's a suggested patch below this commit reference)
> 
> ---
>>From 90ca3859f5ea90050d00e695355934b37357e7bb Mon Sep 17 00:00:00 2001
> From: Gary R Hook <gary.hook@amd.com>
> Date: Thu, 8 Mar 2018 18:34:41 -0600
> Subject: [PATCH] iommu/amd: Use dev_err to send events to the system log
> 
> Remove printk and use a more preferable error logging function.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd_iommu.c | 55
> ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 997a947ddc3b..4cd19f93ca15 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -547,6 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16
> domain_id,
>  
>  static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  {
> +       struct device *dev = iommu->iommu.dev;
>         int type, devid, domid, flags;
>         volatile u32 *event = __evt;
>         int count = 0;
> @@ -573,53 +574,53 @@ static void iommu_print_event(struct amd_iommu *iommu,
> void *__evt)
>                 amd_iommu_report_page_fault(devid, domid, address, flags);
>                 return;
>         } else {
> -               printk(KERN_ERR "AMD-Vi: Event logged [");
> +               dev_err(dev, "AMD-Vi: Event logged [");
>         }
>  
>         switch (type) {
>         case EVENT_TYPE_ILL_DEV:
> -               printk("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
> -                      "address=0x%016llx flags=0x%04x]\n",
> -                      PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -                      address, flags);
> +               dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
> +                       "address=0x%016llx flags=0x%04x]\n",
> +                       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +                       address, flags);
> 
> etc...
> 
> so this could be:
> 
> ---
>  drivers/iommu/amd_iommu.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 596b95c50051..f78cfa094301 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -572,43 +572,42 @@ static void iommu_print_event(struct amd_iommu *iommu,
> void *__evt)
>  	if (type == EVENT_TYPE_IO_FAULT) {
>  		amd_iommu_report_page_fault(devid, pasid, address, flags);
>  		return;
> -	} else {
> -		dev_err(dev, "AMD-Vi: Event logged [");
>  	}
>  
> +	dev_err(dev, "AMD-Vi: Event logged [");
> +
>  	switch (type) {
>  	case EVENT_TYPE_ILL_DEV:
> -		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags);
>  		dump_dte_entry(devid);
>  		break;
>  	case EVENT_TYPE_DEV_TAB_ERR:
> -		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
> -			"address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x address=0x%016llx
> flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			address, flags);
>  		break;
>  	case EVENT_TYPE_PAGE_TAB_ERR:
> -		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x
> address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x
> address=0x%016llx flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags);
>  		break;
>  	case EVENT_TYPE_ILL_CMD:
> -		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
> +		pr_cont("ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
>  		dump_command(address);
>  		break;
>  	case EVENT_TYPE_CMD_HARD_ERR:
> -		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
>  			address, flags);
>  		break;
>  	case EVENT_TYPE_IOTLB_INV_TO:
> -		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
> +		pr_cont("IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			address);
>  		break;
>  	case EVENT_TYPE_INV_DEV_REQ:
> -		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags);
>  		break;
> @@ -616,12 +615,12 @@ static void iommu_print_event(struct amd_iommu *iommu,
> void *__evt)
>  		pasid = ((event[0] >> 16) & 0xFFFF)
>  			| ((event[1] << 6) & 0xF0000);
>  		tag = event[1] & 0x03FF;
> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
> +		pr_cont("INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x
> address=0x%016llx flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags);
>  		break;
>  	default:
> -		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x
> event[3]=0x%08x\n",
> +		pr_cont("UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x
> event[3]=0x%08x\n",
>  			event[0], event[1], event[2], event[3]);
>  	}
>  
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
