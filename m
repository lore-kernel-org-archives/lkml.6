Return-Path: <miguel.ojeda.sandonis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518468144; cv=none;
        d=google.com; s=arc-20160816;
        b=VhbM7HdOf9fh3we0Zzo7hWz5e2CooJUgAihbjY4yniSTt6FYvauDrlsBWgzaXAD/7e
         e2mHRseOKZBp49+NrwSb9uG2U39ts/Xg6fnK4a7OZg2wV0Ak2BLalQIoeNRR0N7DZ6vx
         bbcEj/VsDFxP885vdUyZ5+zXhDKDndcwPBYk1dHcg/TfP5nsXpscYkqAxHWFpU769M4Y
         XLPf2dFbN9HA4YrQTCF82OPFmMetgG9IgzFVzH62drweJlYZYvfEz+KNu3W8E+97rsm8
         DbCmFf+QJc6Moz2SJjg05hp8poNfqYabUzPmX3+xOkzteR3StUD/DirVX0mWaP/hqdNh
         uo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PUM8dcBdB5RdSQCvTyKcQbPKCYMwGoYW+tLnnX7bY98=;
        b=zY2m8WKijHzkfBYqlOZJ4fDb+rOYfVUnFg9soBpFNmJDGH1t8hGmP9f/SSaH7Ni7oi
         lVT4o1FFdJ4HLCnk1uqzwv0M7bS4FvyJxYMQlh6LXOVJsSkckiFm2ZVRRSyns3sfltv5
         dcbT4UTA4WXURU4qKmZS9hKDNnYoTTc2PZuzwUqXHPqorOlX20tIOL5rmTv5hkCwfiIL
         0nsWVA1W1q/klBvr8r4eS0WW/K26jcv2SjBTMiYJg3tgoQ7sRowou8iI1Gg6ziyDiSVL
         GSORhZYnLhQWN1nxpM6Pi1znz6OFRkNzAYF3w7+SBGQxt7JnaDh0DJofqpwGsM3RWbHd
         52vA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y1/OVUUx;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y1/OVUUx;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227fP1MO+7D5cFeqvr1yHI6XGKaxcyUhPYi6vncwRVoPIZ3e7WI3UQgtvwSm8JAR7HDFVFAExlT9OTLc/NbM7nU=
MIME-Version: 1.0
In-Reply-To: <20180212171137.GA31601@1wt.eu>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
 <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com> <20180212171137.GA31601@1wt.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2018 21:42:23 +0100
Message-ID: <CANiq72n0nvCPcR5t=z2dxdP-pJC+QsMmhAN7NXX-+HS-LhN8BA@mail.gmail.com>
Subject: Re: [PATCH V2] auxdisplay: use correct string length
To: Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, Dan <dan.carpenter@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592229253763542229?=
X-GMAIL-MSGID: =?utf-8?q?1592229253763542229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 6:11 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Mon, Feb 12, 2018 at 01:53:57PM +0100, Miguel Ojeda wrote:
>> > diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
>> > index ea7869c..d288900 100644
>> > --- a/drivers/auxdisplay/panel.c
>> > +++ b/drivers/auxdisplay/panel.c
>> > @@ -1506,10 +1506,10 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
>> >         key->rise_time = 1;
>> >         key->fall_time = 1;
>> >
>> > -       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
>> > -       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
>> > +       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str) - 1);
>> > +       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str) - 1);
>> >         strncpy(key->u.kbd.release_str, release,
>> > -               sizeof(key->u.kbd.release_str));
>> > +               sizeof(key->u.kbd.release_str) - 1);
>>
>> Are you sure about this patch? `kbd` says "strings can be non null-terminated".
>>
>> Willy, maybe those should just be memcpy()s? (unless the remaining
>> bytes, if any, must be 0).
>
> For me this seems to be the result of yet another very stupid gcc warning
> trying to dissuade us from using well defined fonctions... it's unimaginable
> how gcc warnings have become stupid and irrelevant since its developers
> stopped using C to write it :-(
>
> If you want to work around this wrong warning, probably that increasing the
> destination storage size by one and adding -1 to strncpy() would shut it up

It does indeed.

> but that really becomes quite annoying to have to modify code and storage
> just to shut down a dumbass compiler trying to be smart.
>

I have looked a bit deeper at this new warning. It comes with -Wall,
and to trigger it the compiler needs to have some optimization passes
enabled (-O2 works). See https://godbolt.org/g/dydPah to play with it
in action.

Assuming gcc 8 comes out with this warning implemented as of today
(likely), we have several options then:

  a) -Wno-stringop-truncation for gcc >= 8. Note: the warning checks
for several kinds of potential issues, some might be useful.

  b) Use the new __attribute__((nonstring)) for gcc >= 8. For
instance, the kbd strings are anyhow marked with the /* strings can be
non null-terminated */ comment, so we might just as well replace the
comment with the attribute.

  c) For this case: +1 the array length, -1 the sizeof; as Willy
suggested; or similar workarounds.

  d) For this case: try to make gcc see that the source is a small
enough array. Unlikely, due to the keypad_profile indirection and the
loop in keypad_init.

Since anyway we will be hit by this warning in N places in the kernel
now or in the future, let's ask Linus et. al. about what should be the
policy to follow :)

Miguel

> Willy
