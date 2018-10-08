Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29A520652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29A520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:00:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41897 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:00:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id l41-v6so8399086qtl.8;
        Mon, 08 Oct 2018 06:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYv3r5jA+NdnoH3HGz1zwHEwiY1SCM1gRryy5WWb598=;
        b=XY9oyYU03OXVfkhKzOGtpyQJrzRwENmHOvCVgT586FSAZCUU4xvnhJ71yKNzp+T3ky
         VIFBU8i2NcgnqrvbKLVM+i48x2AJ6+XPE2gzrGRhvPNwU7pW2801+BjhvKO817SWKqTh
         k3RaQT6aKKHjzVZWFMT6TiPa0XnUhymJg0XW1Mcb/ETGMea7DGkjsp7EIRr2Kb5G9rN5
         RXsMaeBPMKiT417bcqqs1cMuCXa78WaFuhOaSJlnZWqYnqAKnAD0n+UVFNyz2lQtlwB/
         3jc1CdSmy+z46jBq7taRw/tg18Kbhr+ScWWbWjRRBNEK/WnOrOkB5efauH4pfonCwux5
         4j5w==
X-Gm-Message-State: ABuFfogz7HdohniK7FnlrQXSneLJCk3BA20W/xmTkRw6SUKOswRd4o5Q
        ibPkf/cG1atzaFF5uBiponV8wDbb5+q3trXsHdI=
X-Google-Smtp-Source: ACcGV61M99MKz26GijZhfOUalDdzuiAR2hpMyDzOBprGoEMHQaznfJOLhyUxKcyfaX0G/v3CquW4OlZSYrKBUTR4YCc=
X-Received: by 2002:a0c:f64c:: with SMTP id s12-v6mr19420626qvm.115.1539006524876;
 Mon, 08 Oct 2018 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
 <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
 <CA+G9fYuLJH6XVsS14xjhSqJsUGZ9NXdyytseT2Pr0hoxOeWfAg@mail.gmail.com> <20181008130106.GE6490@zn.tnic>
In-Reply-To: <20181008130106.GE6490@zn.tnic>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 15:48:28 +0200
Message-ID: <CAK8P3a3Lek2NryUqFZGxSSG2PZD3McS7bezK9Ur3AAX2v6=mgQ@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/kaslr, ACPI/NUMA: Fix KASLR build error
To:     Borislav Petkov <bp@suse.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, m.mizuma@jp.fujitsu.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 3:01 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Mon, Oct 08, 2018 at 04:33:29PM +0530, Naresh Kamboju wrote:
> > Linux next build for arm64 failed due to
> > numa.c:34:10: fatal error: asm/kaslr.h: No such file or directory
>
> Thanks for letting me know, I guess we could fix that with a weak
> function:
>

> +/* To be overridden by architectures */
> +void __init __weak kaslr_check_padding(void) { }
> +
>  int __init acpi_numa_init(void)
>  {
>         int cnt = 0;
>

I think __weak functions are too fragile, when you do this and it
turns out that another architecture does need to do something,
you won't ever get any indication of it.

If we know that arm64 doesn't need to do anything here, just
add an arch/arm64/include/asm/kaslr.h with an empty function
there.

      Arnd
