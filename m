Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2E120850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2E120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeLDVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:33:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38554 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:33:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so19918386qtl.5;
        Tue, 04 Dec 2018 13:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W0EbAePeEpyft8AGAWdGBucIWf6cgDCPKGR33Rc8cM=;
        b=X3doC94HHPH3DUvET+75C515PPlOsISb60pbF9jecpc2wnsiGrDmKMLhSC4AhkrtAe
         Pw5uxfGxDyKSBxNGUT+cdQV1XYkCCiN1TVKcD1z9lSDBkcCW8gb8f0PVych2C74PTVGz
         JWkuFva/IOftXctCEcKq4Y5dd674esybyyG5VxBhQfrgufsTTjxdVbBN/Muioi2ld61R
         1I4AexAcmTNn2su/RxIzZJISSEpHkDn/GVYHCAU4M05Ln0ov6l5dbImQ0HJKjXydyW46
         f8qOlzfCK8HE4+Rw4/AlrsssZOIAUTpjDjdhQHHG5vNI1qaXqjC1CpVS0UxnjDL3Op5e
         mosg==
X-Gm-Message-State: AA+aEWZ466RAoxIWX+8sncNGvX21rXX0np8gbsYv+RIj8Ra6vO5l//Mr
        C+LBWEoyxxW1TXEiLnFJoJreJ7baczYxeTFJ0Ug=
X-Google-Smtp-Source: AFSGD/VqVajLxF0jVSFmrd5TieXjqarj5TshDi/jn5dRL2G7+HehZB6lV+/HJAqd4cglA3ZUvZ6VPFVLPidTxj5qqgk=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr20936968qte.212.1543959210210;
 Tue, 04 Dec 2018 13:33:30 -0800 (PST)
MIME-Version: 1.0
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
 <1543465611-17122-5-git-send-email-firoz.khan@linaro.org> <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
In-Reply-To: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Dec 2018 22:33:13 +0100
Message-ID: <CAK8P3a0DX6Eh0OwUh975RL2Pq_ux_AQeBPSakPFxZf+t62EJ=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc: generate uapi header and system call
 table files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linuxram@us.ibm.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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

On Tue, Dec 4, 2018 at 10:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> > index 9ff1913..d756348 100644
> > --- a/arch/powerpc/kernel/systbl.S
> > +++ b/arch/powerpc/kernel/systbl.S
>
> >  #ifdef CONFIG_PPC64
> > @@ -47,5 +25,17 @@
> >  .globl sys_call_table
> >  sys_call_table:
> >
> > +#if defined CONFIG_PPC64 && defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> >  #define compat_sys_sigsuspend  sys_sigsuspend
> > -#include <asm/systbl.h>
> > +#include <asm/syscall_table_c32.h>
> > +#undef __SYSCALL
> > +#elif defined CONFIG_PPC64 && !defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> > +#include <asm/syscall_table_64.h>
> > +#undef __SYSCALL
>
> This part looks wrong: where the old sys_call_table contained
> both the native and compat calls side by side, the new table
> contains only the compat versions (note that CONFIG_COMPAT is
> always set on PPC64). I think you copy-pasted this incorrectly from
> one of the other architectures that uses a different layout for the
> compat calls.
>
> The way I think this could work best is if you add a preparation
> patch that splits out the 64-bit table into two separate ones
> (and make sure that works). After that, you can add your
> existing patch, rebased to use the two generated tables
> instead of the old-style tables. I'll follow up with an untested
> patch for illustration.

One more thing I noticed while writing up that patch: you also need
to use the DOTSYM() macro in __SYSCALL() to generate the correct
symbol name for the old ELF ABI (when PPC64_ELF_ABI_v2 is
not set).

       Arnd
