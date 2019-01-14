Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3597520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GicSc8C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfANIqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:46:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45659 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:46:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so18209168ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjZuUldNUjrhkHo06a67Tr1tbf/tCp9SyXzYuO+sgiI=;
        b=GicSc8C1VvprFvghz6A2N6xmNIyCkuACYm3Q77MEtijD4BtZ/hlmWXbxRiqsr1aVbU
         DA1YLy52B1PSIVizKNxHr2BlrhZqpkKI0zPjRjQI0LlUszTj0HM4y6ViQOLfnf9K+qCe
         tvKYPyobXgZ1WRWNLrZeMO4nbcNy9/4FaFD80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjZuUldNUjrhkHo06a67Tr1tbf/tCp9SyXzYuO+sgiI=;
        b=jsJqlTy6la6/hhLHlBcNrGb2O3tfriBpmbLmSP/GpVph/7/lHFODwhWKuSolhesRO6
         +p6q6+ACJ5EQkjU5fJ7TSxye76HMK6GDdCWWKBcINAZvikx+BqfmSQI9AzeiQPyN+1I1
         4Zf4sx5wNhtB0AlV3mhVAe5Ry0G42WJu4KEBI0N+Rig8kicKVukyOXjbkTXy3tN8p0AO
         /rXBs79fMr+9VmlR8DtzmBgP/C1a6uL3Hlv79Qy8nDxvP3JfYv4sMKz6NYXqYHRz43ku
         p9f0lD/zxGTN6bCIn/B1aJNwUKGMFH8x56DqvnYD+Ge3YxpZ5B53hfJ4zqfdAEzJzMaq
         wL3g==
X-Gm-Message-State: AJcUukfHNG9kJunlRtX7q1c8GkbQmAeXEGLpqiwEH0hekCGfxjhNkGZN
        8U7euKm63xtMzBU7jiaVnWovc8f1HhsAA2/BrBIVBA==
X-Google-Smtp-Source: ALg8bN4zY9/0tw9s1Uwy8gidnfrbp6YorOXPonIS5YWH6l7poytTGoCvBySRtLC+dtSRLrQvfMWxXWKr5Ywu49vdYNY=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr13746084ljc.97.1547455558185;
 Mon, 14 Jan 2019 00:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20190113154716.5145-1-masneyb@onstation.org> <CACRpkdbyiPwE8+onB0_Yu0i+6LZCFy8Z7MWWY7p-fjsb0JFVhw@mail.gmail.com>
In-Reply-To: <CACRpkdbyiPwE8+onB0_Yu0i+6LZCFy8Z7MWWY7p-fjsb0JFVhw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 09:45:46 +0100
Message-ID: <CACRpkdYFCid1Hr1auSezwo83Djm9C82L7WF4LzfW1a8gKLLsaQ@mail.gmail.com>
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

On Mon, Jan 14, 2019 at 9:43 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> Regarding the device trees, I think we usually merge device tree
> changes in parallel (orthogonally) and as long as the end result
> after merging both driver code and device tree changes is correct
> we do not bother *too* much about any intermittent states.
>
> That said I can of course merge the DTS changes in the pin control
> tree if I get some ACK from the Qualcomm maintainers.
>
> Else I will just apply patches 1-7 to the pin control tree ASAP and
> the DTS changes need to go through qcom (Andy's tree) and
> ARM SoC.

PS that would mean dropping patches 6 and 14 obviously.
If I merge all patches, I can keep them around.

Yours,
Linus Walleij
