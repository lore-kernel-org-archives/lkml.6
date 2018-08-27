Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4AC208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HtXitLMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AC208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH1CtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:49:23 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45015 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1CtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:49:22 -0400
Received: by mail-ua1-f66.google.com with SMTP id m11-v6so404380uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aArcR8Vt7dJ6QkZNgj3HyIKPsdPwVuSXRBkakVU7ng=;
        b=HtXitLMWU6BekUCYGjjuV6lusCSRNRrh1jm4xUo1NH+w4ygaYGf2/IXSHntCh+Ft99
         DtEC66yjB4ETdUfC6ch+lsgbdwAq5hvJ7CAqIVX2ei74J4DGicYHGDH/7SghR33ZP3Xf
         96CzJHcBnd9wgeHQeRZ+rbxFa/eaXCPC6Umh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aArcR8Vt7dJ6QkZNgj3HyIKPsdPwVuSXRBkakVU7ng=;
        b=LR3xjtND1X/ul7ZqNTQPXUIZbJ0foCVnezhxK98iz6+Gk6QsHmjd0Jw6X3uFT02WEQ
         A72igROyQ8Vd7jitBYCv+iVZOFtItFcTx7EaJ6V4H7LjyXs7YuxsRrSkg+c3DbBTQaj0
         JwrIltWBNBT6b2F8CLbbDQc4/WDI92DuiHWJEOB3cN5tztmexZzToOz09IruqY5gIdrA
         B/N6XCMWWf+DDjD/YdujXTxsPRCcnTBEHhdytZ3brD2qsYHUTdUQHSzTd2k6iqIr0xr8
         157v/NO17Z9VWnVyMfFbl1qz27Wk8wPsfbMxIsr9I3VZNGV4n1QrxzMPKrCsNkmjLRHf
         N2LQ==
X-Gm-Message-State: APzg51BhIC2/yzeUFIHRriClHdi2sbtlk/DLgEQ0xFXP1o+ZnwO0ZKOk
        MMMPnniFGlgvmp828Ak10Lmv/Qeu9stycw==
X-Google-Smtp-Source: ANB0VdbTxQqouBWbnM0ENjeJcoYH/b5HXlM7x+dgqREF8sDbLG0sn/TmRFE2HvYgFL7m2bzgWFlw7Q==
X-Received: by 2002:ab0:4a2:: with SMTP id 31-v6mr9853339uaw.151.1535410839494;
        Mon, 27 Aug 2018 16:00:39 -0700 (PDT)
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com. [209.85.213.52])
        by smtp.gmail.com with ESMTPSA id s123-v6sm150717vke.37.2018.08.27.16.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:00:39 -0700 (PDT)
Received: by mail-vk0-f52.google.com with SMTP id s6-v6so344754vks.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:00:38 -0700 (PDT)
X-Received: by 2002:a1f:a803:: with SMTP id r3-v6mr9143498vke.8.1535410838586;
 Mon, 27 Aug 2018 16:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Mon, 27 Aug 2018 17:00:27 -0600
X-Gmail-Original-Message-ID: <CAGS+omCS3nNke2BVLQtv5LK8xCKrMD6xwiPWajKMphWWfgsC3g@mail.gmail.com>
Message-ID: <CAGS+omCS3nNke2BVLQtv5LK8xCKrMD6xwiPWajKMphWWfgsC3g@mail.gmail.com>
Subject: Re: [PATCH] clk: x86: Set default parent to 48Mhz
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Alexander.Deucher@amd.com,
        Mike Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        rafael.j.wysocki@intel.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:53 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> System clk provided in ST soc can be set to:
> 48Mhz, non-spread
> 25Mhz, spread
> To get accurate rate, we need it to set it at non-spread
> option which is 48Mhz.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/clk/x86/clk-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
> index fb62f39..3a0996f 100644
> --- a/drivers/clk/x86/clk-st.c
> +++ b/drivers/clk/x86/clk-st.c
> @@ -46,7 +46,7 @@ static int st_clk_probe(struct platform_device *pdev)
>                 clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
>                 0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
>
> -       clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
> +       clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
>
>         hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
>                 0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> --
> 1.9.1
>
