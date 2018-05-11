Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEKDv4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:51:56 -0400
Received: from imap.thunk.org ([74.207.234.97]:40308 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeEKDvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:51:55 -0400
Date: Thu, 10 May 2018 23:51:50 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
Message-ID: <20180511035150.GJ8335@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, Arnd Bergmann <arnd@arndb.de>
References: <20180510125211.12583-1-dima@arista.com>
 <20180510125211.12583-2-dima@arista.com>
 <20180510181901.GG8335@thunk.org>
 <1525977460.28243.2.camel@arista.com>
 <20180510194041.GH8335@thunk.org>
 <1525981807.28243.9.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525981807.28243.9.camel@arista.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:50:07PM +0100, Dmitry Safonov wrote:
> random uses __ratelimit() which calls ___ratelimit() with a function
> name. Depending on !RATELIMIT_MSG_ON_RELEASE it prints how many
> messages were suppressed every ratelimit interval (1 second for random)
> and flushes ratelimit_state::missed:

So the thing about the ratelimit system is that if you have a burst of
1,000,000 within the one second burst window, and then nothing ever
again, you will never see a message accounting for those 1,000,000
"callbacks" (which is a terrible wording; it just confuses people).

If you have a burst of 1,000,000 calls to ratelimit, and then a month
goes by, and *then* a single call to __ratelimit is called by printk,
only *the* does the message about the suppressed "callback" get
printed.

So in the case of the random driver, once the random driver is fully
intialized, there will never be a call to __ratelimit() for the
urandom ratelimit structures, so we manually print out the final
number of suppressed message so there is proper accounting for them.

It is not a double-count.  If we didn't do that, those suppressed
warnings would never be mentioned by the kernel.

Cheers,

						- Ted
