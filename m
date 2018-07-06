Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908BC2409E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908BC2409E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeGFFYo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:24:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbeGFFYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:24:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B1DED1;
        Thu,  5 Jul 2018 22:24:41 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C343F5BA;
        Thu,  5 Jul 2018 22:24:39 -0700 (PDT)
Date:   Fri, 6 Jul 2018 06:24:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706052432.q74gql32dtj5gj3b@salmiak>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:19AM +0800, Guo Ren wrote:
> +static int csky_of_cpu(struct device_node *node)
> +{
> +	const char *status;
> +	int cpu;
> +
> +	if (of_property_read_u32(node, "reg", &cpu))
> +		goto error;
> +
> +	if (cpu >= NR_CPUS)
> +		goto error;
> +
> +	if (of_property_read_string(node, "status", &status))
> +		status = "enable";
> +
> +	if (strcmp(status, "disable") == 0)
> +		goto error;

Please use of_device_is_available(node); "enable" is not a sensible value for
the status property, and "disable" (rather than "disabled") is simply unusual.

Neither "enable" nor "disable" are correct values for the status property.

What is the value in the reg property, exactly? Is there a unique ID in
hardware for each CPU in the system?

It would be good to document this, e.g. as arm does in
Documentation/devicetree/bindings/arm/cpus.txt

> +
> +	return cpu;
> +error:
> +	return -ENODEV;
> +}
> +
> +void __init setup_smp(void)
> +{
> +	struct device_node *node = NULL;
> +	int cpu;
> +
> +	while ((node = of_find_node_by_type(node, "cpu"))) {
> +		cpu = csky_of_cpu(node);
> +		if (cpu >= 0) {
> +			set_cpu_possible(cpu, true);
> +			set_cpu_present(cpu, true);
> +		}
> +	}
> +}

What happens if/when the value in the reg property is larger than NR_CPUS?

> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +	unsigned int tmp;
> +
> +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> +
> +	secondary_hint = mfcr("cr31");
> +
> +	secondary_ccr  = mfcr("cr18");
> +
> +	pr_info("%s: CPU%u\n", __func__, cpu);
> +
> +	tmp = mfcr("cr<29, 0>");
> +	tmp |= 1 << cpu;
> +	mtcr("cr<29, 0>", tmp);
> +
> +	while (!cpu_online(cpu));
> +
> +	secondary_stack = 0;
> +
> +	return 0;
> +}

I don't see a start address being setup here, so I assume that CPUs branch to a
fixed address out-of-reset. Does that mean that the kernel has to be loaded at
a particular physical address on a given platform?

Thanks,
Mark.
