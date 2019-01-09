Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfAIIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:31:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfAIIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:31:14 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gh9GZ-00009s-E1; Wed, 09 Jan 2019 09:31:11 +0100
Date:   Wed, 9 Jan 2019 09:31:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Message-ID: <20190109083107.xqjreevkq3lkkfzq@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
 <20190107165056.2lhd53umgt4vod5o@linutronix.de>
 <1546975187.3632.10.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546975187.3632.10.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 13:19:47 [-0600], Scott Wood wrote:
> >  We
> > do it for rtmutex because !RT does it for mutex.
> > Now I can't remember why this was skipped for a rw_sem since it is
> > performed for !RT as part of the schedule() invocation.
> 
> Without this we were seeing XFS hangs on our internal kernel.  I wasn't able
> to reproduce it on a newer kernel, but it's very timing-dependant so I
> wouldn't read too much into that.

In this case I don't care much if you can reproduce this or not. The
point is that !RT does this so RT should do it, too. And back then (when
this piece was added) we wanted to copy the !RT behaviour and somehow
missed that piece.

> > If I don't come up with a plausible explanation then I will apply this
> > plus a hunk for the __down_write_common() case which should also be
> > required (right?).
> 
> I don't think it's needed, as it doesn't call into the rtmutex code via a
> backdoor.  When blocking on sem->rtmutex, rt_mutex_fastlock() will call the
> flush.  When blocking with a direct call to schedule(), tsk_is_pi_blocked()
> will not be true, and thus schedule() will do the flush via
> sched_submit_work().

a backdoor :) But yes, in each case we invoke schedule() so it is good.
Okay then. Let me apply it.
Thank you.

> -Scott

Sebastian
