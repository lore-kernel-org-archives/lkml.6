Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBJSb4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:31:56 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42138 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBJSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:31:55 -0500
X-Google-Smtp-Source: AH8x225ZxS/GkVUnR+yID4vkGcXYQ/Xyf8piP6d6M5vdO9NUN/uqBC6ANUf0NRTPMRY/MWFuOVlKQNSphG0QGsHF/BY=
MIME-Version: 1.0
In-Reply-To: <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Feb 2018 19:31:54 +0100
X-Google-Sender-Auth: q7ZAMCunlZjKvse2NWbQhaL3WBw
Message-ID: <CAMuHMdXmqANSaciMtPad4Q6k-i9LXGO1O8Q36bEB0r+vhp9fCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 9:58 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> The graphics command expects 16 hexadecimal literals, but would allow characters in range [0-9a-zA-Z] instead of [0-9a-fA-F].
>>
>> Signed-off-by: Robert Abel <rabel@robertabel.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>> --- a/drivers/auxdisplay/charlcd.c
>> +++ b/drivers/auxdisplay/charlcd.c
>> @@ -441,9 +441,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
>>                         shift ^= 4;
>>                         if (*esc >= '0' && *esc <= '9') {
>>                                 value |= (*esc - '0') << shift;
>> -                       } else if (*esc >= 'A' && *esc <= 'Z') {
>> +                       } else if (*esc >= 'A' && *esc <= 'F') {
>>                                 value |= (*esc - 'A' + 10) << shift;
>> -                       } else if (*esc >= 'a' && *esc <= 'z') {
>> +                       } else if (*esc >= 'a' && *esc <= 'f') {
>
> Willy, Geert: this seems obvious, but do you know if the broader range
> was intended for some reason? In that case, adding a comment to the
> code would be good. I found some related docs at
> Documentation/misc-devices/lcd-panel-cgram.txt by Willy (which, by the
> way, maybe now we should move them to Documentations/auxdisplay); but
> the paragraph does indeed say they have to be hex:
>
> '''
> Some LCDs allow you to define up to 8 characters, mapped to ASCII
> characters 0 to 7. The escape code to define a new character is
> '\e[LG' followed by one digit from 0 to 7, representing the character
> number, and up to 8 couples of hex digits terminated by a semi-colon
> (';').
> '''

Hadn't noticed this before. Probably a stupid thinko, as Willy said.

The redefinition feature definitely works with hex characters.
I've used it in the past, cfr. the picture on my Google+ profile ;-)
https://plus.google.com/u/0/+GeertUytterhoeven

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
