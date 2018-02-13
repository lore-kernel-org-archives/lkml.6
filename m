Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbeBMHXk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:23:40 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40568 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeBMHXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:23:39 -0500
Date: Tue, 13 Feb 2018 08:23:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] auxdisplay: use correct string length
Message-ID: <20180213072328.GA1636@1wt.eu>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
 <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
 <a1034df8-246d-e979-e2ee-2974ae31dde7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1034df8-246d-e979-e2ee-2974ae31dde7@huawei.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:19:21AM +0800, Xiongfeng Wang wrote:
> >> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> >> index ea7869c..d288900 100644
> >> --- a/drivers/auxdisplay/panel.c
> >> +++ b/drivers/auxdisplay/panel.c
> >> @@ -1506,10 +1506,10 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
> >>         key->rise_time = 1;
> >>         key->fall_time = 1;
> >>
> >> -       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
> >> -       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
> >> +       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str) - 1);
> >> +       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str) - 1);
> >>         strncpy(key->u.kbd.release_str, release,
> >> -               sizeof(key->u.kbd.release_str));
> >> +               sizeof(key->u.kbd.release_str) - 1);
> > 
> > Are you sure about this patch? `kbd` says "strings can be non null-terminated".
> > 
> > Willy, maybe those should just be memcpy()s? (unless the remaining
> > bytes, if any, must be 0).
> Sorry, my apologies. I think I made a mistake. I meant to use strlcpy(), but this
> also decrease the destination storage size by one.
> I think, if the strings can be non null-terminated,  we can just use memcpy().

Well, memcpy() needs as much data in as out. strncpy() does exactly what was
apparently needed there : take at most X chars from a given string, and write
exactly X on the output, possibly padding with zeroes. We sure can stop using
strncpy() and reimplement it, but that becomes ridiculous. One day gcc will
tell us that an "if" statement misses an "else" which is probably an error
and we'll have to put "else dummy();" everywhere in the code to calm it.

> This may suppress the gcc warning.

In fact there are two big problems with gcc warnings :
  - writing -Wno-something-unknown triggers an error on versions where
    "something-unknown" isn't known, making it difficult to permanently
    disable warnings (though in the kernel we handle this pretty fine)

  - warnings and diagnostics are conflated. Some warnings should only be
    provided when the developer explicitly asks for suspicious stuff
    (-Wsecurity, -Wsuspicious, etc) that would *not* be part of -Wall
    since -Wall is usually used to report real warnings.

My preferred one today is the one by which gcc reads your *comments* to
figure whether you forgot a break in a case statement...

Regards,
Willy
