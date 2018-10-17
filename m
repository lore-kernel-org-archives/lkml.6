Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F992150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F992150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJQXLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:11:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44947 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:11:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id c56-v6so30410558qtd.11;
        Wed, 17 Oct 2018 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SagoZupbn9K6behTzzpmN5aP55azlYE5bzT9tVDhWLI=;
        b=Xhs7ARb1cdi+S5T5W492SP4T6QTO5J1GCzzHvlu3vQUIpR+wM/RRDHj1MUeT2vvecU
         yyFaUc3CuJPhNmnbsEwiBjvteBQGnf0gRpP/rs7lpCCTY0YNHgXieMVWsJ5ppbRTnUz9
         UYYDwpAQqkmowaEI6/xN73BlVvx4wz/dsqlaAmVjUALwiBrWJAsW/XYvYLP59nMI/IQO
         Z8DHazW5dZxGKNK0CfE8PrPW7WrCyoo4v4XcBK68kd9fyJG3zTeFqvVjewz8KanO5csk
         296/cdeq/4JrTwrBaWkk5ygV3eCGUc8r0wNUpEuwQvo8W15UuQSsezAc2kfD1Z8fLn3K
         uVOQ==
X-Gm-Message-State: ABuFfojy9x4Pj6aNAZQlRMMAIBy/EdijHAK+pqQml16EkbVMOIYbRhO8
        Qwf4PogBuxuJRyFTGSjn9THzpM8+qpXGW+xz/OPZq6bS
X-Google-Smtp-Source: ACcGV62t0Up4DgQfCqaSzmAjgN9goD81cp/00AnU6EQjJuEqnnM0OIv/S+YFk78y6/jjp6lz79IYnjGmambBldV0vDA=
X-Received: by 2002:aed:35cd:: with SMTP id d13-v6mr24875064qte.212.1539789304731;
 Wed, 17 Oct 2018 08:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <131eaaee23e5f55cdce90b76b2a64f67cdf0c685.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <131eaaee23e5f55cdce90b76b2a64f67cdf0c685.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:14:48 +0200
Message-ID: <CAK8P3a1B9jtV=3e0HrBXNyf=-HvnLmCgeFUhsr0-HZmOyFEHzA@mail.gmail.com>
Subject: Re: [PATCH V9 10/21] csky: IRQ handling
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
> This patch adds IRQ handling files.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> Changelog:
>  - Use CONFIG_GENERIC_IRQ_MULTI_HANDLER

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Using CONFIG_GENERIC_IRQ_MULTI_HANDLER makes this really
short, nice!
