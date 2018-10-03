Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86704C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1172089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1172089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeJCRyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:54:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbeJCRyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:54:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80DD8EEF3115E;
        Wed,  3 Oct 2018 19:06:57 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 3 Oct 2018
 19:06:49 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
CC:     <guohanjun@huawei.com>, <pabba@codeaurora.org>,
        <vkilari@codeaurora.org>, <rruigrok@codeaurora.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Message-ID: <e3546ab9-269c-c39c-344f-ff2eb9a5336b@huawei.com>
Date:   Wed, 3 Oct 2018 12:06:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 16:08, Shameer Kolothum wrote:
> +
> +ssize_t smmu_pmu_event_show(struct device *dev,
> +			    struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +}

Is there some reason PMU drivers have their own edition of this 
function? I see a few similar ones here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/perf_event.c#n309

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/perf/core-book3s.c#n1986

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_event.c#n239

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/qcom_l2_pmu.c#n731

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/qcom_l3_pmu.c#n655

That is apart from the event id width format.

But the leading zeroes seem to be cropped anyway in the perf tool, 
according to this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n335 
(this was added in 0c24d6fb7db, in June 18)

John

> +
> +#define SMMU_EVENT_ATTR(_name, _id)					  \
> +	(&((struct perf_pmu_events_attr[]) {				  \
> +		{ .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
> +		  .id = _id, }						  \
> +	})[0].attr.attr)
> +
> +static struct attribute *smmu_pmu_events[] = {
> +	SMMU_EVENT_ATTR(cycles, 0),
> +	SMMU_EVENT_ATTR(transaction, 1),
> +	SMMU_EVENT_ATTR(tlb_miss, 2),
> +	SMMU_EVENT_ATTR(config_cache_miss, 3),
> +	SMMU_EVENT_ATTR(trans_table_walk, 4),
> +	SMMU_EVENT_ATTR(config_struct_access, 5),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
> +	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
> +	NULL
> +};


