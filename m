Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0F421104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0F421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeK3BVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46186 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbeK3BVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so2045382qtm.13;
        Thu, 29 Nov 2018 06:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwMsN0MymMapX+iJ/bF8gBhwCFKK8oi/Umouxn9UCY8=;
        b=rfNjnxdPndcIHCAZ73zOvPq6Rbrj3hSFLmrcTK8Akh/2vSMg7MjNgOeKRiHHZBOym0
         NDu7wQR7/9kulPJK9ypYePU/MtcQcxqKJx8791+VsPWN2kNRVe+HzcSQ/AAwO8JyHv+6
         8UybqmkyjLQi2OGp2j5OfZ/0G2Zo4585NTXtk5W1IJn6CDt9xBwX0KNl8BvSDvJuqlUb
         /RV4A7IMEPhZdsMqcSHPdplfW8vqhfykH8MoaG+Dwn58XhH1SvMSBCtLUqT0eoD1x6cm
         iy0tzpd6e9WFSNFGaVvZ57C9ctFDxmfAuPCG6l4YQELfPHvfK7MDdKt3p2rpHgIKQhJm
         3gzg==
X-Gm-Message-State: AA+aEWZMzHdSSIyvin+w3fOpsxe7R3eioUzSUKnSFuXGxwUADruO3AMF
        UpZ/QKLDD8K5ByOnHJ8/TPlypdWWXNaTHBkUAn0=
X-Google-Smtp-Source: AFSGD/VUvNzby+S4wIVg0cInp60n3619SBSM9Xrq04K+HaQrdFlLpq0bws5ClRJz7ihaSn5wJoLVGZ7ETa1+jOR2AOc=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr1581648qta.152.1543500975228;
 Thu, 29 Nov 2018 06:16:15 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:15:58 +0100
Message-ID: <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mips: add system call table generation support
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

On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.
>
> The system call table generation script is added in
> kernel/syscalls directory which contain the scripts to
> generate both uapi header file and system call table
> files. The syscall.tbl will be input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry
> point. Add a new system call in this architecture will
> be possible by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi
> header unistd_64/n32/o32.h and syscall_table_32_o32/-
> 64_64/64-n32/64-o32.h files respectively. Both .sh files
> will parse the content syscall.tbl to generate the header
> and table files. unistd_64/n32/o32.h will be included by
> uapi/asm/unistd.h and syscall_table_32_o32/64_64/64-n32-
> /64-o32.h is included by kernel/syscall_table32_o32/64-
> _64/64-n32/64-o32.S - the real system call table.
>
> ARM, s390 and x86 architecuture does have similar support.
> I leverage their implementation to come up with a generic
> solution.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Ah, I see you added the syscallnr.sh script from ARM.  I guess
that is one way to handle it, and the implementation seems
fine. It would be good to mention it in the changelog text above
though.

      Arnd
