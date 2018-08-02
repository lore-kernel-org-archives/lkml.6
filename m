Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B85F2152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O2/MRu6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B85F2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeHBSdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:33:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40680 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:33:40 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so4252692ita.5;
        Thu, 02 Aug 2018 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpeHvaMjD4HKvysga4ULtk7ZF/P3XSqXAA5LvABv2I8=;
        b=O2/MRu6+nfIhfZP25eg4e4Q95f5XUcm+MRguxhMMLZYKooE7ndJRMnNmjEE1BNxDtP
         5Gx5r0LlfnozLrTzHxgWR066gC1ILHMqoWVeiAlaqcIb5+Tr5SdQw6gqjKHGh7M1lSLi
         4NhpipNErINua7HRj9/cSt9lXsOk8cp3s1GHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpeHvaMjD4HKvysga4ULtk7ZF/P3XSqXAA5LvABv2I8=;
        b=MRxAoMorQgKpuLIEvBUVRuVGja6V0nmicYwuEJdjQcM9n6OIjtkBfnEJcNMJiVC1ez
         mivE1n+9SkOGCnnRG967v5zfwt1+1CnQT4Rz6YQk2WVnM5DyUY/o/4e01QfXciTzzRrc
         BHspXjecKFAtpe/Tl8mWCWUlCcFqkFm88HBZrQZY9n3hufWgjO7G3iIa9GoeIeiD2WIW
         UmUhlvixCy5HMFF6eTOZjx+WZa0xSSwv8bXQCJfZLWrZOkJeVb0JxKVVyKy8ZQ7og8jp
         7hrbtwuTJE5/0NiJfL3JbJrzo0ywqeRw2x8x5llZtpg7UWpvWOBDfOuW4YUhsjXcMuuV
         kGbQ==
X-Gm-Message-State: AOUpUlGheU2HU4Z/NMYYJfvOU51sBWk61sttORoQt4dHGCgolMcCUHKc
        nUpDI08pFYcuTc1z9l3tJ3hQk9QdfvAMs3y8/OQ=
X-Google-Smtp-Source: AAOMgpdyitJ9OAEUwpmJdRm0KMD0uioGW93C2DYPT3g3JkMKvWmQQMvpamGE3VJ/e48eX24VjEZOcOmCfWKLk1agDtI=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr272821jaa.10.1533228105296;
 Thu, 02 Aug 2018 09:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com> <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
In-Reply-To: <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Aug 2018 09:41:34 -0700
Message-ID: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     wgh@torlan.ru
Cc:     Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 8:16 AM WGH <wgh@torlan.ru> wrote:
>
> On 08/02/2018 04:31 PM, Ilya Dryomov wrote:
> >
> > From a quick look, --permission r sets DM_READONLY_FLAG, which makes dm
> > mark the disk read-only with set_disk_ro(dm_disk(md), 1) in do_resume().
> > A bit later it tries to write to the disk from write_header():
> >
> >   return chunk_io(ps, ps->header_area, 0, REQ_OP_WRITE, 0, 1);
> >
> > Thanks,
> >
> >                 Ilya
>
> After further investigation, this was fixed on lvm2 side (userspace) in
> https://sourceware.org/git/?p=lvm2.git;a=commit;h=a6fdb9d9d70f51c49ad11a87ab4243344e6701a3
> (snapshot: keep COW writable for read-only volumes).
>
> So I guess that's it. Time to poke my distribution package maintainers
> to bump the package version.

That is *not* how kernel development is supposed to work. If your
script used to work, it should continue to work.

Why did it use to work despite that read-only flag? And what was it
that actually broke this?

We remain bug-for-bug compatible with older kernel versions when
people depend on the bugs. Unless the old bugs are security issues,
and even then we try to make it _look_ like we work the same way.

Or was it a user-space lvm tool that broke in the first place, and the
kernel release update was a red herring?

                 Linus
