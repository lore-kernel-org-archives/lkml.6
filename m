Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0751EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53B124DD8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8U8bl0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53B124DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeGCHMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbeGCHMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:12:34 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3809224DCC;
        Tue,  3 Jul 2018 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530601953;
        bh=ylrF7964J9Fk0nW7a0GxHSh/5AhJpRYjIDXweoA1g4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8U8bl0sl97OSG7/KHRJMqa30I/txstM/9Jj5JogAEIuFdnSdaE+wwKaHRkqC3GhK
         MECT9JC6UuBXTjy4tf1ibhNKd12oIDQf+r7v9yFVhPUUgJ2Ee13deYG2C40VYaZj+S
         b/u/Ct4lPQ8bx5d5yVzugPA2nCSTv0/xNSJNqmOw=
Date:   Tue, 3 Jul 2018 15:12:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>, arm@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
Message-ID: <20180703071215.GM4348@dragon>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
 <1527248760.3472.6.camel@pengutronix.de>
 <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 04:37:39PM +0530, Viresh Kumar wrote:
> Hi Lucas,
> 
> On 25-05-18, 13:46, Lucas Stach wrote:
> > This is a lot of duplicate information for what is effectively a shared
> >  cluster wide thing. This does absolutely not _feel_ right.
> 
> I cannot agree more :)
> 
> > What problem are you solving here? Why do we need all this duplicate
> > information? Why can't we fix it by falling back to looking at cpu0 if
> > needed?
> 
> Let me try explaining one of the problem scenarios to you as your
> platform is a single cluster one. Make cpufreq driver as module, don't
> insert it, hotplug out CPU0 and now insert the cpufreq driver. The
> cpufreq core will try adding the cpufreq policy for CPU1 but wouldn't
> find the required information in the DT node of CPU1 and so will fail
> or behave incorrectly.
> 
> We can't look at CPU0 as we don't know they are related at all.
> Nothing tells that to us. The right solution to fix the duplication is
> to move to OPP-v2 bindings, which allow us to create a single OPP
> table node and refer to it from all the CPU nodes. Because in case of
> imx platforms getting updated here, we use the old and some platforms
> specific frequency tables, we have to duplicate it everywhere.
> 
> But looking from DT otherwise, all the device should anyway have all
> the information required right in their node. That can be simplified
> with things like phandle to opp-v2 node, but still everything needs to
> be there. We shouldn't really rely on other CPU nodes to make it work.
> That would be an incomplete definition of the hardware IMHO.

Lucas,

Are you fine with the patch now considering the respond from Viresh?

Shawn
