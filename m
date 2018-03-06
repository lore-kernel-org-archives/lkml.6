Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeCFJhZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:37:25 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46011 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeCFJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:37:22 -0500
X-Google-Smtp-Source: AG47ELvC9Rn0hFwR3xA2nQB9OrWnvLar/HZrvVo+N6GYQ7l/tGgDmRsHexoF4dAz5GZOGtfJiQGFMdz/VpU0p1AZBio=
MIME-Version: 1.0
In-Reply-To: <20180305231650.GA25693@fury>
References: <20180227211539.5708-1-kernel@kempniu.pl> <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au> <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
 <20180305231650.GA25693@fury>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 11:37:21 +0200
Message-ID: <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
To: Darren Hart <dvhart@infradead.org>
Cc: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w269bWNa029688

On Tue, Mar 6, 2018 at 1:16 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 08:44:26PM +0100, Michał Kępień wrote:
>> > On Wed, Feb 28, 2018 at 06:08:52PM +0200, Andy Shevchenko wrote:
>> > > On Tue, Feb 27, 2018 at 11:15 PM, Micha?? K??pie?? <kernel@kempniu.pl> wrote:
>> > > > Various functions exposed by the firmware through the FUNC interface
>> > > > tend to use a consistent set of integers for denoting the type of
>> > > > operation to be performed for a specified feature.  Use named constants
>> > > > instead of integers in each call_fext_func() invocation in order to more
>> > > > clearly convey the intent of each call.
>> > > >
>> > > > Note that FUNC_FLAGS is a bit peculiar:
>> > >
>> > > > +/* FUNC interface - operations */
>> > > > +#define OP_GET                         BIT(1)
>> > > > +#define OP_GET_CAPS                    0
>> > > > +#define OP_GET_EVENTS                  BIT(0)
>> > > > +#define OP_GET_EXT                     BIT(2)
>> > > > +#define OP_SET                         BIT(0)
>> > > > +#define OP_SET_EXT                     (BIT(2) | BIT(0))
>> > >
>> > > Hmm... this looks unordered a bit.
>> >
>> > It seems to be ordered alphabetically on the identifier.  Andy, is it
>> > preferred to order defines like this based on resolved numeric order?
>>
>> Just to expand on what Jonathan wrote above: if you take a peek at the
>> end result of the patch series, you will notice a pattern: constants in
>> each section are ordered alphabetically by their name.  I wanted all
>> sections to be consistently ordered.  If you would rather have me order
>> things by the bit index, sure, no problem, just please note that the
>> order above is not accidental.
>
> Hrm. In my experience it is more typical to order by value (bit), that's a
> little less obvious when using the BIT()|BIT() macros though. So long as it's
> consistent, I think that's what matters most.

What I'm trying to tell is about consistency of style.

So, imagine if we have two bitfields in some register, one with one
bit and the other with two.
And for latter one only 3 states are possible (00, 10, 11), so,

REG1_FLDA  BIT(0)
REG1_FLDB_STATE0  0
REG1_FLDB_STATE2  BIT(2)
REG1_FLDB_STATE3  BIT(2) | BIT(3) // or 0x6, or (3 << 1)

Above is not what I would like to see.

The consistent may be one of the following

REG1_FLDA  BIT(0)
REG1_FLDB_STATE0  (0 << 1)
REG1_FLDB_STATE2  (2 << 1)
REG1_FLDB_STATE3  (3 << 1)

or (implying that in the code _SHIFT is used)

REG1_FLDA  BIT(0)
REG1_FLDB_SHIFT  1
REG1_FLDB_STATE0  0
REG1_FLDB_STATE2  2
REG1_FLDB_STATE3  3

or (perhaps less wanted)

REG1_FLDA  (1 << 0)
REG1_FLDB_STATE0  (0 << 1)
REG1_FLDB_STATE2  (2 << 1)
REG1_FLDB_STATE3  (3 << 1)

-- 
With Best Regards,
Andy Shevchenko
