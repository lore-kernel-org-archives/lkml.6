Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCVRQt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:16:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35588 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCVRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:16:46 -0400
X-Google-Smtp-Source: AIpwx48NlJW6OFswZ8hUZqWHxfoOuCvWnHTCshcODJhUdQjlA03j/VkyOBLicDLuV3nO3DKEnzk44LClrb0HxCIIvAs=
MIME-Version: 1.0
In-Reply-To: <035ac754e54a4b14844f3300ae1432a9@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com> <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
 <CA+55aFydu4+MZ=-5L7wDr2LvNH6Dbmi4qLnfHAAOrHKZCb5wdA@mail.gmail.com> <035ac754e54a4b14844f3300ae1432a9@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 10:16:45 -0700
X-Google-Sender-Auth: uigpxQIyNtnv5KZ-FW3jwYEgzjg
Message-ID: <CA+55aFxE47LpWsniU=gao4AsmdF8nj1bg39mAG37uY1zTEX-jw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
To: David Laight <David.Laight@aculab.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 3:48 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Linus Torvalds
>>
>> Note that we definitely have seen hardware that *depends* on the
>> regular memcpy_fromio()" not doing big reads. I don't know how
>> hardware people screw it up, but it's clearly possible.

[ That should have been "big writes" ]

> I wonder if that hardware works with the current kernel on recent cpus?
> I bet it doesn't like the byte accesses that get generated either.

The one case we knew about we just fixed to use the special "16-bit
word at a time" scr_memcpyw().

If I recall correctly, it was some "enterprise graphics console".

If it's something I've found over the years, is that "enterprise"
hardware is absolutely the dregs. It's the low-volume stuff that
almost nobody uses and where the customer is used to the whole notion
of boutique hardware, so they're used to having to do special things
for special hardware.

And I very much use the word "special" in the "my mom told me I was
special" sense. It's not the *good* kind of "special". It's the "short
bus" kind of special.

> For x86 being able to request a copy done as 'rep movsx' (for each x)
> would be useful.

The portability issues are horrendous. Particularly if the memory area
(source or dest) might be unaligned.

The rule of thumb should be: don't use PIO, and if you *do* use PIO,
don't be picky about what you get.

And most *definitely* don't complain about performance to software
people. Blame the hardware people. Get a competent piece of hardware,
or a competent hardware designer.

Let's face it, PIO is stupid. Use it for command and status words. Not
for data transfer.

                 Linus
