Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A7AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206FC2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfANKC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:02:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfANKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:02:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64C6CA78;
        Mon, 14 Jan 2019 02:02:26 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EACA23F5AF;
        Mon, 14 Jan 2019 02:02:22 -0800 (PST)
Subject: Re: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to
 select vulnerabilities
To:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, Steven.Price@arm.com,
        stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
        konrad.wilk@oracle.com, mingo@kernel.org, longman@redhat.com,
        ak@linux.intel.com, jkosina@suse.cz
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-2-jeremy.linton@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
Date:   Mon, 14 Jan 2019 10:02:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109235544.2992426-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2019 23:55, Jeremy Linton wrote:
> As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
> a number of cases where its useful for a system to avoid exporting a
> sysfs entry for a given vulnerability. This set adds an architecture
> specific callback which returns the bitmap of vulnerabilities the
> architecture would like to advertise.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
>   drivers/base/cpu.c  | 19 +++++++++++++++++++
>   include/linux/cpu.h |  7 +++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..35f6dfb24cd6 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
>   	NULL
>   };
>   
> +uint __weak arch_supported_vuln_attr_fields(void)
> +{
> +	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
> +}
> +
>   static const struct attribute_group cpu_root_vulnerabilities_group = {
>   	.name  = "vulnerabilities",
>   	.attrs = cpu_root_vulnerabilities_attrs,
> @@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
>   
>   static void __init cpu_register_vulnerabilities(void)
>   {
> +	int fld;
> +	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
> +	struct attribute **hd = cpu_root_vulnerabilities_attrs;
> +	uint enabled_fields = arch_supported_vuln_attr_fields();
> +
> +	/* only enable entries requested by the arch code */
> +	for (fld = 0; fld < max_fields; fld++) {
> +		if (enabled_fields & 1 << fld) {
> +			*hd = cpu_root_vulnerabilities_attrs[fld];
> +			hd++;
> +		}
> +	}
> +	*hd = NULL;
> +

nit: Could we use "is_visible" callback in the attribute group to check this
dynamically ?

>   	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
>   			       &cpu_root_vulnerabilities_group))
>   		pr_err("Unable to register CPU vulnerabilities\n");
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 218df7f4d3e1..5e45814bcc24 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -189,4 +189,11 @@ static inline void cpu_smt_check_topology_early(void) { }
>   static inline void cpu_smt_check_topology(void) { }
>   #endif
>   
> +/* generic cpu vulnerability attributes */
> +#define VULN_MELTDOWN  0x01
> +#define VULN_SPECTREV1 0x02
> +#define VULN_SPECTREV2 0x04
> +#define VULN_SSB       0x08
> +#define VULN_L1TF      0x10

nit: May use BIT() ?

Cheers
Suzuki
