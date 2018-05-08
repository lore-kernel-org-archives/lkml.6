Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755435AbeEHQFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:05:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754920AbeEHQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:05:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 10:05:09 -0600
From: ilina@codeaurora.org
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>, dianders@google.com
Subject: Re: [PATCH v7 04/10] drivers: qcom: rpmh: add RPMH helper functions
In-Reply-To: <CAD=FV=VVrqHnVTATzbXYsZgj8gA9sO=Ky_HRvztfRmjLZoq0=Q@mail.gmail.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-5-ilina@codeaurora.org>
 <CAD=FV=VVrqHnVTATzbXYsZgj8gA9sO=Ky_HRvztfRmjLZoq0=Q@mail.gmail.com>
Message-ID: <ccd6a8e7a11b55f1e54737712facf064@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 14:26, Doug Anderson wrote:
Hi Doug,

> Hi,
> 
> On Wed, May 2, 2018 at 12:37 PM, Lina Iyer <ilina@codeaurora.org> 
> wrote:
>> +static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
>> +static DEFINE_SPINLOCK(rpmh_rsc_lock);
>> +
>> +static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
>> +{
>> +       int i;
>> +       struct rsc_drv *p, *drv = dev_get_drvdata(dev->parent);
>> +       struct rpmh_ctrlr *ctrlr = ERR_PTR(-EINVAL);
>> +       unsigned long flags;
>> +
>> +       if (!drv)
>> +               return ctrlr;
>> +
>> +       for (i = 0; i < RPMH_MAX_CTRLR; i++) {
>> +               if (rpmh_rsc[i].drv == drv) {
>> +                       ctrlr = &rpmh_rsc[i];
>> +                       return ctrlr;
>> +               }
>> +       }
>> +
>> +       spin_lock_irqsave(&rpmh_rsc_lock, flags);
>> +       list_for_each_entry(p, &rsc_drv_list, list) {
>> +               if (drv == p) {
>> +                       for (i = 0; i < RPMH_MAX_CTRLR; i++) {
>> +                               if (!rpmh_rsc[i].drv)
>> +                                       break;
>> +                       }
>> +                       if (i == RPMH_MAX_CTRLR) {
>> +                               ctrlr = ERR_PTR(-ENOMEM);
>> +                               break;
>> +                       }
>> +                       rpmh_rsc[i].drv = drv;
>> +                       ctrlr = &rpmh_rsc[i];
>> +                       break;
>> +               }
>> +       }
>> +       spin_unlock_irqrestore(&rpmh_rsc_lock, flags);
> 
> I may have missed something, but to me it appears that this whole
> "rsc_drv_list" is pretty pointless.  I wrote up a patch atop your
> series to remove it at
> <https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1042883/>
> and it simplifies the code a whole bunch.  From that patch, my
> justification was:
> 
>> The global rsc_drv_list was (as far as I can tell) racy and not useful
>> for anything.
>> 
>> I say it is racy because in general you need some sort of mutual
>> exclusion for lists.  If someone is adding to a list while someone
>> else is iterating over it then you get badness.
>> 
>> I say it is not useful because the only user of it was
>> get_rpmh_ctrlr() and the only thing it did was to verify that the
>> "struct rsc_drv *" that it alrady had was in the list.  How could it
>> not be?
> 
> Note that in v7 of your series you added a spinlock around your access
> of "rsc_drv_list", but this doesn't actually remove the race.
> Specifically I'm pretty sure that the list primitives don't support
> calling list_add() while someone might be iterating over the list and
> your spinlock isn't grabbed in rpmh_rsc_probe().
> 
> Note that I also say in my patch:
> 
>> NOTE: After this patch get_rpmh_ctrlr() still seems a bit fishy.  I'm
>> not sure why every caller would need its own private global cache of
>> stuff.  ...but I left that part alone.
> 
I am not sure I understand this.

> I'll try to dig into this more so I could just be confused, but in
> general it seems really odd to have a spinlock and something called a
> "cache" at this level.  If we need some sort of mutual exclusion or
> caching it seems like it should be stored in memory directly
> associated with the RPMh device, not some external global.
> 
The idea behind the locking is not to avoid the race between rpmh.c and 
rpmh-rsc.c. From the DT, the devices that are dependent on the RSCs are 
probed following the probe of the controller. And init is not that we 
are worried about.
The condition here is to prevent the rpmh_rsc[] from being modified 
concurrently by drivers.

Thanks,
Lina
