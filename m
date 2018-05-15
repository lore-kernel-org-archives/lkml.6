Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeEORrk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:47:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeEORri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:47:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03A60603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 15 May 2018 11:47:36 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180515174736.GB28489@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-5-ilina@codeaurora.org>
 <CAD=FV=VCAaGsRH1e46e+YSPJMYHgHGWf9TcH5UrcuJadQGsLtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=VCAaGsRH1e46e+YSPJMYHgHGWf9TcH5UrcuJadQGsLtw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11 2018 at 14:17 -0600, Doug Anderson wrote:
>Hi,
>
>On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> +int rpmh_write(const struct device *dev, enum rpmh_state state,
>> +              const struct tcs_cmd *cmd, u32 n)
>> +{
>> +       DECLARE_COMPLETION_ONSTACK(compl);
>> +       DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
>> +       int ret;
>> +
>> +       if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
>> +               return -EINVAL;
>> +
>> +       memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
>> +       rpm_msg.msg.num_cmds = n;
>> +
>> +       ret = __rpmh_write(dev, state, &rpm_msg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
>
>IMO it's almost never a good idea to use wait_for_completion_timeout()
>together with a completion that's declared on the stack.  If you
>somehow insist that this is a good idea then I need to see incredibly
>clear and obvious code/comments that say why it's impossible that the
>process might somehow try to signal the completion _after_
>RPMH_TIMEOUT_MS has expired.
>
>Specifically if the timeout happens but the process could still signal
>a completion later then they will access random data on the stack of a
>function that has already returned.  This causes ridiculously
>difficult-to-debug crashes.
>
>
>NOTE: You've got timeout set to 10 seconds here.  Is that really even
>useful?  IMO just call wait_for_completion() without a timeout.  It's
>much better to have a nice clean hang than a random stack corruption.
>
>
The 10 sec timeout will guarantee that we will not get a response at all
anymore for the request. Usually requests can be considered failed if
there is no response in a few tens of microseconds. 10 sec is just an
arbitarily large number.

The reason we use timeout is that once the timeout happens, we know we
have failed, we could trigger a watchdog or crash the system. This is
very important for our productization in debugging RPMH failures. A
hang would not always trigger a watchdog and the failure would be silent
and possibly fatal but hard to debug.

-- Lina
