Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA5AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192F020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CCN4HIIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeGWUCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:02:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40370 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbeGWUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:02:55 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so250572ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nvVkN5YjzEa1ZDxcnuw/cmYC2X4Wn2J/3GX5j65O40=;
        b=CCN4HIIyScSK2lVgwQ2qyO+jehyyq/OZb5lRXtJqKSd1YALm/Z4eexZqQOhrKT8g/C
         NjidzMi5+6RhuUOsS+VcOs70UykQfLKhnvfD1YcYF9C+bbQ5VmgDtS7P47C32gQoiLeD
         YpYUWtJliqq23Bck65aHcazkeIK0tm9rAeKIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nvVkN5YjzEa1ZDxcnuw/cmYC2X4Wn2J/3GX5j65O40=;
        b=N50N6eh3kQ7ErpY/lavxMTK0cKhtvKwyBfjm4qJgOjubcLYQo7CiBKnHR5g63Lm1Gf
         v3ul6WohaVe4gPDBFqCPI/kuub69GqR+zfXMwc3ik3mRryCtA0b5oqopgkZFSlE+fwkh
         8vF8flm91K7OPXuob5c0x9Ny02MqI1WSH8dNJhPcUYAuhwgIiHMDJN+Bctk/1uYOX5i0
         JGgaz9fwsn9DLpBaj8UoRQoor0txh4VU79nBS6f791OoQtXIBYtRgwxrxLk7+ueMZ7Q6
         lo3yQDIWDLorUnfIuF9piU5gqxWGkDJV0qEWzkkxknaivjSDSF+S7eHjBJhJWZMVWLYK
         runw==
X-Gm-Message-State: AOUpUlHkKjEUahsCPUv3AmaZBFxr2kDlaarW86W7wNqz/CBgiqla0NkK
        eAsFqzrffilFIIe68wox1yxUKL7QJ9LqDYUceWk=
X-Google-Smtp-Source: AAOMgpeMIkSZnAxs+Ws20buW3tqcDmMxBU6bJOiZtPhjS2WXbPu+G6WiUOg3xeK9h8q+QOsXBnbqK16GPJNJqEQpAtQ=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr12780530jaa.10.1532372419941;
 Mon, 23 Jul 2018 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <20180723140925.GA4285@amd>
In-Reply-To: <20180723140925.GA4285@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jul 2018 12:00:08 -0700
Message-ID: <CA+55aFynT9Sp7CbnB=GqLbns7GFZbv3pDSQm_h0jFvJpz3ES+g@mail.gmail.com>
Subject: Re: [PATCH 0/3] PTI for x86-32 Fixes and Updates
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 7:09 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Meanwhile... it looks like gcc is not slowed down significantly, but
> other stuff sees 30% .. 40% slowdowns... which is rather
> significant.

That is more or less expected.

Gcc spends about 90+% of its time in user space, and the system calls
it *does* do tend to be "real work" (open/read/etc). And modern gcc's
no longer have the pipe between cpp and cc1, so they don't have that
issue either (which would have sjhown the PTI slowdown a lot more)

Some other loads will do a lot more time traversing the user/kernel
boundary, and in 32-bit mode you won't be able to take advantage of
the address space ID's, so you really get the full effect.

> Would it be possible to have per-process control of kpti? I have
> some processes where trading of speed for security would make sense.

That was pretty extensively discussed, and no sane model for it was
ever agreed upon.  Some people wanted it per-thread, others per-mm,
and it wasn't clear how to set it either and how it should inherit
across fork/exec, and what the namespace rules etc should be.

You absolutely need to inherit it (so that you can say "I trust this
session" or whatever), but at the same time you *don't* want to
inherit if you have a server you trust that then spawns user processes
(think "I want systemd to not have the overhead, but the user
processes it spawns obviously do need protection").

It was just a morass. Nothing came out of it.  I guess people can
discuss it again, but it's not simple.

               Linus
