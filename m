Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbeEAKPI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:15:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeEAKPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:15:06 -0400
Subject: Re: [PATCH 2/7] genirq/msi: Limit level-triggered MSI to platform
 devices
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20180423103440.26592-1-marc.zyngier@arm.com>
 <20180423103440.26592-3-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1804262148420.1596@nanos.tec.linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <7528a81e-f391-3bae-7ad0-6132f44d5a70@arm.com>
Date: Tue, 1 May 2018 11:15:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804262148420.1596@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/18 20:50, Thomas Gleixner wrote:
> On Mon, 23 Apr 2018, Marc Zyngier wrote:
> 
>> Nobody would be insane enough to try and use level triggered
>> MSIs on PCI, but let's make sure it doesn't happen. Also,
>> let's mandate that the irqchip backing the platform MSI domain
>> is providing an irq_set_type method (or the whole thing would
>> be a bit useless).
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/base/platform-msi.c | 3 +++
>>  drivers/pci/msi.c           | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
>> index 8e22073aeeed..3b9694a6beaa 100644
>> --- a/drivers/base/platform-msi.c
>> +++ b/drivers/base/platform-msi.c
>> @@ -101,6 +101,9 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
>>  		chip->irq_set_affinity = msi_domain_set_affinity;
>>  	if (!chip->irq_write_msi_msg)
>>  		chip->irq_write_msi_msg = platform_msi_write_msg;
>> +	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
>> +		    !chip->irq_set_type))
> 
> Shouldn't we just require something like IRQCHIP_SUPPORTS_MSI_LEVEL or such
> in chip->flags being set instead?
That definitely makes sense. Thanks for the suggestion.

	M.
-- 
Jazz is not dead. It just smells funny...
