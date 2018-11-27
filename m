Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46938C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6EC214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpfXQdgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6EC214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeK1D4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbeK1D4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:56:16 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28561223D8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543337865;
        bh=47p5msGX9UndhnpEQoMo6AD5VUOwCqEY4Cka1XjdJIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gpfXQdgoKO4bWwc7TY2tSLhFWp2e739xmb6BCfdHDLq6AKskEXHU7mqgI5MIAYn95
         w7LChKWzhxqkrOnuNBjBTaeNLIZVnEXgcpKO4npIiOAwJjWSamGkrK1W3VhoUyMIzy
         FoecPVWzcptbKr78fUBq+i7SLvC43KDP/VcXLVPA=
Received: by mail-qt1-f172.google.com with SMTP id n21so22509321qtl.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:57:45 -0800 (PST)
X-Gm-Message-State: AA+aEWaYz7M/u3R8IYqwjEQnV7IWEZG7DQc6d7A1LIYiKTRUL9cWuJri
        UJBo1/m9TcvAmlUagFP3uvmYEHbgTjgtgoDuWA==
X-Google-Smtp-Source: AFSGD/UizU2uEZAtY+aJE1nMBdXXyjtGhDd41ya8q1lI3akaYTQQIyrUb5VyFR6sHiSzh77W/eY3EGaT+rV+01f0IUY=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr27379199qta.38.1543337864310;
 Tue, 27 Nov 2018 08:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20181123165418.27745-1-tiny.windzz@gmail.com>
In-Reply-To: <20181123165418.27745-1-tiny.windzz@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Nov 2018 10:57:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7T4=c_NBdSaBD-ecS7vY2FUe8k23ipeff8oyxq=9tew@mail.gmail.com>
Message-ID: <CAL_JsqL7T4=c_NBdSaBD-ecS7vY2FUe8k23ipeff8oyxq=9tew@mail.gmail.com>
Subject: Re: [PATCH] irqchhip: Convert to using %pOFn instead of device_node.name
To:     tiny.windzz@gmail.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        marc.w.gonzalez@free.fr,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:54 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/irqchip/irq-mscc-ocelot.c |  6 +++---
>  drivers/irqchip/irq-stm32-exti.c  |  6 +++---
>  drivers/irqchip/irq-tango.c       | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)

Same here. Already queued a patch for these and others missed here.

Rob
