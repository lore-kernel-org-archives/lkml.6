Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2333620823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBUPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:44:07 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35103 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:44:07 -0500
Received: by mail-ua1-f66.google.com with SMTP id f88so2021548uaf.2;
        Thu, 21 Feb 2019 07:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ujnw5Uiwkv5qTiAYI4IO+ayFYK6PgidtMZeh00Ee/Y=;
        b=pFTjM1h/yqZ3lTbR6XBcfA6TFCo7I+SAmse3h2QFMKlQP1LZ3YdlQJxxmfGndus2hh
         /AG0NmUPFrle3sECi7hu9C4fD82K0P9pazxO/21weTYfnH8a1wewyFRlMNhJUbZerD8o
         +YJQN0/uAH1A3CFPclvHs7QvMMzE7cKq5Yt2tJHKkv6aICwWJW2stsM1jyHVIWgIPnj9
         8+rkhwst4MOf3U3SqZcuykbeaJCN6RTV1mtkR3XCsQrLbDPlFrhwhiqmidxaDZiibLPr
         gGJ0IxYK0MwdCkHCQwA9B1Nu8MAQlxYinaSHtc7HwBf8S7T6+poNtZcYME0jMM2DXihq
         v5Eg==
X-Gm-Message-State: AHQUAuYVR0QHWEUlJmuCzCoVYA6PossDKKRHQRNkNo1P4dW6hnJW42U1
        7Z5ZEwG6iW+PV+yU8DQbXU/U+LFxxWDjoFpOQMI=
X-Google-Smtp-Source: AHgI3IZkIsmyOUVreh1QOkHEAPFxqcxd77snLAmAV+9Sy/chSvR4jotEu/irvqDdLX1f9A4IiENyMkkEowuXViAeJaU=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr3949088vsp.166.1550763846010;
 Thu, 21 Feb 2019 07:44:06 -0800 (PST)
MIME-Version: 1.0
References: <1550749552-8133-1-git-send-email-krzk@kernel.org> <1550749552-8133-2-git-send-email-krzk@kernel.org>
In-Reply-To: <1550749552-8133-2-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Feb 2019 16:43:53 +0100
Message-ID: <CAMuHMdUcn4LtMnE75XzF+p2G8ivTxKPMp_gT6ozx0iwtQFS+Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: samsung: exynos5: Fix possible NULL pointer
 exception on platform_device_alloc() failure
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:47 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> During initialization of subdevices if platform_device_alloc() failed,
> returned NULL pointer will be later dereferenced.  Add proper error
> paths to exynos5_clk_register_subcmu().  The return value of this
> function is still ignored because at this stage of init there is nothing
> we can do.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
