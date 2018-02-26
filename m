Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeBZR0f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:26:35 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33516 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:26:32 -0500
X-Google-Smtp-Source: AG47ELtGsbV8jYaoZc8Rb+uWy9qg6Yvf77H+pIisVCn80S9Gzkl+z3/rZTTImhu725kcwa6FMil8OBoWujy/EOBXDB8=
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve+idUc_HFyBAmGYRSJKDM=hrtNXxqSGBY2+FBqkhrp5Q@mail.gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
 <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com>
 <CANiq72m6fDBAg9b5XdYxAtM8gHuCS7bTtJnFSLJ7=GyvSZAhHA@mail.gmail.com> <CAHp75Ve+idUc_HFyBAmGYRSJKDM=hrtNXxqSGBY2+FBqkhrp5Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 18:26:10 +0100
Message-ID: <CANiq72k-bztnMoDR6D_n-ZnK2mFmpUOvNn1ttpPFq=suxrYPig@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Robert Abel <rabel@robertabel.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 6:09 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 26, 2018 at 6:54 PM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Mon, Feb 26, 2018 at 12:44 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Feb 26, 2018 at 1:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
>
>>>> +                       if ('x' == cmd) {
>>>> +                               if (kstrtoul(esc, 10, &tmp_addr.x) < 0)
>>>>                                         break;
>>>
>>>> +                       } else if ('y' == cmd) {
>>>> +                               if (kstrtoul(esc, 10, &tmp_addr.y) < 0)
>>>>                                         break;
>>>
>>> Perhaps instead of dancing around kstrtox() better to switch to
>>> simple_strtoul() ?
>>
>> It seems deprecated:
>>
>> /* Obsolete, do not use.  Use kstrto<foo> instead */
>> extern unsigned long simple_strtoul(const char *,char **,unsigned int);
>
> It has been discussed several times. The comment is simple wrong.
>
> Because of the requirement of kstrtox() to have a \0 or \n followed by
> \0 as "end of field".
> simple_strto*() is suitable to be run in place.

I agree that in-place versions of these kind of string functions are
very useful, don't get me wrong! But unless someone changes the
"official" comment, we shouldn't add new code relying on them.

>
>>>>         }
>>>> +       }
>>>
>>> Same indentation level or my mailer hides this from me?
>>
>> It is the same, but it is also how the other 'case's do it -- which in
>> this case looks just wrong since it is the last one of the switch. I
>> am not sure what is the preferred way of doing these kind of blocks,
>> coding-style.rst does not seem to give an example for this case.
>
> Comes to my mind
> - using }}
> - putting default in between

That is a clever one :-) But gcc complains, so we would need default +
break, and that looks wrong as well. I would just move those two
blocks into their own static function. The function is already long
enough, specially with the new code. For small inside-switch blocks, I
would just create the block at the level of the code, just like you
would do inside functions. We can have another later patch to clean
that up (and also the stuff below, which even has a TODO comment
regarding it!).

Cheers,
Miguel

> - ... ?
>
> --
> With Best Regards,
> Andy Shevchenko
