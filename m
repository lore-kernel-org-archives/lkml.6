Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034305AbeCBHzI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:55:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53094 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034261AbeCBHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:55:06 -0500
X-Google-Smtp-Source: AG47ELuCtjDmJugFhHez6xf4lK4KsSgsva+qdA1moR+vC+hBmfmmvX+BN4VIaeRCpqcJXO9NIYw0vg==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource v2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20180221090715.2853-1-christian.koenig@amd.com>
 <20180301184957.GI13722@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d850105e-3ce1-2957-de79-98f7eda2dcee@gmail.com>
Date: Fri, 2 Mar 2018 08:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301184957.GI13722@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.03.2018 um 19:49 schrieb Bjorn Helgaas:
> On Wed, Feb 21, 2018 at 10:07:15AM +0100, Christian König wrote:
>> Is it entirely possible that the BIOS wasn't able to assign resources to
>> a device. In this case don't crash in pci_release_resource() when we try
>> to resize the resource.
>>
>> v2: keep printing the info that we try to release the BAR
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> CC: stable@vger.kernel.org
> I was hoping for a dmesg snippet, but I added a Fixes: tag and applied
> this to for-linus for v4.16.

Sorry, been on vacation and missed your mail.

I don't have a dmesg of hand either, cause the reporter provided only a 
mail with a picture of the crash :)

But he confirmed that the patch worked.

Thanks,
Christian.

>
>> ---
>>   drivers/pci/setup-res.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index e815111f3f81..c0f091614805 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>>   	struct resource *res = dev->resource + resno;
>>   
>>   	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
>> +
>> +	if (!res->parent)
>> +		return;
>> +
>>   	release_resource(res);
>>   	res->end = resource_size(res) - 1;
>>   	res->start = 0;
>> -- 
>> 2.14.1
>>
