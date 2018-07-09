Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C60CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AB32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AB32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeGIMgL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:36:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932609AbeGIMgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:36:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDA9ED1;
        Mon,  9 Jul 2018 05:36:09 -0700 (PDT)
Received: from [10.1.211.34] (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1963F5AD;
        Mon,  9 Jul 2018 05:36:08 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
Date:   Mon, 9 Jul 2018 13:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 13:17, Michal Simek wrote:
> Hi Sudeep,
> 
> On 2.5.2018 12:30, Sudeep Holla wrote:
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
>> v1->v2:
>> 	- Added mising static anotation to psci_system_reset2_supported
>> 	- Added missing ')' in the comment
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index c80ec1d03274..91748725534e 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>
>>  static u32 psci_cpu_suspend_feature;
>> +static bool psci_system_reset2_supported;
>>
>>  static inline bool psci_has_ext_power_state(void)
>>  {
>> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
>>
>>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>  {
>> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> 
> I am curious about this reboot_mode setup. I have grepped the kernel and
> reboot_mode is setup via kernel parameters at boot time.
> Shouldn't user decide what reboot type wants to do?
> 

I have almost forgotten how I tested this. IIRC and looking quickly @
kernel/reboot.c and __setup(reboot=,...), I recall passing reboot=w
while testing this. We can do something like what efi_reboot, but not
sure if we need that yet if users need too decide after boot.

-- 
Regards,
Sudeep
