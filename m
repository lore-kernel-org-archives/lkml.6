Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B3AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81752084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfBMMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:13:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:54648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfBMMND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:13:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5980AACE1;
        Wed, 13 Feb 2019 12:13:02 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:13:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        tglx@linutronix.de, Julia Cartwright <julia@ni.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>
Subject: Re: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Message-ID: <20190213121301.d6sff2thya5eubwl@pathway.suse.cz>
References: <20190212162554.19779-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162554.19779-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 17:25:53, Sebastian Andrzej Siewior wrote:
> From: Julia Cartwright <julia@ni.com>
> 
> In order to enable the queuing of kthread work items from hardirq
> context even when PREEMPT_RT_FULL is enabled, convert the worker
> spin_lock to a raw_spin_lock.
> 
> This is only acceptable to do because the work performed under the lock
> is well-bounded and minimal.

I could confirm that it is well-bounded and minimal. The most
expensive function probably is add_timer() called from
__kthread_queue_delayed_work(). It might spin a bit
to get timer->base->lock.

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reported-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
