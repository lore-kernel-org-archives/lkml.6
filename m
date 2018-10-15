Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93159208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="AyD9p1Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93159208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeJPCsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:48:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35748 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeJPCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:48:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so14931180lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd6lezi5BylV008NDKsRb2G+WBfRgJSK+ixJIXZYXcE=;
        b=AyD9p1SgMytW0i2sL74jEYMwAKUjeQ7MQj3toTcv60JUZ2Z93fHc8jnW3hNguH0LZ/
         MKV+80uIwTEQhyShvS4AORDGp2NVSrIsz918KXKCwpAEGknRUeidqj8jTK1ijp1VUMfP
         4swoSDnMdWWSFBuLbvT8d7nLbfWwOdR2/rSaNxFiSJ5rCiaM4QWKcQD04GUtozPiBIOM
         4u8fCJdoaGiFK/yG+Haov+8UMhX62QCxyUgQnGlc+WNooS7tJIMqKRzROnWHrC2Yttk9
         dQa/mZETeDAWVK5w7+bQ1Tn0mVWjFOhmPku4EYsTsO3M9ATa446E7aJ6SVI9JeJX00gT
         dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd6lezi5BylV008NDKsRb2G+WBfRgJSK+ixJIXZYXcE=;
        b=t4Bn8Vn3f7xq/cDL5XymGanvbKUXp7lPiUkJije27EPztnLD2jU2LYkclGIM/Z4iBH
         CIFbOQ2vLrIghK9DC5r/At0yWjaGifiv9xvFs0joqxjRdAMbzgVafFaBZuQVvQBrmqLV
         alj0hqIfEgq38/qoG0DScUG1AVuvZyd1c8tv/VzeKgHfyaqmhEKoL8Yo2jErZyydF/De
         swDU530ZJzUNp8Tl9hYoRKuV8vt1exWTzriiuDahMeMXcECmZefF34SPrs8RMt7JyYDe
         IqQ3M+89WmhSsuFiaK17SYNzHEuT5jpSCD6yYROCvcKyMxZlEMi8Sr3lixO5swfE0B8n
         ryWQ==
X-Gm-Message-State: ABuFfohsV7QP7yAWe9BwTaPzbKboyCFHnuIa+H6QdAExgcsU4twKeIWx
        GxLG8afqMR19nAjTM0bFe1lblRaU4SamaMSpBV1gcQ==
X-Google-Smtp-Source: ACcGV60DK7T7zLRRte1xfE47GERemoKFBWEWLa0cHukToB+ytI3ge3O7qroWfJuv1RNsQpoNdWhF3221xguoa3FxKck=
X-Received: by 2002:a19:be46:: with SMTP id o67-v6mr10015041lff.139.1539630108059;
 Mon, 15 Oct 2018 12:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181015105544.4395-1-christian@brauner.io> <20181015105544.4395-2-christian@brauner.io>
 <CAGXu5j+BZsmRXwXfXk1YcyuSRNMmre=K55e1CXaLJDUZ07rmvQ@mail.gmail.com> <20181015163009.byd2lklpk2n3qzpq@brauner.io>
In-Reply-To: <20181015163009.byd2lklpk2n3qzpq@brauner.io>
From:   Christian Brauner <christian@brauner.io>
Date:   Mon, 15 Oct 2018 21:01:35 +0200
Message-ID: <CAHrFyr4LLxeVFMaP+H=QTLUcVsnNp0JEP4T0L02nKVXU5OwwUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 6:30 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Oct 15, 2018 at 09:18:40AM -0700, Kees Cook wrote:
> > On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> > > proc_get_long() is a funny function. It uses simple_strtoul() and for a
> > > good reason. proc_get_long() wants to always succeed the parse and return
> > > the maybe incorrect value and the trailing characters to check against a
> > > pre-defined list of acceptable trailing values.
> > > However, simple_strtoul() explicitly ignores overflows which can cause
> >
> > What depends on simple_strtoul() ignoring overflows? Can we just cap
> > it to ULONG_MAX instead?
> >
> > I note that both simple_strtoul() and simple_strtoull() are marked as
> > obsolete (more below).
> >
> > > funny things like the following to happen:
> > >
> > > echo 18446744073709551616 > /proc/sys/fs/file-max
> > > cat /proc/sys/fs/file-max
> > > 0
> > >
> > > (Which will cause your system to silently die behind your back.)
> > >
> > > On the other hand kstrtoul() does do overflow detection but fails the parse
> > > in this case, does not return the trailing characters, and also fails the
> > > parse when anything other than '\n' is a trailing character whereas
> > > proc_get_long() wants to be more lenient.
> >
> > This parsing strictness difference makes it seem like the simple_*()
> > shouldn't be considered obsolete...

So what I would prefer in this case - if people agree that such a function
is useful - is to add a new function to lib/kstrtox.c and include/linux/kernel.h
e.g.:

int kstrtoul_bounded(const char *s, unsigned int base, char
**trailing, unsigned long long *res)

which aligns with the other kstrto*() functions, caps at <TYPE>_MAX,
doesn't fail the parse,
and returns the trailing characters in char **trailing. Then people
can start switching users of
simple_strtoul() over to this function without regressing anything.

Christian

> >
> > and it's still very heavily used:
> >
> > $ git grep -E 'simple_strtoull?\(' | wc -l
> > 745
>
> Maybe, but the intention is probably to fade it out and to not use it in
> new code because it doesn't handle overflow.
> Tbh, I'm weary to change that to suddenly return a ULONG_MAX on overflow
> instead of what it is doing now. I have absolutely no idea what this
> might break given how much it is still used in the kernel...
>
> >
> > > Now, before adding another kstrtoul() function let's simply add a static
> > > parse strtoul_cap_erange() which does:
> > > - returns ULONG_MAX on ERANGE
> > > - returns the trailing characters to the caller
> > > This guarantees that we don't regress userspace in any way but also caps
> > > any parsed value to ULONG_MAX and prevents things like file-max to become 0
> > > on overflow.
> >
> > -Kees
> >
> > --
> > Kees Cook
> > Pixel Security
