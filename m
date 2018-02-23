Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225KM9V4vnIZy+oGMZBGMnDhQKgyqL1V4IAU4UlNYP4TY4QjDr2RwLOjjIOs/M3ggRB+t43t
ARC-Seal: i=1; a=rsa-sha256; t=1519367488; cv=none;
        d=google.com; s=arc-20160816;
        b=THz95SftzEStBTvKeTQLVsacCt1AbadjlAngS36ImlEK/nsfkp6ATar/bQWCBz0Shp
         ltb53n9FbZrRw+eo/9DNChxg09KMLtGcw8DAS+Xqv0HMwhtt/2ebKxJMNwW3iRZ2gRuF
         GhLdHyjQfUg8po6uhdCXDD82dlP7ESRWldi73+6jt0d+JlFdylgmPKsiUlkPycag1pPY
         pzGnPzGrRH0B2VzfTUMUtRmpWK913e4wzAkVWDFsv8dlbjNUKTd83rqXZ7rvdFjNHeZL
         JnOmhDHQzxC4ZCeZtO3HAUtZtAljI2zaiBWHib3GB/1hDXHhzC11L3JsyacKIVnRarTt
         bJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=dLaDwN9yLizt6V9Ceq/djIuMLyPeZaUoQqow1AM+ywM=;
        b=SvkwHPQy8/cjsl4kriibDDtFa5jEnzlp21inNinRNqKcZ6Rq9sQXTU67V5zr2Xvo37
         2577Yw9njnqNHtbmwAEPMgp8ShYqozqsTOsOEaEB22vGPl5yEPNRnRRYOnJ8lu94h6DA
         MB480zCKz4Dbwjm3WkHjSUh6Yp+rdBo5DDqYrFZGk9CDsFVs4AfocpnMt9+4ZY4evc/R
         tPvROdl3JBaCGxN2E+1KV9R0tjRGkPhCJWSKyZjU2u31sPsiMNsp8D9albTOU/T9eNWE
         TDXzzKugRbk1QWsXB2IfCqrpLElNFqNf1G1PpsKP/x9DXG8ZDnrtJkZLGUtr+e3iPAhN
         gbLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YpjGI9jm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WbPAeFiB;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YpjGI9jm;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WbPAeFiB;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 12:01:26 +0530
From: poza@codeaurora.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 2/7] PCI/AER: factor out error reporting from AER
In-Reply-To: <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-3-git-send-email-poza@codeaurora.org>
 <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
Message-ID: <412cdd104d1e1cd1ca7e0d873c4b5a7b@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086410511514158?=
X-GMAIL-MSGID: =?utf-8?q?1593172283110449334?=
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


Thanks for the comments, will take care of it.
