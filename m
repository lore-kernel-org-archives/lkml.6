Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 806F3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408FB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408FB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeFLPGu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:06:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45995 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeFLPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:06:49 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 3ce46dd2d57245a2; Tue, 12 Jun 2018 17:06:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Artem S Tashkinov <t.artem@mailcity.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH][v2] sched: cpufreq: Fix long idle judgement logic in load calculation
Date:   Tue, 12 Jun 2018 17:05:46 +0200
Message-ID: <3199989.mUnO823ZlS@aspire.rjw.lan>
In-Reply-To: <20180608040413.2pjfr6by3me5qymk@vireshk-i7>
References: <1528420053-22884-1-git-send-email-yu.c.chen@intel.com> <20180608040413.2pjfr6by3me5qymk@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 8, 2018 6:04:13 AM CEST Viresh Kumar wrote:
> On 08-06-18, 09:07, Chen Yu wrote:
> > According to current code implementation, detecting the long
> > idle period is done by checking if the interval between two
> > adjacent utilization update handers is long enough. Although
> > this mechanism can detect if the idle period is long enough
> > (no utilization hooks invoked during idle period), it might
> > not contain a corner case: if the task has occupied the cpu
> > for too long which causes no context switch during that
> > period, then no utilization handler will be launched until this
> > high prio task is switched out. As a result, the idle_periods
> > field might be calculated incorrectly because it regards the
> > 100% load as 0% and makes the conservative governor who uses
> > this field confusing.
> > 
> > Change the judgement to compare the idle_time with sampling_rate
> > directly.
> > 
> > Reported-by: Artem S. Tashkinov <t.artem@mailcity.com>
> > Cc: Artem S Tashkinov <t.artem@mailcity.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v2: Per Viresh's suggestion, ignore idle_time longer than 30mins and
> >     simplify the code.
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!


