Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D3CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2928208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyzqXENy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2928208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeJPAEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:04:39 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37810 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJPAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:04:39 -0400
Received: by mail-yb1-f193.google.com with SMTP id h1-v6so7710050ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T/sC+eYmGpk6wkvDCQkhcjIHQAX7Gl/+p+UJKaLtP2A=;
        b=QyzqXENy2HRdjeG/AX3jrKF5oDgqEuLPQXs4kYLSR9f6FzdZ2Y6dK/lDdb6oarijjE
         bwPNxaEjgzz8YTR11kXYxkZI1SC5nutPZ4bslrJOGjU3hI4v7pO2wED1TIXxg192EblI
         O6YJCb0nUyYGV23wXaISP+J4dCJXACFsykpMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T/sC+eYmGpk6wkvDCQkhcjIHQAX7Gl/+p+UJKaLtP2A=;
        b=pXUs/urXWDvsAnX8UEGU1UO3hBlWRUO6YcwdyV40YXzbc2eihtdheJ+XKnXNaiEtYx
         23UgZYm1UXtCbobjIeUOkB53dQPzwvpJ9JAuc7mKjoiEN017AqYpthsGWkZ8OOHkqIkP
         Nu7G4eQoBEg5eLLNY8HsX+VL9vqcqtCaGCaLxVPT7GDx2mz0fxOVBjRb9GeaQwcvb3Di
         vbNvN2hoshRJdE1ZHQvRrQjJiG+4v0FfKYg5mMKwYvzajj+9MFI7oxuXnTdTk7D9nI0G
         MJFznbI7khWHKYh5b/Gposanu8SKiYhEmAEjrhlzfAx0VJ1Chvj+sl0G6UB7Nlam8ION
         hiMg==
X-Gm-Message-State: ABuFfoiUXnfBiWaN/G1JqDb3KmFuZGcnb28fJQ5imfn7lNadQSLvVHQV
        AGXmdCE65MywmMNqR0qHFLu0FG2WTXM=
X-Google-Smtp-Source: ACcGV62H/Oh4YgzgOYWx9UVem+ztco9ZsXMdkBehIGaiD81SKTK1C8x3B+A+o5EBV+2H/IEcUVM4Pg==
X-Received: by 2002:a25:bb87:: with SMTP id y7-v6mr9042461ybg.382.1539620325052;
        Mon, 15 Oct 2018 09:18:45 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id p185-v6sm3216142ywc.14.2018.10.15.09.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:18:42 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id a197-v6so7724452ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:18:41 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr10186636ywd.124.1539620321174;
 Mon, 15 Oct 2018 09:18:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 09:18:40
 -0700 (PDT)
In-Reply-To: <20181015105544.4395-2-christian@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io> <20181015105544.4395-2-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 09:18:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+BZsmRXwXfXk1YcyuSRNMmre=K55e1CXaLJDUZ07rmvQ@mail.gmail.com>
Message-ID: <CAGXu5j+BZsmRXwXfXk1YcyuSRNMmre=K55e1CXaLJDUZ07rmvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
To:     Christian Brauner <christian@brauner.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Mon, Oct 15, 2018 at 3:55 AM, Christian Brauner <christian@brauner.io> wrote:
> proc_get_long() is a funny function. It uses simple_strtoul() and for a
> good reason. proc_get_long() wants to always succeed the parse and return
> the maybe incorrect value and the trailing characters to check against a
> pre-defined list of acceptable trailing values.
> However, simple_strtoul() explicitly ignores overflows which can cause

What depends on simple_strtoul() ignoring overflows? Can we just cap
it to ULONG_MAX instead?

I note that both simple_strtoul() and simple_strtoull() are marked as
obsolete (more below).

> funny things like the following to happen:
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
> cat /proc/sys/fs/file-max
> 0
>
> (Which will cause your system to silently die behind your back.)
>
> On the other hand kstrtoul() does do overflow detection but fails the parse
> in this case, does not return the trailing characters, and also fails the
> parse when anything other than '\n' is a trailing character whereas
> proc_get_long() wants to be more lenient.

This parsing strictness difference makes it seem like the simple_*()
shouldn't be considered obsolete...

and it's still very heavily used:

$ git grep -E 'simple_strtoull?\(' | wc -l
745

> Now, before adding another kstrtoul() function let's simply add a static
> parse strtoul_cap_erange() which does:
> - returns ULONG_MAX on ERANGE
> - returns the trailing characters to the caller
> This guarantees that we don't regress userspace in any way but also caps
> any parsed value to ULONG_MAX and prevents things like file-max to become 0
> on overflow.

-Kees

-- 
Kees Cook
Pixel Security
