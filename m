Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966197AbeEJPRT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:17:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964827AbeEJPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:17:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 779AB6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 10 May 2018 09:17:14 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180510151714.GI4698@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-10-ilina@codeaurora.org>
 <20180509220304.GI19594@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180509220304.GI19594@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2018 at 16:03 -0600, Matthias Kaehlcke wrote:
>On Wed, May 09, 2018 at 11:01:58AM -0600, Lina Iyer wrote:
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
>> Changes in v7:
>> 	- Check for loop out of bounds
>>
>> Changes in v6:
>> 	- replace rpmh_client with device *
>> Changes in v4:
>> 	- reorganize rpmh_write_batch()
>> 	- introduce wait_count here, instead of patch#4
>> ---
>>  drivers/soc/qcom/rpmh.c | 154 +++++++++++++++++++++++++++++++++++++++-
>>  include/soc/qcom/rpmh.h |   8 +++
>>  2 files changed, 160 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index 1bb62876795c..a0e277b4b846 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>>
>> ...
>>
>> +static int flush_batch(struct rpmh_ctrlr *ctrlr)
>> +{
>> +	const struct rpmh_request *rpm_msg;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	/* Send Sleep/Wake requests to the controller, expect no response */
>> +	spin_lock_irqsave(&ctrlr->lock, flags);
>> +	for (i = 0; ctrlr->batch_cache[i]; i++) {
>
>I missed this earlier: the loop goes beyond ctrlr->batch_cache when
>the batch cache is full.
>
>> +		rpm_msg = ctrlr->batch_cache[i];
>> +		ret = rpmh_rsc_write_ctrl_data(ctrlr->drv, &rpm_msg->msg);
>> +		if (ret)
>> +			break;
>> +	}
>> +	spin_unlock_irqrestore(&ctrlr->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
>> +{
>> +	unsigned long flags;
>> +	int index = 0;
>> +
>> +	spin_lock_irqsave(&ctrlr->lock, flags);
>> +	while (ctrlr->batch_cache[index]) {
>
>This still goes beyond ctrlr->batch_cache when the batch cache is
>full.
I will check through the code for all out-of-bounds. Seems like I have
not worried about it too much. Well the space here assigned is beyond
what we see on a production device. Neverthless, it needs to be checked.

Thanks for your review Matthias.

-- Lina
