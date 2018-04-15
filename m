Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeDOMKJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:10:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62285 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeDOMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:10:07 -0400
Subject: Re: BUILD_BUG_ON_MSG
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.20.1804150736110.2673@hadrien>
From: Daniel Santos <daniel.santos@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <9f2e95dc-6f8e-0adc-50d9-578f1077722d@pobox.com>
Date: Sun, 15 Apr 2018 07:10:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804150736110.2673@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: EDF064E2-40A5-11E8-992E-44CE1968708C-06139138!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3FCAEi7002902

Hello Julia,

I'm CCing LKML on this so that others can be involved.


On 04/15/2018 12:43 AM, Julia Lawall wrote:
> Hello,
>
> I saw that you introduced BUILD_BUG_ON_MSG in the Linux kernel a few years
> ago.
>
> BUILD_BUG_ON_MSG is not safe when used in header files.  Via
> compiletime_assert, it makes a new function whose name is only determined
> by a line number.  When BUILD_BUG_ON_MSG is used in header files,
> multiple uses may end up at the same line, in different header files.  The
> reported errors are then quite confusing; I guess the last function with
> the given name is used.

Yes, This is an unfortunate side-effect of the implementation, since
"error" and "warning" are function attributes.  This issue was discussed
during review and it was decided that one should simply not use more
than one of such macro on the same line in an implementation file.  I
had thought we added a "don't use more than once per line" in the
documentation for these macros, but I'm not seeing it right now -- if
it's really missing then we probably want to add it.

>
> I tried incorporating __func__, but for some reason it didn't expand into
> anything.  Perhaps I used it incorrectly in some way.

Neither __func__ nor __FUNCTION__ are cpp macros, they are just static
const char arrays (see
https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html).  For some
reason I recall believing that __PRETTY_FUNCTION__ *is* a cpp macro, but
I'm probably wrong, and even if it was it wouldn't be a valid function
prefix.

> If it is not
> possible to get the name of the enclosing function, would it be reasonable
> to make a new kind of BUILD_BUG_ON call that takes an extra argument that
> can be used in the function name to make it unique?
>
> thanks,
> julia
>
You're still going to need the function name as a cpp macro.  If you
have that, you can just expand _compiletime_assert() directly.  Please
post your code when sending an inquiry like this -- it makes it easier
for others to help you and we don't have to waste as much time trying to
figure out exactly what you might be doing and how.  I don't remember if
doing this inside of an always_inline function (instead of a macro
expansion) works or not.

For a long time I've considered the merits of directly adding a gcc
extension to perform these checks without all of these side effects and
the lengthy macro expansion backtrace, which is also an ugly artifact of
this mechanism.  In fact, I was really disappointed with C11's
_Static_assert because I at first thought it was a generic solution, but
then came to find out otherwise.

IMO, the ideal mechanism would behave more like MAYBE_BUILD_BUG_ON, but
without all of the cpp fluff currently required.  Does anybody know if
this has been proposed or a gcc feature request filed for this yet?

Daniel
