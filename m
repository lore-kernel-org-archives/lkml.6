Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05892C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA9923E92
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA9923E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbeGFLn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:43:59 -0400
Received: from foss.arm.com ([217.140.101.70]:35198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932348AbeGFLn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:43:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DECF18A;
        Fri,  6 Jul 2018 04:43:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DA273F5BA;
        Fri,  6 Jul 2018 04:43:55 -0700 (PDT)
Date:   Fri, 6 Jul 2018 12:43:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706113200.GA27148@guoren>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:32:01PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 06:24:33AM +0100, Mark Rutland wrote:
> > > +	if (cpu >= NR_CPUS)
> > > +		goto error;
> > > +
> > > +	if (of_property_read_string(node, "status", &status))
> > > +		status = "enable";
> > > +
> > > +	if (strcmp(status, "disable") == 0)
> > > +		goto error;
> > 
> > Please use of_device_is_available(node); 
> Ok.
> 
> > "enable" is not a sensible value for
> > the status property, and "disable" (rather than "disabled") is simply unusual.
> > 
> > Neither "enable" nor "disable" are correct values for the status property.
> 
> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		cpu@0 {
> 			device_type = "cpu";
> 			reg = <0>;
> 			status = "on";
> 		};
> 
> 		cpu@1 {
> 			device_type = "cpu";
> 			reg = <1>;
> 			status = "off";
> 		};
> 	};

Neither "on" nor "off" are standard status values either.

Please see the devicetree spec [1], section 2.3.4. Valid values are:

* "okay" // equivalent to no status property present
* "disabled"
* "fail"
* "fail-sss"

> > What is the value in the reg property, exactly?
> See above, I'll remove the reg property and it's no use.
> 
> > Is there a unique ID in
> > hardware for each CPU in the system?
> There is no unique ID in current CPU: ck860.

I'm a bit confused. You write (1 << cpu) into cv<29, 0>, to enable a
particular CPU, so I assume that bit uniquely identifies a CPU, and
therefore the reg is some unique ID for the CPU.

[...]

> > > +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > > +{
> > > +	unsigned int tmp;
> > > +
> > > +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> > > +
> > > +	secondary_hint = mfcr("cr31");
> > > +
> > > +	secondary_ccr  = mfcr("cr18");
> > > +
> > > +	pr_info("%s: CPU%u\n", __func__, cpu);
> > > +
> > > +	tmp = mfcr("cr<29, 0>");
> > > +	tmp |= 1 << cpu;
> > > +	mtcr("cr<29, 0>", tmp);
> > > +
> > > +	while (!cpu_online(cpu));
> > > +
> > > +	secondary_stack = 0;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I don't see a start address being setup here, so I assume that CPUs branch to a
> > fixed address out-of-reset. Does that mean that the kernel has to be loaded at
> > a particular physical address on a given platform?
> No, not a fixed address. I put it arch/csky/kernel/traps.c:79-83
> trap_init()
> #ifdef CONFIG_SMP
> 	mtcr("cr<28, 0>", virt_to_phys(vec_base));
> 
> 	VEC_INIT(VEC_RESET, (void *)virt_to_phys(_start_smp_secondary));
> #endi

I see.

Is this SMP bringup mechanism architectual, or are you likely to need
another mechanism to turn on CPUs on future chips?

You probably want to use an enable-method property to describe this.

Thanks,
Mark.

[1] https://www.devicetree.org/specifications/
