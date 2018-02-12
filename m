Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeBLVhU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:37:20 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51715 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:37:18 -0500
X-Google-Smtp-Source: AH8x224bS5YjWj1HZWga/we3cQrdHp7f4RQiX9vFjDbTDr2kfFfxWQ390IMZ9KRyrS8SY4ZJWsanmg==
From: Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
Date: Mon, 12 Feb 2018 13:37:14 -0800
In-Reply-To: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:15:04 -0800")
Message-ID: <xmqqk1vhsxdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Feb 12, 2018 at 1:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> The problem, of course, is that since git is distributed, git doesn't
> know who is "upstream" and who is "downstream", so there's no
> _technical_ difference between merging a development tree, and a
> development tree doing a back-merge of the upstream tree.
>
> Maybe it was a mistake to make signed tag merges non-fast-forward,
> since they cause these kinds of issues with people who use "pull" to
> update their otherwise unmodified trees.
>
> I can always teach myself to just use --no-ff, since I end up doing
> things like verifying at the signatures anyway.
>
> Junio, comments?

I have a slight suspicion that allowing 'pull' to fast-forward even
when merging a signed tag when it is pulling from a configured
default remote for the branch the user is on, and otherwise keeping
the current behaviour, would make majority of people from both camps
happier, but I also have a strong conviction that it is being too
clever and making it hard to explain to people to do such a dwim
that tries to guess which way is 'upstream'.

Another clue we _might_ be able to take advantage of is that when
upstream maintainers merge a signed tag, we do *not* fetch and store
the tag from downstream contributers in our local repository (it is
likely that we have --no-tags in remote.<name>.tagopt), but when
downstream contributers sync from us with "git pull", they do fetch
and store our tags in their local repository.

So "git pull $somewhere $tag" that defaults to "--ff" when the tag
gets stored somewhere in refs/ (or more explicitly, in refs/tags/)
and defaults to "--no-ff" otherwise (i.e. the tag is fetched only to
be recorded in the resulting merge, without ever stored in any of
our refs), might be a good balance.  

And it is easy to explain: "We realize that it was a mistake to
unconditionally default to --no-ff and we are reverting the default
to --ff, but with a twist.  When we tell 'pull' to grab a tag, if
we do not store it anywhere in our local ref space, that would mean
the tag is totally lost if the pull fast-forwards.  That is why we
still use --no-ff in such a case."
