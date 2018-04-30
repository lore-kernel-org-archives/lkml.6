Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbeD3AVJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 20:21:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:43552 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754359AbeD3AVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 20:21:08 -0400
Date: Sun, 29 Apr 2018 20:21:03 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dave Jones <davej@codemonkey.org.uk>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180430002102.GT5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
 <20180429230202.rcsjtnp2jhbqyag2@codemonkey.org.uk>
 <20180429230728.whjg3fpeunxuvkyn@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429230728.whjg3fpeunxuvkyn@codemonkey.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 07:07:29PM -0400, Dave Jones wrote:
>  > Why do we continue to print this stuff out when crng_init=1 though ?
> 
> answering my own question, I think.. This is a tristate, and we need it
> to be >1 to be quiet, which doesn't happen until..
> 
>  > [  165.806247] random: crng init done
> 
> this point.

Right.  What happens is that we divert the first 64 bits of entropy
credits directly into the crng state, without initializing the
input_pool.  So when we hit crng_init=1, the crng has only 64 bits of
entropy (conservatively speaking); furthermore, since we aren't doing
catastrophic reseeding, if something is continuously reading from
/dev/urandom or get_random_bytes() during that time, then the attacker
could be able to detremine which one of the 32 states the entropy pool
was when the entropy count was 5, and then 5 bits later, poll the
output of the pool again, and guess which of the 32 states the pool
was in, etc., and effectively keep up with the entropy as it trickles
in.

This is the reasoning behind catastrophic reseeding; we wait until we
have 128 bits of entropy in the input pool, and then we reseed the
pool all at once.

Why do we have the crng_init=1 state?  Because it provides some basic
protection for super-early users of the entropy pool.  It's
essentially a bandaid, and we could improve the time to get to fully
initialize by about 33% if we left the pool totally unititalized and
only focused on filling the input pool.  But given that on many
distributions, ssh still insists on initializing long-term public keys
at first boot from /dev/urandom, instead of *waiting* until the first
time someone attempts to ssh into box, or waiting until getrandom(2)
doesn't block --- without hanging the boot --- we have the crng_init=1
hack essentially as a palliative.

I view this as working around broken user space.  But userspace has
been broken for a long time, and users tend to blame the kernel, not
userspace....

						- Ted
