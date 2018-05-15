Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeEOPwx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:52:53 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39706 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbeEOPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:52:50 -0400
X-Google-Smtp-Source: AB8JxZoJkNTT9WzovtD875anKDp6KslnodNg5xo/7RnyWGuuoeQpEDLyIrijDKczp9gcG/4EgxsOE0KsWKriW5EMIFY=
MIME-Version: 1.0
In-Reply-To: <20180514195929.GA22950@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-10-ilina@codeaurora.org>
 <CAD=FV=Xvi8V43+J9v-mosU5WUDQtabg8gUbrkn6SCoNEYFtjUQ@mail.gmail.com> <20180514195929.GA22950@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 May 2018 08:52:47 -0700
X-Google-Sender-Auth: sRd4u2CFJCyier1GBGTsCOvgP6g
Message-ID: <CAD=FV=U+6N9LqvAh-V5ZKd_QKL9yTe+P9gVkvH4tr-SsUaMwng@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH request
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 14, 2018 at 12:59 PM, Lina Iyer <ilina@codeaurora.org> wrote:

>>>  /**
>>> @@ -77,12 +82,14 @@ struct rpmh_request {
>>>   * @cache: the list of cached requests
>>>   * @lock: synchronize access to the controller data
>>>   * @dirty: was the cache updated since flush
>>> + * @batch_cache: Cache sleep and wake requests sent as batch
>>>   */
>>>  struct rpmh_ctrlr {
>>>         struct rsc_drv *drv;
>>>         struct list_head cache;
>>>         spinlock_t lock;
>>>         bool dirty;
>>> +       const struct rpmh_request *batch_cache[RPMH_MAX_BATCH_CACHE];
>>
>>
>> I'm pretty confused about why the "batch_cache" is separate from the
>> normal cache.  As far as I can tell the purpose of the two is the same
>> but you have two totally separate code paths and data structures.
>>
> Due to a hardware limitation, requests made by bus drivers must be set
> up in the sleep and wake TCS first before setting up the requests from
> other drivers. Bus drivers use batch mode for any and all RPMH
> communication. Hence their request are the only ones in the batch_cache.

This is totally not obvious and not commented.  Why not rename to
"priority" instead of "batch"?

If the only requirement is that these come first, that's still no
reason to use totally separate code paths and mechanisms.  These
requests can still use the same data structures / functions and just
be ordered to come first, can't they?  ...or given a boolean
"priority" and you can do two passes through your queue: one to do the
priority ones and one to do the secondary ones.


>>> +       spin_unlock_irqrestore(&ctrlr->lock, flags);
>>> +
>>> +       return ret;
>>> +}
>>
>>
>> As part of my overall confusion about why the batch cache is different
>> than the normal one: for the normal use case you still call
>> rpmh_rsc_write_ctrl_data() for things you put in your cache, but you
>> don't for the batch cache.  I still haven't totally figured out what
>> rpmh_rsc_write_ctrl_data() does, but it seems strange that you don't
>> do it for the batch cache but you do for the other one.
>>
>>
> flush_batch does write to the controller using
> rpmh_rsc_write_ctrl_data()

My confusion is that they happen at different times.  As I understand it:

* For the normal case, you immediately calls
rpmh_rsc_write_ctrl_data() and then later do the rest of the work.

* For the batch case, you call both later.

Is there a good reason for this, or is it just an arbitrary
difference?  If there's a good reason, it should be documented.


-Doug
