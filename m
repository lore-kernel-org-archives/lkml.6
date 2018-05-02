Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeEBKUp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:20:45 -0400
Received: from foss.arm.com ([217.140.101.70]:56674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeEBKUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:20:44 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: add support for SYSTEM_RESET2
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <ef2f0c7c-eb2d-157d-e215-ced1ce984aa5@gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <95af7f71-c68e-5312-16ce-08dcd6f0bec6@arm.com>
Date: Wed, 2 May 2018 11:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef2f0c7c-eb2d-157d-e215-ced1ce984aa5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/18 18:59, Florian Fainelli wrote:
> On 05/01/2018 07:51 AM, Sudeep Holla wrote:
>> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
>> where the semantics are described by the PSCI specification itself as
>> well as vendor-specific resets. Currently only system warm reset
>> semantics is defined as part of architectural resets by the specification.
>>
>> This patch implements support for SYSTEM_RESET2 by making using of
>> reboot_mode passed by the reboot infrastructure in the kernel.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>>  include/uapi/linux/psci.h |  2 ++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index c80ec1d03274..216b1950bbd5 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>
>>  static u32 psci_cpu_suspend_feature;
>> +bool psci_system_reset2_supported;
> 
> Should this be static? It does not appear to be used in another
> translation unit.
> 

Indeed will fix it.

>>
>>  static inline bool psci_has_ext_power_state(void)
>>  {
>> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
>>
>>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>  {
>> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>> +	    psci_system_reset2_supported)
>> +		/*
>> +		 * reset_type[31] = 0 (architectural)
>> +		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
>> +		 * cookie = 0 (ignored by the implementation
> 
> Missing closing parenthesis
>

Yes I saw this soon after I sent out, already fixed locally.

-- 
Regards,
Sudeep
