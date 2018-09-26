Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC05C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850A121536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SV/cMuaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850A121536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeI0EmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:42:21 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35437 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeI0EmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:42:21 -0400
Received: by mail-vs1-f67.google.com with SMTP id l3-v6so378155vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIf5qG6HxpksA8wW/Isodofx+oxHrFutWJoiOUUJ2TA=;
        b=SV/cMuaZmddg/smNIXobF25XnArePErTX135EPcfmOZDkA53BoWtxSft3ggEcgg5LX
         5gO0O4+3t1kyTqIzDzMxRYEtIdP6ukSNGyuAQjmwRRktRrCOjuMmvN2MWOHBoACgF8Z3
         MWjh3DPwqoPeyK5ou/NH1HNlqaXnSAl5RAUP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIf5qG6HxpksA8wW/Isodofx+oxHrFutWJoiOUUJ2TA=;
        b=CRqL7MA72llmCC5Up5miCbEoVwgcapLUgBD1FrO2jYXqIV9Hle0qWgmMlSXdJ3nYa2
         L3KTzkrt53LciyEEzorjMltqr9ikXH2+UjVA8j8aigxwRdWV7UEYw7ZXsOa3cpohZcVP
         5FyzOPa/a4ocY6n/1pxfwKcHPfmWud5IMr2ZyF8wDgNsVYRyIuw2RQLfI1MP3cI1ta6f
         vp/HUCSRCVwaOzZJCr/hRZf5tyl5JHOENrA03z/cz1tFQqX8Q2UzhYVJzLGoS1PHq6qw
         KjAW5Q/TS4ExBXt4dwSmrojFlBjRMdOEQ4Ag9JbC2WfxRTwGrNt/9LYF81/JD9IIdDzy
         a7kA==
X-Gm-Message-State: ABuFfojKgcC3P20lUHEyoi2KzTSfl6yg2HjSG/yrDkshvco+W34MkmNN
        LLslPJPwjlFmcYnE3fzUVUq4sN5EyZQ=
X-Google-Smtp-Source: ACcGV61jjsNQvsvKt03u9JKah1qXyfT0N1mrWeTFrfU6X1vMRvzFkBQ5eFrikd/+/HJ+adhwrs/XlA==
X-Received: by 2002:a67:4447:: with SMTP id r68-v6mr2485101vsa.38.1538000832333;
        Wed, 26 Sep 2018 15:27:12 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id v123-v6sm35727vkb.42.2018.09.26.15.27.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 15:27:11 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id y22-v6so347055vsj.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:27:11 -0700 (PDT)
X-Received: by 2002:a67:1141:: with SMTP id 62-v6mr2424367vsr.213.1538000830773;
 Wed, 26 Sep 2018 15:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180926205204.184898-1-ryandcase@chromium.org> <20180926205204.184898-2-ryandcase@chromium.org>
In-Reply-To: <20180926205204.184898-2-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Sep 2018 15:26:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUiL__kts+QH3AZpA61p_adc7j3Ai1_H5VcMjV_MLOgQ@mail.gmail.com>
Message-ID: <CAD=FV=XUiL__kts+QH3AZpA61p_adc7j3Ai1_H5VcMjV_MLOgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan,

On Wed, Sep 26, 2018 at 1:54 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
> controller can also operate in Single or Dual data rate modes.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Corrected QPSPI typo
> - Removed setup function and moved configurations to prepare_message
> - Added __maybe_unused to suspend and resume functions
>
> Changes in v2:
> - Addressed formatting feedback
> - Squashed bug fixes and features from Doug
> - Now uses transfer_one_message instead of mem_ops
> - Fixed suspend/resume
> - Added spinlocks
>
>  drivers/spi/Kconfig         |   6 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-qcom-qspi.c | 598 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 605 insertions(+)
>  create mode 100644 drivers/spi/spi-qcom-qspi.c

This looks good to me and addresses all outstanding feedback I'm aware
of from v2.  I've also tested this patch and it's working fine.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

NOTE to Mark: please be aware that there are currently _two_ SPI
drivers in flight for sdm845 since there are two totally different SPI
IP blocks in SDM845.  We need both this driver (the Quad SPI one) and
also the other driver (the GENI SPI one).  As I understand it Dilip
plans to send the next spin of the GENI SPI driver some time in the
next day or two.

-Doug
