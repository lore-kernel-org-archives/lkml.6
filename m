Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeBLRLw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:11:52 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40553 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbeBLRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:11:50 -0500
Date: Mon, 12 Feb 2018 18:11:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Dan <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] auxdisplay: use correct string length
Message-ID: <20180212171137.GA31601@1wt.eu>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
 <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 01:53:57PM +0100, Miguel Ojeda wrote:
> > diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> > index ea7869c..d288900 100644
> > --- a/drivers/auxdisplay/panel.c
> > +++ b/drivers/auxdisplay/panel.c
> > @@ -1506,10 +1506,10 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
> >         key->rise_time = 1;
> >         key->fall_time = 1;
> >
> > -       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
> > -       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
> > +       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str) - 1);
> > +       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str) - 1);
> >         strncpy(key->u.kbd.release_str, release,
> > -               sizeof(key->u.kbd.release_str));
> > +               sizeof(key->u.kbd.release_str) - 1);
> 
> Are you sure about this patch? `kbd` says "strings can be non null-terminated".
> 
> Willy, maybe those should just be memcpy()s? (unless the remaining
> bytes, if any, must be 0).

For me this seems to be the result of yet another very stupid gcc warning
trying to dissuade us from using well defined fonctions... it's unimaginable
how gcc warnings have become stupid and irrelevant since its developers
stopped using C to write it :-(

If you want to work around this wrong warning, probably that increasing the
destination storage size by one and adding -1 to strncpy() would shut it up
but that really becomes quite annoying to have to modify code and storage
just to shut down a dumbass compiler trying to be smart.

Willy
