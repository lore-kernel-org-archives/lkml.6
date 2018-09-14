Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F24ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A643120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeINPPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:15:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44872 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:15:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so8135541qtk.11;
        Fri, 14 Sep 2018 03:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY/ZDLWi1ATSiCbxdsGOq71b3jg9GV2aBjpqoe3hNmc=;
        b=Prj9y3vy6idM0YMZFs8Fl2RLxLpRzlMxi3R6ha6Ds65AYONPcOQPTDdT+8QSiTPx0O
         JatsP58r3LmPA3W4Si7gU7Bvs0vohEUlXkpZ8bcWh7qla1jHj5WiaXO0afeDNOPhkmOW
         lXTIQ1D9S0tkYvgRyvBD4vEO/yUz18GtFYtwCDZ03AqI/Ho0BvKuzy9NjMokGqTTgUcD
         V6LPagw392SzWinSi6LB74YcTY6M/f/Z4pacVmenZijPwjbLzavoUk07CCRJURoBg39d
         IlaS6aOabdpOF6RWNA/dBajaQrEOEQjBlzK0jUzfYLPIKSLVUNHKJFwffbULBc1hY8VZ
         i42A==
X-Gm-Message-State: APzg51AlnrUBC6SWVCfOCeWGmz9uAeAvSwIx1x1MecPEruKFOW38PG2z
        Y/eQ46hbYa0v/MOx4kzbhUJ/i1PEnEbHQhKYgFU=
X-Google-Smtp-Source: ANB0VdalPW7W3beVHCLbx6CuFgPTcbvA++7tK0HeQTDjnoS50sInkLnYfQ9wmjcHN8YNIJQgn37BYGa69Zn4pQylxGM=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr8034656qtf.185.1536919326984;
 Fri, 14 Sep 2018 03:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org> <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 12:01:51 +0200
Message-ID: <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com,
        leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>,
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

On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> ---
>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++

I think you should only need a single .tbl  input file here.


> +
> +systbl_abi_syscall_table_32 := 32
> +$(out)/syscall_table_32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_64 := 64
> +$(out)/syscall_table_64.h: $(syscall64) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_c32 := c32
> +$(out)/syscall_table_c32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)

And here you need a fourth output file for the SPU table on ppc64.

> +383     common  statx                           sys_statx
> +384     common  pkey_alloc                      sys_pkey_alloc
> +385     common  pkey_free                       sys_pkey_free
> +386     common  pkey_mprotect                   sys_pkey_mprotect

This also misses rseq and io_pgetevents.

       Arnd
