Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92445C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C1720868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKGvhL4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C1720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLFQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:52:08 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34632 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:52:07 -0500
Received: by mail-yb1-f196.google.com with SMTP id a67-v6so955634ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hudTdSDv5qNL7QepcQ/fJ5YR3De7dRNuAhTQWAm3iY=;
        b=IKGvhL4WWfBQNY7mgvdg4cBcNoW47XDZDieadaurkmZSmxjqgmg1koAfM5lzaj7Nv+
         seiBkgt7pRlEl1soYKPZPXglbPLJWkZnhP6Olngt4r/t+n39NyVnwBX8AIHuyRgdniN/
         re8sjXhyLKf7zpTYNLeKHmnVw+ivnBnb87Zxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hudTdSDv5qNL7QepcQ/fJ5YR3De7dRNuAhTQWAm3iY=;
        b=I3cRdf9Hgp8U4VwdaQ0XyhmqNkBIRZgmRrdXZeNUH9fjox/93UWvJrif356i+z0vV5
         9O3nzLABMpGCHgk7vC5bAPQxQPVk5NC0Xb+pnNgxTJ+0ZYARh56oHAb3bEWPOzv4+PSX
         qpN9f03llN0vJ4wKgxPzNehE17y2N6f00C9cPC4DZ7xw4z24wJ4QUxCi28s53+1BNpxc
         RrgiJJ0cP9j0Rup4G/KkBgvkFEeodyxYeKSA2fB/2CWJKjBPjdPEk7S4vW//Hg8RS+dh
         sPKvt0q44UajoapDGX3iwEe91UBN8cpoNKBBL9e9SUcez3G9C6ZB9DEBUfTEhCdyXVU0
         MFlw==
X-Gm-Message-State: AA+aEWY3MM3+Yx3c3yr6mwByeSUi0Dfq0cigd5QayKF+5mT31DhcCSAU
        K1IVDL+YNNzGZGJseT2ly+//3wQ/Jb0=
X-Google-Smtp-Source: AFSGD/VZ99xWN+t0fMJxGCpWZM3JJbl5bYz/uitbKorWpWylghDt6CBGo905NdUQYGyo3TwK6+17+g==
X-Received: by 2002:a81:58c4:: with SMTP id m187mr28942878ywb.300.1544115126429;
        Thu, 06 Dec 2018 08:52:06 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id b144sm359300ywa.33.2018.12.06.08.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:52:05 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id j145so911005ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:52:04 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr28748348ybi.209.1544115124380;
 Thu, 06 Dec 2018 08:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com> <20181206150156.28210-2-david.abdurachmanov@gmail.com>
In-Reply-To: <20181206150156.28210-2-david.abdurachmanov@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 08:51:53 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKfnE_RJL7aA5x-qqYdA9zoTTtKwahg0r5fyW5GqFLgdA@mail.gmail.com>
Message-ID: <CAGXu5jKfnE_RJL7aA5x-qqYdA9zoTTtKwahg0r5fyW5GqFLgdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, green.hu@gmail.com,
        deanbo422@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).

Can you add support to tools/testing/selftests/seccomp/seccomp_bpf.c
as well? That selftest finds a lot of weird corner-cases...

> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 1c9cc8389928..1fd6e4130cab 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -81,6 +81,7 @@ struct thread_info {
>  #define TIF_MEMDIE             5       /* is terminating due to OOM killer */
>  #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
>  #define TIF_SYSCALL_AUDIT      7       /* syscall auditing */
> +#define TIF_SECCOMP                    8       /* syscall secure computing */

Nit: extra tab needs to be removed.

-- 
Kees Cook
