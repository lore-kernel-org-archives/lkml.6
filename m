Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeCFU71 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:59:27 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35705 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbeCFU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:59:25 -0500
X-Google-Smtp-Source: AG47ELv6ijAD4+GdQJdCwtMRSiALne449HDPH4SuzVUsP4rnxtAgiQfcx4g+QjyttW6d/TmpRRGdbQ==
Date: Tue, 6 Mar 2018 21:59:20 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
Message-ID: <20180306205920.GA786@kmp-mobile.hq.kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au>
 <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
 <20180305231650.GA25693@fury>
 <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

> What I'm trying to tell is about consistency of style.

I completely agree with all you wrote, those are all good suggestions.
But you started your reasoning with:

> So, imagine if we have two bitfields in some register, one with one
> bit and the other with two.

We are not looking at a hardware register here.  Rather, I am trying to
bring at least _some_ order to an arbitrary set of values that the
vendor assumed would be fun to scatter around a dozen of firmware
functions.  Some hardware features are controlled by setting a specific
bit in the value being passed to a function; in other cases entire
integers are taken into account; in yet another case *two* bits in a
value control state.  There is no reason or order to be found here.

In the case of OP_* constants, perhaps the simplest thing to do would be
to define them as integers, not bitfields.  But that still results in a
mess:

#define OP_GET		0x2
#define OP_GET_CAPS	0x0
#define OP_GET_EVENTS	0x1
#define OP_GET_EXT	0x4
#define OP_SET		0x1
#define OP_SET_EXT	0x5

or:

#define OP_GET_CAPS	0x0
#define OP_GET_EVENTS	0x1
#define OP_SET		0x1
#define OP_GET		0x2
#define OP_GET_EXT	0x4
#define OP_SET_EXT	0x5

Even worse, what am I supposed to do with crap like radio LED control,
where 0x20 (bit 5) is passed in one argument to select the desired
feature and 0x20 or 0 is passed as another argument to select the
desired state of that feature?  How do I name and define constants that
I can subsequently use in call_fext_func() invocations to spare the
reader the need to learn the hard way that this:

    return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON, 0x0);

is actually supposed to turn the radio LED *off*?

This is the best I could come up with:

#define FEAT_RADIO_LED		BIT(5)
#define STATE_RADIO_LED_OFF	(0 << 0)
#define STATE_RADIO_LED_ON	BIT(5)

Yes, it is ugly.  But the resulting call is (IMHO) a lot more clear than
the original one:

    return fext_flags(device, OP_SET_EXT, FEAT_RADIO_LED, STATE_RADIO_LED_OFF);

All of the above is why I was inclined to just use alphabetic ordering
for all constants defined in fujitsu-laptop.  This approach brings at
least _some_ consistency to this mess (which only the vendor is to blame
for, of course).  If you would rather have me take a different approach,
I am all ears.

-- 
Best regards,
Michał Kępień
