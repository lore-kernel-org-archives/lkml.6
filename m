Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4783C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E67A24351
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yALX+4h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E67A24351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbeFVOZL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeFVOZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:25:10 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED01E2439E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529677510;
        bh=I/HiUBPB9TPpxxikgcULTKc79trJ8CEg9P3m/Ufr1cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yALX+4h6EMwndSoup5qK5yQbydmVso+sWuywe7Cm0mNC7ekRFpZ4azFk8tFo1Enld
         3fhinXfS0AuWP+iO2ecJA4FUtBbmg6/rfGsZ5U9LWHL+gaPm2UeJkvQ5u8aZ16mJ2Q
         X+RKKPlWIVmOH+qNkPiMES2wRifzCnqhFgvpHqYg=
Received: by mail-wm0-f47.google.com with SMTP id o13-v6so2430692wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:25:09 -0700 (PDT)
X-Gm-Message-State: APt69E2H1M81+zYzFOP+XUiNlPPaF9O/jYCbn+a+HnH3xYfawqm164t/
        LdyaOUSJqqbdt7L+7/mpt6VEgjCSsB6N0H3s9kqITw==
X-Google-Smtp-Source: ADUXVKLyf5RboxAmOuGLr4gGeRQE5pij7OD5kvpFVcG6BUT6rml3G4AuKwiSrRqGTCVHO16cCgmrmLxQ1eOt/DXEi6s=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr1783036wmi.46.1529677508417;
 Fri, 22 Jun 2018 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-2-h.peter.anvin@intel.com>
In-Reply-To: <20180621211754.12757-2-h.peter.anvin@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:24:56 -0700
X-Gmail-Original-Message-ID: <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
Message-ID: <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
To:     "H. Peter Anvin" <h.peter.anvin@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:18 PM H. Peter Anvin, Intel
<h.peter.anvin@intel.com> wrote:
>
> From: "H. Peter Anvin" <hpa@linux.intel.com>
>
> It is not only %ds and %es which contain cached user descriptor
> information, %fs and %gs do as well.
>
> To make sure we don't do something stupid that will affect processes
> which wouldn't want this requalification, be more restrictive about
> which selector numbers will be requalified: they need to be LDT
> selectors (which by definition are never null), have an RPL of 3
> (always the case in user space unless null), and match the updated
> descriptor.

That RPL3 part is false.  The following program does:

#include <stdio.h>

int main()
{
    unsigned short sel;
    asm volatile ("mov %%ss, %0" : "=rm" (sel));
    sel &= ~3;
    printf("Will write 0x%hx to GS\n", sel);
    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
    asm volatile ("mov %%gs, %0" : "=rm" (sel));
    printf("GS = 0x%hx\n", sel);
    return 0;
}

prints:

Will write 0x28 to GS
GS = 0x28

The x86 architecture is *insane*.

Other than that, this patch seems generally sensible.  But my
objection that it's incorrect with FSGSBASE enabled for %fs and %gs
still applies.
