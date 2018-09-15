Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C999AECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826A02086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeIOUrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 16:47:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39641 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 16:47:39 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so11523441qtk.6;
        Sat, 15 Sep 2018 08:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nBjs05BlUA/WIn0SRyIlxiS0ulFeeUPHCbPcCM4Kco=;
        b=qRfHeGGIlv5HHU+QxaACppalqK0az9pdbVh/f8vwKpLsc0oxd2e5j0AWfImmcmGKQW
         BnDVp4EJ4GSVhCmWkyY6kWYNTsQjY0y+Wtrx/JhpfzU9cTbH5gbmiyTek2XZlaoBtwEp
         UUu+BG4ATCiiJKJ7k0xLI8sXKL3YAysPE3v2jFZS3P7bgU5/da6tir3NBw4QC+wcLr18
         GecIsGBpnT5u2LavfyPl38TV8VTVfLdeHEHNCoW7RXTdSiNfKDYjJQX+4CsgIFof1uH2
         Ih5u2VldZyzKdnubXzW3ceE0YRTSI5l98pfSr/zQNY3twXTx6D4wwC60GCR5/BGFJaFK
         Gzjg==
X-Gm-Message-State: APzg51C0HyNy7CeDTaB3m7YsmIPQ+bc38K7Lmh9rppBJeXuRLi1knXBQ
        Yo7SaLpJkZmTTQzjpICGHlVhVgDHPQAbr3j0iUE=
X-Google-Smtp-Source: ANB0VdaN2hIDEMo7KgvBBbCrmWM6ATy+khh+pMpubM9FgQudSo3PhF2T+a7Z90l035ZHaG428tWJ9dwAbw7vSegaPdQ=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr12614758qtb.75.1537025295696;
 Sat, 15 Sep 2018 08:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180915050843.19183-1-deepa.kernel@gmail.com> <20180915050843.19183-5-deepa.kernel@gmail.com>
In-Reply-To: <20180915050843.19183-5-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 15 Sep 2018 17:27:59 +0200
Message-ID: <CAK8P3a2Kkm2ubg_MVN_BJL=s7qpUB1-np=9zVpcJ2U-aPAJswg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pselect6: use __kernel_timespec
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 7:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> +#if defined(CONFIG_64BIT_TIME)
> +
> +COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
> +       compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
> +       struct __kernel_timespec __user *, tsp, void __user *, sig)

I got a link error here since compat_sys_pselect6_time64 and
compat_sys_ppoll_time64 are only defined when CONFIG_64BIT_TIME
is set.

I did not think we would select this symbol on arm64, is that a mistake
on my side, or should the #ifdef check be removed?

      Arnd
