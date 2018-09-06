Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092CAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C231B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C231B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeIFRx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:53:27 -0400
Received: from foss.arm.com ([217.140.101.70]:45526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbeIFRx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:53:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87ACA80D;
        Thu,  6 Sep 2018 06:17:57 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05E8D3F575;
        Thu,  6 Sep 2018 06:17:55 -0700 (PDT)
Date:   Thu, 6 Sep 2018 14:17:54 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
Message-ID: <20180906131752.ysubfiufocddpoey@queper01-lin>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wednesday 05 Sep 2018 at 17:38:11 (+0100), Sudeep Holla wrote:
> @@ -166,7 +166,12 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  					le32_to_cpu(attr->sustained_freq_khz);
>  		dom_info->sustained_perf_level =
>  					le32_to_cpu(attr->sustained_perf_level);
> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
> +		if (!dom_info->sustained_freq_khz ||
> +		    !dom_info->sustained_perf_level)
> +			dom_info->mult_factor =	1;

I'm sorry I missed that the first time I reviewed this patch, but after
discussing with Ionela, we found out that there is actually a case where
this could be a problem. If you have perf levels that are 1,2,3,4 (for
example), then with mult_factor=1 you'll register OPPs at 1Hz, 2Hz, 3Hz,
4Hz into PM_OPP. And that will be turned into 0 KHz for all of them at
the CPUFreq level when divided by 1000 in dev_pm_opp_init_cpufreq_table().

I guess a quick fix would be to have a default mult_factor of 1000 ...

What do you think ?

Thanks,
Quentin
