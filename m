Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B170C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C03205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C03205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeK3B2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38716 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbeK3B2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so2101969qtl.5;
        Thu, 29 Nov 2018 06:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp1c5m9Go758zqpd0U6yL4XdcMp/QelpMOB8347WFtA=;
        b=NpR1CWaOtsQLMg/NQb1y0fdwBPLpzVdQp5Yn0gUgDoUYvViKXmB/ERRSMyfmm1dLsw
         QtEFAWBZ6VDSzd9THtNmAJSuUvaPaOatI5qu0T6prIBBGBi5Nh/wO4FXkw1VT6ZU4FD7
         T5OKBGMaN11U/lGtO8Cb154bdwSzrLYr50r3035bCzDLAdnl1bU/u7hZfh6tcSQBbQhV
         rZIuEegk2ilA0IgO5dSjW7Qi9q6ILrpf+NCTcaZ5r9M8j9sQegvyN/O/fekevb8c3FQR
         VPvA2OMX0H5sjQG9INqaoMmK+h5BSox/Mbs5gNeagdqrheQLtXVGl8DstthsfpfwgxBn
         5FQA==
X-Gm-Message-State: AA+aEWauWSRpCmYTkdVjasxCD87SM08efqDs8ocUi2cwzfviwvuOecy8
        Nq60iVKucboXydhJidiCH9buyEw/wFzvE6AVCQE=
X-Google-Smtp-Source: AFSGD/XJaHcKePzx11S3n8QhdfLtER9xpVM+eDuxlxPNHoa0dhNrsDTwh051V+acJkGm5sjqJhai1WbJTiA0FwaPsLA=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr1517085qtr.319.1543501354279;
 Thu, 29 Nov 2018 06:22:34 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:22:16 +0100
Message-ID: <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mips: generate uapi header and system call table files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Nov 29, 2018 at 9:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> index 7a4becd..ed4bd03 100644
> --- a/arch/mips/include/uapi/asm/Kbuild
> +++ b/arch/mips/include/uapi/asm/Kbuild
> @@ -1,5 +1,11 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
>
> +generated-y += unistd_n32.h
> +generated-y += unistd_n64.h
> +generated-y += unistd_o32.h
> +generated-y += unistd_nr_n32.h
> +generated-y += unistd_nr_n64.h
> +generated-y += unistd_nr_o32.h
>  generic-y += bpf_perf_event.h
>  generic-y += ipcbuf.h

I'd argue that the unistd_nr_*.h headers should not be in the uapi directory
but instead be included only from the in-kernel header.


> diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> new file mode 100644
> index 0000000..402a085
> --- /dev/null
> +++ b/arch/mips/kernel/scall64-n64.S
> @@ -0,0 +1,117 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 2001 MIPS Technologies, Inc.
> + */
> +#include <linux/errno.h>
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/irqflags.h>

It looks like you change and rename this file at the same time.
Generally speaking, I would not do that in one patch. Either
leave the slightly inconsistent name unchanged, or rename
it in a separate patch.

         Arnd
