Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26476C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD00920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A7k/Kaiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfAKQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:26:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40495 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfAKQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:26:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so13460348lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbenFxntMJJI3im+gr+rLb3/45Dw0c7ONogM+YwDZXY=;
        b=A7k/KaizozfTI3rBrlvY3irlDJ5TfkFn1JQLsJSc13ang98zrx0HocnODrct6I3zRv
         sXlVINnsBzbxsJRy2F0R8MOI6FDB9D8UqJgkszbOp9fTU/2qZpfc5E3qRvfiuagKxYTH
         khvqSsnfI7FaBQLpIXqdntBzaFT9jEEhlEHik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbenFxntMJJI3im+gr+rLb3/45Dw0c7ONogM+YwDZXY=;
        b=M1eSocn5i8yDlahv8Rofmbx6MgDecInkYKWdXRMDV1OFZdqMGhgoxCzVIN7effE5Xw
         kT/k6QH81yG8zIO1IL/s297LPGIDbP2KWZsmHweU+7ibGJDh+UOyuIGp9AWE/Py46YlA
         CrvBxz+3busUZbDeYorUl0ls+6HHgpix9a7AuTk2AkpVcpifiMwZn7Mc33bJC/OzZoqT
         DbaJCsIblRku36sTHtR3ZYO+APp3dmec/adTijM6lmPx9jTLP0t4sxhE48LL5JPod8hZ
         XP85hZwC/F/c5nSqigxFx6zbhTS1yuc4CHY8Mv+CsomL9oH5SOxVrKptC6JnvmaBZ8EK
         rgig==
X-Gm-Message-State: AJcUukdAZhm9cHv5tLy3Jwo6qMGYVF3PTCr//fDgQBr+MHPqRnFSN7wi
        g9j1h1kp/iXoRe9iM5nx6lpkmE7xX/8=
X-Google-Smtp-Source: ALg8bN7NNPVhLsyXVvsZtb88h68cmXTMoUF4USDA9m3fscG4Oy6A800Ac5qiiv3oPbi9X7BmWSSC9g==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr8820500lja.58.1547223993586;
        Fri, 11 Jan 2019 08:26:33 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y14-v6sm15757414ljj.55.2019.01.11.08.26.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 08:26:31 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id x85-v6so13463536ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:26:31 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr9708846ljx.6.1547223990982;
 Fri, 11 Jan 2019 08:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard> <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard> <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
 <20190111073606.GP27534@dastard>
In-Reply-To: <20190111073606.GP27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 08:26:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
Message-ID: <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:36 PM Dave Chinner <david@fromorbit.com> wrote:
>
> > It's only that single page that *matters*. That's the page that the
> > probe reveals the status of - but it's also the page that the probe
> > then *changes* the status of.
>
> It changes the state of it /after/ we've already got the information
> we need from it. It's not up to date, it has to come from disk, we
> return EAGAIN, which means it was not in the cache.

Oh, I see the confusion.

Yes, you get the information about whether something was in the cache
or not, so the side channel does exist to some degree.

But it's actually hugely reduced for a rather important reason: the
_primary_ reason for needing to know whether some page is in the cache
or not is not actually to see if it was ever accessed - it's to see
that the cache has been scrubbed (and to _guide_ the scrubbing), and
*when* it was accessed.

Think of it this way: the buffer cache residency is actually a
horribly bad signal on its own mainly because you generally have a
very high hit-rate. In most normal non-streaming situations with
sufficient amounts of memory you have pretty much everything cached.

So in order to use it as a signal, first you have to first scrub the
cache (because if the page was already there, there's no signal at
all), and then for the signal to be as useful as possible, you're also
going to want to try to get out more than one bit of information: you
are going to try to see the patterns and the timings of how it gets
filled.

And that's actually quite painful. You don't know the initial cache
state, and you're not (in general) controlling the machine entirely,
because there's also that actual other entity that you're trying to
attack and see what it does.

So what you want to do is basically to first make sure the cache is
scrubbed (only for the pages you're interested in!), then trigger
whatever behavior you are looking for, and then look how that affected
the cache.

In other words,  you want *multiple* residency status check - first to
see what the cache state is (because you're going to want that for
scrubbing), then to see that "yes, it's gone" when doing the
scrubbing, and then to see the *pattern* and timings of how things are
brought in.

And then you're likely to want to do this over and over again, so that
you can get real data out of the signal.

This is why something that doesn't perturb what you measure is really
important. If the act of measurement brings the page in, then you
can't use it for that "did I successfully scrub it" phase at all, and
you can't use it for measurement but once, so your view into patterns
and timings is going to be *much* worse.

And notice that this is true even if the act of measurement only
affects the *one* page you're measuring. Sure, any additional noise
around it would likely be annoying too, but it's not really necessary
to make the attack much harder to carry out. In fact, it's almost
irrelevant, since the signal you're trying to *see* is going to be
affected by prefetching etc too, so the patterns and timings you need
to look at are in bigger chunks than the readahead thing.

So yes, you as an attacker can remove the prefetching from *your*
load, but you can't remove it from the target load anyway, so you'll
just have to live with it.

Can you brute-force scrubbing? Yes. For something like an L1 cache,
that's easy (well, QoS domains make it harder). For something like a
disk cache, it's much harder, and makes any attempt to read out state
a lot slower. The paper that started this all uses mincore() not just
to see "is the page now scrubbed", but also to guide the scrubbing
itself (working set estimation etc).

And note that in many ways, the *scrubbing* is really the harder part.
Populating the cache is really easy: just read the data you want to
populate.

So if you are looking for a particular signal, say "did this error
case trigger so that it faulted in *that* piece of information", you'd
want to scrub the target, populate everything else, and then try to
measure at "did I trigger that target". Except you wouldn't want to do
it one page at a time but see as much pattern of "they were touched in
this order" as you can, and you'd like to get timing information of
how the pages you are interested were populated too.

And you'd generally do this over and over and over again because
you're trying to read out some signal.

Notice what the expensive operation was? It's the scrubbing.The "did
the target do IO" you might actually even see other ways for the
trivial cases, like even just look at iostat: just pre-populate
everything but the part you care about, then try to trigger whatever
you're searching for, and see if it caused IO or not.

So it's a bit like a chalkboard: in order to read out the result, you
need to erase it first, and doing that blindly is nasty. And you want
to look at timings, which is also really nasty if every time you look,
you smudge the very place you looked at. It makes it hard to see what
somebody else is writing on the board if you're always overwriting
what you just looked at. Did you get some new information? If not, now
you have to go back and do that scrubbing again, and you'll likely be
missing what *else* the person wrote.

Ans as always: there is no "black and white". There is no "absolute
security", and similarly, there is no "absolute leak proof". It's all
about making it inconvenient enough that it's not really practical.

                 Linus
