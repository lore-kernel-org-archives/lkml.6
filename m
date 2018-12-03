Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FACC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6342145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8sRG7BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6342145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLCK6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:58:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43451 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLCK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:58:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11609977wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SMXzOxGIwI7ahh3+C69RbZ5VL7nSNipKvcjNbRuC2L4=;
        b=Q8sRG7BEhrJ6uvPcRyvE213xFpk82ymXAHSWaygF/ONuxpByOeON9LXEoILuWuSAde
         YWviQaz3yo9BdbGBNUX0WK/TTZW2u1PBiw+BDxn9zoJgDgji1UZo/2Uu5tgHmXo+wyBr
         vfbE3Ng8TpfNZURKbU0EhO6dNjGIpqLlZ7gwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SMXzOxGIwI7ahh3+C69RbZ5VL7nSNipKvcjNbRuC2L4=;
        b=iBiGH7lULqrgqLHKffeyWdlGdmZ+fZtVBjUj17XVH5XV+k2s1Y+Zw82VwtDfr9k9AE
         82pTPA0PfBZFDBqmDw/5sQKy7zz5XJMj3EuAfpA6Jl7AREOzlLCrVtAinBHMV1mcj7i6
         WZUlaUD/y5EvtKk7BojiW8tHR61TuAFpSUbshMTAD7jUwCiunURHdSTmywTwuWL7le7t
         bfCQPYM21W04QndtL0SOq/B1vat3JAu43Yx8VZ281lbYVZNW06ZMVazc1lmfcXkdAKi6
         159hurtCWOb5CjNetXNAtXRRoFmFUqawKmLYTeRA9eXBDTPJyMYiUPP5X1dIdn3e5l8P
         MRgg==
X-Gm-Message-State: AA+aEWZVEix8hKOlIWdgNNh5pXuf/jKo5v0bZ378eXxftvywhqX+N+jg
        oeCjYc3uWrLn3Hrz5TK6YejyCg==
X-Google-Smtp-Source: AFSGD/V3LE0BfvGfeOd5c6t1e2LGaxRCG2lCQYA8dVsDeVz53QfJuViEw6OmK1jjriaZ2VTnJRARRg==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr14097274wrv.188.1543834653509;
        Mon, 03 Dec 2018 02:57:33 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id p6sm10750987wrx.50.2018.12.03.02.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:57:32 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:57:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 6/8] mfd / platform: cros_ec: instantiate only if th
 EC has a VBC NVRAM.
Message-ID: <20181203105731.GH26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> The cros-ec-vbc driver is DT-only and there is a DT property that
> indicates if the EC has the VCB NVRAM, in such case instantiate the
> driver but don't instantiate on the other cases.
> 
> To do this move the check code to its parent instead of play with the
> attribute group visibility. This changes a bit the actual behaviour.
> Before the patch if an EC doesn't have a VBC NVRAM an empty vbc folder
> is created in /sys/class/chromeos/<ec device>, after the patch the empty
> folder is not created, so, the folder is only created if the vbc is set.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Fixed build error as reported by kbuild test robot.
> 
> Changes in v2:
> - Remove unnecessary IS_ENABLED.
> - Remove dev_err message telling that VBC is found.
> - Use dev_warn instead of dev_err as the error is ignored.
> 
>  drivers/mfd/cros_ec_dev.c             | 19 ++++++++++++++++++-

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------

Isn't there anywhere better for this to reside?

>  2 files changed, 18 insertions(+), 17 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
