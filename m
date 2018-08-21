Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBADC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312D721581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312D721581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHUL4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:56:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49258 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeHUL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:56:54 -0400
Received: from 79.184.253.33.ipv4.supernova.orange.pl (79.184.253.33) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 015ee626f3aea79a; Tue, 21 Aug 2018 10:37:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] cpuidle: menu: Don't stay in shallow state for a long time
Date:   Tue, 21 Aug 2018 10:35:23 +0200
Message-ID: <7779444.DV2K5n5ugl@aspire.rjw.lan>
In-Reply-To: <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org> <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 12, 2018 6:09:30 PM CEST Leo Yan wrote:
> To avoid staying in a shallow state for a long time, the menu governor
> relies on not stopping tick when detects the prediction is shorter than
> the tick event.  This is just luckily to cover most cases but cannot say
> it is completely safe.  For example, if the prediction is 2000us and the
> TICK_USEC=1000 so it's impossible to meet the condition
> 'data->predicted_us < TICK_USEC' and this lead to stop the tick for a
> shallow state; finally the CPU is possible to stay in this shallow state
> for very long time.
> 
> This patch checks the candidate idle state isn't deepest one and find if
> the timer will come after more than 2 times of the maximum target
> residency, though the governor selects a shallow state according to
> prediction, due the timer is most reliable waken up source but it will
> come very late, so the CPU has chance to stay in the shallow state
> for a long time; the patch doesn't stop the tick for this case so can
> avoid powernightmares issue.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 4f02207..566c65c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -284,6 +284,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
>  static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
>  				      struct menu_device *data, int idx)
>  {
> +	int max_target_residency;
> +
> +	max_target_residency = drv->states[drv->state_count-1].target_residency;

But this state may be disabled, may it not?

Thanks,
Rafael

