Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZR0FbG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5309A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJIRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:50:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35926 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJIRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:50:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so1240969wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WWyUQHXzTbDx0RhugJsrtwEIz5ngsvW1C088vvfrAMQ=;
        b=bZR0FbG2ofmpDwHXkeumA0Zg0h2OlbN18HHIJ5SB/bn12/46WIsUeehgEAoc4fmnMt
         2WdhwkMK1+uOcLcOBdGdp5cnXwU9ANsxMQR7ppF8NGojAiDbEOZWhDbO2igGF4pbhttt
         9v/PYMfOiNiLRVVTER/Axm3S/nXwMFz1EecuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WWyUQHXzTbDx0RhugJsrtwEIz5ngsvW1C088vvfrAMQ=;
        b=JI4cfWCFJc+B+DT5bOk23w+RPFEgYvqQBg7bdS9RNiB2V/yQJ2DflJJneYkMnyUMuO
         bMBzzwcBYBbDcmwZjLmDpriRddcSIrepI4P8wWMENNc9JQHIt3vPCUTQLPE1MJJlJCWY
         i194yxRLtEBDL1oDi19Nb99imQNBJxbGuz6mZke4jhwxq65wRJrfy1tl1DI2yL7CMCjp
         muIveNEwOas0XdUgKJaKHqmL/sBzkZE2jEJE86lWRi3KkXZVSCW5HWpwjet+1yTkFmVc
         ohtZHhXFh4TqEij99wfrvRHKSl0Di6PuVtwcB9/c47e6493gUCraAgf1T70ky5+/Ph2T
         8eqg==
X-Gm-Message-State: ABuFfoidx77XGDoG+37DiLqOO/hDEhYPkGXa3FU8ULxoGp+x7jqZ9TTI
        PDgZxH0QntfBksPAwZxTWfsHrQ==
X-Google-Smtp-Source: ACcGV63MpFQajKB1j2/vbPWU1QLX31yT7TKzCxwyGcWp1Y1UVqpEBLh+rZZxl1SzqSD5RTArVPRbXA==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr19007147wre.11.1539081227069;
        Tue, 09 Oct 2018 03:33:47 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 77-v6sm25876197wmv.6.2018.10.09.03.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:33:46 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:33:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v4.20 merge window
Message-ID: <20181009103342.GR4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v4.20

for you to fetch changes up to 7a39915b723ae46e78c5189dfb3fc889df976a8d:

  Input: ti_am335x_tsc: Mark IRQ as wakeup capable (2018-10-09 11:28:31 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v4.20 merge window

----------------------------------------------------------------
Vignesh R (5):
      mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
      Input: ti_am335x_tsc: Mark TSC device as wakeup source
      mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup capable
      iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
      Input: ti_am335x_tsc: Mark IRQ as wakeup capable

 drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
 drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
 drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
 3 files changed, 34 insertions(+), 14 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
