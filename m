Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEJTuN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:50:13 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54866 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:50:12 -0400
X-Google-Smtp-Source: AB8JxZp9MtsGFtnmAgT2uvh0vD6m+Teak4zURmiXOEwasf1AIBHvbJCbEpv/VwjjQCMB/EX/i9mhnA==
Message-ID: <1525981807.28243.9.camel@arista.com>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
From: Dmitry Safonov <dima@arista.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 May 2018 20:50:07 +0100
In-Reply-To: <20180510194041.GH8335@thunk.org>
References: <20180510125211.12583-1-dima@arista.com>
         <20180510125211.12583-2-dima@arista.com> <20180510181901.GG8335@thunk.org>
         <1525977460.28243.2.camel@arista.com> <20180510194041.GH8335@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 15:40 -0400, Theodore Y. Ts'o wrote:
> On Thu, May 10, 2018 at 07:37:40PM +0100, Dmitry Safonov wrote:
> > 
> > Ok, then what's the purpose of those messages?
> > :        pr_notice("random: %d get_random_xx warning(s) missed "
> > :                  "due to ratelimiting\n",
> > :                  unseeded_warning.missed);
> > :        pr_notice("random: %d urandom warning(s) missed "
> > :                  "due to ratelimiting\n",
> > :                  urandom_warning.missed);
> > 
> > I thought you want to print the summary after initializing random,
> > not once per second?
> 
> Yes, and that's what is happening today.  The "output lines
> suppressed
> due to ratelimiting" message is only printed out by
> printk_ratelimit()
> function, which we are *not* using.

random uses __ratelimit() which calls ___ratelimit() with a function
name. Depending on !RATELIMIT_MSG_ON_RELEASE it prints how many
messages were suppressed every ratelimit interval (1 second for random)
and flushes ratelimit_state::missed:

:if (time_is_before_jiffies(rs->begin + rs->interval)) {
:    if (rs->missed) {
:        if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
:            printk_deferred(KERN_WARNING
:                            "%s: %d callbacks suppressed\n",
:                            func, rs->missed);
:            rs->missed = 0;
:        }
:    }
:    rs->begin   = jiffies;
:    rs->printed = 0;
:}

-- 
Thanks,
             Dmitry
