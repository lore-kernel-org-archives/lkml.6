Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEVG4m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:56:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:56:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6D1C6028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Sudeep Holla'" <sudeep.holla@arm.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh@kernel.org>, <mark.rutland@arm.com>,
        <viresh.kumar@linaro.org>, <nm@ti.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>,
        <linux-clk@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-soc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <rnayak@codeaurora.org>, <amit.kucheria@linaro.org>,
        <nicolas.dechesne@linaro.org>, <celster@codeaurora.org>,
        <tfinkel@codeaurora.org>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org> <1526729701-8589-1-git-send-email-ilialin@codeaurora.org> <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com> <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org> <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
In-Reply-To: <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
Subject: RE: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Tue, 22 May 2018 09:56:19 +0300
Message-ID: <001201d3f19a$0130a860$0391f920$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF4oTaoNxz6XIk2qh8MCLQUCquwggJzguYXAj6kKpQCSNS3vQG6YwsHpKxE4zA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4M6ul2U012541



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Monday, May 21, 2018 16:05
> To: ilialin@codeaurora.org; mturquette@baylibre.com; sboyd@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; viresh.kumar@linaro.org;
> nm@ti.com; lgirdwood@gmail.com; broonie@kernel.org;
> andy.gross@linaro.org; david.brown@linaro.org; catalin.marinas@arm.com;
> will.deacon@arm.com; rjw@rjwysocki.net; linux-clk@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; rnayak@codeaurora.org;
> amit.kucheria@linaro.org; nicolas.dechesne@linaro.org;
> celster@codeaurora.org; tfinkel@codeaurora.org
> Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 21/05/18 13:57, ilialin@codeaurora.org wrote:
> >
> [...]
> 
> >>> +#include <linux/cpu.h>
> >>> +#include <linux/err.h>
> >>> +#include <linux/init.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/nvmem-consumer.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/pm_opp.h>
> >>> +#include <linux/slab.h>
> >>> +#include <linux/soc/qcom/smem.h>
> >>> +
> >>> +#define MSM_ID_SMEM	137
> >>> +#define SILVER_LEAD	0
> >>> +#define GOLD_LEAD	2
> >>> +
> >>
> >> So I gather form other emails, that these are physical cpu number(not
> >> even unique identifier like MPIDR). Will this work on parts or
> >> platforms that need to boot in GOLD LEAD cpus.
> >
> > The driver is for Kryo CPU, which (and AFAIK all multicore MSMs)
> > always boots on the CPU0.
> 
> 
> That may be true and I am not that bothered about it. But assuming physical
> ordering from the logical cpu number is *incorrect* and will break if kernel
> decides to change the allocation algorithm. Kernel provides no guarantee on
> that, so you need to depend on some physical ID or may be DT to achieve
> what your want. But the current code as it stands is wrong.

Got your point. In fact CPUs are numbered 0-3 and ordered into 2 clusters in the DT:

cpus {
	#address-cells = <2>;
	#size-cells = <0>;

	CPU0: cpu@0 {
		...
		reg = <0x0 0x0>;
		...
	};

	CPU1: cpu@1 {
		...
		reg = <0x0 0x1>;
		...
	};

	CPU2: cpu@100 {
		...
		reg = <0x0 0x100>;
		...
	};

	CPU3: cpu@101 {
		...
		reg = <0x0 0x101>;
		...
	};

	cpu-map {
		cluster0 {
			core0 {
				cpu = <&CPU0>;
			};

			core1 {
				cpu = <&CPU1>;
			};
		};

		cluster1 {
			core0 {
				cpu = <&CPU2>;
			};

			core1 {
				cpu = <&CPU3>;
			};
		};
	};
};

As far, as I understand, they are probed in the same order. However, to be certain that the physical CPU is the one I intend to configure, I have to fetch the device structure pointer for the cpu-map -> clusterX -> core0 -> cpu path. Could you suggest a kernel API to do that?



> 
> --
> Regards,
> Sudeep
