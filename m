Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeCFWMn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:12:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:12:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D047C6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 6 Mar 2018 15:12:38 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] drivers: qcom: rpmh: cache sleep/wake state
 requests
Message-ID: <20180306221238.GG4930@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-8-ilina@codeaurora.org>
 <CAE=gft59Jkb+X0fOcdEZN_8moUPvptZ-xuQaX1mg-VxBzHrSXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft59Jkb+X0fOcdEZN_8moUPvptZ-xuQaX1mg-VxBzHrSXw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05 2018 at 13:45 -0700, Evan Green wrote:
>Hi Lina,
>
>On Fri, Mar 2, 2018 at 8:43 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> Active state requests are sent immediately to the mailbox controller,
>> while sleep and wake state requests are cached in this driver to avoid
>> taxing the mailbox controller repeatedly. The cached values will be sent
>> to the controller when the rpmh_flush() is called.
>>
>> Generally, flushing is a system PM activity and may be called from the
>> system PM drivers when the system is entering suspend or deeper sleep
>> modes during cpuidle.
>>
>> Also allow invalidating the cached requests, so they may be re-populated
>> again.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v3:
>>         - Remove locking for flush function
>>         - Improve comments
>> ---
>>  drivers/soc/qcom/rpmh.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/soc/qcom/rpmh.h |  10 +++
>>  2 files changed, 217 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index d95ea3fa8b67..8a04009075b8 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>[...]
>> +
>> +/**
>> + * rpmh_invalidate: Invalidate all sleep and active sets
>> + * sets.
>> + *
>> + * @rc: The RPMh handle got from rpmh_get_dev_channel
>> + *
>> + * Invalidate the sleep and active values in the TCS blocks.
>> + */
>> +int rpmh_invalidate(struct rpmh_client *rc)
>> +{
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       int ret;
>> +       unsigned long flags;
>> +
>> +       if (IS_ERR_OR_NULL(rc))
>> +               return -EINVAL;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       rpm->dirty = true;
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>
>Thanks for removing the locking from the flush path. I was hoping to
>see the locking removed around this statement as well. The way I
>understand it, all of the racy bits are attempting to set dirty to
>true, so you don't need a lock to protect multiple threads from
>setting the same value. The only time dirty is read or cleared is in
>the single-threaded PM path, so there are no potentially dangerous
>interactions.
>
Fair point. Will take care of it.

>If no one has any other comments on the series, then I don't need to
>hold everything up based on this one tweak alone. But if you end up
>spinning it again for other reasons, consider making this change as
>well.
>
Thanks,
Lina
