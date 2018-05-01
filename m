Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeEALwu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:52:50 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33058 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754662AbeEALws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:52:48 -0400
X-Google-Smtp-Source: AB8JxZrl6aQjlotAdKk2xkS1DQZAnkNEimlYS9TXJWSuSi2cs4n0tNuWN61EM6lazadhwMYkgeUKtW/nWdLOr51nKl8=
MIME-Version: 1.0
In-Reply-To: <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
References: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org> <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org> <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org> <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box> <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box> <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 1 May 2018 06:52:47 -0500
Message-ID: <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: Jeremy Cline <jeremy@jcline.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 4:12 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> On 04/29/2018 06:05 PM, Theodore Y. Ts'o wrote:
>> On Sun, Apr 29, 2018 at 01:20:33PM -0700, Sultan Alsawaf wrote:
>>> On Sun, Apr 29, 2018 at 08:41:01PM +0200, Pavel Machek wrote:
>>>> Umm. No. https://www.youtube.com/watch?v=xneBjc8z0DE
>>>
>>> Okay, but /dev/urandom isn't a solution to this problem because it isn't usable
>>> until crng init is complete, so it suffers from the same init lag as
>>> /dev/random.
>>
>> It's more accurate to say that using /dev/urandom is no worse than
>> before (from a few years ago).  There are, alas, plenty of
>> distributions and user space application programmers that basically
>> got lazy using /dev/urandom, and assumed that there would be plenty of
>> entropy during early system startup.
>>
>> When they switched over the getrandom(2), the most egregious examples
>> of this caused pain (and they got fixed), but due to a bug in
>> drivers/char/random.c, if getrandom(2) was called after the entropy
>> pool was "half initialized", it would not block, but proceed.
>>
>> Is that exploitable?  Well, Jann and I didn't find an _obvious_ way to
>> exploit the short coming, which is this wasn't treated like an
>> emergency situation ala the embarassing situation we had five years
>> ago[1].
>>
>> [1] https://factorable.net/paper.html
>>
>> However, it was enough to make us be uncomfortable, which is why I
>> pushed the changes that I did.  At least on the devices we had at
>> hand, using the distributions that we typically use, the impact seemed
>> minimal.  Unfortuantely, there is no way to know for sure without
>> rolling out change and seeing who screams.  In the ideal world,
>> software would not require cryptographic randomness immediately after
>> boot, before the user logs in.  And ***really***, as in [1], softwaret
>> should not be generating long-term public keys that are essential to
>> the security of the box a few seconds immediately after the device is
>> first unboxed and plugged in.i
>>
>> What would be useful is if people gave reports that listed exactly
>> what laptop and distributions they are using.  Just "a high spec x86
>> laptop" isn't terribly useful, because *my* brand-new Dell XPS 13
>> running Debian testing is working just fine.  The year, model, make,
>> and CPU type plus what distribution (and distro version number) you
>> are running is useful, so I can assess how wide spread the unhappiness
>> is going to be, and what mitigation steps make sense.
>
> Fedora has started seeing some bug reports on this for Fedora 27[0] and
> I've asked reporters to include their hardware details.
>
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1572944
>

We have also had reports that Fedora users are seeing this on Google
Compute Engine.

Justin
