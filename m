Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E907C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NX10aX+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfANIoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:44:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44913 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfANIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:44:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so14942628lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shEaCEuNwnJ1kazeHqfDD+QbcN+O6S8RuNKqqcokew8=;
        b=NX10aX+RdQBFoGKgdbCgPdqYk2xTcbGXHcgGmQY7IVufNRtIh8A8WmDwktive4ctwK
         WKkDzSoQbSIkDv17Ln6m7VRgChbGQRfZaPY6y643uaQuPSz+ZBm1pojE1n+ovRZrC4AH
         07ocx6jV86BSFDWj5JFpGLh5fGjVyc8kk3ScY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shEaCEuNwnJ1kazeHqfDD+QbcN+O6S8RuNKqqcokew8=;
        b=KrZmMWrJQ65cdLSswRTf0q4P6sCg74AHQZKwM2hH1oNqo6Uz7ayjywMZgpL0Njh0us
         v0cg84hXrPsJsF+DoOepHx4G1IzGP9pz4Sxr7YE810bRyxs1nqUcPP2bRmQbqiqJupSG
         uFEDt1MbcNoHcX1XLAq22TQlEjQfqopZMQOybT0nxg1n57hefOC3tBUf/5D45UWkQJZk
         6/SfGvsuhosFYzbpbPZPFVxoXpfTJrsjyoKsdLPcqaFAwwu6r2RVC32xQurWDMilKcQP
         0lXeN3rwxNklKjoYOSdv/rvbl4+cM+94EBfUX23yj7TvYhdpJ7XsnQfSblKsAR2wVm7b
         2r5g==
X-Gm-Message-State: AJcUukekMOUwaCNiRSUPFAXIu0TIVFyVtw+ok//Y6U0L03PqkyPI8fio
        urc2RH4kl6we36zx0WJRu2an7L9/EXioRLHYb3vF4g==
X-Google-Smtp-Source: ALg8bN53a/U4ZzrYjO6Vtj4xDwtL5symr5fYra6fWNfdJG3yf/Wg3Akr/6uQrx+EpEMuXjGIzQre5ZuJu48LBxRfN5M=
X-Received: by 2002:a19:f813:: with SMTP id a19mr12234423lff.67.1547455441667;
 Mon, 14 Jan 2019 00:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20190113154716.5145-1-masneyb@onstation.org>
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 09:43:50 +0100
Message-ID: <CACRpkdbyiPwE8+onB0_Yu0i+6LZCFy8Z7MWWY7p-fjsb0JFVhw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] qcom: spmi: add support for hierarchical IRQ chip
To:     Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 4:47 PM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to spmi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.

I'm very happy with this series and no matter if it would cause some
stir while merging, the kernel looks so much better for millions of
phones after this patch that it is worth pursuing aggressively.
It also shows the way for other platforms. (And taught me a great
deal about hierarchical interrupts as well.)

It'd be nice to have Stephen's ACK on the SPMI parts so I can merge
all the code through the pin control subsystem.

Regarding the device trees, I think we usually merge device tree
changes in parallel (orthogonally) and as long as the end result
after merging both driver code and device tree changes is correct
we do not bother *too* much about any intermittent states.

That said I can of course merge the DTS changes in the pin control
tree if I get some ACK from the Qualcomm maintainers.

Else I will just apply patches 1-7 to the pin control tree ASAP and
the DTS changes need to go through qcom (Andy's tree) and
ARM SoC.

Thoughts?

Yours,
Linus Walleij
