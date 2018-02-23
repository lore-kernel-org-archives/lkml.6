Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224F93RkQd//9jhi3Idciloo8ENg3D/H+HZNDNqZeUBsvA6KFcgJZQytHTQNj3djtsqR5Mp2
ARC-Seal: i=1; a=rsa-sha256; t=1519367784; cv=none;
        d=google.com; s=arc-20160816;
        b=M/pkjm5gpv0dv1/zd8O3nYXKWkTm9KIc8b9hc6IK7VT2clETsMCr6OEwwfOE4W0An5
         BJXeQTD+p3S+h/ELf++LaES7+f4xUj9bSwSyfjPyHU+LsiIKqpfG5qRTlJ4QdsggQVEX
         g/DYeAlZRWPeXI+tVfX7SIM3RuP02Doj5TW5iTD7w74Rd7hI0bso4rmQKt8X4yEW1QF4
         3/Y+5P+6iUPLLwfGoOR15qiEe6V4SImen9oU2460fPqQV3nYyrRJJE3qVBkQcdvWh+WQ
         Se+q+eiojum0VCNudzlJS9Rdv/fO4hjTSerQ/YlOW/cKUmcSkShwwlNyxXcuRGWPMsGf
         kjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=/gChZMCEEKlSG5QhKcgnEiIpRfkH5BPX73snWDCd0Go=;
        b=hAf3tj10xgfkHpq6zUxdTFiGCxSPkbas6ZhqNatpQLsglS62raFXkN1Gy0u4JUG9iO
         sXR/+sd87J7nG+3BqEZOqnpjAUJ+OkSldjnk6sNg8CugPghZ4FsEz95M7M311eXPXqdv
         0RXquZaYZTGpLw2wsoiLtHyvID5PojSWQgvCYiVUZcSDHTPIbzlzAd8QDdWJSaSRAsV0
         /NyDCLr1lPZv0tUzb2mzggeYw8v3/iaT0bApQkyJj4Ke0fwLCxWMawulxe3WNcA0HCol
         3VYeHaZF9BE0o/jE/KoanKh7ZYtKxjmXBLdG7zoZU7S+lRa0f2IRpqhJtqt8hY24YG7V
         uSrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VY7ErGJb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Rnsmx/WU;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VY7ErGJb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Rnsmx/WU;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 12:06:22 +0530
From: poza@codeaurora.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v9 2/7] PCI/AER: factor out error reporting from AER
In-Reply-To: <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-3-git-send-email-poza@codeaurora.org>
 <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
Message-ID: <e01365a3fa319d6367af546f3be50903@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086410511514158?=
X-GMAIL-MSGID: =?utf-8?q?1593172593632048648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:53, Randy Dunlap wrote:
> On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
> 
> Hi,
> Just minor stuff:
> 
>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> new file mode 100644
>> index 0000000..a532fe0
>> --- /dev/null
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -0,0 +1,334 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * This file implements the error recovery as a core part of PCIe 
>> error reporting.
>> + * When a PCIe error is delivered, an error message will be collected 
>> and printed
>> + * to console, then, an error recovery procedure will be executed by 
>> following
>> + * the PCI error recovery rules.
>> + *
>> + * Copyright (C) 2006 Intel Corp.
>> + *	Tom Long Nguyen (tom.l.nguyen@intel.com)
>> + *	Zhang Yanmin (yanmin.zhang@intel.com)
>> + *
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/aer.h>
>> +#include <linux/pcieport_if.h>
>> +#include "portdrv.h"
> 
>> +static int report_error_detected(struct pci_dev *dev, void *data)
>> +{
>> +	pci_ers_result_t vote;
>> +	const struct pci_error_handlers *err_handler;
>> +	struct aer_broadcast_data *result_data;
>> +
>> +	result_data = (struct aer_broadcast_data *) data;
>> +
>> +	device_lock(&dev->dev);
>> +	dev->error_state = result_data->state;
>> +
>> +	if (!dev->driver ||
>> +		!dev->driver->err_handler ||
>> +		!dev->driver->err_handler->error_detected) {
>> +		if (result_data->state == pci_channel_io_frozen &&
>> +			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>> +			/*
>> +			 * In case of fatal recovery, if one of down-
>> +			 * stream device has no driver. We might be
>> +			 * unable to recover because a later insmod
>> +			 * of a driver for this device is unaware of
>> +			 * its hw state.
>> +			 */
>> +			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
>> +				   dev->driver ?
>> +				   "no error-aware driver" : "no driver");
> 
> or:
> 			dev_printk(KERN_DEBUG, &dev->dev, "device has no%s driver\n",
> 				   dev->driver ? " error-aware" : "");
> 

I might not be able to take care of this, because all the later patches
are dependent on this, and probably I might have to manually merge.
though I will give it a try :)

>> +		}
>> +
>> +		/*
>> +		 * If there's any device in the subtree that does not
>> +		 * have an error_detected callback, returning
>> +		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
>> +		 * the subsequent mmio_enabled/slot_reset/resume
>> +		 * callbacks of "any" device in the subtree. All the
>> +		 * devices in the subtree are left in the error state
>> +		 * without recovery.
>> +		 */
>> +
>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>> +		else
>> +			vote = PCI_ERS_RESULT_NONE;
>> +	} else {
>> +		err_handler = dev->driver->err_handler;
>> +		vote = err_handler->error_detected(dev, result_data->state);
>> +	}
>> +
>> +	result_data->result = merge_result(result_data->result, vote);
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
> 
>> +/**
>> + * broadcast_error_message - handle message broadcast to downstream 
>> drivers
>> + * @dev: pointer to from where in a hierarchy message is broadcasted 
>> down
> 
>             I would drop ^^ "from" ...                   is broadcast 
> downstream
> 
>> + * @state: error state
>> + * @error_mesg: message to print
>> + * @cb: callback to be broadcasted
> 
>                     to be broadcast
> 
>> + *
>> + * Invoked during error recovery process. Once being invoked, the 
>> content
>> + * of error severity will be broadcasted to all downstream drivers in 
>> a
> 
>                         will be broadcast
> 
>> + * hierarchy in question.
>> + */
>> +static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>> +	enum pci_channel_state state,
>> +	char *error_mesg,
>> +	int (*cb)(struct pci_dev *, void *))
>> +{
>> +	struct aer_broadcast_data result_data;
