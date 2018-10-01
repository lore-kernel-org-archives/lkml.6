Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CF420666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ru8JS84H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CF420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJBDEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:04:36 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35219 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJBDEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:04:36 -0400
Received: by mail-yw1-f67.google.com with SMTP id y76-v6so6092977ywd.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hjY4lzU/sfNIL0UgF406c5hYxrb3YbgauVtL0B1K3fA=;
        b=Ru8JS84HsxnScxcrZ9Vj6axAD6eiyCGQoJ4CKtP2ix9DYoJjVW5g1nVtWlTqqGh5V3
         s6bmg++sG7WZY+mpLivWUK9D1mVTzaPsGQ+imgM2G7VQZ+dSfvG1Vzs1pwM4EG1OcoCj
         JYq34mYgmZyql9PyoKCtHy5apFpo/vuRV7ejc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hjY4lzU/sfNIL0UgF406c5hYxrb3YbgauVtL0B1K3fA=;
        b=AxUrpIHHU/0D7lDUeL7Va80w0RWoNOzWKLWM8JDV/nDIYVckwUYIwEQnkHlRKxXVCT
         oKs2I71AfXRJOnuCkStZ8772Oschsj0xMYSYrYT8ulaI9TdGI/BNs/gVhwurh07vqsk1
         e1cLckPPGy3whotNIeZPzm+WV6zHxE/QmxjyiwOxMv3wx6W/5mz2kJFQbSNJ8/LR1Kcx
         LB3sKftfMyylUePKMe5+dz3rqd9d3OFwP6iPccIerP+c7UXUGDSg0zL9VsPKjMYC/iZ2
         z8OJ1CsChF4PO8y9DGU8kKVSCDQrsHKrenlTZIn7bEtHkjyeDKLJzBQ181Uk+8R5/5jC
         dRkw==
X-Gm-Message-State: ABuFfohJk30XUpeESlz6gCWydjHDlx8UVtDYMsnum5GXbTboEpmwFQmW
        q7WnJl2MvWx+R7MD7NJbF9NTPKS3wu0=
X-Google-Smtp-Source: ACcGV61KWK4zXUSCPfXcmhGoIslBNtjlQZilhA0D6LSHvhEpDmJfAYPnetz/R8Uf+X3ZsVGMeUzBMA==
X-Received: by 2002:a0d:e547:: with SMTP id o68-v6mr6686099ywe.403.1538425504773;
        Mon, 01 Oct 2018 13:25:04 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id l30-v6sm13237915ywa.104.2018.10.01.13.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:25:03 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id y14-v6so6084077ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:25:03 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr7015532ywi.288.1538425502937;
 Mon, 01 Oct 2018 13:25:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 13:25:02 -0700 (PDT)
In-Reply-To: <20180927214917.10486-1-zsm@chromium.org>
References: <20180927214917.10486-1-zsm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 13:25:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+MftDkJXP-ufpCwKV=yXWXavwpfnauGXJqbZjeXrkY4A@mail.gmail.com>
Message-ID: <CAGXu5j+MftDkJXP-ufpCwKV=yXWXavwpfnauGXJqbZjeXrkY4A@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Fix uninitialized value in aa_split_fqname
To:     John Johansen <john.johansen@canonical.com>,
        Zubin Mithra <zsm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 2:49 PM, Zubin Mithra <zsm@chromium.org> wrote:
> Syzkaller reported a OOB-read with the stacktrace below. This occurs
> inside __aa_lookupn_ns as `n` is not initialized. `n` is obtained from
> aa_splitn_fqname. In cases where `name` is invalid, aa_splitn_fqname
> returns without initializing `ns_name` and `ns_len`.
>
> Fix this by always initializing `ns_name` and `ns_len`.
>
>         __dump_stack lib/dump_stack.c:77 [inline]
>         dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>         print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>         kasan_report_error mm/kasan/report.c:354 [inline]
>         kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>         __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>         memcmp+0xe3/0x160 lib/string.c:861
>         strnstr+0x4b/0x70 lib/string.c:934
>         __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
>         aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
>         aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
>         fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
>         aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
>         aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
>         aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
>         apparmor_setprocattr+0xaa4/0x1150 security/apparmor/lsm.c:658
>         security_setprocattr+0x66/0xc0 security/security.c:1298
>         proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
>         __vfs_write+0x119/0x9f0 fs/read_write.c:485
>         vfs_write+0x1fc/0x560 fs/read_write.c:549
>         ksys_write+0x101/0x260 fs/read_write.c:598
>         __do_sys_write fs/read_write.c:610 [inline]
>         __se_sys_write fs/read_write.c:607 [inline]
>         __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Fixes: 3b0aaf5866bf ("apparmor: add lib fn to find the "split" for fqnames")
> Reported-by: syzbot+61e4b490d9d2da591b50@syzkaller.appspotmail.com
> Signed-off-by: Zubin Mithra <zsm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  security/apparmor/lib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 974affe50531..76491e7f4177 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -90,10 +90,12 @@ const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
>         const char *end = fqname + n;
>         const char *name = skipn_spaces(fqname, n);
>
> -       if (!name)
> -               return NULL;
>         *ns_name = NULL;
>         *ns_len = 0;
> +
> +       if (!name)
> +               return NULL;
> +
>         if (name[0] == ':') {
>                 char *split = strnchr(&name[1], end - &name[1], ':');
>                 *ns_name = skipn_spaces(&name[1], end - &name[1]);
> --
> 2.19.0.605.g01d371f741-goog
>



-- 
Kees Cook
Pixel Security
