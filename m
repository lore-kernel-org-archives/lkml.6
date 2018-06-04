Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeFDBS6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:18:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35656 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbeFDBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:18:57 -0400
X-Google-Smtp-Source: ADUXVKKrkK/QJ3MzMLhsz2GZ9mOVZn8R1a3m2slvzAYt36qow4t7jddgJ92UZodlVjfWN+2TSaJbeESinl6iNuwIzWE=
MIME-Version: 1.0
In-Reply-To: <87y3fvpf40.fsf@notabene.neil.brown.name>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
 <87y3fvpf40.fsf@notabene.neil.brown.name>
From: Tom Herbert <tom@herbertland.com>
Date: Sun, 3 Jun 2018 18:18:55 -0700
Message-ID: <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
To: NeilBrown <neilb@suse.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 5:30 PM, NeilBrown <neilb@suse.com> wrote:
> On Sat, Jun 02 2018, Herbert Xu wrote:
>
>> On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
>>> This function has a somewhat confused behavior that is not properly
>>> described by the documentation.
>>> Sometimes is returns the previous object, sometimes it returns the
>>> next one.
>>> Sometimes it changes the iterator, sometimes it doesn't.
>>>
>>> This function is not currently used and is not worth keeping, so
>>> remove it.
>>>
>>> A future patch will introduce a new function with a
>>> simpler interface which can meet the same need that
>>> this was added for.
>>>
>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>
>> Please keep Tom Herbert in the loop.  IIRC he had an issue with
>> this patch.
>
> Yes you are right - sorry for forgetting to add Tom.
>
> My understanding of where this issue stands is that Tom raised issue and
> asked for clarification, I replied, nothing further happened.
>
> It summary, my position is that:
> - most users of my new rhashtable_walk_prev() will use it like
>    rhasthable_talk_prev() ?: rhashtable_walk_next()
>   which is close to what rhashtable_walk_peek() does
> - I know of no use-case that could not be solved if we only had
>   the combined operation
> - BUT it is hard to document the combined operation, as it really
>   does two things.  If it is hard to document, then it might be
>   hard to understand.
>
> So provide the most understandable/maintainable solution, I think
> we should provide rhashtable_walk_prev() as a separate interface.
>
I'm still missing why requiring two API operations instead of one is
simpler or easier to document. Also, I disagree that
rhashtable_walk_peek does two things-- it just does one which is to
return the current element in the walk without advancing to the next
one. The fact that the iterator may or may not move is immaterial in
the API, that is an implementation detail. In fact, it's conceivable
that we might completely reimplement this someday such that the
iterator works completely differently implementation semantics but the
API doesn't change. Also the naming in your proposal is confusing,
we'd have operations to get the previous, and the next next object--
so the user may ask where's the API to get the current object in the
walk? The idea that we get it by first trying to get the previous
object, and then if that fails getting the next object seems
counterintuitive.

Tom


Tom

> Thanks,
> NeilBronw
