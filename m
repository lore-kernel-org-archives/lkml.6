Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11572154E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11572154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeHIMH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:07:27 -0400
Received: from foss.arm.com ([217.140.101.70]:51100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbeHIMH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:07:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD4915A2;
        Thu,  9 Aug 2018 02:43:24 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85B4F3F5D4;
        Thu,  9 Aug 2018 02:43:22 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:43:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     skannan@codeaurora.org
Cc:     Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
Message-ID: <20180809094319.GB1324@e107155-lin>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <20180807164114.GA12587@rob-hp-laptop>
 <496ac47a3c78f37655b60841fba7494c@codeaurora.org>
 <20180808084754.GB25416@e107155-lin>
 <8c7ab63d4c646733b89962a1d2a0a4ae@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7ab63d4c646733b89962a1d2a0a4ae@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 02:18:18PM -0700, skannan@codeaurora.org wrote:
> On 2018-08-08 01:47, Sudeep Holla wrote:
> >On Tue, Aug 07, 2018 at 12:37:07PM -0700, skannan@codeaurora.org wrote:
> >>On 2018-08-07 09:41, Rob Herring wrote:
> >>>On Wed, Aug 01, 2018 at 05:57:41PM -0700, Saravana Kannan wrote:
> >>>>Many CPU architectures have caches that can scale independent of the
> >>>>CPUs.
> >>>>Frequency scaling of the caches is necessary to make sure the cache is
> >>>>not
> >>>>a performance bottleneck that leads to poor performance and power. The
> >>>>same
> >>>>idea applies for RAM/DDR.
> >>>>
> >>>>To achieve this, this patch adds a generic devfreq governor that takes
> >>>>the
> >>>>current frequency of each CPU frequency domain and then adjusts the
> >>>>frequency of the cache (or any devfreq device) based on the frequency of
> >>>>the CPUs. It listens to CPU frequency transition notifiers to keep
> >>>>itself
> >>>>up to date on the current CPU frequency.
> >>>>
> >>>>To decide the frequency of the device, the governor does one of the
> >>>>following:
> >>>>
> >>>>* Uses a CPU frequency to device frequency mapping table
> >>>>  - Either one mapping table used for all CPU freq policies (typically
> >>>>used
> >>>>    for system with homogeneous cores/clusters that have the same OPPs).
> >>>>  - One mapping table per CPU freq policy (typically used for ASMP
> >>>>systems
> >>>>    with heterogeneous CPUs with different OPPs)
> >>>>
> >>>>OR
> >>>>
> >>>>* Scales the device frequency in proportion to the CPU frequency. So, if
> >>>>  the CPUs are running at their max frequency, the device runs at its
> >>>>max
> >>>>  frequency.  If the CPUs are running at their min frequency, the device
> >>>>  runs at its min frequency. And interpolated for frequencies in
> >>>>between.
> >>>>
> >>>>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> >>>>---
> >>>> .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
> >>>
> >>>Bindings should be a separate patch.
> >>>
> >>>> drivers/devfreq/Kconfig                            |   8 +
> >>>> drivers/devfreq/Makefile                           |   1 +
> >>>> drivers/devfreq/governor_cpufreq_map.c             | 583
> >>>>+++++++++++++++++++++
> >>>> 4 files changed, 645 insertions(+)
> >>>> create mode 100644
> >>>>Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> >>>> create mode 100644 drivers/devfreq/governor_cpufreq_map.c
> >>>>
> >>>>diff --git
> >>>>a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> >>>>b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> >>>>new file mode 100644
> >>>>index 0000000..982a30b
> >>>>--- /dev/null
> >>>>+++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> >>>>@@ -0,0 +1,53 @@
> >>>>+Devfreq CPUfreq governor
> >>>>+
> >>>>+devfreq-cpufreq-map is a parent device that contains one or more child
> >>>>devices.
> >>>>+Each child device provides CPU frequency to device frequency mapping
> >>>>for a
> >>>>+specific device. Examples of devices that could use this are: DDR,
> >>>>cache and
> >>>>+CCI.
> >>>>+
> >>>>+Parent device name shall be "devfreq-cpufreq-map".
> >>>>+
> >>>>+Required child device properties:
> >>>>+- cpu-to-dev-map, or cpu-to-dev-map-<X>:
> >>>>+			A list of tuples where each tuple consists of a
> >>>>+			CPU frequency (KHz) and the corresponding device
> >>>>+			frequency. CPU frequencies not listed in the table
> >>>>+			will use the device frequency that corresponds to the
> >>>>+			next rounded up CPU frequency.
> >>>>+			Use "cpu-to-dev-map" if all CPUs in the system should
> >>>>+			share same mapping.
> >>>>+			Use cpu-to-dev-map-<cpuid> to describe different
> >>>>+			mappings for different CPUs. The property should be
> >>>>+			listed only for the first CPU if multiple CPUs are
> >>>>+			synchronous.
> >>>>+- target-dev:		Phandle to device that this mapping applies to.
> >>>>+
> >>>>+Example:
> >>>>+	devfreq-cpufreq-map {
> >>>>+		cpubw-cpufreq {
> >>>>+			target-dev = <&cpubw>;
> >>>>+			cpu-to-dev-map =
> >>>>+				<  300000  1144000 >,
> >>>>+				<  422400  2288000 >,
> >>>>+				<  652800  3051000 >,
> >>>>+				<  883200  5996000 >,
> >>>>+				< 1190400  8056000 >,
> >>>>+				< 1497600 10101000 >,
> >>>>+				< 1728000 12145000 >,
> >>>>+				< 2649600 16250000 >;
> >>>
> >>>Now we have frequencies listed in multiple places, the OPP tables and
> >>>here? Perhaps it is grouping OPPs that should be done.
> >>
> >>This doesn't list all OPPs (it can if necessary). This is listing the
> >>minimum frequency needed to give good performance/power for a
> >>device/product.
> >>
> >
> >Shouldn't the "status" property be used to disable OPPs you don't need
> >on a particular platform ?
> 
> But that's not the point here? We aren't trying to disable any OPPs here?
> Not sure what you mean.
>

OK, I misunderstood, but my main concern was about duplication.

> >Duplicating values is highly prone to errors and should be avoided.
> >

IIUC, opp entries are nodes themselves with v2 bindings, can't you use
phandles to avoid duplication.

> >>AFAIK, OPP grouping isn't something that's supported in OPP framework or
> >>in
> >>DT. Is there something specific you had in mind? Also, I'd like for this
> >>to
> >>work even with devices that don't have OPPs listed in DT.
> >>
> >Also what's the solution you have for platforms with new *QCom FW Cpufreq*
> >?
> >IIUC the frequency is obtained from the firmware. TBH this should ideally
> >be handled in firmware if cpufreq is also handled by the firmware. I guess
> >this platform doesn't have that ?
>
> All QC platforms would use this.
>

How about the ones that get OPPs from firmware ? I thought that was the case
with new *QCom FW Cpufreq*

> As a personal (non-Qcom) opinion, I'd rather the kernel control this than
> have some black magic FW manage this.

Indeed every OS person having to find/debug the firmware bug may feel that.
But that doesn't change the fact that the embedded space is evolving.
Firmware is inevitable for good or bad, we need to accept that fact and
move on TBH.

> I've a really bitter taste in my mouth
> for FW hiding this because of a broken ACPI implementation in one of my x86
> motherboards prevented CPUfreq from working (this was well before I worked
> on CPUfreq).

Alternate way to look at this is that embedded developers(at least me) are
new to this space and feel that.

> Pushing stuff to FW seems to beat the ideal behind an opensource OS.

Not always. Even the recent security fixes(spectre/meltdown) had some
dependencies on f/w to deal with the issues. So finding the ways to
co-exist is more helpful than dismissing it.

> In a few cases it's elegant or more robust, so maybe in those
> cases its okay to use a FW. But I'd rather not for simpler stuff like this.

But there are instances where such simple stuffs also open up for security
exploits(clkscrew)

--
Regards,
Sudeep
