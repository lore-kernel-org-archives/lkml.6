Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E462089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E462089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbeGKMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732819AbeGKMzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:55:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0DA20652;
        Wed, 11 Jul 2018 12:51:03 +0000 (UTC)
Date:   Wed, 11 Jul 2018 08:51:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why the mce reverts in 4.16-rt?
Message-ID: <20180711085101.553face7@gandalf.local.home>
In-Reply-To: <20180711072311.cprdgb2xqwag2iem@linutronix.de>
References: <20180710205624.19ff9ef0@gandalf.local.home>
        <20180711072311.cprdgb2xqwag2iem@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:23:11 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-07-10 20:56:24 [-0400], Steven Rostedt wrote:
> > Hi Sebastian,  
> Hi Steven,
> 
> > I'm looking at backporting patches from 4.16-rt and noticed that you
> > have:
> > 
> > Revert "x86: Convert mce timer to hrtimer"
> > Revert "x86/mce: use swait queue for mce wakeups"
> > 
> > With no explanation to why they were reverted. When did things change?
> > Should this be 4.14-rt material?  
> 
> from the announce email:
> |    Changes since v4.16.8-rt2:
> |    
> |      - Drop two MCE related patches. They are no longer required since the
> |        timer wheel rework.

Thanks, still would have preferred a comment in the revert commit
message ;-)

> 
> The timer wheel rework made it possible to have a raw_spin_lock_t in the
> timer_list timer. The problem with MCE was that it enqueued a timer from
> hardirq context which is now possible. So the patches are no longer
> required. This revert does not fix a bug in v4.14 nor does it break
> anything.

OK, even though this doesn't fix anything, I think I'll still
backport it.

-- Steve
