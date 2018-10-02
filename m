Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D22C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AB120684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SloH2imw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AB120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeJBMUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:20:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40871 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:20:31 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so1145197iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xev2zmbezSA+/lohmc8EdKhVAjHCTh2WA/XQaSPKjwI=;
        b=SloH2imwTAoFFm1RJL89OUhWs3BDnxiCdfeuqH1n5gYXQfmiM5LddA/L61ZBHXcGyf
         PHkDUq0sXp+DVdI8zn9B65qHmKU6T+v/Com6QYCFup0FVbuazLNlMjNjQ7t+5sW4BHSX
         HVVb4dJN2S/zzztGaAtpl6wGTY5C8iYIWQ1vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xev2zmbezSA+/lohmc8EdKhVAjHCTh2WA/XQaSPKjwI=;
        b=GFOXxX4BlBoNcXkhBNbzupt/F6qntLrq6BDWP9Zsa47YbgAwe4qZcNPqeEeIq6IC8c
         GUYqVc3ub/f/eWb6gGj94VX7gtqz9vKRQSDw7yKSTv1pbzQCL7GYZZT4WjJzPy9O/3q8
         Rq9MVGu3aKRUBLc9vc5xDPaRJXXbu5Ivwz1d+m53+UVSAfHvE5PF5uXkOt2Kmbft9H0i
         haKrFqAIVF90x5HZy3B/6Tz0t4LvqU/B66jcKg9A89MgJoruRNx/Gqg0fWtRUDqHpY6N
         EXLScCIjgPrxb462EUo7gZdgUPsgUifkDwVQgPfI4hm6nQgoXYzPRPFOWnuNdw6rA3vk
         8NXg==
X-Gm-Message-State: ABuFfoimRAln6+wc4v9GYvWx31oFUSeBuGk1V1deVTbEszVhHGtVgnmn
        JU94Y4Xk2LwD4hA743ikVNgpMqvgcMTdKV2AGARS9g==
X-Google-Smtp-Source: ACcGV61koNS0XXNHcmsTGnkJz7Avc88af9E1oqyUk2QYOFw/QjbKya5Bkglcaliq4hpPKtZ/RoBBMiW5Txrzeiy44IY=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr9273735iob.170.1538458746596;
 Mon, 01 Oct 2018 22:39:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 22:39:06 -0700 (PDT)
In-Reply-To: <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 07:39:06 +0200
Message-ID: <CAKv+Gu94x+pPp_CrPYj=3aFb6fDcZKM9MficvKkkfXhDib2sYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 05:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Arnd,
>
> Apologies for the delay in getting back to you. I had some MTA issues
> and stupidly assumed ARM developers were taking the day off instead...
>
> On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>> +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>
> Unfortunately this doesn't really cut it in my case, as it's not only
> those multiplications:
> chacha20-arm.S:402: Error: selected processor does not support `bxeq
> lr' in ARM mode
>

We have a macro for doing function returns: just replace 'bxeq lr'
with 'reteq lr' (and be sure to include <asm/assembler.h>)


> I think we're going to wind up playing whack-a-mole in silly ways. The
> fact of the matter is that the ARM assembly I'm adding to the tree is
> for ARMv4 and up, and not for ARMv3.
>
> I think there are three options to work around this issue:
>
> 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
> 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
> -march=armv4.
> 3) This patch.
>
> My initial plan was (1). ArdB recommended I do (2) instead. I thought
> that was a bit too nuanced and submitted (3).
>
> It sounds like in light of the bus issues, (1) might be the best
> solution after all?
>
> Let me know, and I'll follow your direction.
>
> Regards,
> Jason
