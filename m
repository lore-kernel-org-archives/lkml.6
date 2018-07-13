Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D069ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182F20843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D182F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeGMLhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:37:20 -0400
Received: from foss.arm.com ([217.140.101.70]:33702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeGMLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA1EED1;
        Fri, 13 Jul 2018 04:23:05 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220DB3F318;
        Fri, 13 Jul 2018 04:23:03 -0700 (PDT)
Subject: Re: [PATCH 6/6] coresight: etm-perf: Add support for ETR backend
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, robert.walker@arm.com,
        mike.leach@linaro.org
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
 <1531318599-8840-7-git-send-email-suzuki.poulose@arm.com>
 <20180712205740.GA22128@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <cf11b93e-6e57-7309-5364-6c1d00ff8381@arm.com>
Date:   Fri, 13 Jul 2018 12:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712205740.GA22128@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/18 21:57, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Jul 11, 2018 at 03:16:39PM +0100, Suzuki K Poulose wrote:
>> Add support for using TMC-ETR as backend for ETM perf tracing.
>> We use software double buffering at the moment. i.e, the TMC-ETR
>> uses a separate buffer than the perf ring buffer. The data is
>> copied to the perf ring buffer once a session completes.
>>
>> The TMC-ETR would try to match the larger of perf ring buffer
>> or the ETR buffer size configured via sysfs, scaling down to
>> a minimum limit of 1MB.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 265 +++++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
>>   2 files changed, 265 insertions(+), 2 deletions(-)

>> +/*
>> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
>> + * buffer to the perf ring buffer.
>> + */
>> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>> +{
>> +	long bytes, to_copy;
>> +	long pg_idx, pg_offset, src_offset;
>> +	unsigned long head = etr_perf->head;
>> +	char **dst_pages, *src_buf;
>> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
>> +
>> +	head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> 
> I'm puzzled here.  Since etr_perf->head is set in tmc_etr_set_perf_buffer() to
> the value of handle->head, its value is always within the range of the perf ring

IIUC, the handle->head is not necessarily guaranteed to be within the aux-ring buffer.

> buffer.  In tmc_etr_alloc_perf_buffer() etr_perf->nr_pages is set to the number
> of pages present in that ring buffer.  As such I'm not sure as to why we need
> the PERF_IDX2OFF() macro.
> 
> It seems to me that "head = etr_perf->head;" above is sufficient.
> 

We need to do the step at some point, which could be moved to set_perf_buffer.

>> +	pg_idx = head >> PAGE_SHIFT;
>> +	pg_offset = head & (PAGE_SIZE - 1);
>> +	dst_pages = (char **)etr_perf->pages;
>> +	src_offset = etr_buf->offset;
>> +	to_copy = etr_buf->len;
>> +
>> +	while (to_copy > 0) {
>> +		/*
>> +		 * We can copy minimum of :
> 
> s/We can copy minimum of :/In one iteration we can copy a minimum of:/
> 
> If I'm wrong about the PERF_IDX2OFF(), don't bother respinning just for that.

I have some more fixes for handling the different modes (sysfs vs perf),
which I can include in the v2.

Suzuki
