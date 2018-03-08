Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966839AbeCHFn5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:43:57 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39195 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966380AbeCHFnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:43:49 -0500
X-Google-Smtp-Source: AG47ELuSgWgNxVJCm6Tf49hOdF9FIu7dqR6yS7jrNg3ARu984468/+Og2A+3fEHDXLCnIYwm+xDPsLscLJME17NhVVY=
MIME-Version: 1.0
In-Reply-To: <CAARXrtk6ZynSzm=xA1E1M8aSJNb=BZ7jxg4gvWa_QJ_=LaQeog@mail.gmail.com>
References: <1520440570-25280-1-git-send-email-eajames@linux.vnet.ibm.com>
 <CACPK8Xe5rVtB6hUo4xW9qSz-T+kehvXSRv5g1_6KOO=BYr8Qwg@mail.gmail.com> <CAARXrtk6ZynSzm=xA1E1M8aSJNb=BZ7jxg4gvWa_QJ_=LaQeog@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 8 Mar 2018 16:13:28 +1030
X-Google-Sender-Auth: kfj-5iGcso1lRjhLfWBEhp_-YH0
Message-ID: <CACPK8Xe55+_aOJD+dhpLrYfnw8_kjE-daXuRhu42p=O3K5Rztw@mail.gmail.com>
Subject: Re: [PATCH] clk: aspeed: Prevent reset if clock is enabled
To: Lei YU <mine260309@gmail.com>
Cc: Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 4:08 PM, Lei YU <mine260309@gmail.com> wrote:
> On Thu, Mar 8, 2018 at 11:42 AM, Joel Stanley <joel@jms.id.au> wrote:
>>> +       /* Only reset/enable/unreset if clock is stopped */
>>> +       regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
>>> +       if (!(reg & clk))
>>> +               return 0;
>>
>> This doesn't generalise to all of the clocks, as some clocks use set
>> to disable. Perhaps we could do something like this:
>>
>>        /* Only reset/enable/unreset if clock is stopped. The LPC clock
>> on ast2500 has issues otherwise */
>>        enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
>>        regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
>>        if ((reg & clk) == enval) {
>>                spin_unlock_irqrestore(gate->lock, flags);
>>                return 0;
>>        }
>>
>> I think we should also do this operation under the lock.
>>
>> Please cc Ryan Chen <ryan_chen@aspeedtech.com> so he can confirm that
>> this workaround is valid, and credit Lei who spent a lot of time
>> investigating this issue. Perhaps "Root-caused-by".
>>
>
> The code has aspeed_clk_is_enabled() already, why not just:
>
>     if (aspeed_clk_is_enabled(hw))
>         return 0;

Good suggestion.

We should also fix up aspeed_clk_is_enabled() for clocks that have
CLK_GATE_SET_TO_DISABLE set.

Cheers,

Joel
