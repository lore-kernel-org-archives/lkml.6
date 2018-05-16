Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEPWMB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:12:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38488 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:11:59 -0400
X-Google-Smtp-Source: AB8JxZq4OmmEsGRAicjdiBRh/brmDM/6kgKUWjHudiCV168Ktk8nwuEAHwhJwfvgZGDegsLI6q32QQ==
Message-ID: <1526508715.28243.34.camel@arista.com>
Subject: Re: [PATCH 1/2] random: Omit double-printing ratelimit messages
From: Dmitry Safonov <dima@arista.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 May 2018 23:11:55 +0100
In-Reply-To: <20180516205437.GB4378@thunk.org>
References: <20180510125211.12583-1-dima@arista.com>
         <20180510125211.12583-2-dima@arista.com> <20180510181901.GG8335@thunk.org>
         <1525977460.28243.2.camel@arista.com> <20180510194041.GH8335@thunk.org>
         <1525981807.28243.9.camel@arista.com> <20180511035150.GJ8335@thunk.org>
         <1526042463.28243.21.camel@arista.com>
         <1526485573.28243.30.camel@arista.com> <20180516205437.GB4378@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 16:54 -0400, Theodore Y. Ts'o wrote:
> On Wed, May 16, 2018 at 04:46:13PM +0100, Dmitry Safonov wrote:
> > > Yeah, but what you print is not total sum, it's since the last
> > > interval because without mentioned flag ___ratelimit() will flush
> > > missed counter and print "suppressed" message.  They might even
> > > double if say other proccess has called get_random_bytes() got to
> > > ___ratelimit() and got preempted. This thread finishes
> > > initializing random driver and prints this not-proper-sum
> > > statistics, and when the code flow is back in the first context,
> > > it will print statistics again from ___ratelimit() function.
> > 
> > So, does it make sense to you, Theodore?
> > If not - I'll just resend second patch rebasing and dropping this
> > one.
> 
> Yes, it's correct that it's not the total sum.  I guess your
> complaint
> is that some of the messages are using the "callbacks suppressed"
> message, and the last one is using the random drvier's custom message
> which I think is much more user-friendly.  That being said, although
> I
> think "callbacks suppressed is a terrible message, I agree that using
> a single message makes more sense.  So setting the
> RATELIMIT_MSG_ON_RELEASE and then calling ratelimit_state_exit() from
> crng_reseed() does make sense.
> 
> In the future I'd like to push for some way to customize --- or
> perhaps just fix --- "callbacks suppressed" to something more sane
> like, "messages ratelimited", but that's more of an aesthetics issue.

Thanks, Ted.
As you've looked inside lib/ratelimit, care to review 2 patch from the
series maybe?

-- 
Thanks,
             Dmitry
