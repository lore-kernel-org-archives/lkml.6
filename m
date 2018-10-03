Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D8DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F942083F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F942083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJCRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:24:59 -0400
Received: from foss.arm.com ([217.140.101.70]:49202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeJCRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE3118A;
        Wed,  3 Oct 2018 03:37:11 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D08FC3F5A0;
        Wed,  3 Oct 2018 03:37:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com,
        john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
Date:   Wed, 3 Oct 2018 11:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/18 16:08, Shameer Kolothum wrote:
[...]
> +
> +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> +					       &smmu_pmu->node);

In theory a hotplug event could happen as soon as the instance is 
registered...

> +	if (err) {
> +		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> +			err, &res_0->start);
> +		return err;
> +	}
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	smmu_pmu->on_cpu = get_cpu();

...so this looks too late, i.e. a race here can result in a bogus call 
to perf_pmu_migrate_context() with an uninitialised pmu.

Robin.

> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> +
> +	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> +	if (err) {
> +		dev_err(dev, "Error %d registering PMU @%pa\n",
> +			err, &res_0->start);
> +		goto out_unregister;
> +	}
> +
> +	put_cpu();
