Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EDEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5421773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfBRMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:15:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32862 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBRMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:15:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so18927128qtz.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxG0a3/6eq8D7gGuNRV0Sr562TfMLTabfemllJBULjw=;
        b=FWSJqfEro4TLflb8jonssEVwvaKWn2UMHf5J1WB1fcMYsgpTlvAQS7B+nrwWXTdbYa
         5vdluM8MhYw5A0EIocvYPEuyClPqDaEbfnL+qHa9jehHASfOVHimAm/itdYq/ACyJOeH
         Nhfm1A81SKGNStjtQgG1Q5d5o/qadg0DVsJcNA6gSAUD7aW73+oYY017xeYex9Nsz9fA
         7zHUJVaEcPquQeNiTlaYg19MU/N+FCkdyRRsXsc/W8ksR+cQX610MwkQBEd0Acg7eH5s
         R6exAHI2AtOgDg7idZb5SJOwr4mGu/O4MrG7a0wBj4eWnUQTAgSFoAgvt2qwe+eybRke
         sj/A==
X-Gm-Message-State: AHQUAuZwV+AWpxmZ3ORHf5R3FN2zKhJGVuDcaVGCy6pSskQHsHGofM52
        sxZ/WBHR9bLy2f38mPPurBLTCYr79geSHKz9vTg=
X-Google-Smtp-Source: AHgI3Ib5sKA34QROB7/6HzwhSfKuCZIlz1qW1sEMrI2L7nY/UpeCSWSsY3EuQQoBe4kDAFkAMp2QdRFu7udzQjuqgu4=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3788997qtb.343.1550492139241;
 Mon, 18 Feb 2019 04:15:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 13:15:22 +0100
Message-ID: <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> +static int m10v_pm_enter(suspend_state_t state)
> +{
> +       switch (state) {
> +       case PM_SUSPEND_STANDBY:
> +               pr_err("STANDBY\n");
> +               asm("wfi");
> +               break;
> +       case PM_SUSPEND_MEM:
> +               pr_err("SUSPEND\n");
> +               cpu_pm_enter();
> +               cpu_suspend(0, m10v_die);
> +               cpu_pm_exit();
> +               break;
> +       }
> +       return 0;
> +}

It looks like you left the pr_err() messages from bringup, they should probably
be removed now.

> +static int __init m10v_pm_init(void)
> +{
> +       suspend_set_ops(&m10v_pm_ops);
> +
> +       return 0;
> +}
> +late_initcall(m10v_pm_init);

This requires a check to ensure you are actually on the right platform,
otherwise you break suspend/resume in a multiplatform kernel running
on anything other than milbeaut.

       Arnd
