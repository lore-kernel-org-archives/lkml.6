Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeEWR7P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933949AbeEWR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:59:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 23 May 2018 10:59:07 -0700
From: rishabhb@codeaurora.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <CAHp75Vd8HZU+BT38-OfXHiihv1yZG6YBeMWyfweBA+kAwk6HUw@mail.gmail.com>
References: <1526492623-20527-1-git-send-email-rishabhb@codeaurora.org>
 <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
 <CAHp75VdO7+u-PQ+RBH71sxHHG0WkAyEVxv0BNPaycbcRnrZang@mail.gmail.com>
 <f1970a64be17267e0f044242dc0764d6@codeaurora.org>
 <CAHp75Vd8HZU+BT38-OfXHiihv1yZG6YBeMWyfweBA+kAwk6HUw@mail.gmail.com>
Message-ID: <e2fd7e4b452d955b766401fd871e93c4@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 12:38, Andy Shevchenko wrote:
> On Tue, May 22, 2018 at 9:33 PM,  <rishabhb@codeaurora.org> wrote:
>> On 2018-05-18 14:01, Andy Shevchenko wrote:
>>> On Wed, May 16, 2018 at 8:43 PM, Rishabh Bhatnagar
>>> <rishabhb@codeaurora.org> wrote:
> 
>>>> +#define ACTIVATE                      0x1
>>>> +#define DEACTIVATE                    0x2
>>>> +#define ACT_CTRL_OPCODE_ACTIVATE      0x1
>>>> +#define ACT_CTRL_OPCODE_DEACTIVATE    0x2
>>>> +#define ACT_CTRL_ACT_TRIG             0x1
>>> 
>>> 
>>> Are these bits? Perhaps BIT() ?
>>> 
>> isn't it just better to use fixed size as u suggest in the next 
>> comment?
> 
> If the are bits, use BIT() macro.
> 
>>>> +struct llcc_slice_desc *llcc_slice_getd(u32 uid)
>>>> +{
>>>> +       const struct llcc_slice_config *cfg;
>>>> +       struct llcc_slice_desc *desc;
>>>> +       u32 sz, count = 0;
>>>> +
>>>> +       cfg = drv_data->cfg;
>>>> +       sz = drv_data->cfg_size;
>>>> +
>>> 
>>> 
>>>> +       while (cfg && count < sz) {
>>>> +               if (cfg->usecase_id == uid)
>>>> +                       break;
>>>> +               cfg++;
>>>> +               count++;
>>>> +       }
>>>> +       if (cfg == NULL || count == sz)
>>>> +               return ERR_PTR(-ENODEV);
>>> 
>>> 
>>> if (!cfg)
>>>           return ERR_PTR(-ENODEV);
>>> 
>>> while (cfg->... != uid) {
>>>   cfg++;
>>>   count++;
>>> }
>>> 
>>> if (count == sz)
>>>  return ...
>>> 
>>> Though I would rather put it to for () loop.
>>> 
>> In each while loop iteration the cfg pointer needs to be checked for
>> NULL. What if the usecase id never matches the uid passed by client
>> and we keep iterating. At some point it will crash.
> 
> do {
>   if (!cfg || count == sz)
>    return ...(-ENODEV);
>  ...
> } while (...);
> 
> Though, as I said for-loop will look slightly better I think.
> 
>>>> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
>>>> +                                 DEACTIVATE);
>>> 
>>> 
>>> Perhaps one line (~83 characters here is OK) ?
>> 
>> The checkpatch script complains about such lines.
> 
> So what if it just 3 characters out?
> 
Many upstream reviewers have objection to lines crossing over 80 
characters
I have gotten reviews to reduce the line length even if its like 81~82
characters. Can we keep this as it is? I have addressed all other
comments and will send out the next patch by today.

>>>> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
>>>> +                                 ACTIVATE);
> 
>>> Ditto.
> 
>>>> +               attr1_cfg = bcast_off +
>>>> +
>>>> LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
>>>> +               attr0_cfg = bcast_off +
>>>> +
>>>> LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
> 
>>> Ditto.
> 
>>>> +               attr1_val |= llcc_table[i].probe_target_ways <<
>>>> +                               ATTR1_PROBE_TARGET_WAYS_SHIFT;
>>>> +               attr1_val |= llcc_table[i].fixed_size <<
>>>> +                               ATTR1_FIXED_SIZE_SHIFT;
>>>> +               attr1_val |= llcc_table[i].priority <<
>>>> ATTR1_PRIORITY_SHIFT;
> 
>>> foo |=
>>>   bar << SHIFT;
>>> 
>>> would look slightly better.
> 
> Did you consider this option ?
