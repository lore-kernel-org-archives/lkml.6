Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeCGCRL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:17:11 -0500
Received: from eso.teric.us ([69.164.192.171]:41040 "EHLO eso.teric.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754150AbeCGCRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:17:09 -0500
Date: Tue, 6 Mar 2018 20:17:08 -0600
From: Julia Cartwright <juliac@eso.teric.us>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, pageexec@freemail.hu
Subject: Re: C tricks for efficient stack zeroing
Message-ID: <20180307021708.GC1924@kryptos.localdomain>
References: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 08:50:17PM +0100, Jason A. Donenfeld wrote:
[..]
> What would be really nice would be to somehow keep track of the
> maximum stack depth, and just before the function returns, clear from
> the maximum depth to its stack base, all in one single call. This
> would not only make the code faster and less brittle, but it would
> also clean up some algorithms quite a bit.
> 
> Ideally this would take the form of a gcc attribute on the function,
> but I was unable to find anything of that nature. I started looking
> for little C tricks for this, and came up dry too. I realize I could
> probably just take the current stack address and zero out until _the
> very end_ but that seems to overshoot and would probably be bad for
> performance. The best I've been able to do come up with are some
> x86-specific macros, but that approach seems a bit underwhelming.
> Other approaches include adding a new attribute via the gcc plugin
> system, which could make this kind of thing more complete [cc'ing
> pipacs in case he's thought about that before].

Can objtool support a static stack usage analysis?

I'm wondering if it's possible to place these sensitive functions in a
special linker section, like .text.stackzero.<tag>; objtool could
collect static call data (as it already does) and stack usage, spitting
out a symbol definition stackzero_<tag>_max_depth, which you could then
use to bound your zeroing.

Obviously this is a static analysis, with the limitations therein.

   Julia
