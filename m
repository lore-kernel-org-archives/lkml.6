Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CFB23E71
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CFB23E71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeFVIW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:22:28 -0400
Received: from foss.arm.com ([217.140.101.70]:59608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFVIW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E921435;
        Fri, 22 Jun 2018 01:22:25 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704AE3F58F;
        Fri, 22 Jun 2018 01:22:24 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:22:22 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/9] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180622082222.GD23168@e108498-lin.cambridge.arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
 <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten,

On Wednesday 20 Jun 2018 at 10:05:41 (+0100), Morten Rasmussen wrote:
> +static void update_asym_cpucapacity(int cpu)
> +{
> +	int enable = false;
> +
> +	rcu_read_lock();
> +	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
> +		enable = true;
> +	rcu_read_unlock();
> +
> +	if (enable) {
> +		/* This expects to be hotplug-safe */
> +		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
> +	}
> +}

What would happen if you hotplugged an entire cluster ? You'd loose the
SD_ASYM_CPUCAPACITY flag but keep the static key is that right ? Should
we care ?

And also, Peter mentioned an issue with the EAS patches with multiple
root_domains. Does that apply here as well ? What if you had a
configuration with big and little CPUs in different root_domains for ex?

Should we disable the static key in the above cases ?

Thanks,
Quentin
