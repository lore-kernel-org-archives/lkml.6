Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeEWMaw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:30:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbeEWMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:30:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5916C602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 08/10] drivers: qcom: rpmh: allow requests to be sent
 asynchronously
To: Doug Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, msivasub@codeaurora.org,
        mkshah@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-9-ilina@codeaurora.org>
 <CAD=FV=WmXkW1ms=4=25z=o7wt_uBZgS2t1SZr6qRLhP=B_bBMg@mail.gmail.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <7384b854-1930-8a52-a0df-d3ef9cde8f42@codeaurora.org>
Date: Wed, 23 May 2018 18:00:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WmXkW1ms=4=25z=o7wt_uBZgS2t1SZr6qRLhP=B_bBMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/2018 1:46 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>   /**
>> @@ -137,6 +140,8 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>>                  dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
>>                          rpm_msg->msg.cmds[0].addr, r);
>>
>> +       kfree(rpm_msg->free);
>> +
> 
> The way the code is written makes it seem like you could free memory
> _and_ have a completion but you can't.  Specifically:
> 
> * The only plausible thing that "rpm_msg->free" could point to is "rpm_msg".
> 
> * The complete(compl) would then be accessing freed memory.

As the completions are declared on stack, it will not access freed memory.

> 
> I believe the kfree() should be at the end of the function.
> Personally I'd make it more obvious that this is just a boolean value
> and change to:
> 
> if (rpm_msg->needs_free)
>    kgree(rpm_msg)
> 
> ...then the reader of the code doesn't need to go figure out what
> you're trying to free.
> 
> 
> -Doug
> 

Yes. Will change it this way in next patch set.

Thanks,
Raju
