Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2CA208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWzILbBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2CA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbeFRHSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:18:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55118 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754876AbeFRHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:18:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so12189919wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n9xnzpdkLNBJO5Xwx/8IeDOPaVfjHcW3zJhg4CEDOes=;
        b=VWzILbBVQbJJncok+xiLkzlwkK/02ZaYiLTSbFDEzsjZfEybR1YY01HlykLUtFbSKj
         Box1tP6Md5LZ3WwDoaJl0oVAmKxTXS97vn+NjaZsXKb8VaOVNMfxoWOuvWZVTFOi+NsN
         FK13d4SUCCsyjDuo+VJQZlLim2Uo9Qzvcj9K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n9xnzpdkLNBJO5Xwx/8IeDOPaVfjHcW3zJhg4CEDOes=;
        b=ZdmoOwbBm/CPkWXY8yYOH7DCQSLxqpsHt8WQYvAhp0NlJzHDHffsFZYR3T8E858xgi
         ZJOtaL8Q5qiMTLH5FGKegXq4DmDc1TJjKfhIfTbGzpmUFbqx/vB1w8DWKSxqWCORYCEj
         OQdq/I85bc8Z2Pq4qp1X7AgUXLKytYlD9M7mps3k0dkPMh+ynG3KTtry3y0GW1M2vzyj
         P32afnxTeTx/rKiRfROpS/eOUW3axAxdZudnBrgaEQ37062/aH2CZO0qA+DM+hFR5dXE
         6YFlJ85wEn33a+b3kw2TuLyy3EeOeOSIUF6VmCHJ1sTs0gInCf3cBsLI1PxmqvH9D2W4
         7uKQ==
X-Gm-Message-State: APt69E1E1xxZH1B27Z79sIb8iI3PKbw6zsjVe6eaMCuVyDvb0RwGFpSK
        pj2kEtwZ/tZBWwfFqvft+Kwjwg==
X-Google-Smtp-Source: ADUXVKJG7JIPqP3aMgAQRvqu88xIdGywlOAWIwEgGbUylxiGg0MhZzEqr6IfiXTz2t5FwCwghgkdEA==
X-Received: by 2002:a1c:1389:: with SMTP id 131-v6mr7706161wmt.65.1529306283826;
        Mon, 18 Jun 2018 00:18:03 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id y3-v6sm13337250wro.21.2018.06.18.00.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 00:18:02 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:18:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 03/12] mfd: cros_ec: Make license text and module
 license match.
Message-ID: <20180618071801.GI31141@dell>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606150900.8342-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Enric Balletbo i Serra wrote:

> The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> boiler plate does not match, go for boiler plate license.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec.c     | 2 +-
>  drivers/mfd/cros_ec_i2c.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
