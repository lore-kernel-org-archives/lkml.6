Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD87C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9EB2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeJLTYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:24:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44369 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeJLTYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:24:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so13471271qtd.11;
        Fri, 12 Oct 2018 04:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDq2t2cMNcJeQ0YcbIahyQwNnd6dr21sidFAAiwbO2s=;
        b=XFBSuEB9bLP0anP7YOQKPdA8NBzDu4SgXszwCk/PSvIEuDEpUA50XD/jso8T8nXJpw
         p03rwVXIwcMUWR4aecj1t8A9S+AT9CJh1nUzJO7HytSa6729idtN1uXtTvCvdcqFPU0X
         X6njZRhkIz70uwqw4yWQsFpu1KWYi0No0d7RLWgxrKUOGMzPmuHU0eogwSKhCbmsuiUg
         uEhe279XmJTUn5OQbBP6ukiTTscBKKV+DHlIjWFsUn6AxzggFhlteb5SgbkxwOQX4vTx
         fRCeqUykX6pZKZhZYU7007g1JegwGk/Pi+EFX1UYgP/0/R7LwgpAhPGJLY7d60GyYoI1
         pLXA==
X-Gm-Message-State: ABuFfojO8AHEniApF21EAtBsrAAwCG8DDiSe/1Ctc4Eqz7RhQnPUCjVF
        5TcWAe06EbzcaA3pxAYHtPGMWhzMzYmOw6edH0M=
X-Google-Smtp-Source: ACcGV60OGIneDWiadoRjHtVwFkF0WvQD+6ea5IhiaCnMx+cC7ClY/7kLVgoM4AR22irTVPjzyl922sPl/U+FwsMFOuc=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr5462111qvl.40.1539345151218;
 Fri, 12 Oct 2018 04:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
In-Reply-To: <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 13:52:15 +0200
Message-ID: <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
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

On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Arnd,
>
> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >
> > > Wire up rseq system call requires an architecture specific
> > > implementation as it not present now.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >
> > Didn't we conclude that this should be skipped?
>
> Helge told "I prefer to keep the warning for rseq for now.
> It reminds me that we still may want the rseq syscall.
> If the warning is a problem, you may simply add the __IGNORE_rseq define."
>
> I chose this option; I feel it looks clean
> "# rseq requires an architecture specific implementation" in syscall.tbl
> hopefully remind him to add rseq syscall implementation in this architecture.
>

But he said he wants the warning instead.

     Arnd
