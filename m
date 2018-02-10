Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBJI6r (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:58:47 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39809 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeBJI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:58:46 -0500
X-Google-Smtp-Source: AH8x224itGg4ToSrg7smTCDO6HHUuz8NA7VnwEOwJv+G9m1I1255MTrT8Ywug6Pj4rXPKKuN/h9opMrljp3mBX3Cge8=
MIME-Version: 1.0
In-Reply-To: <20180209235012.4993-2-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Feb 2018 09:58:44 +0100
Message-ID: <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
> The graphics command expects 16 hexadecimal literals, but would allow characters in range [0-9a-zA-Z] instead of [0-9a-fA-F].
>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index 642afd88870b..324d02f9f1c5 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -441,9 +441,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
>                         shift ^= 4;
>                         if (*esc >= '0' && *esc <= '9') {
>                                 value |= (*esc - '0') << shift;
> -                       } else if (*esc >= 'A' && *esc <= 'Z') {
> +                       } else if (*esc >= 'A' && *esc <= 'F') {
>                                 value |= (*esc - 'A' + 10) << shift;
> -                       } else if (*esc >= 'a' && *esc <= 'z') {
> +                       } else if (*esc >= 'a' && *esc <= 'f') {

Willy, Geert: this seems obvious, but do you know if the broader range
was intended for some reason? In that case, adding a comment to the
code would be good. I found some related docs at
Documentation/misc-devices/lcd-panel-cgram.txt by Willy (which, by the
way, maybe now we should move them to Documentations/auxdisplay); but
the paragraph does indeed say they have to be hex:

'''
Some LCDs allow you to define up to 8 characters, mapped to ASCII
characters 0 to 7. The escape code to define a new character is
'\e[LG' followed by one digit from 0 to 7, representing the character
number, and up to 8 couples of hex digits terminated by a semi-colon
(';').
'''

>                                 value |= (*esc - 'a' + 10) << shift;
>                         } else {
>                                 esc++;
> --
> 2.11.0
>
