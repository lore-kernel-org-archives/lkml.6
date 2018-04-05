Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeDETc4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:32:56 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:52872 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeDETcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:32:54 -0400
X-Google-Smtp-Source: AIpwx4/YLmYQYnwRhf9WzugtMB/38qIKW+iU+ctpS+awTuO077Y4D0rC9y6XGbSvGW5Q8C7alz8K4p+yEhI+6d2J6Jw=
MIME-Version: 1.0
In-Reply-To: <20180405190441.GC12349@sirena.org.uk>
References: <s5hwoxmdpmu.wl-tiwai@suse.de> <CA+55aFxuowsvQyq0+xeq=ganTHqw2uZ6kkZ8DBk0k01cJHUzjA@mail.gmail.com>
 <20180405190441.GC12349@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 12:32:52 -0700
X-Google-Sender-Auth: e_g1SH4LECjDyvoouEwmHwvRZXs
Message-ID: <CA+55aFw3B=2NjM2dapxFRU=GYtMJ+Mm=MBVDEp8PNqp9LGz_7Q@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.17-rc1
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 12:04 PM, Mark Brown <broonie@kernel.org> wrote:
>
> I'm a little bit confused about what's best to do here.  The reason I'm
> throwing the merge away and redoing it is that you've previously said
> that you don't want to see main development branches that contain
> nothing but long strings of merges, if I keep the same set of branches
> and just do the merges incrementally every time a branch is added or
> changes then there'd be even more merges which I'm pretty sure you
> wouldn't be at all happy with either.

Don't do the merges AT ALL. Not until the branch is done. Stop the
whole "daily merges" entirely. It's wrong.

The whole idea with a topic branch is that it's a topic branch. You do
the development on that branch, and then at the END of development you
merge it once and that branch is now *dead*. If you continue using
that branch, you shouldn't be merging it.

So nobody ever sees empty merges, because by definition they never
happen.  You only merge a branch once, and obviously only when it
actually had real changes in it.

And if you do daily merges for testing, then do them into a *testing*
branch. Those daily merges have nothing what-so-ever to do with what
you should send upstream, they are for testing.

In short: do not do any automated merges for upstreaming AT ALL.
Automated merging for that is WRONG. Don't do it.

It really is that simple.

So we have roughly three entirely different cases:

 (1) testing (daily, weekly, hourly, "on demand", "when I feel like
it", or for linux-next, or whatever).

     This has absolutely *nothing* to do with upstreaming, and
shouldn't ever be in your development branch.

     Have a separate branch for testing (or for "linux-next pulls
this"), and then you can do automated merging in that branch, but the
whole point is that is a throw-away branch for checking things out.

     The kinds of things you check out can be many different things,
like "does it merge at all and have conflicts?" or "does it build?" or
"does it work?".

     The more of this kind of automation you do the better. Do it
daily. Do it every hour. Have a test-farm that does a build every
single time any branch changes at all. Whatever floats your boat.

     And nobody will ever complain, because nobody will ever even
*see* it. Except perhaps in the sense of "Wow, Mark really does a
great job, and all his branches just always work", because all the
daily testing you do means that you see any problems long before
anybody else sees it.

 (2) if you have an EXPLICIT REASON to merge

     You have two branches that have an actual dependency, or some
other interaction, and you want to merge them together.

     THIS IS NEVER EVER AUTOMATED!

     It shouldn't even be scripted, because this shouldn't be about
tens of branches anyway, and it certainly shouldn't be something all
that common, or something is seriously wrong.

     And btw, in this case the merge commit message should talk about
what the dependency was, which is another reason why this shouldn't be
scripted or automated.

 (3) if you are done and ready with a branch, and it's time to just
say "the development on this branch is all done, now I will ask
upstream to pull it, and I'll merge this into my upstream branch"

     THIS IS NEVER AUTOMATED!

     Sure, you might script it ("I have 35+ branches that I will send
out, I use a script to merge them all together"), but the act of
running that script is not something daily, it's something like "I am
now ready to ask Takashi to take this", so you do it before you do the
pull request to upstream.

See? Three cases. One of them may well be entirely automated and
possibly have a lot of merges, but that one will never ever be
relevant for upstream, and should never be in a branch that you expose
upstream anyway.

And you don't do merges and then undo them. If you do the automated
thing, just do them in a throw-away branch, so even then you never
need to undo them - because you just throw them away afterwards.

Now exactly when you decide to throw it away is entirely up to you.
Maybe you create a new branch each time you do a test build. Or maybe
you keep the same "merge after merge after merge" branch for a while,
and you only throw them away when you have done the "send upstream"
thing. Nobody will care, because nobody will ever see that outside of
the automation scripts.

Are there possibly other cases that are relevant? Maybe. But the above
should be the basic guideline. Upstream should basically have minimal
merges, because it really just makes history harder to see. The empty
merges in particular that clearly have no actual *reason* for them.

That's another way of seeing the same issue: if you cannot write an
actual explicit reason for the merge, it damn well should never EVER
show up upstream.

You have a lot of merges that have no actual merge commit message at
all. They say what they do, but they don't explain it. That should be
a big warning sign to you.

That's ok for automated testing (like pushing to linux-next or 0day
build-bot or whatever). But those things have *nothing* to do with
upstreaming, except in the indirect sense ("I've done a lot of testing
on these changes, so now I'm happy to merge them for upstreaming").

See the difference?

             Linus
