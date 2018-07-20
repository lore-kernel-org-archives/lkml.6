Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED93ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606312084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606312084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeGTJyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:54:31 -0400
Received: from foss.arm.com ([217.140.101.70]:59908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeGTJyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:54:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09FB180D;
        Fri, 20 Jul 2018 02:07:13 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7023F5B3;
        Fri, 20 Jul 2018 02:07:11 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] coresight: etm-perf: Add support for ETR backend
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-11-git-send-email-suzuki.poulose@arm.com>
 <20180719195949.GA9421@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <2e3a1a45-d71c-2f63-0ec9-9a8071a491f1@arm.com>
Date:   Fri, 20 Jul 2018 10:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719195949.GA9421@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/18 20:59, Mathieu Poirier wrote:
> On Tue, Jul 17, 2018 at 06:11:41PM +0100, Suzuki K Poulose wrote:
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

>> +	CS_UNLOCK(drvdata->base);
>> +
>> +	tmc_flush_and_stop(drvdata);
>> +	tmc_sync_etr_buf(drvdata);
>> +
>> +	CS_UNLOCK(drvdata->base);
> 
> This is a copy/paste oversight, here you want to lock again.

Thanks for catching that, will fix it.

> 
>> +	/* Reset perf specific data */
>> +	drvdata->perf_data = NULL;
>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +	size = etr_buf->len;
>> +	tmc_etr_sync_perf_buffer(etr_perf);
>> +
>> +	/*
>> +	 * Update handle->head in snapshot mode. Also update the size to the
>> +	 * hardware buffer size if there was an overflow.
>> +	 */
>> +	if (etr_perf->snapshot) {
>> +		handle->head += size;
>> +		if (etr_buf->full)
>> +			size = etr_buf->size;
>> +	}
>> +
>> +	lost |= etr_buf->full;
>> +out:
>> +	if (lost)
>> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +	return size;
>> +}
>> +
>>   static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>>   {
>> -	/* We don't support perf mode yet ! */
>> -	return -EINVAL;
>> +	int rc = 0;
>> +	unsigned long flags;
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +	struct perf_output_handle *handle = data;
>> +	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
>> +
>> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>> +	/*
>> +	 * There can be only one writer per sink in perf mode. If the sink
>> +	 * is already open in SYSFS mode, we can't use it.
>> +	 */
>> +	if (drvdata->mode != CS_MODE_DISABLED || drvdata->perf_data) {
>> +		rc = -EBUSY;

As discussed in the previous patch, I am missing a WARN_ON here : i.e,

    +	if (drvdata->mode != CS_MODE_DISABLED || WARN_ON(drvdata->perf_data))

which was there in the previous version in set_buffer, which triggered some
warnings for me with testing.

>> +		goto unlock_out;
>> +	}
>> +
>> +	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
>> +		rc = -EINVAL;
>> +		goto unlock_out;
>> +	}
>> +
>> +	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
>> +	drvdata->perf_data = etr_perf;
>> +	drvdata->mode = CS_MODE_PERF;
>> +	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
>> +
>> +unlock_out:
>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +	return rc;
>>   }
>>   
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev,
>> @@ -1148,6 +1389,9 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>>   	.enable		= tmc_enable_etr_sink,
>>   	.disable	= tmc_disable_etr_sink,
>> +	.alloc_buffer	= tmc_etr_alloc_perf_buffer,
>> +	.update_buffer	= tmc_etr_update_perf_buffer,
>> +	.free_buffer	= tmc_etr_free_perf_buffer,
> 
> 
> 	.alloc_buffer	= tmc_alloc_etr_buffer,
> 	.update_buffer	= tmc_update_etr_buffer,
> 	.free_buffer	= tmc_free_etr_buffer,
> 
> To be consistant with .enable and .disable along with the naming convention on
> the ETF side.


Sure, I can change them.

Cheers
Suzuki
