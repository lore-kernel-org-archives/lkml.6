Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeBTQDo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:03:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeBTQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:03:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 060ED602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 20 Feb 2018 16:03:40 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180220160340.GD28504@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-6-ilina@codeaurora.org>
 <CAE=gft5vEa69ML7mu=-=dg8Djb5dGdbs01PnwAYcJmSPioNasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft5vEa69ML7mu=-=dg8Djb5dGdbs01PnwAYcJmSPioNasg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thanks for your review.

On Fri, Feb 16 2018 at 23:51 +0000, Evan Green wrote:
>Hello Lina,
>
>On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> Sleep and wake requests are sent when the application processor
>> subsystem of the SoC is entering deep sleep states like in suspend.
>> These requests help lower the system power requirements when the
>> resources are not in use.
>>
>> Sleep and wake requests are written to the TCS slots but are not
>> triggered at the time of writing. The TCS are triggered by the firmware
>> after the last of the CPUs has executed its WFI. Since these requests
>> may come in different batches of requests, it is job of this controller
>> driver to find arrange the requests into the available TCSes.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |   7 +++
>>  drivers/soc/qcom/rpmh-rsc.c      | 126 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 133 insertions(+)
>>
>[...]
>> +static int find_slots(struct tcs_group *tcs, struct tcs_request *msg,
>> +                    int *m, int *n)
>> +{
>> +       int slot, offset;
>> +       int i = 0;
>> +
>> +       /* Find if we already have the msg in our TCS */
>> +       slot = find_match(tcs, msg->payload, msg->num_payload);
>> +       if (slot >= 0)
>> +               goto copy_data;
>> +
>> +       /* Do over, until we can fit the full payload in a TCS */
>> +       do {
>> +               slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
>> +                                                i, msg->num_payload, 0);
>> +               if (slot == MAX_TCS_SLOTS)
>> +                       break;
>> +               i += tcs->ncpt;
>> +       } while (slot + msg->num_payload - 1 >= i);
>> +
>> +       if (slot == MAX_TCS_SLOTS)
>> +               return -ENOMEM;
>> +
>> +copy_data:
>> +       bitmap_set(tcs->slots, slot, msg->num_payload);
>> +       /* Copy the addresses of the resources over to the slots */
>> +       for (i = 0; tcs->cmd_addr && i < msg->num_payload; i++)
>
>I don't think tcs->cmd_addr can be null, can it? Above, find_match()
>is already reaching through cmd_addr with enthusiasm. If kept, it
>could at least be moved outside of the loop.
>
It would be NULL for ACTIVE_TCS. I can move the check outside the loop.

Thanks,
Lina
