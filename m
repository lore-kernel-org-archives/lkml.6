Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBBCECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B341A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B341A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIQWig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:38:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbeIQWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:38:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 034A6B6932EF9;
        Tue, 18 Sep 2018 01:10:18 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 01:10:13 +0800
Subject: Re: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
To:     Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <will.deacon@arm.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
 <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
CC:     <mark.rutland@arm.com>, <guohanjun@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a7481657-1551-8f3e-e679-8bfbee8f1ab4@huawei.com>
Date:   Mon, 17 Sep 2018 18:10:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +
>> +#define SMMU_EVENT_ATTR(_name, _id)                      \
>> +    (&((struct perf_pmu_events_attr[]) {                  \
>> +        { .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
>> +          .id = _id, }                          \
>> +    })[0].attr.attr)
>> +
>> +static struct attribute *smmu_pmu_events[] = {
>> +    SMMU_EVENT_ATTR(cycles, SMMU_PMU_CYCLES),
>> +    SMMU_EVENT_ATTR(transaction, SMMU_PMU_TRANSACTION),
>> +    SMMU_EVENT_ATTR(tlb_miss, SMMU_PMU_TLB_MISS),
>> +    SMMU_EVENT_ATTR(config_cache_miss, SMMU_PMU_CONFIG_CACHE_MISS),
>> +    SMMU_EVENT_ATTR(trans_table_walk, SMMU_PMU_TRANS_TABLE_WALK),
>> +    SMMU_EVENT_ATTR(config_struct_access,
>> SMMU_PMU_CONFIG_STRUCT_ACCESS),
>> +    SMMU_EVENT_ATTR(pcie_ats_trans_rq, SMMU_PMU_PCIE_ATS_TRANS_RQ),
>> +    SMMU_EVENT_ATTR(pcie_ats_trans_passed,
>> SMMU_PMU_PCIE_ATS_TRANS_PASSED),
>> +    NULL
>> +};
>> +
>> +static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
>> +                     struct attribute *attr, int unused)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
>> +    struct perf_pmu_events_attr *pmu_attr;
>> +
>> +    pmu_attr = container_of(attr, struct perf_pmu_events_attr,
>> attr.attr);
>> +
>> +    if (test_bit(pmu_attr->id, smmu_pmu->supported_events))
>> +        return attr->mode;
>> +
>> +    return 0;
>> +}
>> +static struct attribute_group smmu_pmu_events_group = {
>> +    .name = "events",
>> +    .attrs = smmu_pmu_events,
>> +    .is_visible = smmu_pmu_event_is_visible,
>> +};
>> +
>> +/* Formats */
>> +PMU_FORMAT_ATTR(event,           "config:0-15");
>> +PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
>> +PMU_FORMAT_ATTR(filter_span,       "config1:32");
>> +PMU_FORMAT_ATTR(filter_enable,       "config1:33");
>> +
>> +static struct attribute *smmu_pmu_formats[] = {
>> +    &format_attr_event.attr,
>> +    &format_attr_filter_stream_id.attr,
>> +    &format_attr_filter_span.attr,
>> +    &format_attr_filter_enable.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group smmu_pmu_format_group = {
>> +    .name = "format",
>> +    .attrs = smmu_pmu_formats,
>> +};
>> +
>> +static const struct attribute_group *smmu_pmu_attr_grps[] = {
>> +    &smmu_pmu_cpumask_group,
>> +    &smmu_pmu_events_group,
>> +    &smmu_pmu_format_group,
>> +    NULL,
>> +};
>> +


Question: If we wanted to add proper named event support for the 
IMPLEMENTATION DEFINED events, how to add (if at all)?

So currently the driver only supports the Architected events, which is 
fine. And we support raw events for the IMPLEMENTATION DEFINED events 
(0x80-0xFFFF).

But to add named event support for the IMP DEF events, I assume we would 
want to do something similar to arm64 CPU PMU events - that is, common 
architected events in kernel pmu driver, and implementation defined 
events defined in perf tool. However I don't know if it's even feasible 
considering there does not seem to be a mandatory/standard PMCG ID 
register to detect the implementation.

Thanks,
John


