Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeB0Xkm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:40:42 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33933 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeB0Xkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:40:41 -0500
X-Google-Smtp-Source: AG47ELvQsv+Ec8KXW2tGnZjpn8ghlgM9L9MZQ2hfuhoTdozfLsJv55ibXdTyDjLDsyFv1Vr7mcORE4vsQqQEXx10OxA=
MIME-Version: 1.0
In-Reply-To: <68c24a6f-3a48-3672-8b16-0b46d880d0e3@robertabel.eu>
References: <20180227220952.57wc3wpc26b2fdyq@gmail.com> <68c24a6f-3a48-3672-8b16-0b46d880d0e3@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Feb 2018 00:40:20 +0100
Message-ID: <CANiq72mkVbwmc1g=p87bqefYu1mwH5h4n9x4XfTjPZPe-OTRFA@mail.gmail.com>
Subject: Re: [PATCH RFC v3] auxdisplay: charlcd: Fix and clean up handling of
 x/y commands
To: Robert Abel <rabel@robertabel.eu>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 12:23 AM, Robert Abel <rabel@robertabel.eu> wrote:
> On 27 Feb 2018 23:09, Miguel Ojeda wrote:> @@ -469,24 +543,11 @@ static
> inline int handle_lcd_special_code(struct charlcd *lcd)
>>       }
>>       case 'x':       /* gotoxy : LxXXX[yYYY]; */
>>       case 'y':       /* gotoxy : LyYYY[xXXX]; */
>> -             if (!strchr(esc, ';'))
>> -                     break;
>
> Might want to keep this. It's in line with all other cases and prevents
> calling parse_xy with input that has no chance of being correct due to
> missing final ';'.

I agree performance is not that critical here and the string would
probably be in cache anyway, but I would say it is better to fix
parse_xy() if it is not doing what it specifies.

>
>> +             /* If the command is valid, move to the new address */
>> +             if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
>> +                     charlcd_gotoxy(lcd);
>
> While not in the original code, the inputs are now not clamped to width
> and height.
> That means for a two-line display ^[[Ly02; will actually end up on line
> y = 1, not y = 2 % 2 = 0, because the four-line display logic bumps the
> address up.
> The same goes for going over lcd->width/lcd->bwidth in the x coordinate.
> For four-line displays that ends up going to the line y + 2, because the
> buffer is split in the middle.
> The distinction between lcd->width and lcd->bwidth depends on whether it
> makes sense to put the cursor outside the visible area or not.

Don't worry, the RFC patch is meant to agree on a fix for the multiple
x/y command code. The clamping and other stuff can still go in in
another patch of yours :)

Cheers,
Miguel

>
> Regards,
>
> Robert
