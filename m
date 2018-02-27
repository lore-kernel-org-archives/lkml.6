Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeB0TcG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:32:06 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33320 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeB0TcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:32:05 -0500
X-Google-Smtp-Source: AG47ELsjFN8iRkuCiOAPMyjTZ6x3Uf/mTy1NeJj9E6RQDH3m0M4c7odXdljvVueAmm6H+C//Ja5NsinJQF/kR1vxA64=
MIME-Version: 1.0
In-Reply-To: <20180227051905.GA26781@1wt.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
 <50a2fd51-8bdb-d2b7-c2b3-7df638fdedde@robertabel.eu> <20180227051905.GA26781@1wt.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2018 20:31:44 +0100
Message-ID: <CANiq72=7SX3vrC0uY2uoFcZ7C0Zdfn-eOPuLpdb-dKA4=mLJuQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Willy Tarreau <w@1wt.eu>
Cc: Robert Abel <rabel@robertabel.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 6:19 AM, Willy Tarreau <w@1wt.eu> wrote:
> On Mon, Feb 26, 2018 at 11:43:36PM +0100, Robert Abel wrote:
>> On 26 Feb 2018 17:49, Miguel Ojeda wrote:
>> > On a general note, the code seems a bit convoluted for what it does,
>> > specially without the comment written in the commit message :-) Isn't
>> > it simpler to use a tiny array in the stack and put the numbers to be
>> > converted instead of modifying the input sequence and dancing with
>> > pointers?
>>
>> That's what I felt at first, too. If we can drop the backwards
>> compatibility of repeated xy commands, the whole affair gets much
>> easier, but will unfortunately break existing use.
>>
>> Ex. ^[[Lx004y002x006; --> x6y2, because repeats of x would just
>> overwrite earlier values. That's what the while loop allowed in the
>> first place.
>>
>> I suspect the while loop to parse was just a clever way of parsing y
>> followed by x and x followed by y using the same code and the
>> overwriting behavior is actually an unaccounted-for side-effect.
>
> Well actually I don't see a problem there at all. The principle is simply
> to accept any sequence assigning x or y or both. If you write x4y2x6, it
> simply means that you changed your mind regarding x and that the last
> value (6) is the one you want. Just as if you wrote "^[[Lx4;^[[y2;^[[x6;".
> The while loop doesn't even try to do anything clever, it simply parses
> everything matching x and y followed by digits. I think the only reason
> for having both x and y processed in the same loop was to call
> charlcd_gotoxy() only once for both axes.
>

Robert, Willy, Geert, Andy: what about this? (sending the patch
separately, otherwise gmail messes the code up).

Cheers,
Miguel

> Regards,
> Willy
