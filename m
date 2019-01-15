Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89219C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7H3gHUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfAORhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:37:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33769 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfAORhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:37:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so1577355wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z/2bbTbzxPpRc/4UtRoAqudsKLmh1F634okQES3cXg=;
        b=i7H3gHUcX5vO+PFS1Ydfkg911iGffGB5u+Z/OzplF4DjXJzGjxJh/lLxVa/TkgwIaL
         N6nuCe0BwaCmFVI2Z87GiBk24BVLv/FVF2V4BLuWC7XW/6K+N1ai2BMvylbGneD+V0Oz
         SS7/aUcN/ca0+ENf6jzRCRZxoGrzOi82qnca4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z/2bbTbzxPpRc/4UtRoAqudsKLmh1F634okQES3cXg=;
        b=iOkrGNyg1FyyV4JY02Alxxj3exBOnChY497ynkRZ0rXaSbLXBE7Vzm+Xo9b0QI+tjt
         RzecCe1kyttn0cZ00hoST3/2GwmUbi8Q7Mh37EraSB7q10EVuT2Yo4N914h/mYbh2V6p
         0VI8pMN0sMIEreY8CMo/FpiQyE7hkSy9rMfRmuTaubRDHjwOKWX35vbmnM8qwdJmmAhY
         /FuYLXNMRfzamc8BQGfSsdRy1dB0x3jwcAJr9qGP2gjTsmKVw+1c4n75UTDhnMxTsJCy
         jUwHdEqTS6w45zR8WAcEH1xiJgLwTJ09k1NYKuN+pIQl6NSYgX2vm+fnaxuWn2RByPjy
         P3NA==
X-Gm-Message-State: AJcUukce2vbnAjjRvGFBeyS8zgoKRtsyUTcF4+UyhsuKk0xUhaA+G0O0
        0iaA4/JSlrqUPszVXHJBqrnTbmZOF72k4fpotbuDZf4nB00=
X-Google-Smtp-Source: ALg8bN5xtIrr+nvt3YPWFXRxeWib5ciEgEGNl0WlnZfupuyH9RgxS9RvKYGFDk3Fz7QYrHUH1WQ0Ex/npTrjDK5u8Zg=
X-Received: by 2002:a1c:6657:: with SMTP id a84mr3985082wmc.23.1547573824109;
 Tue, 15 Jan 2019 09:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20190112203816.85534-1-joel@joelfernandes.org> <20190112203816.85534-2-joel@joelfernandes.org>
In-Reply-To: <20190112203816.85534-2-joel@joelfernandes.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 15 Jan 2019 09:36:52 -0800
Message-ID: <CALAqxLXFvktP+k8AWPEoT=-MM_vdu=1hzgzPYEzhSp8hXd-ADg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/memfd: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 12:38 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>
> Android uses ashmem for sharing memory regions.  We are looking forward to
> migrating all usecases of ashmem to memfd so that we can possibly remove
> the ashmem driver in the future from staging while also benefiting from
> using memfd and contributing to it.  Note staging drivers are also not ABI
> and generally can be removed at anytime.
>
> One of the main usecases Android has is the ability to create a region and
> mmap it as writeable, then add protection against making any "future"
> writes while keeping the existing already mmap'ed writeable-region active.
> This allows us to implement a usecase where receivers of the shared
> memory buffer can get a read-only view, while the sender continues to
> write to the buffer.  See CursorWindow documentation in Android for more
> details:
> https://developer.android.com/reference/android/database/CursorWindow
>
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active.
>
> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
> where we don't need to modify core VFS structures to get the same
> behavior of the seal. This solves several side-effects pointed by Andy.
> self-tests are provided in later patch to verify the expected semantics.
>
> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
>
> [Thanks a lot to Andy for suggestions to improve code]
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/hugetlbfs/inode.c       |  2 +-
>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 |  3 ++-
>  mm/shmem.c                 | 25 ++++++++++++++++++++++---
>  4 files changed, 26 insertions(+), 5 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>
