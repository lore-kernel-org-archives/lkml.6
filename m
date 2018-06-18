Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A749C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctilGNk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1089B208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeFRHp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:45:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45819 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754909AbeFRHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:45:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so15666043wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oGXmg582+0PdNR58R598T3ioDRO+qPuP1L6AWg7LxF8=;
        b=ctilGNk756CXDpAQR/U0Rl0hl2snTmeB2C3A6pjWla7OjmFveiytBZGunaJ+JaWcdE
         Je1sshpQLl1Jxgt+Y+tBcmoUSy7OEmAUMO05Z4O/RD2D2dXi5gZQAP0xpigDvLcCJMHP
         gay1fhLif/RA7NUSEJW+UabdP+l6rHkumxTd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGXmg582+0PdNR58R598T3ioDRO+qPuP1L6AWg7LxF8=;
        b=RMKX4pRXZQmQEXhbfa7SC1aBqHJYoYSPhq/4VYUSPCHIfxJoPPSUYvA41npHpcahBm
         As+bkfySDqeukq9+EBHAb4OV0qnvyRFSPbE73Uj7rwmQ9e2kb+dEeYXfVMjdq5y07WYR
         tqJJO+5Ux0f/C4eFsNpchfjMYEw6Bb7MfHzSW3Bo6rdpglS7fkdgkMZJsGd0ej58eXo7
         xc1toNQiAs/rzJWkFvdwp5DFXGzlTeB2FzBU3uFzkZ14HsXrhQVAKm6DCKdThDBxSmyP
         xethOHkSBiCQ0ioezL0stz0Y4lYh3YqbWw83zE9KjIwtZys7EVK2Kd1dCCB/9Qr/q3uR
         58/A==
X-Gm-Message-State: APt69E0cknChyD7lTPlySHZ6HynnLD9dxptN1CbWlkNzP51xMyHyPguY
        l13i2ut5olwN60RuzGpC6mxUNg==
X-Google-Smtp-Source: ADUXVKJBc1MBSX4CmwkLwIkP5mo0euwCDdjO4rIo8HTMnt0lIXHK/mTywrB1Qiu8nxzs5hkHAu4FKA==
X-Received: by 2002:adf:b89b:: with SMTP id i27-v6mr8689949wrf.163.1529307923331;
        Mon, 18 Jun 2018 00:45:23 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id v68-v6sm10051073wmd.12.2018.06.18.00.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 00:45:22 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:45:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v7 4/6] mfd: cros-ec: Introduce CEC commands and events
 definitions.
Message-ID: <20180618074520.GL31141@dell>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-5-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527841154-24832-5-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018, Neil Armstrong wrote:

> The EC can expose a CEC bus, this patch adds the CEC related definitions
> needed by the cros-ec-cec driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 81 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
