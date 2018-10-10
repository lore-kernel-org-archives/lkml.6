Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8003C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CE22150B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CE22150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJJWZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:25:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJWZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:25:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54386ED1;
        Wed, 10 Oct 2018 08:03:22 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656B23F5B3;
        Wed, 10 Oct 2018 08:03:19 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:03:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Message-ID: <20181010150312.GA4844@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003143824.13059-5-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 04:38:17PM +0200, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Update DT bindings to represent hierarchical CPU and CPU PM domain idle
> states for PSCI. Also update the PSCI examples to clearly show how
> flattened and hierarchical idle states can be represented in DT.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
> index a2c4f1d52492..17aa3d3a1c8e 100644
> --- a/Documentation/devicetree/bindings/arm/psci.txt
> +++ b/Documentation/devicetree/bindings/arm/psci.txt
> @@ -105,7 +105,163 @@ Case 3: PSCI v0.2 and PSCI v0.1.
>  		...
>  	};
>  
> +ARM systems can have multiple cores sometimes in hierarchical arrangement.
> +This often, but not always, maps directly to the processor power topology of
> +the system. Individual nodes in a topology have their own specific power states
> +and can be better represented in DT hierarchically.
> +
> +For these cases, the definitions of the idle states for the CPUs and the CPU
> +topology, must conform to the domain idle state specification [3]. The domain
> +idle states themselves, must be compatible with the defined 'domain-idle-state'
> +binding [1], and also need to specify the arm,psci-suspend-param property for
> +each idle state.
> +
> +DT allows representing CPUs and CPU idle states in two different ways -
> +
> +The flattened model as given in Example 1, lists CPU's idle states followed by
> +the domain idle state that the CPUs may choose. Note that the idle states are
> +all compatible with "arm,idle-state".
> +
> +Example 2 represents the hierarchical model of CPUs and domain idle states.
> +CPUs define their domain provider in their psci DT node. The domain controls
> +the power to the CPU and possibly other h/w blocks that would enter an idle
> +state along with the CPU. The CPU's idle states may therefore be considered as
> +the domain's idle states and have the compatible "arm,idle-state". Such domains
> +may also be embedded within another domain that may represent common h/w blocks
> +between these CPUs. The idle states of the CPU topology shall be represented as
> +the domain's idle states.
> +
> +In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order to use it,
> +the hierarchical representation must be used.
> +
> +Example 1: Flattened representation of CPU and domain idle states

[...]

> +Example 2: Hierarchical representation of CPU and domain idle states

I understand that this may not be of interest for this series, but do
we need to add any suggestions on how to arrive Flattened representation
of CPU idle states from its hierarchical representation. If the DT has
latter and PSCI call returns as PC mode only for idle. We need to deal
with that case.

--
Regards,
Sudeep
