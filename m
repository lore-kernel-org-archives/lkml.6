Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773846; cv=none;
        d=google.com; s=arc-20160816;
        b=sgG0UstFn7cXT+sKsT0V25BiBJWm0SfoDPSUkTWslP+/NRnuyDZBZ1uWq68R+zIIde
         6xcJw47MO3TkK7Ss2jwSeBF3KW2PXZaSsnLZzGR1Gb5JlBDhO2oMoEVlWloxl8K/kwi2
         SeE/juPacoR3FYHPXzrE0iwct2j1wfRL9j51y5eZgr7/qbIAyBX6Rt4ZVI2O3m9EiN5T
         UWAedV97GMZOUG0twlwnIZGgXxD14KGA9WGC5KONhrVpSvYP2IgLOPWvUBzWkGS27Pvt
         f/yDZgUS00hLQ/ot8MaJjUm47geYqiITq5lk5p0erYf+teGJw0IemsjzTMOQy/BqhNP0
         omxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=5afE0EGM52kycuRXFwmD1LdxV9C/CMDCoRwNBLQHUY4=;
        b=Qiia1zyhBurNiJvTfkl/dhFX6TEcUFIXbVY3ncwSKaPBztfgPWIuU0xJ5/ivD7t0D8
         eA8qorh3QnBnj+F8aLtfZAqicpGRgzeCYibQ4PV5W2c+q6oDwsVwmmyX8zn/gJYhV1zb
         AXEbVYn/GdogrD8EIE0RUEbeCmaRH7Dza883fmLYY6O2zFztelgm04S2w0Or7ZDYcu3q
         a90bjuRKdVcWNo93jCe5cTs6LvnlYGX61Pabhbk86OAWrJzwKGHgWkgXtZTqdadYu6dm
         FrlzBYNTrB2Hb0pYzZmzFAROqtrFb3GY2bMs/h8wcHvRGkMK8AY61E5JIV9o4WqCq48x
         KFOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P9glOKsk;
       dkim=pass header.i=@chromium.org header.s=google header.b=EjHUA42v;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P9glOKsk;
       dkim=pass header.i=@chromium.org header.s=google header.b=EjHUA42v;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvtMPlAKd0X84JkuxkkVGyHK2YzSYvmoJF8lCvTHmrn4LJLPnU0IoM0YnUM+fEgNx2Yq1SrkFjGq4IpvcQvfnA=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224030046.24238-1-mcgrof@kernel.org>
References: <20180224030046.24238-1-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:24:05 -0800
X-Google-Sender-Auth: ZsIlBxbJycSNl0LOiNAApIz8LGI
Message-ID: <CAGXu5jJO_=EbY3bP2h0YPGUYNA=4H1PujaUkkRN-kkgQaKupwg@mail.gmail.com>
Subject: Re: [PATCH] test_kmod: fix limit check on number of test devices created
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Michal Marek <mmarek@suse.com>,
	Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Matt Redfearn <matt.redfearn@imgtec.com>, Dan Carpenter <dan.carpenter@oracle.com>,
	Colin King <colin.king@canonical.com>, Daniel Mentz <danielmentz@google.com>,
	David Binderman <dcb314@hotmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593249635638091156?=
X-GMAIL-MSGID: =?utf-8?q?1593598381148780176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 7:00 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> As reported by Dan the parentheses is in the wrong place, and since
> unlikely() call returns either 0 or 1 it's never less than zero.
> The second issue is that signed integer overflows like "INT_MAX + 1" are
> undefined behavior.
>
> Since num_test_devs represents the number of devices, we want to stop
> prior to hitting the max, and not rely on the wrap arround at all. So
> just cap at num_test_devs + 1, prior to assigning a new device.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_kmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index e372b97eee13..0e5b7a61460b 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -1141,7 +1141,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
>         mutex_lock(&reg_dev_mutex);
>
>         /* int should suffice for number of devices, test for wrap */
> -       if (unlikely(num_test_devs + 1) < 0) {
> +       if (num_test_devs + 1 == INT_MAX) {
>                 pr_err("reached limit of number of test devices\n");
>                 goto out;
>         }
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
