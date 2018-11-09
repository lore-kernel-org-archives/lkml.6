Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3587C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CEA20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pE1MTJ1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CEA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeKJI4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:56:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46441 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeKJI4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:56:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so1574589plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ecdfi+s3UHADkB/c9MvtGgEFKZcs4GegnUCkw0TJ+hk=;
        b=pE1MTJ1+tNrplxr+0LMaYhqlvih2j0Mdc8x/B/ilmRColjgNXleCTfJMBOQapitpE/
         gaLOPibn3xY82ixgHtyAruFdb8jxdAofYZJAoMHAbKwJg/+Od3d2kUilB/o0PRADIK91
         qG3WUScsNmp3M1CZsQZdTISto2jFijSuw5HM5P15FP8QebaVjW5j2ZSxq5Ip6LCDpQfX
         WaG+ouXQMx+fCRkt5RKgGRJc9j5E0DzS+dwMGVByZmnZKIbM3m1OxB/b9riaKigdkzX/
         isPwUsPvyouOTfbwEdZYu6XgzCIyhadVjkdC9aTZL6FkFzpA9NnhFa2eAFhM1EB/xRH3
         eWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ecdfi+s3UHADkB/c9MvtGgEFKZcs4GegnUCkw0TJ+hk=;
        b=A9siDU9KDHswN4kf5ZTw8fsDjraaIgHxHngUwJM7xolfMBLKHa8/48o/vjgkYQDxHO
         tzFhvYa/iRN/5/RntTu/HN4EFUmy3YPhLRbTEDyrBmZjOdm75qPA3VbVFB+uYlYQEcMS
         GtKkEYMb5MPUY8me/7kt8OAQWGZoSTtaNS1aqXdE/aVomhHMR4jGgvJeO9jQG14jvjcY
         a5oQgJ8DQAouLMt2MGQmPqze26JRGM8yUpvUswkQxldshBhJI1YlgPT4I+nkoTzZIWXM
         3a3dnC/noSkK07xU+EcctgyKsQzypP4bHScEO+lzYPocTZBebJ7Y/eYE77QCb0CZa+ox
         BQcQ==
X-Gm-Message-State: AGRZ1gIVsxucSrceEU9pcAZz2v1NeV/am/2Z0q6KZ95n3LX+SX2/EDdN
        hCVneO67Ka/hHF04Bwxa45cguA==
X-Google-Smtp-Source: AJdET5fpWHvuP7wuaAiUbNtni/EgFTRWm6VJ9x47ZndV49KFybUTUGtTXHVTwCiDnHMA6WnDLeI55w==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr10370949plb.69.1541805244804;
        Fri, 09 Nov 2018 15:14:04 -0800 (PST)
Received: from ?IPv6:2600:1010:b053:7a5b:70bc:5409:d54c:f5a1? ([2600:1010:b053:7a5b:70bc:5409:d54c:f5a1])
        by smtp.gmail.com with ESMTPSA id k129sm11968615pgk.29.2018.11.09.15.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:14:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZuetZrL10zWwn4Jzzg0QL2nd3Fm0JxGtzC79SZAfOK525Ag@mail.gmail.com>
Date:   Fri, 9 Nov 2018 15:14:02 -0800
Cc:     Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8A6A5DC-3BA0-43BD-B7EC-EDE199B33A02@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com> <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com> <BB64C995-F374-49EB-8469-4820231D8152@amacapital.net> <CAKOZuetZrL10zWwn4Jzzg0QL2nd3Fm0JxGtzC79SZAfOK525Ag@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 2:42 PM, Daniel Colascione <dancol@google.com> wrote:
>=20
> On Fri, Nov 9, 2018 at 2:37 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>>> Another, more general fix might be to prevent /proc/pid/fd/N opens
>>> from "upgrading" access modes. But that'd be a bigger ABI break.
>>=20
>> I think we should fix that, too.  I consider it a bug fix, not an ABI bre=
ak, personally.
>=20
> Someone, somewhere is probably relying on it though, and that means
> that we probably can't change it unless it's actually causing
> problems.
>=20
> <mumble>spacebar heating</mumble>

I think it has caused problems in the past. It=E2=80=99s certainly extremely=
 surprising behavior.  I=E2=80=99d say it should be fixed and, if needed, a s=
ysctl to unfix it might be okay.

>=20
>>>> That aside: I wonder whether a better API would be something that
>>>> allows you to create a new readonly file descriptor, instead of
>>>> fiddling with the writability of an existing fd.
>>>=20
>>> That doesn't work, unfortunately. The ashmem API we're replacing with
>>> memfd requires file descriptor continuity. I also looked into opening
>>> a new FD and dup2(2)ing atop the old one, but this approach doesn't
>>> work in the case that the old FD has already leaked to some other
>>> context (e.g., another dup, SCM_RIGHTS). See
>>> https://developer.android.com/ndk/reference/group/memory. We can't
>>> break ASharedMemory_setProt.
>>=20
>>=20
>> Hmm.  If we fix the general reopen bug, a way to drop write access from a=
n existing struct file would do what Android needs, right?  I don=E2=80=99t k=
now if there are general VFS issues with that.
>=20
> I also proposed that. :-) Maybe it'd work best as a special case of
> the perennial revoke(2) that people keep proposing. You'd be able to
> selectively revoke all access or just write access.

Sounds good to me, modulo possible races, but that shouldn=E2=80=99t be too h=
ard to deal with.=
