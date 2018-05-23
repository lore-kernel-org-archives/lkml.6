Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeEWMTd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:19:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeEWMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:19:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A6EA60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 04/10] drivers: qcom: rpmh: add RPMH helper functions
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
 <20180509170159.29682-5-ilina@codeaurora.org>
 <CAD=FV=VCAaGsRH1e46e+YSPJMYHgHGWf9TcH5UrcuJadQGsLtw@mail.gmail.com>
 <20180515174736.GB28489@codeaurora.org>
 <CAD=FV=W9ahLJNuJBmMgziabumkU9q_PS59Z822+tLBwRZU7euQ@mail.gmail.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <e79895de-4c9e-942a-5f19-b8080fa9a935@codeaurora.org>
Date: Wed, 23 May 2018 17:49:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W9ahLJNuJBmMgziabumkU9q_PS59Z822+tLBwRZU7euQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/15/2018 11:52 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 15, 2018 at 10:47 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> On Fri, May 11 2018 at 14:17 -0600, Doug Anderson wrote:
>>>
>>> Hi,
>>>
>>> On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>>>
>>>> +int rpmh_write(const struct device *dev, enum rpmh_state state,
>>>> +              const struct tcs_cmd *cmd, u32 n)
>>>> +{
>>>> +       DECLARE_COMPLETION_ONSTACK(compl);
>>>> +       DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
>>>> +       int ret;
>>>> +
>>>> +       if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
>>>> +               return -EINVAL;
>>>> +
>>>> +       memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
>>>> +       rpm_msg.msg.num_cmds = n;
>>>> +
>>>> +       ret = __rpmh_write(dev, state, &rpm_msg);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
>>>
>>>
>>> IMO it's almost never a good idea to use wait_for_completion_timeout()
>>> together with a completion that's declared on the stack.  If you
>>> somehow insist that this is a good idea then I need to see incredibly
>>> clear and obvious code/comments that say why it's impossible that the
>>> process might somehow try to signal the completion _after_
>>> RPMH_TIMEOUT_MS has expired.
>>>
>>> Specifically if the timeout happens but the process could still signal
>>> a completion later then they will access random data on the stack of a
>>> function that has already returned.  This causes ridiculously
>>> difficult-to-debug crashes.
>>>
>>>
>>> NOTE: You've got timeout set to 10 seconds here.  Is that really even
>>> useful?  IMO just call wait_for_completion() without a timeout.  It's
>>> much better to have a nice clean hang than a random stack corruption.
>>>
>>>
>> The 10 sec timeout will guarantee that we will not get a response at all
>> anymore for the request. Usually requests can be considered failed if
>> there is no response in a few tens of microseconds. 10 sec is just an
>> arbitarily large number.
>>
>> The reason we use timeout is that once the timeout happens, we know we
>> have failed, we could trigger a watchdog or crash the system. This is
>> very important for our productization in debugging RPMH failures. A
>> hang would not always trigger a watchdog and the failure would be silent
>> and possibly fatal but hard to debug.
> 
> If you intend the system to crash when this timeout happens then IMHO
> add a BUG_ON.  Then I won't worry about something coming around later
> and clobbering the stack.
> 
> -Doug
> 

Sure. Will add BUG_ON in next patch.

Thanks,
Raju.
