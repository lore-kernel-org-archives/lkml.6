Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F81FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DA82080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbB6HkTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DA82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeKJBn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:43:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45952 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJBn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:43:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id p144-v6so1839476oic.12;
        Fri, 09 Nov 2018 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyJT/Z1FDu6UKvFnNcnXKcjFSXHdIfhIXfpytCDOKDA=;
        b=IbB6HkTv8p9yr57vR0IJ0/gSy2VMOuvQrm1yfOXDc6ZBclO/thk6pcNUEZMu6WYyGh
         onr3i7Bw6Pot6z9kbD1EfrsA4fUrF4Sg44SpU/zwb9iP9K+MVAVJNllk4tzaJUBU+N9l
         8gXZXWrOkg3WIV5s5t6Swcbb382OQU3B8jL5832VoiqThvhp1xMh+RD6CESBdtj3Zj7e
         hn+nzPIbls+C/o+21/Vc5VpYTm4fQfKT8Y2rRKElbZPuGhAbtUR4L5zI+c6eMzQSVCOO
         llyUT+Llm5aaj6PsyEXXpipp4qBcyETirEGVfCrr6ZBwzTxcD95e9nMqKzohjetB404Z
         1NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyJT/Z1FDu6UKvFnNcnXKcjFSXHdIfhIXfpytCDOKDA=;
        b=OvHFtJ+G5/NPAD+ef3JAydC2ZVHZuIDgfO7lfdmXQJn8+5VheGDwWHL9nGaqzIQq/G
         gu9Fd+aUknUjJ76XI+Y/yqKKuFx7wGZhuOgbF7w9jcsB887fUVmpVnWzVhGIohw4DSYb
         exKKFlbQGybxxghe2W+pCMbMfIxfqhOCZ8TLZok1l8Mcw6PI8SBXgQAvow8iDh17qxsT
         r4hFzweDzZhlY04HfmG5iVF4hDSidbCBKy/FdCHoFOLONiqNwZlsk4dQNHptquCpEmJu
         5NEUgIc3LzcjBTgkJaRPS3ozVHQQLHQL4o1VnNiAuAKHkmc5hldLWeYaLLP9gypf0Lxu
         6KNQ==
X-Gm-Message-State: AGRZ1gIJiTeIqDVNzdvDw/aWEjw0UEBoeg+UrukOoomGu5dkQ+a9hh4L
        ZeeOTD2G9n8QtKcR5PWLJpIcD+T0BE+OKW+u2bA=
X-Google-Smtp-Source: AJdET5c/3H5pvrInZIPt9bNAfdVoyBgV089DJPieXeGc15Nxcu4Y3kOx58w82R/eXgZ19Y/puo6K+hYV3kH80tQ1mbc=
X-Received: by 2002:a54:458c:: with SMTP id z12-v6mr5377330oib.297.1541779335394;
 Fri, 09 Nov 2018 08:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 9 Nov 2018 11:02:04 -0500
Message-ID: <CAGngYiU+8k4ZHYhFVQGKXW8mATEDi64Mi9PsVkX-5vn2PCY3ew@mail.gmail.com>
Subject: Re: [PATCH anybus v3 0/6] Support HMS Profinet Card over Anybus
To:     Sven Van Asbroeck <svendev@arcx.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Rob, Linus,

Many thanks for your constructive feedback so far !

Is there anything in general about this set that would prevent it from being
mainlined? Perhaps I am trying to do too much at once, dropping a patchset
that is too complex to be properly reviewed?

I've been thinking about reworking the host to its simplest, yet feature-
complete form. Just serialize all card accesses with a single lock.
Then the kernel thread, kqueue, kcache, kref etc would all disappear.
The price we pay is a reduction in performance/parallelism.
We could then increase parallelism at a later stage.
Would that be of any help?

Comments on v3 will go into v4 shortly.
(Rob, I'm not sure how to address your feedback, other than to s/host/slot/g ?)

Yours,
Sven
