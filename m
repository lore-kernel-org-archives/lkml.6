Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6E3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5498C20661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aotUeaPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5498C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeH2Pxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:53:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33729 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeH2Pxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:53:54 -0400
Received: by mail-it0-f65.google.com with SMTP id j198-v6so4904518ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcQsj7fKz1Qb4JwEYFG7gqC/sWjSJIEhF6cXuaOma9I=;
        b=aotUeaPBP3NwGv2Nh2h3WiNrv/bxzM9m152d5prdEaNoIG4at6EcxodKxcOn/8N6kn
         NQTrg6RG+tLuy/GsXkDIg+wjTcxCKnF1D/AXSBjhDit8SKUaZv9NXfeWqzqWQzMG2/2P
         4jfdQsttBruzJpKQWdhv8eBhvnCQT9yFZjenA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcQsj7fKz1Qb4JwEYFG7gqC/sWjSJIEhF6cXuaOma9I=;
        b=pGx7+uCF+mqmgVClumPKZtMRhgrH6TMj5TmwWtYgd1BV9tn//LBD6o6Mn+zQRqo1l0
         hCzOjYOV6YUEJLHcTxxThH7+QWXJIu/Ob5nArphXeqMV1Pdl+hhCAlSm95B2PGeiPsnU
         VvQQFka5DvCqr3KlrBU8Au+BPJzIeSzYNItlf0eji7rMtDF7gi38Nkn3VnTv2DAQFlLt
         h35xhHnEefkurNSneQa6H1G0Fa7kg/4GI+H6U+vH+p32mqzqQxxzWwsBmQS7FrubNie2
         4yk7SQb3zZFV/G9kU5RdwozjYMhtkcI4hyLos3hkQWoe/gwthhDYZDtotCLZ9u6Hxyhf
         rQAw==
X-Gm-Message-State: APzg51D0b+9g7NnDhZAX9pW+fyk6PWrf9ICRyL1NvkEgsViurV+u/3gn
        AJ8aDFw4PKp2iwR7OTSBO3CoRodDx11i5Sb4yTok8Q==
X-Google-Smtp-Source: ANB0VdZ9EjqsUW8yPCtEmRaRD7MrVyzDYhhOGzK2O2AzPFtGvI8M8N8SyuunDHHJEVH7wNDlpDaDF17xLygeom4Sfes=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr4949814jag.112.1535543840688;
 Wed, 29 Aug 2018 04:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180825084417.13526-1-robert.jarzmik@free.fr>
In-Reply-To: <20180825084417.13526-1-robert.jarzmik@free.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:57:08 +0200
Message-ID: <CACRpkdbU=87WNn1jksJitVouOQuXJsukUqCXggnD6kUjyr7Zwg@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: handle corner case of unprobed device
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:44 AM Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> In the corner case where the gpio driver probe fails, for whatever
> reason, the suspend and resume handlers will still be called as they
> have to be registered as syscore operations. This applies as well when
> no probe was called while the driver has been built in the kernel.
>
> Nicolas tracked this in :
> https://bugzilla.kernel.org/show_bug.cgi?id=200905
>
> Therefore, add a failsafe in these function, and test if a proper probe
> succeeded and the driver is functional.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Reported-by: Nicolas Chauvet <kwizart@gmail.com>

Patch applied.

Yours,
Linus Walleij
