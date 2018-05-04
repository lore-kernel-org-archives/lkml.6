Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeEDUuK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:50:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34258 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeEDUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:50:07 -0400
X-Google-Smtp-Source: AB8JxZqsj6rDrhivkBMRuHsfsl9iXmVFGmgfUgZdzEKo0S+P+dIo1fynyAAiJDUsY/6u0HRa7cQTOg==
Date: Fri, 4 May 2018 13:50:05 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Lina Iyer <ilina@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180504205005.GC19594@google.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-5-ilina@codeaurora.org>
 <CAD=FV=VVrqHnVTATzbXYsZgj8gA9sO=Ky_HRvztfRmjLZoq0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VVrqHnVTATzbXYsZgj8gA9sO=Ky_HRvztfRmjLZoq0=Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:26:07PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 2, 2018 at 12:37 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> > +static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
> > +static DEFINE_SPINLOCK(rpmh_rsc_lock);
> > +
> > +static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
> > +{
> > +       int i;
> > +       struct rsc_drv *p, *drv = dev_get_drvdata(dev->parent);
> > +       struct rpmh_ctrlr *ctrlr = ERR_PTR(-EINVAL);
> > +       unsigned long flags;
> > +
> > +       if (!drv)
> > +               return ctrlr;
> > +
> > +       for (i = 0; i < RPMH_MAX_CTRLR; i++) {
> > +               if (rpmh_rsc[i].drv == drv) {
> > +                       ctrlr = &rpmh_rsc[i];
> > +                       return ctrlr;
> > +               }
> > +       }
> > +
> > +       spin_lock_irqsave(&rpmh_rsc_lock, flags);
> > +       list_for_each_entry(p, &rsc_drv_list, list) {
> > +               if (drv == p) {
> > +                       for (i = 0; i < RPMH_MAX_CTRLR; i++) {
> > +                               if (!rpmh_rsc[i].drv)
> > +                                       break;
> > +                       }
> > +                       if (i == RPMH_MAX_CTRLR) {
> > +                               ctrlr = ERR_PTR(-ENOMEM);
> > +                               break;
> > +                       }
> > +                       rpmh_rsc[i].drv = drv;
> > +                       ctrlr = &rpmh_rsc[i];
> > +                       break;
> > +               }
> > +       }
> > +       spin_unlock_irqrestore(&rpmh_rsc_lock, flags);
> 
> I may have missed something, but to me it appears that this whole
> "rsc_drv_list" is pretty pointless.  I wrote up a patch atop your
> series to remove it at
> <https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1042883/>
> and it simplifies the code a whole bunch.  From that patch, my
> justification was:
> 
> > The global rsc_drv_list was (as far as I can tell) racy and not useful
> > for anything.
> >
> > I say it is racy because in general you need some sort of mutual
> > exclusion for lists.  If someone is adding to a list while someone
> > else is iterating over it then you get badness.
> >
> > I say it is not useful because the only user of it was
> > get_rpmh_ctrlr() and the only thing it did was to verify that the
> > "struct rsc_drv *" that it alrady had was in the list.  How could it
> > not be?

I agree that the list doesn't seem to be very useful.

> Note that in v7 of your series you added a spinlock around your access
> of "rsc_drv_list", but this doesn't actually remove the race.
> Specifically I'm pretty sure that the list primitives don't support
> calling list_add() while someone might be iterating over the list and
> your spinlock isn't grabbed in rpmh_rsc_probe().

Actually adding a lock was my suggestion, but to protect against
another race that is still/again present with your patch:

> if (!rpmh_rsc[i].drv) {
>     rpmh_rsc[i].drv = drv;

This could be executed concurrently with both/all instances seeing
rpmh_rsc[i].drv == NULL and then clobbering each other.

>     spin_lock_init(&rpmh_rsc[i].lock);
>     INIT_LIST_HEAD(&rpmh_rsc[i].cache);
>     return &rpmh_rsc[i];
> }
