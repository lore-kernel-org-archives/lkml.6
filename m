Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A80C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884362148C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CJALoDOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884362148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJQISM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:18:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43522 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeJQISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:18:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id p34-v6so18400546lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yiyXevFQcKiSav9R+PPf007BSwBS50KV+i99Exngp8=;
        b=CJALoDOvEA2Jink0bHra/Epb/mGqOX8SF9HymFLjBgYNLu9rTXSnWTGVt4/ni3VLA8
         6R4ZOvwQyAbY+x4tOozk2vGaOv49F0EU6Av2kkKbPMOH3rk9V95k9adiGCLbdWmAftcy
         BcY45BtTm1n3eb6I3M5ZRjz3sJYxHIRE5Tt20XmD590JQMGg8rjZLu2TWqcGZxN53LmM
         LoP+jJ+7922z7st4m1PwzSG+BVws3YIz0/sVnIQcghNhxh2/bVmX/OL8xWtDKyNKAFgC
         O6hopZlql5uzD+XRZf2wvIPzQtoghpvWWcYgTB/tbVMs/a5AzPT49G/edNsowYLx1Y6h
         woEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yiyXevFQcKiSav9R+PPf007BSwBS50KV+i99Exngp8=;
        b=O7dwtsDEs+io4PywIztIb8/WgCoz80dj4tMdv9k1rHaDwIANgkL1npc8fUfELm9iGZ
         tLgG5elfF7Ra3RpEdqKVJeygGOk5YJ093pySfhdVEbffKAd2H8woq6DO3QLJhVA72qb/
         hGcweVKf0XIJSpe2YmYcmWZCy1l/TpA4+bgXBhlI8QH3+KIptoQmIqeN5/Hbel5qLDv5
         KdEDX4bA1z0oFATQntdawYYGX/KlSlDJ9pxXFQ2fi9SOJVf78XysbzlSxhVNUGt3o6Sb
         M9P0ZHKjti237k9BC4SDJlBNxMAGguH6PKOMSb0E7+k6oo2+FfLsKA1aXMusoZjx/YZh
         v3vA==
X-Gm-Message-State: ABuFfojRekrMbVvy1QVp+IXhG4tbdMo/thnaFW4fDwxHdmoeKca6YaHi
        QrQQ+MKIAjy3CKpo1Eb8eA2t5ooCNoAHUhQ3xo6GMg==
X-Google-Smtp-Source: ACcGV63HO6c3ZRf0w+0XB46Z1TKJmra8gDf1MvvWM4HpM4cgeGzbFnoXtYk0BsRyaAQbckKQoP/S52UqqNgIr+ki+gc=
X-Received: by 2002:a19:be46:: with SMTP id o67-v6mr13312129lff.139.1539735909822;
 Tue, 16 Oct 2018 17:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181016223322.16844-1-christian@brauner.io> <20181016223322.16844-2-christian@brauner.io>
 <877eihjw0n.fsf@xmission.com>
In-Reply-To: <877eihjw0n.fsf@xmission.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Wed, 17 Oct 2018 02:24:57 +0200
Message-ID: <CAHrFyr6AeZzfGkQneiyoLz6YZ-vnyyQWTtc0HK-tqVJkoXt=4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sysctl: handle overflow in proc_get_long
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 1:46 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christian Brauner <christian@brauner.io> writes:
>
> > proc_get_long() is a funny function. It uses simple_strtoul() and for a
> > good reason. proc_get_long() wants to always succeed the parse and return
> > the maybe incorrect value and the trailing characters to check against a
> > pre-defined list of acceptable trailing values.
> > However, simple_strtoul() explicitly ignores overflows which can cause
> > funny things like the following to happen:
> >
> > echo 18446744073709551616 > /proc/sys/fs/file-max
> > cat /proc/sys/fs/file-max
> > 0
> >
> > (Which will cause your system to silently die behind your back.)
> >
> > On the other hand kstrtoul() does do overflow detection but does not return
> > the trailing characters, and also fails the parse when anything other than
> > '\n' is a trailing character whereas proc_get_long() wants to be more
> > lenient.
> >
> > Now, before adding another kstrtoul() function let's simply add a static
> > parse strtoul_lenient() which:
> > - fails on overflow with -ERANGE
> > - returns the trailing characters to the caller
> >
> > The reason why we should fail on ERANGE is that we already do a partial
> > fail on overflow right now. Namely, when the TMPBUFLEN is exceeded. So we
> > already reject values such as 184467440737095516160 (21 chars) but accept
> > values such as 18446744073709551616 (20 chars) but both are overflows. So
> > we should just always reject 64bit overflows and not special-case this
> > based on the number of chars.
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > v2->v3:
> > - (Kees) s/#include <../lib/kstrtox.h>/#include "../lib/kstrtox.h"/g
> > - (Kees) document strtoul_lenient()
> >
> > v1->v2:
> > - s/sysctl_cap_erange/sysctl_lenient/g
> > - consistenly fail on overflow
> >
> > v0->v1:
> > - s/sysctl_strtoul_lenient/strtoul_cap_erange/g
> > - (Al) remove bool overflow return argument from strtoul_cap_erange
> > - (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
> > - (Dominik) fix spelling in commit message
> > ---
> >  kernel/sysctl.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index cc02050fd0c4..102aa7a65687 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -68,6 +68,8 @@
> >  #include <linux/mount.h>
> >  #include <linux/pipe_fs_i.h>
> >
> > +#include "../lib/kstrtox.h"
> > +
> >  #include <linux/uaccess.h>
> >  #include <asm/processor.h>
> >
> > @@ -2065,6 +2067,41 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
> >       }
> >  }
> >
> > +/**
> > + * strtoul_lenient - parse an ASCII formatted integer from a buffer and only
> > + *                   fail on overflow
> > + *
> > + * @cp: kernel buffer containing the string to parse
> > + * @endp: pointer to store the trailing characters
> > + * @base: the base to use
> > + * @res: where the parsed integer will be stored
> > + *
> > + * In case of success 0 is returned and @res will contain the parsed integer,
> > + * @endp will hold any trailing characters.
> > + * This function will fail the parse on overflow. If there wasn't an overflow
> > + * the function will defer the decision what characters count as invalid to the
> > + * caller.
> > + */
> > +static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
> > +                        unsigned long *res)
> > +{
> > +     unsigned long long result;
> > +     unsigned int rv;
> > +
> > +     cp = _parse_integer_fixup_radix(cp, &base);
> > +     rv = _parse_integer(cp, base, &result);
> > +     if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
> > +             return -ERANGE;
> > +
> > +     cp += rv;
> > +
> > +     if (endp)
> > +             *endp = (char *)cp;
> > +
> > +     *res = (unsigned long)result;
> > +     return 0;
> > +}
> > +
> >  #define TMPBUFLEN 22
> >  /**
> >   * proc_get_long - reads an ASCII formatted integer from a user buffer
> > @@ -2108,7 +2145,8 @@ static int proc_get_long(char **buf, size_t *size,
> >       if (!isdigit(*p))
> >               return -EINVAL;
> >
> > -     *val = simple_strtoul(p, &p, 0);
> > +     if (strtoul_lenient(p, &p, 0, val))
> > +             return -EINVAL;
>
> Is it deliberate that on an error stroul_lenient returns -ERANGE but
> then proc_get_long returns -EINVAL?  That feels wrong.  The write system

Yes, because all other integer parsing function return ERANGE as well.
Right now there are no other users but if someone wants to use that function
I wanted it to behave like the others.

> call does not permit -ERANGE or -EINVAL for the contents of the data
> so both options appear equally bad from a standards point of view.

Right, but if you write a value that exceeds the buffer of 22 chars that is used
to parse you already get EINVAL back on current kernels.
So it didn't feel like returning EOVERFLOW or ERANGE might make sense.
I saw a change in 4.10 or 4.11 as well that used EINVAL on UINT_MAX overflow
or something. EINVAL might be enough information for userspace here ?/.

>
> I am just wondering what the thinking is here.
>
> >       len = p - tmp;
