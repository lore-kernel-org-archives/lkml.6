Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeCIPp2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:45:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:45:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FCF36050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 9 Mar 2018 08:45:24 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180309154524.GD3577@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-6-ilina@codeaurora.org>
 <152053809443.219802.15873554351627646762@swboyd.mtv.corp.google.com>
 <20180308235830.GC3577@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180308235830.GC3577@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08 2018 at 16:58 -0700, Lina Iyer wrote:
>On Thu, Mar 08 2018 at 12:41 -0700, Stephen Boyd wrote:
>>Quoting Lina Iyer (2018-03-02 08:43:12)

>>>+static int find_slots(struct tcs_group *tcs, struct tcs_request *msg,
>>>+                    int *m, int *n)
>>>+{
>>>+       int slot, offset;
>>>+       int i = 0;
>>>+
>>>+       /* Find if we already have the msg in our TCS */
>>>+       slot = find_match(tcs, msg->payload, msg->num_payload);
>>>+       if (slot >= 0)
>>>+               goto copy_data;
>>
>>Shouldn't this goto skip setting the bits in tcs->slots?
>>
>No, we overwrite what we found with this new data.
>>>+
>>>+       /* Do over, until we can fit the full payload in a TCS */
>>>+       do {
>>>+               slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
>>>+                                                i, msg->num_payload, 0);
>>>+               if (slot == MAX_TCS_SLOTS)
>>>+                       break;
>>>+               i += tcs->ncpt;
>>>+       } while (slot + msg->num_payload - 1 >= i);
>>>+
>>>+       if (slot == MAX_TCS_SLOTS)
>>>+               return -ENOMEM;
>>
>>Would be nice to remove this duplicate condition somehow. Maybe a goto?
>>
>I would return instead of the break earlier instead of this here.
>>>+
>>>+copy_data:
>>>+       bitmap_set(tcs->slots, slot, msg->num_payload);
>>>+       /* Copy the addresses of the resources over to the slots */
>>>+       if (tcs->cmd_addr) {
>>
>>find_match() above didn't check for tcs->cmd_addr. Does this ever happen
>>to fail?
>>
>Not allocated for active TCSes. I should be checking for it there as
>well. Not sure how I didnt see a failure.
>
Ah, this function is never called for active tcs which would have the
tcs->cmd_addr to be NULL. I dont need this check.

-- Lina
