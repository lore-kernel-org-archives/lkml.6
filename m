Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7B20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kyvS9nJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF7B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJBKep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:34:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56017 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJBKep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:34:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 10ce06b3
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=OGm2w7xoZwpZIOHg45TUPGlz4K8=; b=kyvS9n
        J9sXki/mcfbeAJVoDqCMl+WFmoCEQyafdJfxR+NvEvDGbOlBVWP/4HYB76MAuJ3o
        ka/ZYEJE25V/UiVk8WoFy8+td3lq8oW/PqTeERHSCFb1DBjt9pzmX9flJnzcoRAN
        Xi7dGmTYthSvFpkHLKqde10S/YsqTBSV0suy29FxbZ0geONBJ5JgY8ZL+Kf6toBm
        yHru5+JPESCiutBuGXqhurmpjWaxdRXGgV0EGKcU76jvhqjT5ptxb+LGOPfeuVp1
        sHteyf1e+l7H4G7KY2o2G9ongxyrMX71ky/9jxVncMokR/1hO6frqaVMUAnZ84HR
        IpjjK6mNUfXf19kw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 15ba7e0d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 03:53:37 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id u197-v6so431142oif.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:53:38 -0700 (PDT)
X-Gm-Message-State: ABuFfoho31qmsI2mX5wTFjPrWrwWdAMtU+aNB5q83OlaRCG2Oe2x4YMS
        LImOarrP1YHR9p2aM1M5mKg9sTQjI/U/6PXkfbA=
X-Google-Smtp-Source: ACcGV60jIZFyarPTXFgKmZ6gtiG/qMfgo/spL6wcFSSs0OqViA2JeddvLlUB/c57NCk95JvpZLFgVpWJ1jdoz1qoHHk=
X-Received: by 2002:aca:2c5:: with SMTP id 188-v6mr6212954oic.192.1538452417417;
 Mon, 01 Oct 2018 20:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
In-Reply-To: <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:53:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
Message-ID: <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Apologies for the delay in getting back to you. I had some MTA issues
and stupidly assumed ARM developers were taking the day off instead...

On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
> +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m

Unfortunately this doesn't really cut it in my case, as it's not only
those multiplications:
chacha20-arm.S:402: Error: selected processor does not support `bxeq
lr' in ARM mode

I think we're going to wind up playing whack-a-mole in silly ways. The
fact of the matter is that the ARM assembly I'm adding to the tree is
for ARMv4 and up, and not for ARMv3.

I think there are three options to work around this issue:

1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
-march=armv4.
3) This patch.

My initial plan was (1). ArdB recommended I do (2) instead. I thought
that was a bit too nuanced and submitted (3).

It sounds like in light of the bus issues, (1) might be the best
solution after all?

Let me know, and I'll follow your direction.

Regards,
Jason
