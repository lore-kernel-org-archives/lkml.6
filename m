Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A839FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA6420857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA6420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeIFPMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:12:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44254 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeIFPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:12:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so11583273qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCNQGdXTFc5chVvmfuCmeTM/VUiZFPcVsXa3fkhO0MA=;
        b=Wwn2ERaYjO30ba8f/NbPMU8ogyVfjcjTVELCRFwxbjjMwEklQawNi7/uAGD/V8KjbR
         Ojz34QWwYUgpoMEIRwNJiRfvpdju6xXtNyDcIsEIWEp7d3E/sZ/LPqq96Uvv6eTHNG7n
         tPQ0DZg3VoEU9nQQMi/HGkTOK4CwJr6iNEsxvxUKhHXrVuCjq19j6QrWRZE8Zhw1EzCZ
         2SM64CO+OobYqzZHOESk4GXXWGOfxjYUC+/kZ5nCBwsRDV9ms3JsyW4Rnw+R2u1DziWU
         nJwXgqEbmRBhsXrZawiXg/O7hy0KzbpjvoJ9xa0awB+E5aj8jg7jYq6zTt5UjkYi6uYz
         EGoQ==
X-Gm-Message-State: APzg51A6A7x6sGIX1sL9Mfb2Q5nNFbO958vVIF190nkhbIMzGJgzmSCz
        H9tkAsTgwphJKFs1eeM7MeNvZPDWngm0Grfuu6EqQlFt
X-Google-Smtp-Source: ANB0VdYuVnt1kAQuiZxsbDM7rREXgVNAp+fJIvqCDJ+OFYfVOi0BoB4zHqNti3YPzsDiMhVfOCrwNQqx5p6uRWNCTxI=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr1517332qtr.9.1536230267042;
 Thu, 06 Sep 2018 03:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180901174353.GA14271@roeck-us.net> <mhng-a047b20f-8546-4762-bcf0-f884be595b92@palmer-si-x1c4>
In-Reply-To: <mhng-a047b20f-8546-4762-bcf0-f884be595b92@palmer-si-x1c4>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 12:37:28 +0200
Message-ID: <CAK8P3a2kS-vF954NA6QmN=d6DsnhCqESCBu_X2cdrx5gkR8HKg@mail.gmail.com>
Subject: Re: [PATCH] y2038: Remove newstat family from default syscall set
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 11:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> On Sat, 01 Sep 2018 10:43:53 PDT (-0700), linux@roeck-us.net wrote:
> >
> > +#define __ARCH_WANT_NEW_STAT
> >  #define __ARCH_WANT_SYS_CLONE
> >  #include <uapi/asm/unistd.h>
> >  #include <uapi/asm/syscalls.h>
>
> I'm afraid I'm not sure what the right thing to do here is either, but from the
> patch description it does seem like we should have this guarded by an "#ifdef
> CONFIG_32BIT" so we can keep it out of our 32-bit ABI (which isn't in glibc
> yet, so isn't stable) in favor of statx() (or maybe stat64()?).

I think the patch is correct.

> The one
> problem here is that I can't find "newstat" anywhere in glibc to verify it's
> actually supposed to be part of our 64-bit ABI, though I can find a bunch of
> references to "statx" that seem to indicate it's meant to be present.
>
> That said, assuming you don't have anything wacky going on in userspace if this
> breaks the ABI then it breaks the ABI, so however newstat got into a binary we
> still need to keep it around.  Poking around my Fedora glibc image I see
>
>     000000000009b040 <__xstat>:
>        9b040:       e51d                    bnez    a0,9b06e <__xstat+0x2e>
>        9b042:       04f00893                li      a7,79
>        9b046:       f9c00513                li      a0,-100
>        9b04a:       4681                    li      a3,0
>        9b04c:       00000073                ecall
>
> which seems to coorespond with sys_newfstatat, which indicates to me we should
> have it in the 64-bit ABI.

In uapi/asm-generic/unistd.h we have

#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
#define __NR3264_fstatat 79
__SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
#define __NR3264_fstat 80
__SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
#endif
#define __NR_newfstatat __NR3264_fstatat
#define __NR_fstat __NR3264_fstat
#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
#else
#define __NR_fstatat64 __NR3264_fstatat
#define __NR_fstat64 __NR3264_fstat
#endif

So in the kernel, we have two families of implementations, both
with awful historic names:

On 64-bit systems, we have __NR_newfstatat pointing to sys_newfstatat
(with a 'struct stat argument), and on 32-bit systems we have
__NR_fstatat64 pointing to sys_fstatat64 (with a struct stat64 argument).

In glibc, we have __xstat, which calls __NR_newfstatat on 64-bit systems,
and __NR_fstatat64 on 32-bit systems. The result is the same in both
cases, the only user-visible difference is the layout of the atime/mtime/ctime
fields.

       Arnd
