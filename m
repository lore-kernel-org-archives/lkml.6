Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C782184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfACUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:32:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56688 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACUcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:32:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063DBEBD;
        Thu,  3 Jan 2019 12:32:48 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AE393F575;
        Thu,  3 Jan 2019 12:32:46 -0800 (PST)
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     mark.rutland@arm.com, julien.thierry@arm.com, mlangsdo@redhat.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, shankerd@codeaurora.org,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103163740.GC3529@e103592.cambridge.arm.com>
 <db5968e6-609b-1a1f-464d-436327dd1738@arm.com>
 <1951199845.271163.1546543806398@email.ionos.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5818faa8-e820-7aee-5aaa-42ced65d6f9d@arm.com>
Date:   Thu, 3 Jan 2019 14:32:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1951199845.271163.1546543806398@email.ionos.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/2019 01:30 PM, Stefan Wahren wrote:
> Hi Jeremy,
> 
>> Jeremy Linton <jeremy.linton@arm.com> hat am 3. Januar 2019 um 17:46 geschrieben:
>>
>>
>> Hi,
>>
>> On 01/03/2019 10:37 AM, Dave Martin wrote:
>>> On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
>>>> There is a lot of variation in the Arm ecosystem. Because of this,
>>>> there exist possible cases where the kernel cannot authoritatively
>>>> determine if a machine is vulnerable.
>>>>
>>>> Rather than guess the vulnerability status in cases where
>>>> the mitigation is disabled or the firmware isn't responding
>>>> correctly, we need to display an "Unknown" state.
>>>>
> 
> i applied your patch series on linux-next-20190103. On my Raspberry Pi 3B+ (defconfig) i'm getting this from sysfs:
> 
> l1tf:Not affected
> meltdown:Not affected
> spec_store_bypass:Unknown
> spectre_v1:Mitigation: __user pointer sanitization
> spectre_v2:Unknown
> 
> AFAIK it has 4 Cortex-A53 cores (no PSCI firmware), so shouldn't be affected.

So, for spec_store_bypass, as you noted your getting hit by the lack of 
psci/smccc to report the ssb state, and this patch is just reflecting that.

In the case of spectrev2 it may be correct to blame this patch set 
because its displaying "unknown" since your core isn't in the black 
list, and your core isn't new enough to have the csv2 bit indicating its 
not vulnerable. In this case if we do away with the unknown state, we 
should probably depend entirely on the black list and simply display 
"Not affected" if the core isn't listed. (meaning we may report cores 
not affected when they are missing from the blacklist).


> How can this be fixed?

For ssb, the correct answer is probably fix the firmware, but given the 
situation, its likely this kind of machine is going to force an 
additional MIDR list to report the state correctly. Maybe Will or 
someone can chime in here?

For spectrev2, wait for another version of this patch.

