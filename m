Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D438C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E8320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfAHVhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:37:47 -0500
Received: from muru.com ([72.249.23.125]:60758 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfAHVhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:37:46 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4CEBD8080;
        Tue,  8 Jan 2019 21:37:52 +0000 (UTC)
Date:   Tue, 8 Jan 2019 13:37:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190108213743.GN5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
> > Hmm so could it be that we now rely on timers that that may
> > not be capable of waking up the system from idle states with
> > hrtimer?
> 
> With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> the tick so you should use the same interrupt.

OK yeah looks like that part is working just fine.

Adding some printks and debugging over ssh, looks like
omap8250_runtime_resume() gets called just fine based on a wakeirq,
but then omap8250_runtime_suspend() runs immediately instead of
waiting for the three second timeout.

Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
Anything higher than 2200 ms seems to somehow time out immediately
now :)

Regards,

Tony
