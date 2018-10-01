Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1829DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AC02089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXnlKWvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AC02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeJATGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:06:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38299 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbeJATGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:06:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id u197-v6so10995745oif.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzcmUr/rQVIrMQq+LwEcrc2tBipkiKRrMFA6QScA0/I=;
        b=SXnlKWvlVtqPhlPrsrBgZKX/A4qe1XqGBxK5yMvVWEIKrQKmCthlOoFe/7U++Yv/CT
         9KnkfmH1iJsXdykjZ0bXOSnj04RvrFykuNNitF4bRzyjGuxscdouopSJvSi6zFutcEg3
         y46HTeHu+hGuIPAyP5DJ6r/1nKynMkdJwI50LN4blMKQVD3sDrX70q5tr51a/ke6yQg3
         hVRdIujkRtcL4DnRywYzoKaVP8m5ct7LUHjz8pBqxkJpP9rPATZPAwt/EXYbbqAtoLVo
         q3XO6Cncl6m1OqLMV6dfSg8y7M5h6P3LGTVWL8GgTxqUgQmvbNVs1JISwa8zoivc9rVP
         krSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzcmUr/rQVIrMQq+LwEcrc2tBipkiKRrMFA6QScA0/I=;
        b=Ss+fAwIbO1sSSQzar+zPOBnhJC19tqSXa+Zm09d9ohGgBgZgffyK+Ru/V5W9f/FFQg
         RZLqmMThPWcOin5Uo6u80o7USHpY+H7FQA1DKGAM4bq4Tfr9cixH4m+t5URDB4hYx8Ay
         veSZrVrRbe0PFKyHiywFdDXJVvQkDUAUbtx4ecuVLniOBzE0jAHcckltWTAsapuRARAA
         Bo0LLik5yzufVhxHJ3wu7+/WGl4JhY6Ipf4WDo0l/wDVof+kFbSXkVJp0qUIG75iMPoi
         TXUTMI0rCUuneN1mZ+977c9dp9b0H9dsQYzSvXMhh+fiDWR3GqLuMoGSQBnVqv99RPvr
         jbyQ==
X-Gm-Message-State: ABuFfogk/xi842ApWJqdqozxyXETkkwg9RFsK3ibHsm4H5yM5gxfHGlO
        wud+O3uS6iK9cz2ao4LPRISYvNZoCeA0vjF03BM8uQ==
X-Google-Smtp-Source: ACcGV62ig2Y4IvYEEvRnYezB+MtWhb5tG/AmsLT2I9rCzf8lsBsDaZOBZ5d1yD1PZiLb9lInu/AOKAeASk1bcfPCgVM=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr4691305oif.177.1538396910549;
 Mon, 01 Oct 2018 05:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929103453.12025-2-cyphar@cyphar.com>
In-Reply-To: <20180929103453.12025-2-cyphar@cyphar.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Oct 2018 14:28:03 +0200
Message-ID: <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
To:     cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 4:28 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> Add the following flags for path resolution. The primary justification
> for these flags is to allow for programs to be far more strict about how
> they want path resolution to handle symlinks, mountpoint crossings, and
> paths that escape the dirfd (through an absolute path or ".."
> shenanigans).
>
> This is of particular concern to container runtimes that want to be very
> careful about malicious root filesystems that a container's init might
> have screwed around with (and there is no real way to protect against
> this in userspace if you consider potential races against a malicious
> container's init).
>
> * AT_BENEATH: Disallow ".." or absolute paths (either in the path or
>   found during symlink resolution) to escape the starting point of name
>   resolution, though ".." is permitted in cases like "foo/../bar".
>   Relative symlinks are still allowed (as long as they don't escape the
>   starting point).

As I said on the other thread, I would strongly prefer an API that
behaves along the lines of David Drysdale's old patch
https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/
: Forbid any use of "..". This would also be more straightforward to
implement safely. If that doesn't work for you, I would like it if you
could at least make that an option. I would like it if this API could
mitigate straightforward directory traversal bugs such as
https://bugs.chromium.org/p/project-zero/issues/detail?id=1583, where
a confused deputy attempts to access a path like
"/mnt/media_rw/../../data" while intending to access a directory under
"/mnt/media_rw".

> * AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
>   from one). The primary "scoping" use is to blocking resolution that
>   crosses a bind-mount, which has a similar property to a symlink (in
>   the way that it allows for escape from the starting-point). Since it
>   is not possible to differentiate bind-mounts However since
>   bind-mounting requires privileges (in ways symlinks don't) this has
>   been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
>   (though find(1) doesn't walk upwards, the semantics seem obvious).
>
> * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
>   specific restriction, and it exists because /proc/$pid/fd/...
>   "symlinks" allow for access outside nd->root and pose risk to
>   container runtimes that don't want to be tricked into accessing a host
>   path (but do want to allow no-funny-business symlink resolution).

AT_BENEATH has to imply AT_NO_PROCLINK, right? Especially with the
semantics you picked for AT_BENEATH. With the original O_BENEATH_ONLY
semantics, it might be okay to not imply AT_NO_PROCLINK...

> * AT_NO_SYMLINK: Disallows symlink jumping *of any kind*. Implies
>   AT_NO_PROCLINK (obviously).
>
> The AT_NO_*LINK flags return -ELOOP if path resolution would violates
> their requirement, while the others all return -EXDEV. Currently these
> are only enabled for the stat(2) family and the openat(2) family (the
> latter has its own brand of O_* flags with the same semantics). Ideally
> these flags would be supported by all *at(2) syscalls, but this will
> require adding flags arguments to many of them (and will be done in a
> separate patchset).
