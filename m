Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELsJwxdfN3VpB1GJwro7ijpMZsCy/9gopIyuQKbL+czCBiai2l1AH6IOZmHuP5Gep77HOZKa
ARC-Seal: i=1; a=rsa-sha256; t=1519708596; cv=none;
        d=google.com; s=arc-20160816;
        b=kErjk4Cn/Ub82/EVZLne8CqNQX1kPFMnVsCdLEwXXW8KS6EW+/XQYkHuT6WChG92NH
         s0rQpSk9VkTzoYF8WIL+i4FnAmUE7X4fUoXD5NTV88FA9nqQd/eAQhlUHOhyBWpOR7Tf
         wzrSSyU5Ke7m4ItXidMHVyFB7yg5LLu542q+MoCv6gBaBZpZSO697VTbZNi10P6qQBVd
         ZvX9irSUHCs2yK7/aZ8Bpc5GhaeCWJpJv5X9Tc4kv9NTjk3rKkHNLvjkpFMweHQ3osCJ
         A68jPxrTHTiFMpTWk++RKz92UvRjsoCLvUD6MMIdfs+dXG00yYtDMClfsJ+AggSLGO5O
         5ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=1++SVcz9cTo1mTnyxHvKjf2Tt48gbXRlttO6GVImAr4=;
        b=sSNCr6+mikkpfWXO9k+FwBC15D4pYMHWj4Fq+jxruPnWw3gCrGy+f0fQJHEY3my9sQ
         msb+sUW8FotTXpEI54CsmFCHmuxFWc8SR8Rqb9JVYgFcGGE3vVU5k5dLZIXKiOVw/f2e
         FKR80YEI0/fEyV9tqYgJbksDkngs8s5agrWtsdl5Ebiwl0XiisfochZNRaGpCZ7n0pVd
         I+uwBdIqM9Q0GGH4tV07MnR+LukodA+9Yvz0kPkGO2wlYy+BqYT9uXoI+nZyEUXydao+
         GsZHEwe46oeuWggpIpa/2LiqD7Lazd7/za4e2h2ycfrm7EZWXcMbrSYM0Z0ErmIPKwMN
         ZIgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BL/0WHTK;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fdwUZsr/;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BL/0WHTK;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fdwUZsr/;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Feb 2018 10:46:34 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 3/7] PCI/ERR: add mutex to synchronize recovery
In-Reply-To: <20180223234525.GQ14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-4-git-send-email-poza@codeaurora.org>
 <20180223234525.GQ14632@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <34e4c9a98a9ed3494a0295d00e181fe9@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593529961250695535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-24 05:15, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2018 at 01:54:00PM +0530, Oza Pawandeep wrote:
>> This patch protects pci_do_recovery with mutex.
> 
> pcie_do_recovery()
> 
> Please explain why the mutex is necessary.  What bad things happen
> without the mutex?
> 
> You named (some) of the other things "pcie"; maybe use "pcie" in the
> mutex name as well so they look the same.
> 

PCIe specification: 6.2.10
When DPC is triggered due to receipt of an uncorrectable error Message, 
the Requester ID from the Message is recorded in the DPC Error Source ID 
register and that Message is discarded and not forwarded Upstream.

So, having said that, what we think is we dont need Mutex, because in 
DPC enabled system either AER or DPC can be triggered, not both.
so right now there is no need of guarding pcie_do_recovery() with mutex.

but I was in a thought that; since pcie_do_recovery is supposed to be 
used by error clients,
from sw architecture point of view, adding mutex takes care of 
concurrency if it exists (in corner cases, faulty hw where both AER and 
DPC triggered etc..)

We can choose to drop this patch, since we dont require mutex.
Bjorn, please advise.


>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> index fcd5add..f830975 100644
>> --- a/drivers/pci/pcie/pcie-err.c
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -20,6 +20,8 @@
>>  #include <linux/pcieport_if.h>
>>  #include "portdrv.h"
>> 
>> +static DEFINE_MUTEX(pci_err_recovery_lock);
>> +
>>  struct aer_broadcast_data {
>>  	enum pci_channel_state state;
>>  	enum pci_ers_result result;
>> @@ -283,6 +285,8 @@ void pcie_do_recovery(struct pci_dev *dev, int 
>> severity)
>>  	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
>>  	enum pci_channel_state state;
>> 
>> +	mutex_lock(&pci_err_recovery_lock);
>> +
>>  	if (severity == AER_FATAL)
>>  		state = pci_channel_io_frozen;
>>  	else
>> @@ -326,9 +330,11 @@ void pcie_do_recovery(struct pci_dev *dev, int 
>> severity)
>>  				report_resume);
>> 
>>  	dev_info(&dev->dev, "Device recovery successful\n");
>> +	mutex_unlock(&pci_err_recovery_lock);
>>  	return;
>> 
>>  failed:
>>  	/* TODO: Should kernel panic here? */
>>  	dev_info(&dev->dev, "Device recovery failed\n");
>> +	mutex_unlock(&pci_err_recovery_lock);
>>  }
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
