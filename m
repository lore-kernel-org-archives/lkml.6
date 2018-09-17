Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD81AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99908214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99908214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeIQS5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:57:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeIQS5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:57:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335A41596;
        Mon, 17 Sep 2018 06:30:23 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 055763F557;
        Mon, 17 Sep 2018 06:30:23 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9189C1AE3063; Mon, 17 Sep 2018 14:30:41 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:30:41 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 4/6] arm64: add sysfs vulnerability show for
 spectre v2
Message-ID: <20180917133041.GC23040@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-5-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827143310.641-5-ykaukab@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:33:08PM +0200, Mian Yousaf Kaukab wrote:
> Only report mitigation present if hardening callback has been
> successfully installed.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 92616431ae4e..8469d3be7b15 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -481,7 +481,8 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
>  			caps->cpu_enable(caps);
>  }
>  
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
> +	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
>  
>  /*
>   * List of CPUs where we need to issue a psci call to
> @@ -712,4 +713,35 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  }
>  
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	u64 pfr0;
> +	struct bp_hardening_data *data;
> +
> +	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> +	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
> +		return sprintf(buf, "Not affected\n");

This strikes me as a pretty terrible interface, as it means that the file
can return different contents depending on which CPU it was read from on a
big/little machine. I think we need to either expose this per-cpu, or expose
the value of the system (e.g. if one CPU is vulnerable, we always say
vulnerable).

> +
> +	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
> +		/*
> +		 * Hardware is vulnerable. Lets check if bp hardening callback
> +		 * has been successfully installed
> +		 */
> +		data = arm64_get_bp_hardening_data();

Related to the above, but this is accessing per-cpu stuff.

Will
