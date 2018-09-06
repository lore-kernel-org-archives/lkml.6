Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB71420652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsjMIAIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB71420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIFUv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:51:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41969 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeIFUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:51:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so21573152oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciCVaYPRc2WngadWfkFmnVvwn24qXRIYuOCGVqQLGo0=;
        b=EsjMIAIFbmbKK3sNicie/oicXb0JlTnHQK+Ne9OEoDloVdBzSNLyAqRcoGgHRCO1MM
         x9UVWjDpmD2AWCBuaW8hyuzPS35X5+94gArJPgc6O7rbC1OSNDDPecHltrLViV4bdA6l
         04l99vQQ0q2ui2KFCd5vZ1QC4781xX1RSw0EZwz0aveJnifgzEpVwPei/Vz4gOd9VItl
         esnVZA3y6o/u2nfVYza7wC6uLonaGsBxXCx4hsbCjAzFqWapXMLZaMNn1kgfHNC+ooo7
         6QGT4huLj9KeuNdlzpyBsppAyMlcPrk3LT+gKb8e+gJ2okRyOEeHUHI8opy0DlUUic3+
         h1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciCVaYPRc2WngadWfkFmnVvwn24qXRIYuOCGVqQLGo0=;
        b=Xbq+BueaJHm6y5VTLQ/4OLEwX6pyAGrayyM3Fi8MAzqfYjT574EqMbalseXIfoBFQs
         pfBeM6jqzHYAvb+z55o3kkdsKcQfp8nxFauxnUb2SjqYg8PlS/y5na3hEuohTzvcBqu5
         /PZ4abaRvmc/hUx4nau+FbnSrV3dJhYpwYuZkngzCQRpc53E6wh6Np1yO4E5Okhzs7Jx
         f2/dECx54PwoHQ4cSc9pa6TVAxQlWppBOLF7rXPZt8fGsDIm0vKR20kGDBmRtVFO/XuY
         NIOyrlutcOsfb+DrT0JNDasrSmR7Cd+G2NILCYaC5XwtCiy4pH8Wq4N4J0V0SrPaOpvs
         JpYw==
X-Gm-Message-State: APzg51BWg7RSYIOXL5Ho0N8QtMJzwV8G8/6XwEw2A/rRRpg3SGHuy+QX
        IwLi/JxrX2td4XUZwGJoPLR18uRtn4cNJ+9AhpwmnZSM
X-Google-Smtp-Source: ANB0VdbqQ0bA1qFOCsDZuV/2dgGcZnT8H6U4KwYfEErNx4rI3WZG2hl8L6I9nsgzUUK/6xWaiLJ0kI1kJEpq3B7vt+g=
X-Received: by 2002:aca:b40a:: with SMTP id d10-v6mr3803968oif.190.1536250545053;
 Thu, 06 Sep 2018 09:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
In-Reply-To: <20180906152859.7810-5-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Sep 2018 18:15:18 +0200
Message-ID: <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> The idea here is that the userspace handler should be able to pass an fd
> back to the trapped task, for example so it can be returned from socket().
[...]
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index d1498885c1c7..1c0aab306426 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -235,6 +235,9 @@ The interface for a seccomp notification fd consists of two structures:
>          __u64 id;
>          __s32 error;
>          __s64 val;
> +        __u8 return_fd;
> +        __u32 fd;
> +        __u32 fd_flags;

Normally,  syscalls that take an optional file descriptor accept a
signed 32-bit number, with -1 standing for "no file descriptor". Is
there a reason why this uses a separate variable to signal whether an
fd was provided?

Apart from that, this patch looks good to me.
