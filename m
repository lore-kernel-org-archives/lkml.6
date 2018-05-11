Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeEKMlM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:41:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55946 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeEKMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:41:07 -0400
X-Google-Smtp-Source: AB8JxZqA3Ln8hmbz1a/RBHpy4VO2445h7bZF16rmLsITNXFzCK50GkItYY22NG21G7tONE9ERf4Jcw==
Message-ID: <1526042463.28243.21.camel@arista.com>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
From: Dmitry Safonov <dima@arista.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 May 2018 13:41:03 +0100
In-Reply-To: <20180511035150.GJ8335@thunk.org>
References: <20180510125211.12583-1-dima@arista.com>
         <20180510125211.12583-2-dima@arista.com> <20180510181901.GG8335@thunk.org>
         <1525977460.28243.2.camel@arista.com> <20180510194041.GH8335@thunk.org>
         <1525981807.28243.9.camel@arista.com> <20180511035150.GJ8335@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 23:51 -0400, Theodore Y. Ts'o wrote:
> On Thu, May 10, 2018 at 08:50:07PM +0100, Dmitry Safonov wrote:
> > random uses __ratelimit() which calls ___ratelimit() with a
> > function
> > name. Depending on !RATELIMIT_MSG_ON_RELEASE it prints how many
> > messages were suppressed every ratelimit interval (1 second for
> > random)
> > and flushes ratelimit_state::missed:
> 
> So the thing about the ratelimit system is that if you have a burst
> of
> 1,000,000 within the one second burst window, and then nothing ever
> again, you will never see a message accounting for those 1,000,000
> "callbacks" (which is a terrible wording; it just confuses people).
> 
> If you have a burst of 1,000,000 calls to ratelimit, and then a month
> goes by, and *then* a single call to __ratelimit is called by printk,
> only *the* does the message about the suppressed "callback" get
> printed.

Yes, if the initialization time of driver is lesser than a second.
If it's 1.1 sec - you'll have prints from ___ratelimit() and from your
driver too. And they differ in format.

> So in the case of the random driver, once the random driver is fully
> intialized, there will never be a call to __ratelimit() for the
> urandom ratelimit structures, so we manually print out the final
> number of suppressed message so there is proper accounting for them.

So, there is this flag, AFAICS, which perfectly fits your purpose
RATELIMIT_MSG_ON_RELEASE which will omit printing how many messages
were suppressed every interval of ___ratelimit(). And that will allow
you to print total in the end.

> It is not a double-count.  If we didn't do that, those suppressed
> warnings would never be mentioned by the kernel.

Yeah, but what you print is not total sum, it's since the last interval
because without mentioned flag ___ratelimit() will flush missed counter
and print "suppressed" message.
They might even double if say other proccess has called
get_random_bytes() got to ___ratelimit() and got preempted. This thread
finishes initializing random driver and prints this not-proper-sum
statistics, and when the code flow is back in the first context, it
will print statistics again from ___ratelimit() function. 

-- 
Thanks,
             Dmitry
