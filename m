Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F783C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10832098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MGtDx8tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10832098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeGJXCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:02:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53272 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeGJXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:02:36 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so1056809itd.3;
        Tue, 10 Jul 2018 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DqREegzBZb9ouBcwAq1ghPvABiKBW6GSPywXXSW9nuU=;
        b=MGtDx8tRWrI+ujPQNO5xept0CeTgXP7SMOy+ebnqNy5dCnu0jTEK0JGUvHoV+sfzmC
         fixQiD/Nej2T+MxWrDBW0HcWIDlO60kIgXSOGMyev6P4VdPGGVj/iMpbB4foucSM6v9M
         qZPUMXk5hP4EgKk2vNU6TJvS6wkMe8cB8LyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DqREegzBZb9ouBcwAq1ghPvABiKBW6GSPywXXSW9nuU=;
        b=lvCAxfl4H/e0wOQzJyM04mkNhRkvy16ImfzscbxKblj/tz7rn0qXYGVWBZfBAKO/Pp
         5udAmz+2NtyNr8mMzO8fizVsIvQWuFeQHmPUmtF72O5a/c434Bjtlh8Ub/3/ofCBevnm
         pAuqfjiovPDgC20nQiPz1wlnomYdIZiu5ZkoWW8x9OnuPW2WPjaQ14Ktb2sE736YTRbe
         bVPkR7QZbSRKY1AYLUU0O8omP1KI3TY5pkpqecBHS167NZ30Xb7hCqrZhVoFvGzOL/E9
         Dc8Ckm32KOn4aTWOmyREej99BvB2sTLInfdECe1WW4mBPMGgF9NtvHwhnZPNvWHLL/44
         3p7w==
X-Gm-Message-State: APt69E0YxXdWd9SqvRUVg65RX60eHoV/tdSnZkD1/ZzMVdz9rDS7juqr
        Fz8t4SlqBU1ze9Xpc1Jm+JcqrV71/x7FfH9KdOs=
X-Google-Smtp-Source: AAOMgpfEWBBWhA3UyiLNTQMmoitgH/UgQwZEKxKFSpNYpwkcf5tghaVuP/a37hUbo1meFExYPI13z7EuBWKWTfHNW/8=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr20289456itg.1.1531263677445;
 Tue, 10 Jul 2018 16:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
In-Reply-To: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 16:01:06 -0700
Message-ID: <CA+55aFzEjPUGZFk7PnM0T6YEn5uRrscgyCHyhc_cYz0m8ejdLA@mail.gmail.com>
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:41 PM David Howells <dhowells@redhat.com> wrote:
>
> Here are a set of patches to create a filesystem context prior to setting
> up a new mount, populating it with the parsed options/binary data, creati=
ng
> the superblock and then effecting the mount.  This is also used for remou=
nt
> since much of the parsing stuff is common in many filesystems.
>
> This allows namespaces and other information to be conveyed through the
> mount procedure.
>
> This also allows Mikl=C3=B3s Szeredi's idea of doing:
>
>         fd =3D fsopen("nfs");
>         write(fd, "option=3Dval", ...);
>         mfd =3D fsmount(fd, MS_NODEV);
>         move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
>
> that he presented at LSF-2017 to be implemented (see the relevant patches
> in the series).

All your documentation (both commit logs, man-pages and in-kernel
actual docs you add) only talk about "what".

They don't talk about _why_.

I can imagine why's. But I think that the "why" is actually way mnore
important than the what. At no point did I see a "this is the current
interface, and it doesn't work for xyz, so here's the new interface
that allows us to do stuff".

When you have a diffstat like this:

 171 files changed, 7147 insertions(+), 1805 deletions(-)

I sure want to see an explanation for *WHY* it adds 5000+ lines of core cod=
e.

Also, I want to hear about sane security models. One of the things
people really want to do is have users do their own mounts. We've had
security issues in that area. Why does this improve on it, or make it
even worse?

And by "secuyrity models" I absolutely do not mean "here's how you can
do complex smack rules for it".

                 Linus
