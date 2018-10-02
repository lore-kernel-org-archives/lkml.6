Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B262083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B262083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeJBXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:03:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41148 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJBXDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:03:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A0F87A9;
        Tue,  2 Oct 2018 09:19:23 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CB713F5D3;
        Tue,  2 Oct 2018 09:19:20 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com
Cc:     mark.rutland@arm.com, vkilari@codeaurora.org,
        neil.m.leeder@gmail.com, pabba@codeaurora.org,
        john.garry@huawei.com, will.deacon@arm.com,
        rruigrok@codeaurora.org, linuxarm@huawei.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com, linux-kernel@vger.kernel.org
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
Message-ID: <1dc554eb-7ed2-45b3-109f-8cec286b4525@arm.com>
Date:   Tue, 2 Oct 2018 17:19:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 15:11, Jean-Philippe Brucker wrote:
>> +	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);

Something I missed previously: when SMMU_PMCG_CFGR.SID_FILTER_TYPE is 1,
filtering for all counters is configured by SMMU_PMCG_SMR0 and
SMMU_PMCG_EVTYPER0 (instead of having one separate filter per counter).

In that mode with your patch, if the user applies a filter to the first
event in the list passed to perf, it will be applied to all events.
Filter applied on any subsequent event will be ignored. Could we make
this more explicit? Maybe in the probe print that the PMCG is
global-filtering, and when attempting to apply a filter to something
else than EVCNTR0, return an error?

Thanks,
Jean

