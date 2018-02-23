Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227eRlPDaueGNEvITVf45hRDAzdtmiQFZIGFcrontyrTelElfdd87aPivKHHW9pVzChlzkWQ
ARC-Seal: i=1; a=rsa-sha256; t=1519363736; cv=none;
        d=google.com; s=arc-20160816;
        b=xCsElrMwmt+B/jytScmV6oDtm76t5zxX+o/ZK4eteRIf5dXX/NBBtzzMGckJWkR6Uy
         3RQQi6ZZZqhjL9HCDO+jtm1ffMBO+2OPVq2BzMM5sBHtjVxYZmLztVqOox+GftkS8/jm
         icbvReJoe26PkLsK2BsNlS0tM9x9pGuh7PUUeTB3/xHTrJP8keHcon06LMlQfxBSIDtL
         B3QdSoAUcldzg9yBiO0GIhdxR0VtCIwiSDchTboWKdzp0Og4hd30gQMMYG8hyhOleatE
         9FOoMjj8h5epudjp2m86r79vsrzXUKTxJtXbwwcbvHDRn4SHHvkjoYJLfiqBhibFyMa9
         oyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=oDfGhiuod3fkGEXpvxbQPFyJHZy9f9mvi3RbxktaXKo=;
        b=qN0P7Gv457kRk0i5UH4zDpBvwYpRD0yLGUG0y4Zi5zbFK47L5wlqbQ0tOz5w5dugg0
         ch2IYCWIoJaFutsixEG7Wi0tdX4FdLkeo8StOFF0winG1Ko8FM8CSV0Tk0Nm/Amby1b3
         V6MGJY93Pvl2TYhcvEjltBkto5GE5zfN50q569R+XoytjBojdjRBYCs+ANPces/QhCjA
         H7dFL8F9hByq6+QhbikDkOS1r1I0jBdNac7zGVzs5jU7mybTlQjDJFjyhT0UAEN4O1Qx
         mTDIp42HX/OggtDstjikrf9rJT4Mnu8p1RjD3UvOnTpJ2P8by89KmYDzPMYLs6gf/y8f
         4y9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H64eYVpJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PZ/pArLD;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H64eYVpJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PZ/pArLD;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 10:58:54 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v10 4/7] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <20180222183954.GD6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-5-git-send-email-poza@codeaurora.org>
 <20180222183954.GD6267@infradead.org>
Message-ID: <29cde9310bb4977ab10c747d104dcb21@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086415695868818?=
X-GMAIL-MSGID: =?utf-8?q?1593168348446753856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:09, Christoph Hellwig wrote:
> On Thu, Feb 22, 2018 at 09:32:09PM +0530, Oza Pawandeep wrote:
>> Current DPC driver does not do recovery, e.g. calling end-point's 
>> driver's
>> callbacks, which sanitize the sw.
>> 
>> DPC driver implements link_reset callback, and calls pci_do_recovery.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a5a79f0..124f42e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -343,6 +343,8 @@ static inline resource_size_t 
>> pci_resource_alignment(struct pci_dev *dev,
>>  void pci_enable_acs(struct pci_dev *dev);
>> 
>>  /* PCI error reporting and recovery */
>> +#define DPC_FATAL	4
>> +
>>  void pci_do_recovery(struct pci_dev *dev, int severity);
>> 
>>  #ifdef CONFIG_PCIEASPM
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index 38e40c6..208b427 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/pcieport_if.h>
>>  #include "../pci.h"
>>  #include "aer/aerdrv.h"
>> +#include "portdrv.h"
>> 
>>  struct dpc_dev {
>>  	struct pcie_device	*dev;
>> @@ -45,6 +46,60 @@ struct dpc_dev {
>>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>>  };
>> 
>> +static int find_dpc_dev_iter(struct device *device, void *data)
>> +{
>> +	struct pcie_port_service_driver *service_driver;
>> +	struct device **dev;
>> +
>> +	dev = (struct device **) data;
>> +
>> +	if (device->bus == &pcie_port_bus_type && device->driver) {
>> +		service_driver = to_service_driver(device->driver);
> 
> Please move the initial assignment to the declaration line to
> clean this up a bit:
> 
> 	struct device **dev = (struct device **)data;
> 
> Same thing happens a couple more times in this patch.
> 
>> +EXPORT_SYMBOL(pci_find_dpc_service);
> 
> EXPORT_SYMBOL_GPL for PCI layer internals again - and ditto for
> probably about everything in this series.

will take care of all these comments.

> 
>>  #if IS_ENABLED(CONFIG_PCIEAER)
>> -	/* Use the aer driver of the component firstly */
>> -	driver = pci_find_aer_service(udev);
>> +	if ((severity == AER_FATAL) ||
>> +	    (severity == AER_NONFATAL) ||
>> +	    (severity == AER_CORRECTABLE))
>> +		driver = pci_find_aer_service(udev);
>>  #endif
> 
> No need for the inner braces here.
> 
>> -	if (severity == AER_FATAL)
>> +	if ((severity == AER_FATAL) ||
>> +	    (severity == DPC_FATAL))
>>  		state = pci_channel_io_frozen;
>>  	else
>>  		state = pci_channel_io_normal;
> 
> Same here and a few more times below.

will take care
Thanks,
Oza.
