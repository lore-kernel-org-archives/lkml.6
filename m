Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81DDECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A22E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A22E21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJQXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:15:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33552 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:15:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id q40-v6so30476111qte.0;
        Wed, 17 Oct 2018 08:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cneHIWjz7K5rpI3XYjwVIdoJZ92okMRPNwTLEfUAxg=;
        b=KzXFuVHmiUIkhHMGJn2CIuww7Kake3SRkiNSUERM+DEAwNmTkYD/64GFDYxuL2ZJYB
         VLaNI/tTfO84GJS/ED8F6fyaIpgtsrQb+n6i9B7ttSLrfM7tWpi1MRDjAFIB5tRZhMum
         KCtyDCYPeTAJ++wrmW+AbSLfytik72NtdrJtNloFNUBqkl0GyOfE+nLgstU/BjvB/Dxc
         lDatafXx+TxrtlVgDUQah+0nLmpNBEkBrE80BbHFoT2OLSgrSnNsRveyegSTY/JAfPxG
         iGposgDwuPKd6huXmFHJ29xH2OOZBpt0COcK9neR2gxmRY5SHCvVmyhTONz8oyf2OzyT
         k/AA==
X-Gm-Message-State: ABuFfojbaK3Q9aAjuLhXF96DpwIrCqXLPy36Yx1eQ5Ky3q1wjd5SZYF7
        eqw+6DXXP1EvCfhGpArveEDHvHnw+tyhXjeXtD8=
X-Google-Smtp-Source: ACcGV61fVW3NHQSW/mB1kBEzGwZ3y5izU4WtXQVp9yaRN1fms41l7bNtbA16THAbuxgjVNn4H+9H68ZycX/8E7vsWWc=
X-Received: by 2002:aed:35cd:: with SMTP id d13-v6mr24891918qte.212.1539789545696;
 Wed, 17 Oct 2018 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <27589f69f513177892d39868050dccb5f21023aa.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <27589f69f513177892d39868050dccb5f21023aa.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:18:49 +0200
Message-ID: <CAK8P3a2vwe=4SqKfyGruKEJ1yd7txbdBqw6kD_3pN47F8u7OAA@mail.gmail.com>
Subject: Re: [PATCH V9 12/21] csky: ELF and module probe
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds ELF definition and module relocate codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

> +#ifdef __cskyBE__
> +#define ELF_DATA       ELFDATA2MSB
> +#else
> +#define ELF_DATA       ELFDATA2LSB
> +#endif

You removed support for big-endian, right? I guess the #ifdef can also
get removed here then. Aside from that,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
