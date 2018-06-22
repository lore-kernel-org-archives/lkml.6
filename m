Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0474C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD0423EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD0423EC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeFVIMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:12:16 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40959 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeFVIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:12:10 -0400
Received: by mail-ua0-f195.google.com with SMTP id l11-v6so3765384uak.7;
        Fri, 22 Jun 2018 01:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFvWEvBE+tER3NesNR5rnNKEpD8RVlHJ9UN8uppk4Pw=;
        b=lH89e9jZJ8lLa6I0LJS70kMFUhJmymeWN8Vs7o236biBLmd4PEa1RooXC5FeFhn/+q
         33CbT1GfuDbjUJrOejNYDD3yPVymt7AyWDz8KbboIXNtU8fF7ZFWNODaYaZhXP85bb9C
         IS2zhpNF4aNBqU29dfSCJkI3aR0l9Um1x5khi0RY3oqb4G+dILjSnkv1o5WTkd9IHn7a
         ix0yiqr7p9r26OOAEXwz8/IgXUv+XojrQ+OCNUH9nEBeM/HwOSNfLw9B4L9whdrsH0vx
         CIiGWS80lvbx5JF12GGWnY2Qnwf/gkEWCFuvfbgblvvp4TFtOX8RAY+aSAJV3lmyiD3T
         GfoQ==
X-Gm-Message-State: APt69E3GMu/5gz04joAMEIkILnnpp4yEcnrFbxszH8IqayMUd9DOpp9k
        BGZsnkxnOKfErNRgxJZSIridmQkMAgYx/3kzGAc=
X-Google-Smtp-Source: ADUXVKLXsF4H1J8j777N4NQqFQU9Z8FzUWj/b57ALmtinnRV5Q0T7z2kNaUqTsZTDVxCqqMuQbfq+yu6CiAz8aNrtrA=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr396210uae.72.1529655129263;
 Fri, 22 Jun 2018 01:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180622075421.16001-1-geert@linux-m68k.org>
In-Reply-To: <20180622075421.16001-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 10:11:58 +0200
Message-ID: <CAMuHMdWhFyiAhA=bdjxSSmopJ=yJMXqMmOAD8hWUHWpiz0t4kA@mail.gmail.com>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC alpha, mips

On Fri, Jun 22, 2018 at 9:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> time period.
>
> However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> zero for small non-zero time periods.  This may break code that relies
> on receiving back a non-zero value.
>
> jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> not support values of HZ larger than 12287, thus rejecting any
> problematic huge values of HZ.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Add examples of affected systems,
>   - Use DIV_ROUND_UP().
> ---
>  kernel/time/time.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 6fa99213fc720e4b..2b41e8e2d31db26f 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -28,6 +28,7 @@
>   */
>
>  #include <linux/export.h>
> +#include <linux/kernel.h>
>  #include <linux/timex.h>
>  #include <linux/capability.h>
>  #include <linux/timekeeper_internal.h>
> @@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
>         return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
>  #else
>  # if BITS_PER_LONG == 32
> -       return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
> +       return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
> +              HZ_TO_MSEC_SHR32;
>  # else
> -       return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
> +       return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
>  # endif
>  #endif
>  }
> --
> 2.17.1
