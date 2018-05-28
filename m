Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423486AbeE1LHu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:07:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43993 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423471AbeE1LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:07:42 -0400
X-Google-Smtp-Source: AB8JxZpVMlxdj3f9bYxIALid2OwwGBO3RGBCVq0mBvd3EfqoTgfbPjePoJ+HYCK1IizdINecFGbcZA==
Date: Mon, 28 May 2018 16:37:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: arm@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
Message-ID: <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
 <1527248760.3472.6.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527248760.3472.6.camel@pengutronix.de>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 25-05-18, 13:46, Lucas Stach wrote:
> This is a lot of duplicate information for what is effectively a shared
>  cluster wide thing. This does absolutely not _feel_ right.

I cannot agree more :)

> What problem are you solving here? Why do we need all this duplicate
> information? Why can't we fix it by falling back to looking at cpu0 if
> needed?

Let me try explaining one of the problem scenarios to you as your
platform is a single cluster one. Make cpufreq driver as module, don't
insert it, hotplug out CPU0 and now insert the cpufreq driver. The
cpufreq core will try adding the cpufreq policy for CPU1 but wouldn't
find the required information in the DT node of CPU1 and so will fail
or behave incorrectly.

We can't look at CPU0 as we don't know they are related at all.
Nothing tells that to us. The right solution to fix the duplication is
to move to OPP-v2 bindings, which allow us to create a single OPP
table node and refer to it from all the CPU nodes. Because in case of
imx platforms getting updated here, we use the old and some platforms
specific frequency tables, we have to duplicate it everywhere.

But looking from DT otherwise, all the device should anyway have all
the information required right in their node. That can be simplified
with things like phandle to opp-v2 node, but still everything needs to
be there. We shouldn't really rely on other CPU nodes to make it work.
That would be an incomplete definition of the hardware IMHO.

-- 
viresh
