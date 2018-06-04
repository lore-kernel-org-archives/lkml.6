Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeFDVbF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:31:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37210 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeFDVbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:31:03 -0400
X-Google-Smtp-Source: ADUXVKJPaS9wMkIFfJY+vIc7mcOpr1LcCDiuPx6JfCcFGs/H2cWw4AmhY2q0IlHx2iFN9nugoWM80tBvuAIyy3QljG0=
MIME-Version: 1.0
In-Reply-To: <87sh63pakb.fsf@notabene.neil.brown.name>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
 <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com>
 <87sh63pakb.fsf@notabene.neil.brown.name>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 4 Jun 2018 14:31:01 -0700
Message-ID: <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
To: NeilBrown <neilb@suse.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 7:09 PM, NeilBrown <neilb@suse.com> wrote:
> On Sun, Jun 03 2018, Tom Herbert wrote:
>
>> On Sun, Jun 3, 2018 at 5:30 PM, NeilBrown <neilb@suse.com> wrote:
>>> On Sat, Jun 02 2018, Herbert Xu wrote:
>>>
>>>> On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
>>>>> This function has a somewhat confused behavior that is not properly
>>>>> described by the documentation.
>>>>> Sometimes is returns the previous object, sometimes it returns the
>>>>> next one.
>>>>> Sometimes it changes the iterator, sometimes it doesn't.
>>>>>
>>>>> This function is not currently used and is not worth keeping, so
>>>>> remove it.
>>>>>
>>>>> A future patch will introduce a new function with a
>>>>> simpler interface which can meet the same need that
>>>>> this was added for.
>>>>>
>>>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>>>
>>>> Please keep Tom Herbert in the loop.  IIRC he had an issue with
>>>> this patch.
>>>
>>> Yes you are right - sorry for forgetting to add Tom.
>>>
>>> My understanding of where this issue stands is that Tom raised issue and
>>> asked for clarification, I replied, nothing further happened.
>>>
>>> It summary, my position is that:
>>> - most users of my new rhashtable_walk_prev() will use it like
>>>    rhasthable_talk_prev() ?: rhashtable_walk_next()
>>>   which is close to what rhashtable_walk_peek() does
>>> - I know of no use-case that could not be solved if we only had
>>>   the combined operation
>>> - BUT it is hard to document the combined operation, as it really
>>>   does two things.  If it is hard to document, then it might be
>>>   hard to understand.
>>>
>>> So provide the most understandable/maintainable solution, I think
>>> we should provide rhashtable_walk_prev() as a separate interface.
>>>
>> I'm still missing why requiring two API operations instead of one is
>> simpler or easier to document. Also, I disagree that
>> rhashtable_walk_peek does two things-- it just does one which is to
>> return the current element in the walk without advancing to the next
>> one. The fact that the iterator may or may not move is immaterial in
>> the API, that is an implementation detail. In fact, it's conceivable
>> that we might completely reimplement this someday such that the
>> iterator works completely differently implementation semantics but the
>> API doesn't change. Also the naming in your proposal is confusing,
>> we'd have operations to get the previous, and the next next object--
>> so the user may ask where's the API to get the current object in the
>> walk? The idea that we get it by first trying to get the previous
>> object, and then if that fails getting the next object seems
>> counterintuitive.
>
> To respond to your points out of order:
>
> - I accept that "rhashtable_walk_prev" is not a perfect name.  It
>   suggests a stronger symmetry with rhasthable_walk_next than actually
>   exist.  I cannot think of a better name, but I think the
>   description "Return the previously returned object if it is
>   still in the table" is clear and simple and explains the name.
>   I'm certainly open to suggestions for a better name.
>
> - I don't think it is meaningful to talk about a "current" element in a
>   table where asynchronous insert/remove is to be expected.
>   The best we can hope for is a "current location" is the sequence of
>   objects in the table - a location which is after some objects and
>   before all others.  rhashtable_walk_next() returns the next object
>   after the current location, and advances the location pointer past
>   that object.
>   rhashtable_walk_prev() *doesn't* return the previous object in the
>   table.  It returns the previously returned object. ("previous" in
>   time, but not in space, if you like).
>
> - rhashtable_walk_peek() currently does one of two different things.
>   It either returns the previously returned object (iter->p) if that
>   is still in the table, or it find the next object, steps over it, and
>   returns it.
>
> - I would like to suggest that when an API acts on a iterator object,
>   the question of whether or not the iterator is advanced *must* be a
>   fundamental question, not one that might change from time to time.
>
> Maybe a useful way forward would be for you to write documentation for
> the rhashtable_walk_peek() interface which correctly describes what it
> does and how it is used.  Given that, I can implement that interface
> with the stability improvements that I'm working on.
>

Here's how it's documented currently:

"rhashtable_walk_peek - Return the next object but don't advance the iterator"

I don't see what is incorrect about that. Peek returns the next object
in the walk, however does not move the iterator past that object, so
sucessive calls to peek return the same object. In other words it's a
way to inspect the next object but not "consume" it. This is what is
needed when netlink returns in the middle of a walk. The last object
retrieved from the table may not have been processed completely, so it
needs to be the first one processed on the next invocation to netlink.

This is also easily distinguishable from

"rhashtable_walk_next - Return the next object and advance the iterator"

Where the only difference is that peek and walk is that, walk advances
the iterator and peek does not. Hence why "peek" is a descriptive name
for what is happening.

Tom

> Thanks,
> NeilBrown
