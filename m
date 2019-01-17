Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfAQQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:30:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39754 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfAQQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:30:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so11948464qtj.6;
        Thu, 17 Jan 2019 08:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guAp2BQZAZN8luhXlwYizmkL+xnir6kk0PsAK2MmTo8=;
        b=fszkimHZHgFrOaOO0Y4X1qjrIKuUJ3V5B4C+ikMZpjMLbGmChtkwMFj9nRNBErW2t7
         DXy3KWT0vVfDWwXcC2OFZqg85tIkTLGHfsniwixNDOd1Vmm2faI/2upYJbzrKHZ+jbCc
         K8nazDT/26RlaQCuwLIm5JOElf+vQ+3ckiKnifn9uYFHQ3HeTYRebdmwsM9lqiEsGbnw
         nHudC8NXvAc2sX6FauOXyR3w4HRKWlxK0QPbFI5uDjcDCoG78qW/UNjIxwp2SLQL4yIZ
         ntDb9EXU2ifE5H7iGRSmsZldooK66u36b1S1pyu7yW3jYWvxyU8mtUOmZLwz/cxGXYc5
         V2KA==
X-Gm-Message-State: AJcUukfp6vl2Ja2T+qp/prXucwnJrcAId8rjocMRaBqJHRYJ9SjKo6nI
        340R579VBnbj+WByrwEY5gbX0GXO2b/KpAbR0BY=
X-Google-Smtp-Source: ALg8bN4ZyrU9c/eQp6uMqmObzW6Yesx6RmidyI815keL4Nh/jy50QoQYuQSgcWU1pofc5talyWaIQrOzcwxvudtGBUs=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr11751196qvm.149.1547742611737;
 Thu, 17 Jan 2019 08:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20190116131527.2071570-1-arnd@arndb.de> <20190116131527.2071570-3-arnd@arndb.de>
 <20190117132906.GB18351@osiris>
In-Reply-To: <20190117132906.GB18351@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 17:29:55 +0100
Message-ID: <CAK8P3a1u0OJKPnuBHVy4WSFy6T04kfNw5BwkpsLmkEU4KQD5eQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:29 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:

> diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
> index 6aa8fe00b39e..fd0cbbed4d9f 100644
> --- a/arch/s390/kernel/sys_s390.c
> +++ b/arch/s390/kernel/sys_s390.c
> @@ -58,6 +58,7 @@ SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
>         return error;
>  }
>
> +#ifdef CONFIG_SYSVIPC
>  /*
>   * sys_ipc() is the de-multiplexer for the SysV IPC calls.
>   */
> @@ -76,6 +77,7 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
>          */
>         return ksys_ipc(call, first, second, third, ptr, third);
>  }
> +#endif /* CONFIG_SYSVIPC */

Ack.

>  SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
>  {
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index ab9d0e3c6d50..ad016a7db0ea 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -366,7 +366,7 @@ COND_SYSCALL(kexec_file_load);
>  /* s390 */
>  COND_SYSCALL(s390_pci_mmio_read);
>  COND_SYSCALL(s390_pci_mmio_write);
> -COND_SYSCALL_COMPAT(s390_ipc);
> +COND_SYSCALL(s390_ipc);
>
>  /* powerpc */
>  COND_SYSCALL(rtas);

I think you need to keep the

COND_SYSCALL_COMPAT(s390_ipc);

here, otherwise it still fails with CONFIG_SYSV_IPC=n, CONFIG_COMPAT=y, right?

       Arnd
