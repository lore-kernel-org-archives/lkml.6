Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F168021480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F168021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeHVN0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:26:49 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34334 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHVN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:26:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so1388199qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 03:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeX2FQmUyzDpVaMcYixH/LnRt+y7+yZD59MqswQ6G/A=;
        b=kgK2E/E9XZUdfByfo11a+c9GrExBPHEOwi7RtAjNuxpCVBzZmZKZajIcIA93s5Hx5h
         pq1lKarFMRotmiwcy3lIYfEVyeiol0nXmJw3W5jDnBkBl+2WkYgXJtNu6aeu6O3w2txs
         9lruKfW6iUcoL8Uy+phv3tpROmb45MywxYcTo7sEum05o+HMD7nJMHF7vSvz2cLHHL/A
         cas1ccKSnk8WSc3B+arGYJgHX9A+lkbn1cYibteFn9TDtC6AfKC2wEv6xoPDrqArkRZS
         hyarknRpG04JLJowGq9LakfZtTNsK2wOyXPiKbsODM4HAdHU4rPGI0EVYLDQRTvH2MRu
         CMEQ==
X-Gm-Message-State: APzg51ArvZ68+v4r+khopuJHYFQgNsalTBnm91RPFlS37MJVybK6Ko6B
        vOWqIMG0vd9ucVo0AKe+jHBxQ7Q1RmTrILSc+mX1D8G/
X-Google-Smtp-Source: ANB0VdZEZfs6Sp4NYkN7hNL52wbqTcIMysppxIdpJHxTBKfWAwWMaPfsL3t6Q8nZyQyHrePvqwNjyQO7YeX6F/RFnSI=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr17045427qvp.149.1534932155687;
 Wed, 22 Aug 2018 03:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180821222416.7771-1-stefan@agner.ch>
In-Reply-To: <20180821222416.7771-1-stefan@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Aug 2018 12:02:19 +0200
Message-ID: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
Subject: Re: [PATCH] ARM: use choice for kernel unwinders
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
>
> While in theory multiple unwinders could be compiled in, it does
> not make sense in practise. Use a choice to make the unwinder
> selection mutually exclusive and mandatory.
>
> Already before this commit it has not been possible to deselect
> FRAME_POINTER. Remove the obsolete comment.
>
> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> enabled the kernel needs a specific function prologue:
>     mov    ip, sp
>     stmfd    sp!, {fp, ip, lr, pc}
>     sub    fp, ip, #4
>
> To get to the required prologue gcc uses apcs and no-sched-prolog.
> This compiler options are not available on clang, and clang is not
> able to generate the required prologue. Make the FRAME_POINTER
> config symbol depending on !clang.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks ok to me. I've added it to my randconfig test environment, you
will hear from me within a day if I run into build regressions.

We may still want to clean up these three lines:

lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
!ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
!MICROBLAZE && !ARM_UNWIND && !ARC && !X86
lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
!MICROBLAZE && !ARM_UNWIND && !ARC && !X86

in which ARM is the odd case that currently depends on an architecture
specific rather than the architecture itself.
We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
and then simplify the 'select' statements here.

       Arnd
