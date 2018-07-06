Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F62C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264A23D22
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A264A23D22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeGFM0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:26:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39068 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932732AbeGFM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:26:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07793569|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l01425;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CN5.Ucd_1530879991;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN5.Ucd_1530879991)
          by smtp.aliyun-inc.com(10.147.40.233);
          Fri, 06 Jul 2018 20:26:31 +0800
Date:   Fri, 6 Jul 2018 20:26:31 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706122631.GA30265@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
 <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:43:52PM +0100, Mark Rutland wrote:
> Please see the devicetree spec [1], section 2.3.4. Valid values are:
> 
> * "okay" // equivalent to no status property present
> * "disabled"
> * "fail"
> * "fail-sss"
Nice tip, thx.

> I'm a bit confused. You write (1 << cpu) into cv<29, 0>, to enable a
> particular CPU, so I assume that bit uniquely identifies a CPU,
Yes, you're right and cr<29, 0>'s bit uniquely identifies a cpu.

> and
> therefore the reg is some unique ID for the CPU.
static int csky_of_cpu(struct device_node *node)
{
	const char *status;

	if (of_property_read_string(node, "status", &status))
		status = "okay";

	if (strcmp(status, "disabled") == 0)
		goto error;

	return 1;
error:
	return 0;
}

void __init setup_smp(void)
{
	struct device_node *node = NULL;
	int i = 0;

	while ((node = of_find_node_by_type(node, "cpu"))) {
		if (!csky_of_cpu(node))
			continue;

		set_cpu_possible(i, true);
		set_cpu_present(i, true);

		i++;
	}
}
Hmm?

No <reg> in next version patch, it's no use.

> I see.
> 
> Is this SMP bringup mechanism architectual, or are you likely to need
> another mechanism to turn on CPUs on future chips?
It's the only SMP bringup mechanism architectual for C-SKY SMP. There is
no another way in future and SOC vendor couldn't change it.

> You probably want to use an enable-method property to describe this.
No, thx.

 Guo Ren
