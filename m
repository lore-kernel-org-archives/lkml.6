Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4157DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D970220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTBE7TeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbeGKReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:34:11 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41782 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeGKReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:34:11 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so10324707ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSali/o/AcG5to4gY3V1TuvA/3y1XMLyE6wn98yA4pI=;
        b=iTBE7TeC/viOlWHHhvW9lyeqDH11zdfC+eOdBbUhooLrJCjiTJN4/6s5m+pEHHq5YH
         7L7/zCrqFSDHG7o9iW2zwcFi0ujE6+wSGnO/W5FYVht8F1GzeOLkHsJW4D9JGNRQ6oMs
         NASaBhMUWr6s4L8zmQ7RgNL+0Jdt8srKve4zvKozl2bF2pwC1UEKZBHSS1xGRuA8PEiH
         SBAeiKz8LQOS7rLj5EDF66OBDgEx0FVKSmNMhcfXVu2OkAq7VOSInS3YN1cwm1A1O/17
         Dn6achesqdJPitKxdJU84KhIGfrz+muHcNd2+YFhfVsp7cX6QUYBx8tqNM9vJpgmCZiA
         d0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSali/o/AcG5to4gY3V1TuvA/3y1XMLyE6wn98yA4pI=;
        b=TXhgZGAkbmd3q1slklSPo4KqCQVENHtfuyRoxOxNDisPD2uYTFoOg1bCqQsIeFkxtg
         4BJ7T2QWhTZkWg2870j6lx335VwZfet4yNPILiIo8vOuw8xeuQsIfxR3klETNMlcU3J5
         QDJY21Di4O05xwlgQWXzR4VjwGBQY0mAbrWcs1lUTvIxFgYxVAn/uHX/x9+/WphdhQcB
         lHdkqLNag5i1H5P/wNlgbNPzcvG/dCDRHkfbJTdVgqoZdl7oRwjqnlVzv/W07MehVqcC
         aYb7wMofJzOkc2bk6o9EJKij+yWvF7VZtiC3pSMakPEicOomre5dFSLSYR+6w+qNEBR/
         mJxA==
X-Gm-Message-State: APt69E0Ds7UVSPJ1UQVQAoBoU8tGXIOW5gYlzOdnof39BTUY8NfskGyB
        nnnyR6GGiGNB1FSlzkI/Q3I=
X-Google-Smtp-Source: AAOMgpe4rNCkCNf/QJBag6q75HbC07gE9RtraTX+xOI5aIGnh2ovE+BuGUuUIpe28k25mkeeQMOTvA==
X-Received: by 2002:a25:23d3:: with SMTP id j202-v6mr16435026ybj.350.1531330130891;
        Wed, 11 Jul 2018 10:28:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id h145-v6sm4663026ywc.3.2018.07.11.10.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:28:50 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:28:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] cgroup: use irqsave in cgroup_rstat_flush_locked()
Message-ID: <20180711172848.GF72677@devbig577.frc2.facebook.com>
References: <20180703164544.25268-1-bigeasy@linutronix.de>
 <20180703202424.GB72677@devbig577.frc2.facebook.com>
 <20180703213539.i3mozfuhi7j7xefm@linutronix.de>
 <20180711110513.7gqhlf6odqoxnext@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711110513.7gqhlf6odqoxnext@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sebastian.

On Wed, Jul 11, 2018 at 01:05:13PM +0200, Sebastian Andrzej Siewior wrote:
> > > We at least used to do this in the kernel - manipulating irqsafe locks
> > > with spin_lock/unlock() if the irq state is known, whether enabled or
> > > disabled, and ISTR lockdep being smart enough to track actual irq
> > > state to determine irq safety.  Am I misremembering or is this
> > > different on RT kernels?
> > 
> > No, this is correct. So on !RT kernels the spin_lock_irq() disables
> > interrupts and the raw_spin_lock() has the interrupts already disabled,
> > everything is good. On RT kernels the spin_lock_irq() does not disable
> > interrupts and the raw_spin_lock() acquires the lock with enabled
> > interrupts and lockdep complains properly.
> > lockdep sees the hardirq path via:

I feel weary about applying a patch which isn't needed in mainline,
especially without annotations or at least comments.  I suppose it may
not be too common but this can't be the only place which needs this
and using irqsave/restore spuriously in all those sites doesn't sound
like a good solution.  Is there any other way of handling this?

Thanks.

-- 
tejun
