Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE9E23C9B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE9E23C9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeGFLce (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:32:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49569 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932236AbeGFLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:32:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07571276|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CN49ibC_1530876721;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN49ibC_1530876721)
          by smtp.aliyun-inc.com(10.147.41.121);
          Fri, 06 Jul 2018 19:32:01 +0800
Date:   Fri, 6 Jul 2018 19:32:01 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706113200.GA27148@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706052432.q74gql32dtj5gj3b@salmiak>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:24:33AM +0100, Mark Rutland wrote:
> > +	if (cpu >= NR_CPUS)
> > +		goto error;
> > +
> > +	if (of_property_read_string(node, "status", &status))
> > +		status = "enable";
> > +
> > +	if (strcmp(status, "disable") == 0)
> > +		goto error;
> 
> Please use of_device_is_available(node); 
Ok.

> "enable" is not a sensible value for
> the status property, and "disable" (rather than "disabled") is simply unusual.
> 
> Neither "enable" nor "disable" are correct values for the status property.

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;
		cpu@0 {
			device_type = "cpu";
			reg = <0>;
			status = "on";
		};

		cpu@1 {
			device_type = "cpu";
			reg = <1>;
			status = "off";
		};
	};

> What is the value in the reg property, exactly?
See above, I'll remove the reg property and it's no use.

> Is there a unique ID in
> hardware for each CPU in the system?
There is no unique ID in current CPU: ck860.

> 
> It would be good to document this, e.g. as arm does in
> Documentation/devicetree/bindings/arm/cpus.txt
Ok.

> > +
> > +	return cpu;
> > +error:
> > +	return -ENODEV;
> > +}
> > +
> > +void __init setup_smp(void)
> > +{
> > +	struct device_node *node = NULL;
> > +	int cpu;
> > +
> > +	while ((node = of_find_node_by_type(node, "cpu"))) {
> > +		cpu = csky_of_cpu(node);
> > +		if (cpu >= 0) {
> > +			set_cpu_possible(cpu, true);
> > +			set_cpu_present(cpu, true);
> > +		}
> > +	}
> > +}
> 
> What happens if/when the value in the reg property is larger than NR_CPUS?
Bug. I'll add NR_CPUS limit.

> > +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > +{
> > +	unsigned int tmp;
> > +
> > +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> > +
> > +	secondary_hint = mfcr("cr31");
> > +
> > +	secondary_ccr  = mfcr("cr18");
> > +
> > +	pr_info("%s: CPU%u\n", __func__, cpu);
> > +
> > +	tmp = mfcr("cr<29, 0>");
> > +	tmp |= 1 << cpu;
> > +	mtcr("cr<29, 0>", tmp);
> > +
> > +	while (!cpu_online(cpu));
> > +
> > +	secondary_stack = 0;
> > +
> > +	return 0;
> > +}
> 
> I don't see a start address being setup here, so I assume that CPUs branch to a
> fixed address out-of-reset. Does that mean that the kernel has to be loaded at
> a particular physical address on a given platform?
No, not a fixed address. I put it arch/csky/kernel/traps.c:79-83
trap_init()
#ifdef CONFIG_SMP
	mtcr("cr<28, 0>", virt_to_phys(vec_base));

	VEC_INIT(VEC_RESET, (void *)virt_to_phys(_start_smp_secondary));
#endi

 Guo Ren
