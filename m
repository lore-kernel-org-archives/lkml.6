Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758735AbeD0QYS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:24:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758563AbeD0QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:24:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4569B60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 27 Apr 2018 10:24:08 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180427162408.GA6380@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-10-ilina@codeaurora.org>
 <20180425234149.GE243180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180425234149.GE243180@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25 2018 at 17:41 -0600, Matthias Kaehlcke wrote:
>On Thu, Apr 19, 2018 at 04:16:34PM -0600, Lina Iyer wrote:
>> Platform drivers need make a lot of resource state requests at the same
>> time, say, at the start or end of an usecase. It can be quite
>> inefficient to send each request separately. Instead they can give the
>> RPMH library a batch of requests to be sent and wait on the whole
>> transaction to be complete.
>>
>> rpmh_write_batch() is a blocking call that can be used to send multiple
>> RPMH command sets. Each RPMH command set is set asynchronously and the
>> API blocks until all the command sets are complete and receive their
>> tx_done callbacks.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v6:
>> 	- replace rpmh_client with device *
>> Changes in v4:
>> 	- reorganize rpmh_write_batch()
>> 	- introduce wait_count here, instead of patch#4
>> ---
>>  drivers/soc/qcom/rpmh.c | 155 +++++++++++++++++++++++++++++++++++++++-
>>  include/soc/qcom/rpmh.h |   8 +++
>>  2 files changed, 161 insertions(+), 2 deletions(-)
>>

><snip>
>
>> +static int cache_batch(struct rpmh_ctrlr *ctrlr,
>> +		       struct rpmh_request **rpm_msg, int count)
>> +{
>> +	unsigned long flags;
>> +	int ret = 0;
>> +	int index = 0;
>> +	int i;
>> +
>> +	spin_lock_irqsave(&ctrlr->lock, flags);
>> +	while (ctrlr->batch_cache[index])
>> +		index++;
>
>This will access memory beyond 'batch_cache' when the cache is full.
>
Ok. Will check for index.

><snip>
>
>> +static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
>> +{
>> +	unsigned long flags;
>> +	int index = 0;
>> +	int i;
>> +
>> +	spin_lock_irqsave(&ctrlr->lock, flags);
>> +	while (ctrlr->batch_cache[index])
>> +		index++;
>
>Same as above. Also, why loop twice?
>
Good idea. Will fix.

>> +	for (i = 0; i < index; i++) {
>> +		kfree(ctrlr->batch_cache[i]->free);
>> +		ctrlr->batch_cache[i] = NULL;
>> +	}
>
><snip>
>
>> +/**
>> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>> + * batch to finish.
>> + *
>> + * @dev: the device making the request
>> + * @state: Active/sleep set
>> + * @cmd: The payload data
>> + * @n: The array of count of elements in each batch, 0 terminated.
>
>nit: in this driver 'n' is usually associated with the command offset
>within a TCS. Since it isn't an overly descriptive name it may already
>cost the reader a while to commit that to his/her memory, and now
>we are overloading 'n' with a different meaning (I also noticed this in
>another patch of this series, but didn't comment).
>
Sure, will change the variable name here.

>>  	/*
>>  	 * Nobody else should be calling this function other than system PM,,
>                                                                            ~
>Remove extra comma.
OK.

Thanks,
Lina
