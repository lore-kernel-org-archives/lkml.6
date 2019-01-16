Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7251B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392493AbfAPMOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:14:31 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35640 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbfAPMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:14:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so6887821qtc.2;
        Wed, 16 Jan 2019 04:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvT8UEGTNgUOWn4aDzojgNkCEy0NRz+atz8DCKuaLjQ=;
        b=H1X/bdVMTIUXAoqj2b7Hs9Fbg5lzWg0wF+0aVVqPWeaCdjz97F/YVoYY6vmZGp4lTD
         Osj+5XxTvaNQcAP8EuPrjhCDLJfjhimvtkLlA7SeEfbIpBQl71RFfsODS92v019eHZlU
         RLZRL3a0D7eIQyUh4r02i1+Myb9jo8jlmGtbz5/jM60p7Kw9P/p9DahNGY/Epedthmup
         04mcrdAyw35YI406lddZA6GEa0pXQVu+XepuISH7fEvTvlprKz5MR+JCpNgYHHr2N5Tg
         e8eIFvWjO4moY/kA0Cj9dc8HF7hIsTnpRz0hrf1t7XOLtDcUOrwHxT3FAMQGzStlUayd
         3J4Q==
X-Gm-Message-State: AJcUukf4YSZmFsp564vd2Pnyh+5TTE/N2iUoVGyOAtDce6gTtDJ7VDf0
        UgNeB/7E56whaOPoTZbHpBytEFjnn0CdKJC4hcQ=
X-Google-Smtp-Source: ALg8bN6aCvJfHDZ/arzelyorZUeaRxresG0MORoNVuPOOaH7xlxYOTSsvtpPZK/HmB40aVs+havkmS7bLtR/ZVAVHVE=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr6496899qtm.96.1547640870312;
 Wed, 16 Jan 2019 04:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com> <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 13:14:13 +0100
Message-ID: <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the late reply, I just realized that I had never sent out the
mail after Lee asked me for a review last year and I had drafted
my reply).

On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> Some system control registers need to be clocked, so the registers can
> be accessed. Add an optional clock and attach it to regmap.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

This looks ok to me in principle, but I have one question: When we
do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
does that change the behavior of syscon nodes that are otherwise
unused?

I think we have a bunch of devices that started out as a syscon but
then we added a proper driver for them, which would handle the
clocks explicitly. Is it guaranteed that this will keep working (including
shutting down the clocks when they are unused) if we have two drivers
that call clk_get() on the same device node?

       Arnd
