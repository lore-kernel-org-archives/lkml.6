Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966426AbeE2Tcl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:32:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45495 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966107AbeE2Tci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:32:38 -0400
X-Google-Smtp-Source: ADUXVKJGBC2p6yLZBDSlwx0eDGMvuSCY7Wd1x/CeRR3jmH8N5N/rjlc3TBEHmCT/sk0XzIKMS/T9qA==
Date: Tue, 29 May 2018 12:32:36 -0700
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
Subject: Re: [PATCH 05/11] PM / devfreq: governors: Return device frequency
 limits instead of user limits
Message-ID: <20180529193236.GH168650@google.com>
References: <20180525203043.249193-6-mka@chromium.org>
 <20180525203043.249193-1-mka@chromium.org>
 <CGME20180525203125epcas3p46c7cac352ede4b0ba5d2b36bc32ad566@epcms1p8>
 <20180528050444epcms1p8e6552d55231a099ec89304dfb1f819b9@epcms1p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180528050444epcms1p8e6552d55231a099ec89304dfb1f819b9@epcms1p8>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 02:04:44PM +0900, MyungJoo Ham wrote:
> >The performance, powersave and simpleondemand governors can return
> >df->min/max_freq, which are the user defined frequency limits.
> >update_devfreq() already takes care of adjusting the target frequency
> >with the user limits if necessary, therefore we can return
> >df->scaling_min/max_freq instead, which is the min/max frequency
> >supported by the device at a given time (depending on the
> >enabled/disabled OPPs)
> >
> >Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >---
> > drivers/devfreq/governor_performance.c    | 2 +-
> > drivers/devfreq/governor_powersave.c      | 2 +-
> > drivers/devfreq/governor_simpleondemand.c | 6 +++---
> > 3 files changed, 5 insertions(+), 5 deletions(-)
> >
> 
> Actually, even scaling_max_freq and scaling_min_freq are
> covered centerally at devfreq.c:update_devfreq();
> 
> Wouldn't it be sufficient to return UINT_MAX for performance
> and return UINT_MIN (0) for powersave, if the purpose is to
> remove redundancy?
> 
> In the same sense, we may return UINT_MAX for freq-increasing
> case for simpleondemand as well, because they are filtered
> centrally anyway.
> 
> (This commit might be better merged to 4/11 in that case as well.)

I did this in the first variant of the patch (before sending it in a
series), but Chanwoo Choi objected:

https://patchwork.kernel.org/patch/10404893/

I also still think that returning a constant would be the cleanest
solution if we can agree on this. What do you think about
DEVFREQ_MIN/MAX_FREQ (0/UINT_MAX) to make things slightly clearer?
