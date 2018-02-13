Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965241AbeBMRjw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:39:52 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44264 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeBMRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:39:51 -0500
X-Google-Smtp-Source: AH8x226ZqRZ5I0mKVEGiB9gCmc1ENjQPX59fLVB4T95tJhwVowsGkCglQAeGBmOk1sko4gLVbx90Lg==
Date: Tue, 13 Feb 2018 20:39:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
Message-ID: <20180213173946.GB28598@avx2>
References: <20180210211110.GA24324@avx2>
 <CAGXu5jL2xLz88X8in-9GjLZyDQzynYvf3bKDnCPVgL+e3uGFLw@mail.gmail.com>
 <20180212115822.GA4984@avx2>
 <CAGXu5jL8zjn1c0bHDz8SF8fkpt2WZ9-_n1suYi_hJsaOBRK=oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL8zjn1c0bHDz8SF8fkpt2WZ9-_n1suYi_hJsaOBRK=oA@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:03:06AM -0800, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 3:58 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Sun, Feb 11, 2018 at 01:27:58PM -0800, Kees Cook wrote:
> >> On Sat, Feb 10, 2018 at 1:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >> > Once upon a time module parameter parsing code accepted
> >> > 0, 1, y, n, Y and N for boolean values. Gratituous but contained
> >> > to module code and thus tolerable.
> >>
> >> And kernel command line.
> >
> > True that.
> 
> The divergence in behavior is what I think is weirdest. Everything
> _except_ this change will take generous inputs.
> 
> >> > Commit ef951599074ba4fad2d0efa0a977129b41e6d203
> >> > ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
> >> > to kstrtobool() and, more importantly, kstrtobool_from_user().
> >> >
> >> > Later set of accepted values was expanded to "on" and "of".
> >> > Now there are 6+8=14(!) valid strings for a boolean.
> >> >
> >> > This patch reduces set of accepted values to "0" and "1"
> >> > (with optional newline) in spirit with other kstrto*() functions.
> >> >
> >> > I'm starting with kstrtobool_from_user() as it is explicitly designed
> >> > to be used for interacting with userspace. Currently there are 9 users
> >> > all debug code, so there is hope.
> >> >
> >> > Please send before 4.16 so no real users start to depend on verbose behaviour.
> >> >
> >> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>
> >> Why bother? What's wrong with generous input parsing? This just
> >> creates a divergence where none is needed.
> >
> > Generous parsing creates more problems and more code than necessary.
> > kstrtobool() is very instructive example.
> >
> > Booleans are 2 values, so 2 strings is enough.
> > Add optional newline so shell users don't have to type "echo -n".
> > That's all.
> >
> > In a generous world things are little more complicated:
> >
> > First, as written code doesn't accept "on" it accepts "on.*" and
> > "of.*". Now imagine some parameter gets semantic change from "on/off"
> 
> Well, this already accepts the newlines you mentioned, so that matches
> the needs there.
> 
> > to "on/off/once" (kmemleak-style detectors).
> 
> At that point it's no longer a boolean, so it makes sense to have
> different parsing rules.
> 
> > Second, English centric view of the world. If English speaking users get
> > more usability with "on" and "off" why, say, 150 millions of
> > Russian-speaking people can't get that too. And if you accept that argument,
> > encoding subquestion arises immediately.
> 
> The kernel is English-centric. Just look at comments, variables, /sys,
> /proc, etc. I don't find this a compelling argument.
> 
> > At this point you've adding Merriam Webster and libicu to the kernel.
> 
> See above; this won't turn into a slippery slope.
> 
> > Third, it is simply more code in ring 0. If anyone wants user-friendly
> > parameters, then write wrappers and leave kernel alone.
> 
> This is the problem: it was already all kernel code. There were
> separate non-compatible boolean parsers scattered around the kernel
> and this unified the boolean parsing into one place to avoid code
> duplication (which can have bugs) and unexpected results (which
> frustrates users). This is attempting to fragment the code again, with
> no obvious benefit.

You're implying that all the code that can be unified should be unified.

Fancy boolean parsing was a wart, someone added yYnN because it was cool,
but I don't know the story, it was before me.

Let's look at it form the other side:
0 and 1 are accepted, you come and say "lets accept yes and no".
Natural answer will be "whay can't you use 0 and 1?".

>From the documentation point of view it may be also
beneficial: all those blogs posts will use all the same "0" and "1"
but now they have many more variants and will feel kind of random.

I have no problem with kernel parameters parsing acceping something
other than "0" and "1", some of them are ancient. But what you did is
to put it all over proc, sysfs, and debugfs which is a lot of exposure.

Benefit is that core stays well designed and minimal and the rest can
live outside. Integer kstrto*() functions don't accept "one" and "zero"
just like they don't accept Roman numerals. Kernel is not a place
for UI games.
