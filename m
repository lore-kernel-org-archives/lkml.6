Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030410AbeCAMaD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:30:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030328AbeCAMaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:30:01 -0500
Subject: Re: [PATCH v7 1/3] irqchip/gic-v3-its: add ability to save/restore
 ITS state
To: Mark Rutland <mark.rutland@arm.com>,
        Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com,
        sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, briannorris@chromium.org
References: <20180301054820.42847-1-dbasehore@chromium.org>
 <20180301054820.42847-2-dbasehore@chromium.org>
 <20180301114144.nmwu4qtslvj7ogj5@lakrids.cambridge.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <0a74f87a-027a-df7d-ca2d-fc164ec9cdf7@arm.com>
Date: Thu, 1 Mar 2018 12:29:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301114144.nmwu4qtslvj7ogj5@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 01/03/18 11:41, Mark Rutland wrote:
> On Wed, Feb 28, 2018 at 09:48:18PM -0800, Derek Basehore wrote:
>> Some platforms power off GIC logic in suspend, so we need to
>> save/restore state. The distributor and redistributor registers need
>> to be handled in platform code due to access permissions on those
>> registers, but the ITS registers can be restored in the kernel.
>>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> 
> How much state do we have to save/restore?
> 
> Given we can apparently read all this state, couldn't we *always* save
> the state, then upon resume detect if the state has been lost, restoring
> it if so?
> 
> That way, we don't need a property in FW tables for DT or ACPI.

That's a good point. I guess that we could just compare the saved
GITS_CTLR register and restore the full state only if the ITS comes back
as disabled.

I'm just a bit worried that it makes it an implicit convention between
kernel an FW, which could change in funny ways. Importantly, the PSCI
spec says states FW should restore *the whole state*. Obviously, it
cannot to that on HW that doesn't allow you to read out the state, hence
the DT flag that outlines the departure from the expected behaviour.

I'm happy to go either way, but then I have the feeling that we should
go back to quirking it on the actual implementation (GIC500 in this
case) if we're to from the property.

> 
> [...]
> 
>> @@ -3261,6 +3363,9 @@ static int __init its_probe_one(struct resource *res,
>>  		ctlr |= GITS_CTLR_ImDe;
>>  	writel_relaxed(ctlr, its->base + GITS_CTLR);
>>  
>> +	if (fwnode_property_present(handle, "reset-on-suspend"))
>> +		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
> 
> Does this allow this property on an ACPI system?
> 
> If we need this on ACPI, we need a spec update to handle this properly,
> and shouldn't use device properties like this.

Well spotted. I guess that dropping the property would fix that
altogether, assuming we feel that the above is safe enough.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
