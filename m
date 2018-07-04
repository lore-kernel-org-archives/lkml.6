Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC1C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FF523D77
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FF523D77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbeGDCl2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:41:28 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:6690 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932853AbeGDCl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:41:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w642fC88009125;
        Wed, 4 Jul 2018 04:41:12 +0200
Date:   Wed, 4 Jul 2018 04:41:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, ben.whitten@gmail.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704024112.GB9015@1wt.eu>
References: <20180703155328.GA18299@arbeit>
 <CAHp75VcQmUPCqzteHs=EaA5h-ABAQ=GWuLVRGWL3meMKZBJ-iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQmUPCqzteHs=EaA5h-ABAQ=GWuLVRGWL3meMKZBJ-iQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:43:06PM +0300, Andy Shevchenko wrote:
> > +struct morse_char {
> > +       char    c;
> > +       char    *z;
> > +};
> > +
> 
> > +static struct morse_char morse_table[] = {
> 
> const ?
> 
> > +       {'a', ".-"},
> > +       {'b', "-..."},
> > +       {'c', "-.-."},
> > +       {'d', "-.."},
> > +       {'e', "."},
> > +       {'f', "..-."},
> > +       {'g', "--."},
> > +       {'h', "...."},
> > +       {'i', ".."},
> > +       {'j', ".---"},
> > +       {'k', "-.-"},
> > +       {'l', ".-.."},
> > +       {'m', "--"},
> > +       {'n', "-."},
> > +       {'o', "---"},
> > +       {'p', ".--."},
> > +       {'q', "--.-"},
> > +       {'r', ".-."},
> > +       {'s', "..."},
> > +       {'t', "-"},
> > +       {'u', "..-"},
> > +       {'v', "...-"},
> > +       {'w', ".--"},
> > +       {'x', "-..-"},
> > +       {'y', "-.--"},
> > +       {'z', "--.."},
> > +       {'1', ".----"},
> > +       {'2', "..---"},
> > +       {'3', "...--"},
> > +       {'4', "....-"},
> > +       {'5', "....."},
> > +       {'6', "-...."},
> > +       {'7', "--..."},
> > +       {'8', "---.."},
> > +       {'9', "----."},
> > +       {'0', "-----"},
> 
> Do you expect this to be changed somehow?
> Otherwise we might just to keep two char arrays of alphas and digits
> in an order of ascii appearance.
> 
> In the code something like
> 
> ch = tolower(x);
> if (isalpha(ch))
>  code = alphas[ch - 'a'];
> else if (isdigit(ch))
>  code = digits[ch - '0'];
> else
>  code = unknown;
> 
> > +       {0, NULL},
> 
> And this will gone, you just provide it with known size,

Well, in this case it's even possible to go further and avoid storing
36 strings. Indeed, no representation is longer than 5 symbols, so you
can use 5 bits for the encoding (0=".", 1="-") and 3 bits for the
length, it gives you a single byte per character instead of a pointer
to a string plus 6 chars. Then in order to make it readable, 5 macros
can be provided to emit the code :

#define MORSE1(a,b)       (1 | ((a)<<3))
#define MORSE2(a,b)       (2 | ((a)<<3)|((b)<<4))
#define MORSE3(a,b,c)     (3 | ((a)<<3)|((b)<<4)|((c)<<5))
#define MORSE4(a,b,c,d)   (4 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6))
#define MORSE5(a,b,c,d,e) (5 | ((a)<<3)|((b)<<4)|((c)<<5)|((d)<<6)|((e)<<7))

Then all chars may be defined like this :

    ['a'] = MORSE2(0,1),
    ['b'] = MORSE4(1,0,0,0),
    ['c'] = MORSE4(1,0,1,0),
    ['d'] = MORSE3(1,0,0),
    ['e'] = MORSE1(0),
    ...

and when processing these :

    code = morse_table[tolower(c)];
    code_len = code & 7;
    code >>= 3;

    while (code_len) {
       if (code & 1)
           emit_long();
       else
           emit_short();
       code >>= 1;
       code_len--;
    }

In this case it could even cover the whole ASCII table at once since it's
not certain that the saved bytes compensate for the extra code and alignment
used to save them :-)

Note that I'm not suggesting that it is required to proceed like this, but
I think it makes the whole code more compact, which aligns with the purpose
of focusing on embedded devices.

Cheers,
Willy
