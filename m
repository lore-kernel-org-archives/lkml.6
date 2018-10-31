Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5A820823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHRU33o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5A820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeKABV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:21:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43761 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeKABV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:21:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so15068116otl.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kX6mHvEQrRN2wbkOJHgYmxBAU2VQeMHQY12JvsJhlaI=;
        b=kHRU33o7xH0yIvcZ80JRZmrCc3MMqqrNsg/kDX0dpugyWnKknqkZKwZgiBzVVYw6KX
         dI8lBV9pXRznMuNexPBmZX9tumnndRJbZQ1xS2g8qTKtAMIKRJS0Mr1fAnvVJ/LXAj4Z
         rCMkabKNmSc6EQZH1vZj/sQm4CrF/IKKGfdsleb93aJJYztvv1eTpg7dw+vs6wyYcEfs
         AF17XF8h3wBKt/lK1HGUYSO4BMx2VM954u0qdYiN1S72y5S1Mcdep2cUHyF/F42FECr2
         79wnl9Anktvyi70rUClNrbR2djhnDS6kJH3ZYlj1U1IEwYTNDfpo57in15MGF6xD0hyb
         PsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kX6mHvEQrRN2wbkOJHgYmxBAU2VQeMHQY12JvsJhlaI=;
        b=OHyAU8LkZ0KYHMG/oEH+WGMe5egdwg2XA9WklY/ReD3p+uOhixCW4q0FvKI9Hci+A/
         KbhaHnEPZE57YvU7rRDJSs8IFGJNX7q/J3FDCNDDOBNOEN8xrJNEl1m64CSLyCp4jDjk
         amk6hSLD/N0eVjBnlO2hZcUHL8inJkGAElRuy3wcgBe3W8ZhtEC9zl6jA0r8Va9aaLqY
         ZqHhuU9jJA8ZEU4uuTjsz+JTApqZP1JyiNAKhvelpTVSQmtDmt+sQ6at39OumQj7yjUc
         YHqSkq8zOlLHV7DfHiYfEUr5miVqZIPo+EippxNtFbBz04fyf7x7++HrxMx+0cpIuQGN
         53Bw==
X-Gm-Message-State: AGRZ1gJ3XQ+g0xw4O+Gx9nh3aJ0BkaWtz9ubz1OmwRCftXgcs+QS/jm0
        iKB7b3sv7ExySxxrIEynFmleo2KNiqUcDYc2veTkrQ==
X-Google-Smtp-Source: AJdET5cdSgwU11YUOircrFHRwRd9nMeTQKeqcDVh+hhTcxf06kZHYDk73lu29OOcIEqGmO3blUdIeT0qUvnFzJOc0/A=
X-Received: by 2002:a9d:17e8:: with SMTP id j95mr2140405otj.292.1541002995869;
 Wed, 31 Oct 2018 09:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com>
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 Oct 2018 17:22:49 +0100
Message-ID: <CAG48ez01OWYVqEo+Qf65scG7a-48tDM4Gh3BOUKY+-b9g+9itw@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     dancol@google.com
Cc:     kernel list <linux-kernel@vger.kernel.org>, timmurray@google.com,
        Joel Fernandes <joelaf@google.com>, surenb@google.com,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-api, Andy Lutomirski, Eric Biederman

On Wed, Oct 31, 2018 at 3:12 AM Daniel Colascione <dancol@google.com> wrote:
> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.

This is a kernel API change, you should CC the linux-api list.

I think that getting the semantics of this right might be easier if
you used an ioctl handler instead of a write handler.

> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.
>
> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".
>
>     #!/bin/bash
>     set -euo pipefail
>     pat=$1
>     for proc_status in /proc/*/status; do (
>         cd $(dirname $proc_status)
>         readarray proc_argv -d'' < cmdline
>         if ((${#proc_argv[@]} > 0)) &&
>                [[ ${proc_argv[0]} = *$pat* ]];
>         then
>             echo 15 > kill
>         fi
>     ) || true; done
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  fs/proc/base.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..923d62b21e67 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -205,6 +205,44 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
>         return result;
>  }
>
> +static ssize_t proc_pid_kill_write(struct file *file,
> +                                  const char __user *buf,
> +                                  size_t count, loff_t *ppos)
> +{
> +       ssize_t res;
> +       int sig;
> +       char buffer[4];
> +
> +       res = -EINVAL;
> +       if (*ppos != 0)
> +               goto out;
> +
> +       res = -EINVAL;
> +       if (count > sizeof(buffer) - 1)
> +               goto out;
> +
> +       res = -EFAULT;
> +       if (copy_from_user(buffer, buf, count))
> +               goto out;
> +
> +       buffer[count] = '\0';
> +       res = kstrtoint(strstrip(buffer), 10, &sig);
> +       if (res)
> +               goto out;
> +
> +       res = kill_pid(proc_pid(file_inode(file)), sig, 0);
> +       if (res)
> +               goto out;
> +       res = count;
> +out:
> +       return res;
> +
> +}
