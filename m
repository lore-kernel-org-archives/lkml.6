Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4931121905
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfBMMCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:02:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:53174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbfBMMCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:02:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79598AC3D;
        Wed, 13 Feb 2019 12:02:51 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:02:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] kthread: Do not use TIMER_IRQSAFE
Message-ID: <20190213120250.qqlw3g2aen5aispq@pathway.suse.cz>
References: <20190212162554.19779-1-bigeasy@linutronix.de>
 <20190212162554.19779-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162554.19779-2-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 17:25:54, Sebastian Andrzej Siewior wrote:
> The TIMER_IRQSAFE was introduced in commit
> 
>   22597dc3d97b1 ("kthread: initial support for delayed kthread work")
> 
> which modelled the delayed kthread code after workqueue's code. The
> workqueue code requires the flag TIMER_IRQSAFE for synchronisation
> purpose. This is not true for kthread's delay timer since all
> operations occur under a lock.

Great catch! The original proposal used a lockless code. We missed
that the irq safe timer was not longer needed with the spin lock.

> Remove TIMER_IRQSAFE from the timer initialisation.
> Use timer_setup() for initialisation purpose which is the official
> function.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
