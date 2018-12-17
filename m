Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD0FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF2421848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLQVku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:40:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43422 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLQVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:40:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so15876178qtj.10;
        Mon, 17 Dec 2018 13:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwsA82BHFQMwc/4Q2uYH3aoKdRVMEgTxPzbMSqrA0XM=;
        b=PDZEs2Pb21fuSaSSklBQ65YDrjpnfHba82lIlupGo2RG9WSEbZSiBtGws8CM3PozB5
         5NUxlLaf/w/v1hgXd2+V1khkM0dCknZTyDJoCUqsPlcssRs+QPV0/xJGMSb8SbOa0hax
         DLmS4X8l2LyNwfLoPW5o4LuOuaRIw5S2MyGQjorulIdI2u8GLIPTpc2bo2vLWthHe4EG
         0AXN7Sned8v4FJ1PPbtXrqa0Eno1+nXcMy7kwSs8aW2HJIeoSu8Pv1QMGcj62dyWGjh2
         EQFYPDr91aPEVwTR1oZq1dyeroG+ed1yyrFWhpmCwOdxlWjtSZ0g8JuwIL1ctgTzbS/o
         tzfA==
X-Gm-Message-State: AA+aEWYpqp2cVHLWjvk6+7aiX7IDbjvNn+n4kiViN9zAEusTEhcEc5Tb
        rt7rdsLXEBIxJTijW589Y3FJ2VLu+eKv5TuooJs=
X-Google-Smtp-Source: AFSGD/XM8Opvd8+/+Fd0hCkAB6OKt+WgaNNTWYvowbwb3nkgJsy0+HtW8XNFKLgMshdOz76CozlAAgud8geV4EU6Fa8=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr14387730qvm.149.1545082848233;
 Mon, 17 Dec 2018 13:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20181217130646.GB3560@osiris>
In-Reply-To: <20181217130646.GB3560@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Dec 2018 22:40:31 +0100
Message-ID: <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
Subject: Re: [-next] strace tests fail because of "y2038: socket: Add compat_sys_recvmmsg_time64"
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 2:06 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> Hi Arnd,
>
> in linux-next as of today 16 strace self tests fail on s390. I could
> bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").
>
> The following tests fail:

Hi Heiko,

Thanks for the report and sorry I broke things. I'll have a closer look
tomorrow if I don't find it right away. I suppose the regression was in
native system calls, not the compat syscalls with 31-bit user space,
right?

     Arnd

> mmsg.gen.test
> clock.gen.test
> regex.gen.test
> sched.gen.test
> trace_fstatfs.gen.test
> trace_personality_regex_64.gen.test
> trace_fstat.gen.test
> trace_personality_32.gen.test
> trace_question.gen.test
> trace_personality_regex_32.gen.test
> trace_personality_64.gen.test
> trace_stat.gen.test
> trace_statfs.gen.test
> trace_lstat.gen.test
> trace_stat_like.gen.test
> trace_statfs_like.gen.test
>
> If needed the s390 kernel config can be re-created with
>
> make ARCH=s390 performance_defconfig
>
> strace self tests can be reproduced with
>
> > git clone https://gitlab.com/strace/strace.git
> > cd strace
> > ./bootstrap
> > ./configure
> > make
> > cd tests
> > make check
>
