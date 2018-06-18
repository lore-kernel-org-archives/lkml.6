Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCCC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A391D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRvkTb8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A391D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754998AbeFRGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:37:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44358 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754971AbeFRGhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:37:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so15476508wro.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kdt3zDXVYB+Wq+rmjJBe2U7vGkPu6F0zuH6/mce9fQM=;
        b=KRvkTb8r+nSolalp1KhNKBaHyxXlBKCkrAleexHy1JSI25PfbyZ+Ng6h3ORcCeja6v
         Y+uxByPvriy9BnQLTcTfltNm31/b/97uW0/3bhNPZZ9IwFT+z9XEamYxJwxo7bhxJdzf
         LUmqIIpZgu8Azp+rVhLCXXhF24W/3ziYEqmbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kdt3zDXVYB+Wq+rmjJBe2U7vGkPu6F0zuH6/mce9fQM=;
        b=Wpkao/fpjjAgwGmNTiNEtsH/5NjvqBDRu+Ut3YPKF8vv4YsVwO04AWKmWBquuZb3c0
         fHMHxa7mtDMfXGFCyQlyOS9mKwqNUpYs9Z1eOsbx5I0tKPyWIMGjooSGK/pGvNhakZLa
         jwc/KVAJnkxazJh2r0NzKjePWMKif+jmjVsXL9zTMmB+FiLAF4FCZd2ZcqEpg2XdULUy
         67FFlXNJaCIgk7SSKhdMdhdBWsQvCrR9Z/hQjpoYrMBSDABcpqx0ppHgK0o2ekscaxPU
         uWljoMN7Fc4AMh037aOYUQS0fRdxMn15jy+ZvaZmkD/PVEVvaG2zgLsCtk4RiYu5l5Nv
         dzQw==
X-Gm-Message-State: APt69E35CRpjezf/U2hzq0/BU2mUgcaF5DdJdQCs6fbr7eriJRxP94+X
        SeUJXqoHy8wakst7aRdX9C+dLg==
X-Google-Smtp-Source: ADUXVKImuVMMTXgUcSmnMHIYwu3sV3T1IIJqlLK0Fr3Cneyrdwih8TH9KlQASSes+BizAPdJfPsZEQ==
X-Received: by 2002:adf:a419:: with SMTP id d25-v6mr8975549wra.121.1529303872228;
        Sun, 17 Jun 2018 23:37:52 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id d5-v6sm16702778wrp.64.2018.06.17.23.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:37:51 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:37:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] mfd: cros_ec: Add or fix SPDX-License-Identifier
 in all files.
Message-ID: <20180618063750.GH31141@dell>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605175429.9072-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2018, Enric Balletbo i Serra wrote:

> And get rid of the license text that is no longer necessary. Also fix
> the license as sometimes doesn't match what the header with the value in
> the MODULE_LICENSE macro. Assuming that the desired license is GPL-2.0+,
> all the files are updated to this license version.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mfd/cros_ec.c                | 26 ++++++++------------------
>  drivers/mfd/cros_ec_dev.c            | 23 +++++------------------
>  drivers/mfd/cros_ec_dev.h            | 16 ++--------------
>  drivers/mfd/cros_ec_i2c.c            | 18 ++++--------------
>  drivers/mfd/cros_ec_spi.c            | 20 +++++---------------
>  include/linux/mfd/cros_ec.h          | 10 +---------
>  include/linux/mfd/cros_ec_commands.h | 10 +---------
>  include/linux/mfd/cros_ec_lpc_mec.h  | 14 +++-----------
>  include/linux/mfd/cros_ec_lpc_reg.h  | 14 +++-----------
>  9 files changed, 32 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 58e05069163e..5b6a1c541543 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -1,21 +1,11 @@
> -/*
> - * ChromeOS EC multi-function device
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * The ChromeOS EC multi function device is used to mux all the requests
> - * to the EC device for its multiple features: keyboard controller,
> - * battery charging and regulator control, firmware update.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// ChromeOS EC multi-function device.
> +//
> +// Copyright (C) 2012 Google, Inc
> +//
> +// The ChromeOS EC multi function device is used to mux all the requests
> +// to the EC device for its multiple features: keyboard controller,
> +// battery charging and regulator control, firmware update.

I must admit I haven't seen a great many patches like this.  Is C++
comments for the SPDX header *and* the Copyright text the done thing
now then?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
