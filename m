Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933062AbeBLL62 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:58:28 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35882 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeBLL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:58:26 -0500
X-Google-Smtp-Source: AH8x227rubXeebTAdt0QmPzvFOrpuOViMGY7LBAqIpQsipnmMj0AdDzBRPu49INgf4Hn1ClE36J0Hw==
Date: Mon, 12 Feb 2018 14:58:22 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
Message-ID: <20180212115822.GA4984@avx2>
References: <20180210211110.GA24324@avx2>
 <CAGXu5jL2xLz88X8in-9GjLZyDQzynYvf3bKDnCPVgL+e3uGFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL2xLz88X8in-9GjLZyDQzynYvf3bKDnCPVgL+e3uGFLw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 01:27:58PM -0800, Kees Cook wrote:
> On Sat, Feb 10, 2018 at 1:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Once upon a time module parameter parsing code accepted
> > 0, 1, y, n, Y and N for boolean values. Gratituous but contained
> > to module code and thus tolerable.
> 
> And kernel command line.

True that.

> > Commit ef951599074ba4fad2d0efa0a977129b41e6d203
> > ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
> > to kstrtobool() and, more importantly, kstrtobool_from_user().
> >
> > Later set of accepted values was expanded to "on" and "of".
> > Now there are 6+8=14(!) valid strings for a boolean.
> >
> > This patch reduces set of accepted values to "0" and "1"
> > (with optional newline) in spirit with other kstrto*() functions.
> >
> > I'm starting with kstrtobool_from_user() as it is explicitly designed
> > to be used for interacting with userspace. Currently there are 9 users
> > all debug code, so there is hope.
> >
> > Please send before 4.16 so no real users start to depend on verbose behaviour.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Why bother? What's wrong with generous input parsing? This just
> creates a divergence where none is needed.

Generous parsing creates more problems and more code than necessary.
kstrtobool() is very instructive example.

Booleans are 2 values, so 2 strings is enough.
Add optional newline so shell users don't have to type "echo -n".
That's all.

In a generous world things are little more complicated:

First, as written code doesn't accept "on" it accepts "on.*" and
"of.*". Now imagine some parameter gets semantic change from "on/off"
to "on/off/once" (kmemleak-style detectors).

Formally you can't add "once" because user in theory may use "once"
by accident or mistake and expecting "on" behaviour which he relies
upon.

In a very strict world, I add "2" for "once" and document it.
Now I know that no users were broken, because kstrtobool() returned
errors for "2" previously.

Second, English centric view of the world. If English speaking users get
more usability with "on" and "off" why, say, 150 millions of
Russian-speaking people can't get that too. And if you accept that argument,
encoding subquestion arises immediately.

At this point you've adding Merriam Webster and libicu to the kernel.

Third, it is simply more code in ring 0. If anyone wants user-friendly
parameters, then write wrappers and leave kernel alone.

To reiterate, it was mistake to add "yYnN" to module and kernel parameter
parsing code, it was another mistake to propagate yYnN to generic code.
Those "on" and "off" exceptions should have stayed where they were as
small monuments to kernel imperfection :^)
