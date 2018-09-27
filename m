Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F82C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4F2170B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k0H7Qtxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C4F2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeI1AY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:24:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32798 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbeI1AY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:24:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id o21-v6so2948975lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Otv75TYHT+A7mXLRkCtJvSoTwJgu4jolgu8uoNqZaSs=;
        b=k0H7QtxjFCYM2TftoArHwPEIYD1FLo59wQPY+IXjmtabVjbuTxmowl2cKhsJWq+Pu6
         M7BD/kJMKY12wVHlhyV47e7CeTGHQ06qF25hA5VfA5A1NeBGuxCCxOzjNEWAPoR85wY+
         WXr65OtvMBvP5wjKyXA3XAUsTHPYwCaHaKSMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Otv75TYHT+A7mXLRkCtJvSoTwJgu4jolgu8uoNqZaSs=;
        b=CEnfaBNiHeun9Auy+3Sg1Y9XRcb5YTz+/ZEnZ6LV2zZxljRXkFxPeyeUEOLaRRdVV4
         cIiOWmVUjgcs5uDFyM5Xa3P1mtFEklEsaPvgFRL5eoyXiNwicZjnsWWWIYSa5j26vv2n
         XBaGLhhvHQyIDqvqnAvSHdWSmt02MfqvReiiSZ3gzVB/09mxfpbP7o2yRal0AWLazvmC
         l6BwNmewVd5BkU8mCjZmhlB/DmwkdSz62t5BL9sD8sMVRRvGCZhg4wa+m0psa0Q7sU0K
         3AAnHaJSVg9Jn4zN114MaqZglWHDCSysi0RLi+9zs4ajX05JjNX/mMh3Yu2rubRrWQs/
         SIdA==
X-Gm-Message-State: ABuFfoj5Ne/64eZzSjnCHruyoXGeH512Lx83epHyxMx88sW4fgHg/SjQ
        ieyvaTom/SSMFuTtdjHJ3DJViYA4Mes=
X-Google-Smtp-Source: ACcGV60Uvr2U0XRe7JZHLzIZiklYTk52Seu5lKOhziJZs6ejgb8oTF4vD0TU4CY0Uq3hKgexrHFAAg==
X-Received: by 2002:a19:cb09:: with SMTP id b9-v6mr7900423lfg.117.1538071497085;
        Thu, 27 Sep 2018 11:04:57 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i21-v6sm549919lfa.71.2018.09.27.11.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:04:56 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v9-v6so3330804ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:04:56 -0700 (PDT)
X-Received: by 2002:a2e:9c89:: with SMTP id x9-v6mr9158682lji.110.1538071495832;
 Thu, 27 Sep 2018 11:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180927171810.22968-1-ilina@codeaurora.org>
In-Reply-To: <20180927171810.22968-1-ilina@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Sep 2018 11:04:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft48d5cWiGS_Zu-rcdCnEUxwjRAGzqCJLriOOXuFKhq1tQ@mail.gmail.com>
Message-ID: <CAE=gft48d5cWiGS_Zu-rcdCnEUxwjRAGzqCJLriOOXuFKhq1tQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: irqchip: pdc: setup all edge interrupts as
 rising edge at GIC
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, sboyd@kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:18 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> The PDC irqchp can convert a falling edge or level low interrupt to a
> rising edge or level high interrupt at the GIC. We just need to setup
> the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
> as IRQ_TYPE_EDGE_RISING at the GIC.
>
> Reported-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
