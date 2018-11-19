Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F7C2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F7C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbeKTEBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:01:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34711 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbeKTDPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so49728973qkg.1;
        Mon, 19 Nov 2018 08:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5SjZ2tyDSOvAr2TOoAahu6zukA4Tlmwd7HV3ERJZK0=;
        b=NCu1OqQb5tDCEv81hInSEYhsAWbSvyeQ3xz2agKSut88j98QwG74+UyTkmf3LRKe8i
         TUMkoJpbGN3GPlfusdWelUHO1bZmtgplIwseu1xyGNLFUZdN2BZs3wqsh/gmzk9KdHnp
         BdIOLCe6S2eCrLaHLYBLEoWgHMpsdVG/iiwuuyhx6FGbrr5khrpXCQy8yoVaox9D0tDE
         4NkR/6zkGgA7xyhjuj+bedmSpz17N6POXvAJDfD+A+YlgyJvFwyOYMrqV+ggaeP4PtGa
         UFXxaPVaBh3CGKdT6b/tflSsR3fCotXUveqXXyM1VqrQoIYE/Di+PJqlcNN3J1WsELW0
         XZLQ==
X-Gm-Message-State: AGRZ1gLFfTglMv7dNzvl90NaP2EgpIqpSufVxno3nfCLi74+jxkCCYPs
        hhtGZ6DkBOMRdOa7niEutIZaYUtPIhCbUcif+Ak=
X-Google-Smtp-Source: AJdET5fgsj/hG5MpQYCDCchEECDxrNweB0VLzGleFvH849d+JGpcx8/tHR6Zam2BpRQGIGD3P1zH4YacF5gnfP+W7qk=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr21842914qvm.149.1542646266888;
 Mon, 19 Nov 2018 08:51:06 -0800 (PST)
MIME-Version: 1.0
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org> <1542169930-24118-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542169930-24118-2-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:50:50 +0100
Message-ID: <CAK8P3a3fFznLDZTs0eLa_dJCKdENC96w1MoC1pNM6gYwcb=Cow@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sh: add __NR_syscalls along with NR_syscalls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
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

On Wed, Nov 14, 2018 at 5:32 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> NR_syscalls macro holds the number of system call exist
> in sh architecture. We have to change the value of NR-
> _syscalls, if we add or delete a system call.
>
> One of the patch in this patch series has a script which
> will generate a uapi header based on syscall.tbl file.
> The syscall.tbl file contains the total number of system
> calls information. So we have two option to update NR_sy-
> scalls value.
>
> 1. Update NR_syscalls in asm/unistd.h manually by count-
>    ing the no.of system calls. No need to update NR_sys-
>    calls until we either add a new system call or delete
>    existing system call.
>
> 2. We can keep this feature it above mentioned script,
>    that will count the number of syscalls and keep it in
>    a generated file. In this case we don't need to expli-
>    citly update NR_syscalls in asm/unistd.h file.
>
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd_32/64.h
> along with NR_syscalls which is moved to asm/unistd.h.
> The macro __NR_syscalls also added for making the name
> convention same across all architecture. While __NR_sys-
> calls isn't strictly part of the uapi, having it as part
> of the generated header to simplifies the implementation.
> We also need to enclose this macro with #ifdef __KERNEL__
> to avoid side effects.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Looks correct to me, but since there are only three references to
'NR_syscalls' in arch/sh, I wonder if we should just replace it with
__NR_syscalls in the same patch.

       Arnd
