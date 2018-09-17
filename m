Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C70ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DF1214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DF1214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeIQMD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:03:28 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:41646 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbeIQMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:03:28 -0400
X-Greylist: delayed 796 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 08:03:27 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w8H6NRpQ009070
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 08:23:27 +0200
Received: from [139.22.44.236] ([139.22.44.236])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w8H6NR3Z012693;
        Mon, 17 Sep 2018 08:23:27 +0200
Subject: Re: [PATCH] arm: Initialize hrtimer-based broadcast clockevent
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jailhouse <jailhouse-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <86a7e675-11bd-3b8b-22a0-8f440db96293@siemens.com>
 <8f2fd3b9-416a-992e-5ca6-fc83aad5700d@siemens.com>
 <35966a15-8312-5ba9-ef76-33a6cfda1f32@siemens.com>
 <e24a907f-d016-5587-a62e-0046f60d9536@siemens.com>
Message-ID: <a9ed1dab-2020-6244-7b9f-a283812e842d@siemens.com>
Date:   Mon, 17 Sep 2018 08:23:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <e24a907f-d016-5587-a62e-0046f60d9536@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.18 07:42, Jan Kiszka wrote:
> On 2018-04-04 17:54, Jan Kiszka wrote:
>> On 2018-03-01 07:04, Jan Kiszka wrote:
>>> On 2018-01-22 07:06, Jan Kiszka wrote:
>>>> Analogously to 9358d755bd5c, this registers a broadcast clockevent in
>>>> case no hardware broadcast timer is available and the per-CPU timers can
>>>> be stopped in deep power states.
>>>>
>>>> Partitions of the Jailhouse hypervisor fall in this category.
>>>> Registering the workaround timer allows to enter high-resolution mode in
>>>> that case.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>   arch/arm/kernel/time.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>>>> index 629f8e9981f1..0a45d861ef8e 100644
>>>> --- a/arch/arm/kernel/time.c
>>>> +++ b/arch/arm/kernel/time.c
>>>> @@ -12,6 +12,7 @@
>>>>    *  reading the RTC at bootup, etc...
>>>>    */
>>>>   #include <linux/clk-provider.h>
>>>> +#include <linux/clockchips.h>
>>>>   #include <linux/clocksource.h>
>>>>   #include <linux/errno.h>
>>>>   #include <linux/export.h>
>>>> @@ -121,5 +122,7 @@ void __init time_init(void)
>>>>   		of_clk_init(NULL);
>>>>   #endif
>>>>   		timer_probe();
>>>> +
>>>> +		tick_setup_hrtimer_broadcast();
>>>>   	}
>>>>   }
>>>>
>>>
>>> Gentle ping, just to avoid that this falls through the cracks because
>>> it's so small.
>>>
>>
>> 2nd ping. Should this patch be routed via ARM or rather some tip/timers
>> tree?
>>
> 
> 3rd try: Could someone have a look at this and merge it - or at least
> ack it in order to move forward?
> 

Still no reactions, so I'm kindly reminding of this patch again.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
