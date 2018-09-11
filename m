Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7AC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb1XNfG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7AC20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIKRjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:39:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34042 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeIKRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:39:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so7717820wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CPtzFACY4su4BfPig6c8W/3c4FETASJAdffNr4W/0oI=;
        b=Rb1XNfG81Bm5xsNkb6ZufAPXrewfxh52PUdcouWKGxnWiQm3/MIVGDuPYPRUZPCWTV
         4AZt1d9HpG7/lgh22n6KCb+NK/n5QBj0Dxoq3ssTzHaR+sM1dLVqQ2k5K/o/fZyfGrAU
         zA+AjWuKJdUrzH1WYl7lUCBD0j0GBigLe/VbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CPtzFACY4su4BfPig6c8W/3c4FETASJAdffNr4W/0oI=;
        b=nvwQ5hDT9NMrTyYtBDxuO6s4/rRBlQloZXHdXBJ8B/nT7RNN7AczW711l127y7uxB0
         RPiAkiK8L0ePsbPo0Qpkzw52jInkBukLqCIUZ5I/nIyKMebyPlbnmvJTy41hUvRLP89S
         mUXS/+DMIC5jQqfyHAqZJ2tVXCrLsJpMhsYvaJ/V5vICgrbR1rLd6tKzJg7EEsPwPHpO
         Tp39PVnktB3C5PA75oPPnQJOmxmSNO67a6+WhEdSuQxfk0K4h28/bIL83KZdciLP4L7S
         28SiZMcxk59+VjGZ3USgwg3DOlhvssUaKg/noSG8uBm8zL+zSzVu5YSao4AkBb+TR3GU
         FMoQ==
X-Gm-Message-State: APzg51C9RhbFcPDQTA5f5HWlWN96N8PcfuzncZmBl34BIY9nnt4rzTMO
        VYFnlWfL6S0v4qhYsud+YfhbjA==
X-Google-Smtp-Source: ANB0VdY4jRuS4FFGjtlMth3mEQ/2DOWQPaBz5s9PaTlWCvMEkUoLfNtRJtd48EQnXYPyOuAFatbscQ==
X-Received: by 2002:a1c:4904:: with SMTP id w4-v6mr1346603wma.0.1536669632280;
        Tue, 11 Sep 2018 05:40:32 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id p89-v6sm30411133wrc.97.2018.09.11.05.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:40:31 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:40:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180911124029.GO4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Matti Vaittinen wrote:

> There is a HW quirk in BD71837. The shutdown sequence timings for
> bucks/LDOs which are enabled via register interface are changed.
> At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
> beginning of shut-down sequence. This causes LDO5/6 voltage
> monitoring to detect under voltage and force PMIC to emergency
> state instead of poweroff. Disable voltage monitoring for LDO5 and
> LDO6 at probe to avoid this.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++

>  include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
