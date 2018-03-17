Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeCQJiB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 05:38:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55001 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCQJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 05:37:59 -0400
X-Google-Smtp-Source: AG47ELtnKCKinTx0bugYOyICvisAQWOQgf8eIriKAoC9Yhnj9gdxMN969jBf+TGciYjlJkhnGmOx3g==
Subject: Re: [PATCH] scsi: scsi_transport_iscsi: use put_device() instead of
 kfree()
To: Chris Leech <cleech@redhat.com>, lduncan@suse.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
References: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
 <20180315174448.GB32176@straylight.hirudinean.org>
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AACE1F0.1080109@gmail.com>
Date: Sat, 17 Mar 2018 15:07:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180315174448.GB32176@straylight.hirudinean.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 15 March 2018 11:14 PM, Chris Leech wrote:
> On Wed, Mar 07, 2018 at 05:07:33PM +0530, Arvind Yadav wrote:
>> Never directly free @dev after calling device_register(), even
>> if it returned an error! Always use put_device() to give up the
>> reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/scsi/scsi_transport_iscsi.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> @@ -783,7 +781,7 @@ struct iscsi_iface *
>>   
>>   free_iface:
>>   	put_device(iface->dev.parent);
>> -	kfree(iface);
>> +	put_device(&iface->dev);
>>   	return NULL;
>>   }
>>   EXPORT_SYMBOL_GPL(iscsi_create_iface);
> Am I reading the device code correctly that the parent reference is only
> released in the unregister path (device_unregister calls device_del) and
> so the manual put_device on the parent here is still correct?
>
> Just want to make sure that's still needed with the call to put_device.
The manual put_device on the parent is not correct.
This should be removed for here. we should call
put_device(&iface->dev) only and It'll released
parent reference.

> Other than that question, I this all looks good.
> Thanks.
>
> Signed-off-by: Chris Leech <cleech@redhat.com>
>

~arvind
