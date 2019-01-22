Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA80BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BCB21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548160936;
	bh=dp15uKwqwdlEj1uUFXimVhvyYY5t4Ul7E+PFaOKJkoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lVqNlHPTHR25BtLsKzhshHeUiH6v6SQgXTH7wX6VsDMDx82qw/c5M2KDNzqCvwJoS
	 VzCBWEwzPCg41sasPJ9Hm7kuB9GjaYLnQKbPws/mX8uULUGdVl8hvpHhZiNA7j1m3S
	 yTJ8nN1POezGKE6hQ1860dEl7TKSalw8XMerOxSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAVMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfAVMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:42:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AD420855;
        Tue, 22 Jan 2019 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548160932;
        bh=dp15uKwqwdlEj1uUFXimVhvyYY5t4Ul7E+PFaOKJkoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v06nkiHyaPeoIMyTCPKrOe0E3suQWdz5XaVnRvgqHQqejAIhdf1LusImEJb/HeY7r
         dEIcS4FE27SVcYh5S78YKMW6b0xUIrzkB8W6uFtCT7wpldEVi5WDF7c6LcWKgKKtQm
         HrV03GJ4xaJ4AYHMoirEP7Y/w7o5tYO/Lwsczmas=
Date:   Tue, 22 Jan 2019 13:42:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Message-ID: <20190122124204.GA26969@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
> 
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
> 
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
> 
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Below is a simplified diagram of a real-world SoC topology. The interconnect
> providers are the NoCs.
> 
> +----------------+    +----------------+
> | HW Accelerator |--->|      M NoC     |<---------------+
> +----------------+    +----------------+                |
>                         |      |                    +------------+
>  +-----+  +-------------+      V       +------+     |            |
>  | DDR |  |                +--------+  | PCIe |     |            |
>  +-----+  |                | Slaves |  +------+     |            |
>    ^ ^    |                +--------+     |         |   C NoC    |
>    | |    V                               V         |            |
> +------------------+   +------------------------+   |            |   +-----+
> |                  |-->|                        |-->|            |-->| CPU |
> |                  |-->|                        |<--|            |   +-----+
> |     Mem NoC      |   |         S NoC          |   +------------+
> |                  |<--|                        |---------+    |
> |                  |<--|                        |<------+ |    |   +--------+
> +------------------+   +------------------------+       | |    +-->| Slaves |
>   ^  ^    ^    ^          ^                             | |        +--------+
>   |  |    |    |          |                             | V
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>           |
>       +-------+
>       | Modem |
>       +-------+
> 
> It's important to note that the interconnect API, in contrast with devfreq,
> is allowing drivers to express their needs in advance and be proactive.
> Devfreq is using a reactive approach (e.g. monitor performance counters and
> reconfigure bandwidth when the bottleneck had already occurred), which is
> suboptimal and might not work well. The interconnect API is designed to
> deal with multi-tiered bus topologies and aggregating constraints provided
> by drivers, while the devfreq is more oriented towards a device like GPU
> or CPU, that controls the power/performance of itself and not other devices.
> 
> Some examples of how interconnect API is used by consumers:
> https://lkml.org/lkml/2018/12/20/811
> https://lkml.org/lkml/2019/1/9/740
> https://lkml.org/lkml/2018/10/11/499
> https://lkml.org/lkml/2018/9/20/986
> 
> Platform drivers for different SoCs are available:
> https://lkml.org/lkml/2018/11/17/368
> https://lkml.org/lkml/2018/8/10/380

All now queued up, thanks.

greg k-h
