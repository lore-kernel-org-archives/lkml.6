Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B91C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7F42063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8foX2LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfANPLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:11:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:11:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so19325632lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xeU39kKvuzpWV2g4S+6k90ETR4scHi5Z/69jfWwpeE=;
        b=G8foX2LZWDk8oTxIcKPEYUNPqQ4tsqu+jeAp+bTMYfE7ltJitKh6Pd5ftTMVMR7pIj
         49AmKwLYvsgMplLTV2ro83pnu2xS7/LED1J9yJ7g+aBEyRvI4LRgwIfKzsa51ZjGw7KZ
         R5FUmBxs9PUOllsLlYJGiPMvXOcR+D1UPbMT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xeU39kKvuzpWV2g4S+6k90ETR4scHi5Z/69jfWwpeE=;
        b=ZZkPJ/g4rxHVO+/gI48zQP2PzxaxnJzW4e0ryjjhz0LedKn6VJGa3L/BboSdh/yiki
         km2DJ3DtzasJg/ZIHSz3Ih42VANsPrCvGWOaGBY/FoXNBY9HO4N9kvu+BIr3U8oyeurf
         T8fIYAZDI+yeL3fUSHRNZ4y1zYH8gGsLMaOGwi7q9wX+nl4rTNSA6ENVDPYuy0TovUPV
         /W18oi7LrjCwAsxIC+raq5bxiA2E4OZN8a1cdE3xQpt+8WHHKpsa87p/zMV/JjQt+RsL
         B0+S0IuNGu7tQTszz64x3BHQ+mlpY/QPkqEgf6Sanr92iE5Rm8cWaQkht+8pubMTBAfO
         3Qtg==
X-Gm-Message-State: AJcUukcEPlz6D7EbLUe+sIqexIWc4RyAwcaqbHMnNmIHLrGAnwovgwBb
        /t2msK8iIGk+xnz0rmXwcHQSSHiTwM1BLXKELtdlZw==
X-Google-Smtp-Source: ALg8bN6cHJ+fz1QqOQkuNNQFfwNpp0MF1iXurr6kxiULSYvBo5YUuZwSPe28oyTQRNOjSIm8o4z21nHC4jePJ1X5ZXw=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr14822840ljj.9.1547478703360;
 Mon, 14 Jan 2019 07:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190113095723.25295-1-wens@csie.org>
In-Reply-To: <20190113095723.25295-1-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 16:11:30 +0100
Message-ID: <CACRpkdazBiRB7ocTkT2hgEnv+-MyyMfdKFFZ_cfnOn202vq0jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: sunxi: Fix and simplify pin bank
 regulator handling
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 10:57 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The new per-pin-bank regulator handling code in the sunxi pinctrl driver
> has mismatched conditions for enabling and disabling the regulator: it
> is enabled each time a pin is requested, but only disabled when the
> pin-bank's reference count reaches zero.
>
> Since we are doing reference counting already, there's no need to enable
> the regulator each time a pin is requested. Instead we can just do it
> for the first requested pin of each pin-bank. Thus we can reverse the
> test and bail out early if it's not the first occurrence.
>
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>
>   - Moved before the other fix. Both fixes are needed, but having this
>     one first made reworking the other one easier.

Patch applied for fixes.

Yours,
Linus Walleij
