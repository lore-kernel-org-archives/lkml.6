Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2394E214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfBAVzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:55:06 -0500
Received: from colin.muc.de ([193.149.48.1]:63785 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1726116AbfBAVzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:55:05 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 16:55:05 EST
Received: (qmail 43792 invoked by uid 3782); 1 Feb 2019 21:48:23 -0000
Received: from acm.muc.de (p4FE15ED8.dip0.t-ipconnect.de [79.225.94.216]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Fri, 01 Feb 2019 22:48:21 +0100
Received: (qmail 5451 invoked by uid 1000); 1 Feb 2019 21:47:00 -0000
Date:   Fri, 1 Feb 2019 21:47:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     34235@debbugs.gnu.org, Eli Zaretskii <eliz@gnu.org>,
        Alex Branham <alex.branham@gmail.com>
Subject: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix division
        by zero bug).  Problems with glibc.
Message-ID: <20190201214700.GA4950@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas, Hello Linux.

0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
posix-timers: Fix division by zero bug
Committed: 2018-12-17 17:35:45 +0100

With this patch in place I am seeing problems with glibc's function
timer_create.  I am an Emacs maintainer, and saw these problems whilst
investigating Emacs bug #34235 "27.0.50; lisp profiler does not work".
Full details of this bug are at
https://debbugs.gnu.org/cgi/bugreport.cgi?bug=34235.

Emacs's profiler fails in kernel 4.19.13, but works in a version of
4.19.13 with the patch reversed, otherwise unchanged.  My current version
of glibc is 2.27-r6 (I think the "-r6" comes from Gentoo, my distro).

The Emacs profiler works by a signal handler being repeatedly triggered
by the SIGPROF signal every 1 millisecond.  In the bug scenario, this
signal gets triggered precisely once each time the Emacs profiler is
started, rather than continually.

The core of the code in Emacs which initialises the glibc timer is:

      int i;
      struct sigevent sigev;
      sigev.sigev_value.sival_ptr = &profiler_timer;
      sigev.sigev_signo = SIGPROF;
      sigev.sigev_notify = SIGEV_SIGNAL;

      for (i = 0; i < ARRAYELTS (system_clock); i++)
        if (timer_create (system_clock[i], &sigev, &profiler_timer) == 0)
          {
            profiler_timer_ok = 1;
            break;
          }
    }

  if (profiler_timer_ok)
    {
      struct itimerspec ispec;
      ispec.it_value = ispec.it_interval = interval;
      if (timer_settime (profiler_timer, 0, &ispec, 0) == 0)
        return TIMER_SETTIME_RUNNING;
    }

The variable `interval' has been checked as non-zero.  This code is in
.../emacs/src/profiler.c

It seems either that the patch has uncovered some invalid call between
Emacs and glibc, or between glibc and Linux, or that there is some
intrinsic problem with the patch.

I have very little familiarity with glibc and Linux source code, so I
would be greatful if you could help me investigate the bug scenario.
Naturally, I will help as I can in this process.

Thanks in advance!

-- 
Alan Mackenzie (Nuremberg, Germany).
