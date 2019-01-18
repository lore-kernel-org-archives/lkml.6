Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CCBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfARQbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:31:03 -0500
Received: from foss.arm.com ([217.140.101.70]:33502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfARQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:31:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB4BEBD;
        Fri, 18 Jan 2019 08:31:02 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E593F557;
        Fri, 18 Jan 2019 08:31:00 -0800 (PST)
Subject: Re: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to
 select vulnerabilities
To:     Greg KH <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, marc.zyngier@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        Steven.Price@arm.com, stefan.wahren@i2se.com, rafael@kernel.org,
        tglx@linutronix.de, jpoimboe@redhat.com, konrad.wilk@oracle.com,
        mingo@kernel.org, longman@redhat.com, ak@linux.intel.com,
        jkosina@suse.cz
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-2-jeremy.linton@arm.com>
 <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
 <20190118154637.GA8564@kroah.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <988ddbc9-ae46-22cc-4228-5f1ea98605c1@arm.com>
Date:   Fri, 18 Jan 2019 10:31:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190118154637.GA8564@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/2019 09:46 AM, Greg KH wrote:
> On Mon, Jan 14, 2019 at 10:02:21AM +0000, Suzuki K Poulose wrote:
>>
>>
>> On 09/01/2019 23:55, Jeremy Linton wrote:
>>> As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
>>> a number of cases where its useful for a system to avoid exporting a
>>> sysfs entry for a given vulnerability. This set adds an architecture
>>> specific callback which returns the bitmap of vulnerabilities the
>>> architecture would like to advertise.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>> ---
>>>    drivers/base/cpu.c  | 19 +++++++++++++++++++
>>>    include/linux/cpu.h |  7 +++++++
>>>    2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>>> index eb9443d5bae1..35f6dfb24cd6 100644
>>> --- a/drivers/base/cpu.c
>>> +++ b/drivers/base/cpu.c
>>> @@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
>>>    	NULL
>>>    };
>>> +uint __weak arch_supported_vuln_attr_fields(void)
>>> +{
>>> +	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
>>> +}
>>> +
>>>    static const struct attribute_group cpu_root_vulnerabilities_group = {
>>>    	.name  = "vulnerabilities",
>>>    	.attrs = cpu_root_vulnerabilities_attrs,
>>> @@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
>>>    static void __init cpu_register_vulnerabilities(void)
>>>    {
>>> +	int fld;
>>> +	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
>>> +	struct attribute **hd = cpu_root_vulnerabilities_attrs;
>>> +	uint enabled_fields = arch_supported_vuln_attr_fields();
>>> +
>>> +	/* only enable entries requested by the arch code */
>>> +	for (fld = 0; fld < max_fields; fld++) {
>>> +		if (enabled_fields & 1 << fld) {
>>> +			*hd = cpu_root_vulnerabilities_attrs[fld];
>>> +			hd++;
>>> +		}
>>> +	}
>>> +	*hd = NULL;
>>> +
>>
>> nit: Could we use "is_visible" callback in the attribute group to check this
>> dynamically ?
> 
> You should, that is what it is there for.


Yes, its a good suggestion. OTOH, I think the plan is to drop this 
functionality all together by removing the ability to build kernels 
without the vulnerability checking/processor white lists. That will 
simplify some of the #ifdef'ing going on as well.




