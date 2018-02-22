Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeBVREz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:04:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeBVREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:04:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 466716021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 22 Feb 2018 17:04:51 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180222170451.GB7098@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-10-ilina@codeaurora.org>
 <CAE=gft7DV3semzumy+62hQgrUWUvOATJs6BKB5x0mj=0dt+Tig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft7DV3semzumy+62hQgrUWUvOATJs6BKB5x0mj=0dt+Tig@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21 2018 at 23:25 +0000, Evan Green wrote:
>Hello Lina,
>
>On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
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
>>  drivers/soc/qcom/rpmh.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/soc/qcom/rpmh.h |   8 +++
>>  2 files changed, 158 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index dff4c46be3af..6f60bb9a4dfa 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>[...]
>> @@ -394,6 +537,11 @@ int rpmh_flush(struct rpmh_client *rc)
>>         }
>>         spin_unlock_irqrestore(&rpm->lock, flags);
>>
>> +       /* First flush the cached batch requests */
>> +       ret = flush_batch(rc);
>> +       if (ret)
>> +               return ret;
>> +
>>         /*
>>          * Nobody else should be calling this function other than system PM,,
>>          * hence we can run without locks.
This comment and the comment in the header of this function.

>> @@ -438,6 +586,8 @@ int rpmh_invalidate(struct rpmh_client *rc)
>>         if (IS_ERR_OR_NULL(rc))
>>                 return -EINVAL;
>>
>> +       invalidate_batch(rc);
>> +
>
>Similarly to my comments in patch 7, aren't there races here with
>adding new elements? After flush_batch, but before invalidate_batch,
>somebody could call cache_batch, which would add new things on the end
>of the array. These new items would be clobbered by invalidate_batch,
>without having been flushed first.
>
Flush is a system PM function and is not called by drivers and is not
expected to run conncurrently with other threads using the RPMH library.

Thanks,
Lina
