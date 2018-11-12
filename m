Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D5D224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D5D224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeKMEmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:42:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728431AbeKMEmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:42:55 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 27D4CEBE9A909;
        Tue, 13 Nov 2018 02:48:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 02:48:14 +0800
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
To:     Joe Perches <joe@perches.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
 <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
 <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
 <3b62b0ad-53ba-37c2-817c-591d94eed838@huawei.com>
 <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
Date:   Mon, 12 Nov 2018 18:48:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 18:30, Joe Perches wrote:
> On Mon, 2018-11-12 at 17:55 +0000, John Garry wrote:
>> On 12/11/2018 17:49, John Garry wrote:
>>> On 12/11/2018 17:32, Joe Perches wrote:
>>>> On Tue, 2018-11-13 at 01:28 +0800, John Garry wrote:
>>>>> Not all host drivers are PCI drivers - like hisi_sas, which supports a
>>>>> platform driver - so remove reference to "pcidev".
>>>>>
>>>>> The debug level is also downgraded to KERN_ERR for the same message.
>>>> []
>>>>> diff --git a/drivers/scsi/libsas/sas_discover.c
>>>>> b/drivers/scsi/libsas/sas_discover.c
>>>> []
>>>>> @@ -186,7 +186,7 @@ int sas_notify_lldd_dev_found(struct
>>>>> domain_device *dev)
>>>>>
>>>>>      res = i->dft->lldd_dev_found(dev);
>>>>>      if (res) {
>>>>> -        printk("sas: driver on pcidev %s cannot handle "
>>>>> +        pr_err("sas: driver on host %s cannot handle "
>>>>>                 "device %llx, error:%d\n",
>>>>
>>>> As a printk without a KERN_<LEVEL> is printed at whatever
>>>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT is set to (default: 4 and
>>>> rarely unchanged), this is effectively upgraded from a
>>>> KERN_WARNING to KERN_ERR.
>>>
>>> ah, I thought that it was printed always.
>>>
>>> So maybe I'll just leave as-is.
>>
>> I forgot to mention that checkpatch complains about using printk() -
>> that's why I changed it.
>
> I believe that always assigning a KERN_<LEVEL>
> is good thing so I am not against this change.
>
> Describing the change a bit more correctly than
> 'debug level downgraded' would be useful.
>

Right

> My preference is a patch like this which
> always prefixes "sas: " to each log message
> by adding a #define pr_fmt and converts the
> bare printks to pr_notice, and converts the
> slightly odd sas_printk macro and uses with
> a hidden KERN_NOTICE to pr_notice.
>
> ---
>  drivers/scsi/libsas/sas_discover.c |  9 ++++-----
>  drivers/scsi/libsas/sas_expander.c | 33 ++++++++++++++++-----------------
>  drivers/scsi/libsas/sas_init.c     | 10 +++++-----
>  drivers/scsi/libsas/sas_internal.h |  5 ++++-
>  drivers/scsi/libsas/sas_phy.c      | 10 +++++-----
>  drivers/scsi/libsas/sas_port.c     |  3 +--
>  6 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index dde433aa59c2..193d7a1ebeb3 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -128,7 +128,8 @@ static int sas_get_port_device(struct asd_sas_port *port)
>  					  SAS_FANOUT_EXPANDER_DEVICE);
>  		break;
>  	default:

[ ... ]

This all seems reasonable

>  		} else {
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 50e12d662ffe..263cb41853c2 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -32,7 +32,10 @@
>  #include <scsi/libsas.h>
>  #include <scsi/sas_ata.h>
>
> -#define sas_printk(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt) "sas: " fmt

Some other subsystem may try to include this header, and gets its 
message prefix overwritten. Just a consequence for doing something bad, 
right?

>
>  #define SAS_DPRINTK(fmt, ...) printk(KERN_DEBUG "sas: " fmt, ## __VA_ARGS__)
>
> diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
> index bf3e1b979ca6..d628c0e6289d 100644
> --- a/drivers/scsi/libsas/sas_phy.c
> +++ b/drivers/scsi/libsas/sas_phy.c
> @@ -122,11 +122,11 @@ static void sas_phye_shutdown(struct work_struct *work)
>  		phy->enabled = 0;
>  		ret = i->dft->lldd_control_phy(phy, PHY_FUNC_DISABLE, NULL);
>  		if (ret)
> -			sas_printk("lldd disable phy%02d returned %d\n",
> -				phy->id, ret);
> -	} else
> -		sas_printk("phy%02d is not enabled, cannot shutdown\n",
> -			phy->id);
> +			pr_notice("lldd disable phy%02d returned %d\n",
> +				  phy->id, ret);
> +	} else {
> +		pr_notice("phy%02d is not enabled, cannot shutdown\n", phy->id);
> +	}
>  }
>
>  /* ---------- Phy class registration ---------- */
> diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
> index fad23dd39114..f2a25cef85b7 100644
> --- a/drivers/scsi/libsas/sas_port.c
> +++ b/drivers/scsi/libsas/sas_port.c
> @@ -147,8 +147,7 @@ static void sas_form_port(struct asd_sas_phy *phy)
>  	}
>
>  	if (i >= sas_ha->num_phys) {
> -		printk(KERN_NOTICE "%s: couldn't find a free port, bug?\n",
> -		       __func__);
> +		pr_notice("%s: couldn't find a free port, bug?\n", __func__);
>  		spin_unlock_irqrestore(&sas_ha->phy_port_lock, flags);
>  		return;
>  	}
>
>
>
> .
>


