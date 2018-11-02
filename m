Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6040C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2642082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iU1px3kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2642082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeKCGJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:09:37 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38403 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCGJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:09:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id x64so1835524vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+8Qzx9Dv51DZY61zt5+NaCpjjzandyc9jmCVKnU9Gw=;
        b=iU1px3kte32xzIiHFzCnZe6G1Kwe36MSlCV/VskN2tBcTwmZ7K0sDkzLm+l3zEY8Gt
         g27fa18XRqw4XkuM4vr52ZfPde+Ri/Us9wBiYPf7GdeTro1GTMrJCO8xMeA9C4NaZBmh
         BKp3O9fyMoxAhNKbyydx/3GKKlKxdsZRzEcxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+8Qzx9Dv51DZY61zt5+NaCpjjzandyc9jmCVKnU9Gw=;
        b=N3Vp6arbSEjKc5pKG5zFNIErXNeETuwAAMLA9MIBB0s0bY1npEEi57fhnjMnL1hvK1
         rLbDeLNqzlCey3ffXEF6TAu2oYjlaqP/GFGqSq72A9+E8auN5oFluh1fzQFvzfjeNsNt
         H4j5stJn4NuKztXhPgm0VfO6b4Ekcbl5qmyRv14xhZKuPNDsjOzmP/GXUyUPlho79pib
         cWTFV2ctRrKGI2Ji2mf74w+k28g+50WgW401MI2BGW8wnc9by+GsPSZJ4efN9G+TS3qP
         Hn4rhappFUOuY5q8qWLbGrOt32YjziPg+YShsNoSQVka9/x54N1R4OdlEO9fjkGIwygG
         JvaA==
X-Gm-Message-State: AGRZ1gIpm3E6tjylYiXLu35kJqJweS262Qcgqez95udTf79AS3nLlCzj
        l5J0EPRwLizkgrKWIjsiDVfNHXYPmSA=
X-Google-Smtp-Source: AJdET5clY3u6Fg9mqpTckHyQlEqFB32ibN++XWv22mqxrs/3x1yFA8w4DmeE8GzYkh8qLuzs8swcVQ==
X-Received: by 2002:a67:f294:: with SMTP id m20mr5625553vsk.81.1541192454737;
        Fri, 02 Nov 2018 14:00:54 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id k22-v6sm10061696vkk.29.2018.11.02.14.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:00:54 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id p74so1847222vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:00:53 -0700 (PDT)
X-Received: by 2002:a67:ac0c:: with SMTP id v12mr3343141vse.121.1541192453089;
 Fri, 02 Nov 2018 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181102205732.116851-1-swboyd@chromium.org>
In-Reply-To: <20181102205732.116851-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Nov 2018 14:00:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVncnodGgsjH19T0eN-9EAp+HRgZio1cs2RY_OhsP9iA@mail.gmail.com>
Message-ID: <CAD=FV=UVncnodGgsjH19T0eN-9EAp+HRgZio1cs2RY_OhsP9iA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Fix runtime PM mismatch with child devices
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, alokc@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 2, 2018 at 1:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We need to enable runtime PM on this i2c controller before populating
> child devices with i2c_add_adapter(). Otherwise, if a child device uses
> runtime PM and stays runtime PM enabled we'll get the following warning
> at boot.
>
>  Enabling runtime PM for inactive device (a98000.i2c) with active children
>  WARNING: CPU: 4 PID: 1 at drivers/base/power/runtime.c:1300 pm_runtime_enable+0xd8/0xf8
>  Modules linked in:
>  CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.19.0 #6
>  elants_i2c 14-0010: 14-0010 supply vccio not found, using dummy regulator
>  pstate: 60c00089 (nZCv daIf +PAN +UAO)
>  pc : pm_runtime_enable+0xd8/0xf8
>  lr : pm_runtime_enable+0xd8/0xf8
>  sp : ffffffc0de257a30
>  x29: ffffffc0de257a30 x28: 0000000000061a80
>  x27: ffffff9008ea7118
>  x26: ffffffc0d718b058
>  x25: ffffff9008ea7000 x24: ffffffc0d718a8dc
>  x23: ffffffc0d718a8b0 x22: ffffffc0d823dd58
>  x21: 0000000000000000 x20: ffffffc0d823dbc8
>  x19: ffffffc0d823da90 x18: 000000007f743d9a
>  x17: 0000000000000080 x16: 0000000000000003
>  x15: 000000000000003f x14: 0720072007200720
>  x13: 0720072007200720 x12: 0720072007200720
>  x11: 0720072007200720 x10: 0720072007200720
>  x9 : 0720072007200720 x8 : 0720072007200720
>  x7 : ffffff900816da30 x6 : 0000000000000000
>  x5 : 0000000000000080 x4 : 0000000000000003
>  x3 : ffffff900816f304 x2 : ffffffc0de248050
>  x1 : 25045a74f48a7400 x0 : 25045a74f48a7400
>  Call trace:
>   pm_runtime_enable+0xd8/0xf8
>   geni_i2c_probe+0x440/0x460
>   platform_drv_probe+0x74/0xc8
>   really_probe+0x1ac/0x35c
>   driver_probe_device+0xd4/0x118
>   __driver_attach+0xc8/0x118
>   bus_for_each_dev+0xac/0xe8
>   driver_attach+0x38/0x44
>   bus_add_driver+0x15c/0x294
>   driver_register+0x13c/0x198
>   __platform_driver_register+0x88/0x94
>   geni_i2c_driver_init+0x20/0x28
>   do_one_initcall+0x250/0x4ec
>   kernel_init_freeable+0x6f0/0x7c4
>   kernel_init+0x18/0x120
>   ret_from_fork+0x10/0x18
>
> Let's move the runtime PM enabling and setup to before we add the
> adapter, so that this device can respond to runtime PM requests from
> children.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Also fix the driver remove path
>
>  drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
