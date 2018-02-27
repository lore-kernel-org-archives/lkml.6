Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeB0U5Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:57:16 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:44475 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB0U5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:57:14 -0500
X-Google-Smtp-Source: AG47ELtUrJFTnVyTwjXhUlNxchAGSUakqF7YPsTNnImlG1ghmWQODk4DnqWEXOXyCyRiNee52LF0VvNOkaWu0HAgWpU=
MIME-Version: 1.0
In-Reply-To: <20180227201355.GA27525@1wt.eu>
References: <20180227193118.n33bkbrqxybfhgdc@gmail.com> <20180227201355.GA27525@1wt.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2018 21:56:53 +0100
Message-ID: <CANiq72kP-nfuQ8oN_jQSA+qw9fm75GFU5-XJ2L_vsmK1=-pjiA@mail.gmail.com>
Subject: Re: [PATCH RFC] auxdisplay: charlcd: Fix and clean up handling of x/y commands
To: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robert Abel <rabel@robertabel.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 9:13 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Feb 27, 2018 at 08:32:21PM +0100, Miguel Ojeda wrote:
>> The current version is not parsing multiple x/y commands as the code
>> originally intended. On top of that, kstrtoul() expects
>> NULL-terminated strings. Finally, the code had to do two passes over
>> the string, while now only one is done.
>>
>> Some explanations about the supported syntax are added as well.
>
> Thanks Miguel for doing this. To be fair, I personally think that the code

You're welcome!

> was significantly complexified compared to the original version, just for
> the purpose of using one library function designed to multiply by ten and
> add a number. Not to mention that it now requires a copy before parsing.

I agree. I wrote this version like this so that parse_n() can be
removed in the future if we have access to an in-place alternative to
the kstrtoul*() functions (cf. the discussion in the other thread with
Andy); which would take the copy away as well.

> For me it simply means that the initial code change was a wrong idea in
> the end. But at least with your version, the bugs introduced by the
> previous "fix" should now be gone, which is a good thing.

Thanks! :-) This one has the "advantage" that it only goes by the
string once (i.e. no initial strchr()) and that gotoxy() is not called
unless the full command is valid (but I am not sure whether this is OK
or not for the HW, though).

Cheers,
Miguel

>
> Thanks,
> Willy
