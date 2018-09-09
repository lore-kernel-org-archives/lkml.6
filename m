Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B809DC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A6020857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnUoOVhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeIIIpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 04:45:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38787 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIIpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 04:45:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so34241733oix.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrsZ0rGUyFzOkk97Ad9wAmZlJk6xgDsHpD/zd2pfqMc=;
        b=XnUoOVhn3bOAK2E09JG1YJ882Ug4n4B/MeXJsXoRz6JsdT4EToOvLqpR5eKuCqwsjL
         F0njaR/xPg6B78So9xpZ3/eHdezbfcPnHljhaklZwln2QUVCcmFHDtZOcRSxx2cunxSh
         EmIK44lUiVTLZyngmirkNZU0mwM8SlP7swLWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrsZ0rGUyFzOkk97Ad9wAmZlJk6xgDsHpD/zd2pfqMc=;
        b=h8Vpdhc1YUxzKRuyhADqoyVkvkxz3KmT+ZJEM04Ua49HHcB7n/Hfjo/GkCg9pU8f2M
         TRnmEgc1L2zB+weJNHmuarUz4KzaR9qW0wWkI1jixHjOFAQeN5+6hG8LTfMhwNQUnOXe
         oaZ/wFSBiHXX+FF8xtANmooD9PGKrQ7fAvgFQvlMjfF5yJk/58Bo7vLTiX3/6R2ASFBQ
         F9nyEJ7f7VA9mS1nFUDd7bAay/48ECRT7qayz7bK6QFavhn6XSlzl8xHwrtwnJ4ElRzB
         xz/WiXtvOnlRK6g1tLFAUd1hcl2ImM0XfWQt0Pp9x+SYam3ABSFJ6xH4ZqYMpyzlEOEF
         Z3WA==
X-Gm-Message-State: APzg51BZQLVsEwwSI83g082IJau9bVg5ykqtAn2lqifXo+4vH4/vYgCv
        SLbsKKYy54wKsUtX7RL0R9nSPyE36t6ejw==
X-Google-Smtp-Source: ANB0VdaVFk0+tiB+BLJ9atliWEsb2AMtJljCmVi2FU1NtFMx2MzPmrb4k43YVBAlAhEjZrVmvNyzdg==
X-Received: by 2002:aca:38d5:: with SMTP id f204-v6mr16176340oia.195.1536465433549;
        Sat, 08 Sep 2018 20:57:13 -0700 (PDT)
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id x5-v6sm12243125oix.3.2018.09.08.20.57.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 20:57:12 -0700 (PDT)
Received: by mail-oi0-f41.google.com with SMTP id b15-v6so34196344oib.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 20:57:11 -0700 (PDT)
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr14956990oie.68.1536465431552;
 Sat, 08 Sep 2018 20:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180907210904.607934824@linuxfoundation.org> <20180907210908.241189276@linuxfoundation.org>
In-Reply-To: <20180907210908.241189276@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Sun, 9 Sep 2018 00:56:45 -0300
X-Gmail-Original-Message-ID: <CABdQkv8Oxmy7ZcwAhKJ-tYJyqJCWba9+vtGCSgMS2aGymEzhsQ@mail.gmail.com>
Message-ID: <CABdQkv8Oxmy7ZcwAhKJ-tYJyqJCWba9+vtGCSgMS2aGymEzhsQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 34/47] userns: move user access out of the mutex
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, christian@brauner.io, serge@hallyn.com,
        ebiederm@xmission.com, dan.rue@linaro.org,
        naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Fri, Sep 7, 2018 at 6:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.4-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Jann Horn <jannh@google.com>
>
> commit 5820f140edef111a9ea2ef414ab2428b8cb805b1 upstream.
>
> The old code would hold the userns_state_mutex indefinitely if
> memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> moving the memdup_user_nul in front of the mutex_lock().
>
> Note: This changes the error precedence of invalid buf/count/*ppos vs
> map already written / capabilities missing.
>
> Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Christian Brauner <christian@brauner.io>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  kernel/user_namespace.c |   22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -604,7 +604,16 @@ static ssize_t map_write(struct file *fi
>         struct uid_gid_extent *extent = NULL;
>         unsigned long page = 0;
>         char *kbuf, *pos, *next_line;
> -       ssize_t ret = -EINVAL;
> +       ssize_t ret;
> +
> +       /* Only allow < page size writes at the beginning of the file */
> +       if ((*ppos != 0) || (count >= PAGE_SIZE))
> +               return -EINVAL;
> +
> +       /* Slurp in the user data */
> +       if (copy_from_user(kbuf, buf, count))
> +               return -EFAULT;
> +       kbuf[count] = '\0';

Naresh will soon report issues found by LKFT on user_ns for 4.4 kernel
for this review round.

selftests: mount_run_tests.sh [FAIL]
write to /proc/self/uid_map failed: Bad address

LTP: user_namespace2 1 TBROK : safe_macros.c:452: userns02.c:95:
write(6,0x7ffc133113d0,18446744073709551615) failed: errno=EFAULT(14):
Bad address

I believe the EFAULT was caused because when changing code from
"memdup_user_nul" to "copy_from_user", for the older kernels, you
missed allocating the slab object for "kbuf", like memdup_user_nul()
does.

Note: This likely applies to 3.18 as well.

We are finishing functional tests without this patch, but we wanted to
make you aware right away.

Best Regards,
Rafael
