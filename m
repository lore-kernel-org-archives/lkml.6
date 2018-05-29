Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966581AbeE2UCo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:02:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46675 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966433AbeE2UCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:02:42 -0400
X-Google-Smtp-Source: AB8JxZroXXCOk+CXsZ9KyTEfI/EfoZuO3Z2gtBKQVCQZ8+3sOBetcubBS2quBe3xj6+t5D/UraCHug==
Date: Tue, 29 May 2018 13:02:40 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 07/11] PM / devfreg: Add support policy notifiers
Message-ID: <20180529200240.GI168650@google.com>
References: <20180525203043.249193-8-mka@chromium.org>
 <20180525203043.249193-1-mka@chromium.org>
 <CGME20180525203128epcas5p138dbf89498c03bc2a9221aa662001fd4@epcms1p3>
 <20180528051949epcms1p3bedd6ac3e2f20d0bcd8cb082349d97fa@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528051949epcms1p3bedd6ac3e2f20d0bcd8cb082349d97fa@epcms1p3>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 02:19:49PM +0900, MyungJoo Ham wrote:
> >Policy notifiers are called before a frequency change and may narrow
> >the min/max frequency range in devfreq_policy, which is used to adjust
> >the target frequency if it is beyond this range.
> >
> >Also add a few helpers:
> > - devfreq_verify_within_[dev_]limits()
> >    - should be used by the notifiers for policy adjustments.
> > - dev_to_devfreq()
> >    - lookup a devfreq strict from a device pointer
> >
> >Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >---
> > drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++-------
> > include/linux/devfreq.h   | 66 +++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 102 insertions(+), 11 deletions(-)
> 
> Hello Matthias,
> 
> 
> Why should we have yet another notifier from an instance of devfreq?
> Wouldn't it better to let the current notifier (transition notifier)
> handle new events as well by adding possible event states to it?

Honestly the main reason is that I sought inspiration from cpufreq,
which uses a dedicated policy notifier. Unfortunately this change
predates the git history so I don't know what was the exact rationale
to do it this way.

Some minor advantages that I see are:

- transition notifiers aren't bothered about adjustments and viceversa
- different data types are passed for transitions and adjustments,
  which makes code of notifiers that handle both a bit more messy.

> Anyway, is this the reason why you've separated some data of devfreq
> into "policy" struct? (I was wondering why while reading commit 6/11).

The DEVFREQ_ADJUST is the reason for the "policy struct". With this
change we are dealing with 3 types of frequency pairs: user
(df->min/max_freq), devinfo (df->scaling_min/max_freq) and the
policy/adjustable ones. I think it is cleaner to group them in a
struct (and sub-structs), rather than having 6 individual
<type>_min/max_freq variables. Also it allows to only pass the policy
object to the notifiers, instead of the entire devfreq device.

I opted to do the introduction of the struct policy in a separate NOP
patch, because I think it is easier to review the 'reorg' churn
and the functional change separately.

Please let me know if you'd prefer to have certain things done
differently.

Thanks

Matthias
