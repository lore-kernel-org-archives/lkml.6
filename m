Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FBC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA3120832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGzJJbKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJXXJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:09:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46590 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeJXXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:09:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so2209270ybk.13;
        Wed, 24 Oct 2018 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cwRjKzQG2ZoEfLmqMundxMJxuVwlDB8jke5Q5JJhsNU=;
        b=UGzJJbKd8F3qC8ufxlmGH6HrUQtrJaFt3x9z0GYzQz4HC+E4a0otfj+qAIVqMVIPBT
         caEC2x4xQY4EBMPSnxK9X+bUC2qabNhQguRZAa7vvj0liGEInjtyJYLzs6m1XO4EfRhP
         IcnD2fDgejAJ5lbL/wS8qy5lK3Guj1jjLc5xKdy5ajg6GrhNcUL0P9IUcvKZQ3418JFs
         Qg9NwNoAN9ZeVWchceNX9JmuLPvef/zrwpk6Kme4wigNyZF3/iaotbxuyaVus/YIj0Bw
         TgL+FlsXDwlJSBHPaQjjIf4Z9MxVaQDejDD1iAJjCI/mLTeDRVp/SoIrjnEUXxNG19B1
         RhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cwRjKzQG2ZoEfLmqMundxMJxuVwlDB8jke5Q5JJhsNU=;
        b=czFeok8suY3pIXvkXs9VuLGrqTehaFZtCJv7pUNlR6xdeH/xWYE6b2STgrixegmUI7
         Kd5bHpw8Luq0gXELUeJ5aGMpLF4uoORltoJIiizmZbvuEgW7dRBniyg+kfZ8u9aE4IVK
         llp9m4hPyRtypVWYH4vapkROxde8ES4OLsXBcfmAYRT4oIIAx7m3rOXfrmVs8XALTRP9
         Zt59waxFIEVu3FHNdX4hI1cos85sGjOVDV4qzvshYr8qoSxvaQxg3lgI155EiVWNE7eS
         Vk4fhuQXgQlBueyTIeaHj6mCMMF8abdj7KZALaZAypwUWtUmQTDaFPhqe68eqVgmHVCf
         3gFQ==
X-Gm-Message-State: AGRZ1gLHv7FPNEHfkxSzUI/Ki1sSOkWMlhl4jnYT415LZXXCQ+27uIPH
        rLc9UTZ4lIkuD8RaViCJipeiIRyQM6fInYa6uoJlMVWz
X-Google-Smtp-Source: AJdET5cmNHRiFn0lFPDUKjICOj/jaftpeYoYXtAqgaKtSBfWUJGfzOuTzD3T7SvWCmekafrCNjuTpA5QAoAtJ4HahS4=
X-Received: by 2002:a25:5555:: with SMTP id j82-v6mr2529477ybb.337.1540392086894;
 Wed, 24 Oct 2018 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201953.GA15687@pathfinder> <20181024130206.GC11606@thunk.org>
In-Reply-To: <20181024130206.GC11606@thunk.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 17:41:15 +0300
Message-ID: <CAOQ4uxhGGZv52Ch2NjxOFt35KsFpja=jCk-x8jBNZcxRe9OoYA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
To:     Theodore Tso <tytso@mit.edu>,
        Phillip Potter <phil@philpotter.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 4:02 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 23, 2018 at 09:19:53PM +0100, Phillip Potter wrote:
> > diff --git a/include/linux/file_type.h b/include/linux/file_type.h
>
> Shouldn't this be in include/uapi/linux/fs_types.h?
>

IDGI. Why do we want this file in uapi?
The DT_ constants are already defined by glibc dirent.h
and the FT_ constants and macros we don't want to expose
to uapi at all. Right?

Maybe all we need is a comment above DT_ constants
that those are defined by POSIX and in glibc dirent.h?

> One of things which must be made crystal clear is these definitions
> MUST NOT ever change.  It would break the Userspace ABI, and would
> break file systems on-disk format.
>
> It might also be useful to be clear *why* we are making this change in
> the first place.  Code refactorization is good from a code maintenance
> perspective (either to fix bugs, although this code is pretty
> trivial),

Very trivial code that has had an out of bounds access bug for two
decades and bug was duplicated to 7 filesystems. IMO, fixing the bug in
one place instead of 7 is a good enough reason for re-factoring.

Thanks,
Amir.
