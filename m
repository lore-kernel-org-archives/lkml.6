Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAF023EA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm6hBYIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAF023EA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeGDVEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:04:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42891 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeGDVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:04:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id u202-v6so5240090lff.9;
        Wed, 04 Jul 2018 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zM34YYeSY303DykYc9y9EC7OaPzxNgh9B0qs8/JMmTI=;
        b=Fm6hBYIebJ91ywrcceIMjq/BHmmLNkG8cyJefUwEItxov14JwhO2MZvODEx8fZUNQW
         77eOlDM5yH2qcEoeROOi6MRyUzCo8KsNh0GRmA7lqqogLZAFQtNs7WeyF5NDkfmJjr9m
         VxHGQM/YNuiCCllBRCz5YzTz1PvEpFrS3MaUzYKvstHKzxjz+Vj5OHJFsIe3JYgC6rI3
         w7kniiY+VB+OvpZ7oDzcOGB0UHBbiRpF9O36uwq4NUSWFhhSu1rY7U40kVIvpTmU3ftQ
         pnOPW86mOqOpurwMnSNHFJCYV5x2WEbFnbMlTPnQbVCI32RNyUIHeh+E4hC1nSm6GwQ/
         mySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zM34YYeSY303DykYc9y9EC7OaPzxNgh9B0qs8/JMmTI=;
        b=jdYyvBfl8cFV6zZRRYiMhpoUuVLaWLosNa2wZI2vU29E/0fV+tO6IdZeBjfdouD+Qx
         fiExvrZwSEPvawCPHdnrocbxgpY5Q6isv1E1aSm62t38qC4F/d1YXNQJgiNaQPjo9v3j
         CAJYFoB3WN5nPR+ZzyvKbczJNhjBw1n4eHW0152xjQCxV6NLD4WfnmLYD7FtHCoigyg1
         uWuiCJz1BH1bzy2WOv8JlvJY7zOIqzUUJt6IuAcl1Xy+PI6q8PvRZ+Pih70n0uL6M3+H
         lBOzfeYbmBI7OBjHO5+ljjx526nJBrAHRaHfxj0Y3rqYA55y5xfkEdr8wTT/oEc1/8tE
         +xnA==
X-Gm-Message-State: APt69E24ATuk+9FmrcQygiIs1qfjVtFg2JxFw78agDi/zb85+HKFF50z
        Q0sMfiYq2ECMTBLnWFE2lOR8AmMKFkftddNf/J8=
X-Google-Smtp-Source: AAOMgpfS7FX5XvLVDp6Ta+D+/XA8CHhoUi3UZ4HE2Mon6OM7tH5UQNi2jnHEJdXdbDxK1Z9xC43aYobS1aSqlKV8qZ8=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr2375064lfk.132.1530738278815;
 Wed, 04 Jul 2018 14:04:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 14:04:37 -0700 (PDT)
In-Reply-To: <20180704114952.GB22857@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com> <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
 <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com> <20180704114952.GB22857@guoren>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Jul 2018 23:04:37 +0200
X-Google-Sender-Auth: Le2KtDZzTATR3I-WNSMHrBpjTAI
Message-ID: <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
Subject: Re: [PATCH V2 05/19] csky: System Call
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:49 PM, Guo Ren <ren_guo@c-sky.com> wrote:

>
>> > +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
>> > +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
>> > +#define __NR_ipc               (__NR_arch_specific_syscall + 1)
>> > +__SYSCALL(__NR_ipc, sys_ipc)
>> > +#define __NR_socketcall                (__NR_arch_specific_syscall + 2)
>> > +__SYSCALL(__NR_socketcall, sys_socketcall)
>> > +#define __NR_ugetrlimit                (__NR_arch_specific_syscall + 3)
>> > +__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
>> > +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
>> > +__SYSCALL(__NR_cacheflush, sys_cacheflush)
>> > +#define __NR_sysfs             (__NR_arch_specific_syscall + 5)
>> > +__SYSCALL(__NR_sysfs, sys_sysfs)
>> > +
>> > +__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)
>>
>> We definitely don't want ipc, socketcall, ugetrlimit, or sysfs.
> Ok, remove them.
>
>> For fadvise64_64, please redefine the symbol name so the
>> table points at the right entry.
> We need exchange the args for abiv1. loff_t is 64bit and abiv1 need
> 8-bytes align in args.
> /*
>  * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
>  */
> SYSCALL_DEFINE4(csky_fadvise64_64,
>         int, fd,
>         int, advice,
>         loff_t, offset,
>         loff_t, len)
> {
>         return sys_fadvise64_64(fd, offset, len, advice);
> }

Right, I do understand what it's used for, my point was that you
don't really need a separate system call number for it, just redirect
the entry point using the same trick that nds32 has in
arch/nds32/kernel/syscall_table.c:

#define sys_fadvise64_64 csky_fadvise64_64

>> I'm not completely sure about set_thread_area, can you explain
>> what you need that for?
> In abiv1 there is no tls register, so we use "trap 3" for csky_get_tls
> defined in arch/csky/kernel/entry.S to get tls.
>
> Also we use set_thread_area to set tls in kernel.
>
> For abiv2 it has r31 for tls-reg, but we still keep the mechanism.

ok.

            Arnd
