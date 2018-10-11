Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B9CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550092077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550092077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJKOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:51:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43922 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeJKOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:51:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so8729927qtq.10;
        Thu, 11 Oct 2018 00:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyzASNNKfWaC7Ld4nY/CqQkXsywxQM9v1ImPrqUTec4=;
        b=L6tEyJNnaGewKOskJhN+Ys+1xfjqzklagZ6CGyL/1hmfrEnCCOdLrXEE4YkR20ALk1
         dwQMcSkvsUOIY5361R2otQe50grmORZat0jjaPvVm0UHiNOFavoy4Y9SfhcGG1G2Mck4
         GDpjcCZoBYV9sbWRcU24r0PN+6igtnHu2qh2EX3WwxNEkJ5r7oIvSH7j6i0HhVlHx3l+
         sOwsBnKKAMWMdEMP8O2XowIRmPrzh4E4wdoLnZhEh7l/7E3KiCCYC4kLy1xTy/UgLS5n
         ZvLgQWZYBbpZPiuH3wROO1hE3ZMtZw5LGuvgMu8orPM8VT3dHh/i/iYrBJKktRbSFPqz
         CRlg==
X-Gm-Message-State: ABuFfogDyEdRVMWXwlffInBdFUGNEB64JCDD1iPunzOeb2zWs0AJG1QA
        17ZMLX6VKcB5IUsZYPTnEVZE3/T9I2RiW/QQxGw=
X-Google-Smtp-Source: ACcGV61UhOEO6uQwKmZCBK3gKoIVJjbV5hpNiArbioIZLzKZKXwW6tDK6DjlnzBq1wdPblD7sN7zSxG8gSr0I4WycaM=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr418356qtn.152.1539242700217;
 Thu, 11 Oct 2018 00:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org> <1539231895-4118-8-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539231895-4118-8-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:24:43 +0200
Message-ID: <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ia64: wire up system calls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 6:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> wire up perf_event_open, seccomp, pkey_mprotect, pkey_alloc,
> pkey_free, statx, io_pgetevents and rseq system calls
>
> This require an architecture specific implementation as it not
> present now.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/ia64/kernel/syscalls/syscall.tbl | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 6b64f60..1f42b60 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -335,3 +335,19 @@
>  323     common  copy_file_range                 sys_copy_file_range
>  324     common  preadv2                         sys_preadv2
>  325     common  pwritev2                        sys_pwritev2
> +# perf_event_open requires an architecture specific implementation
> +326    common  perf_event_open                 sys_perf_event_open
> +# seccomp requires an architecture specific implementation
> +327    common  seccomp                         sys_seccomp

I don't think that's correct for these two. perf_event_open() of
course requires 'perf' support that ia64 does not have, but
at least seccomp should just work.

> +# pkey_mprotect requires an architecture specific implementation
> +328    common  pkey_mprotect                   sys_pkey_mprotect
> +# pkey_alloc requires an architecture specific implementation
> +329    common  pkey_alloc                      sys_pkey_alloc
> +# pkey_free requires an architecture specific implementation
> +330    common  pkey_free                       sys_pkey_free

One comment for all pkey calls would be sufficient. More importantly
it requires hardware support that ia64 does not have AFAICT.

> +# statx requires an architecture specific implementation
> +331    common  statx                           sys_statx
> +# io_pgetevents requires an architecture specific implementation
> +332    common  io_pgetevents                   sys_io_pgetevents

It certainly does not require any support from the architecture for these.

> +# rseq requires an architecture specific implementation
> +333    common  rseq                            sys_rseq

Maybe leave rseq and pkey_* commented out so we reserve
the number but don't add it for real? Maybe the ia64 maintainers
have a preference.

As asm-generic maintainer, I'd like to have the various asm/unistd.h
headers be as similar as possible and at least reserve all the
numbers even if we don't need the calls on a given architecture.

       Arnd
