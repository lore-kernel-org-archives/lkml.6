Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B31C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F126217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PoVJYaGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAXBTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:19:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47098 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfAXBTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:19:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so3030730lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYOSbofglNAJWY1LRY85s+aLYj+xUOL7/6KVkUK+Pzw=;
        b=PoVJYaGNEN/zJ/WXkOQ9cB6ZJJWR45k0RsxtgpejetNq9FcuMaAcmZ7ZUViEZkm12u
         OhxyhkZtntz5lBG5RNKP6LuWQb9yXjYNODug+3WMF/1bg/4e+3DxjQnDDoQoSFVkJdY0
         BCQQNuH6U1vdU1GOUjaQE5bRE3RETyWDRTIjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYOSbofglNAJWY1LRY85s+aLYj+xUOL7/6KVkUK+Pzw=;
        b=UhvpRBlreRCdyhqeRM2Ol5Ly3buLUtfwtc2Ruy8wHMQo2+syh6lLiZFYst6La4uR83
         CFivVaCbvVP1GrI8ArZagEg/DvHQwfHcS+l+O+x6+RdH7EgrONUnN2mQ0jUZmAZF5cZ/
         os5j5AkgzI9WYBUdZOzkrzV3UX0MpZJ/nBQg4HY/3Ntr+MA4cRK3rdMc9a/QzYtVch4Q
         nNwtrJwEYYTqiqeKn7kX7KNsX8yLDNgDQnycyhFcP8x2Enw2uvKqcqeMYhRWW6W827La
         zoabLxK74l7xSfzILYLk7qLVejTA6+ToFrIonb+yKk757TRnKDzD/nVek37rzzgEDRHN
         YvNA==
X-Gm-Message-State: AJcUukdsqRSkUjy54Im0uQb+tJrAL9EnmxiWJJnMWu/s0iPXYW5XQcyb
        JUDydeX/97RRIpLFE6BkV0EJ4vYe8/Q=
X-Google-Smtp-Source: ALg8bN5ZHexTQhADLOsUda0ADSXH7QHk04ICvbF3qOfvp3YvE5XevWn5081dVFDkUoCOxneet2kgyw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr3583943lfb.72.1548292787667;
        Wed, 23 Jan 2019 17:19:47 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 85-v6sm778581lja.16.2019.01.23.17.19.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:19:46 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id f5so3030691lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:19:46 -0800 (PST)
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr3639684lfe.154.1548292785963;
 Wed, 23 Jan 2019 17:19:45 -0800 (PST)
MIME-Version: 1.0
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 17:19:09 -0800
X-Gmail-Original-Message-ID: <CAE=gft6dT0HXzrmberdGg2nS-hp1M68mzbxJyEBOmdrh5x1p1w@mail.gmail.com>
Message-ID: <CAE=gft6dT0HXzrmberdGg2nS-hp1M68mzbxJyEBOmdrh5x1p1w@mail.gmail.com>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Get the interconnect paths for I2C based Serial Engine device
> and vote accordingly based on maximum supported I2C frequency.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc..e8fe63a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spinlock.h>
> +#include <linux/interconnect.h>
>
>  #define SE_I2C_TX_TRANS_LEN            0x26c
>  #define SE_I2C_RX_TRANS_LEN            0x270
> @@ -508,6 +509,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       /* Set the bus quota to a reasonable value */
> +       gi2c->se.avg_bw = Bps_to_icc(1000);
> +       gi2c->se.peak_bw = Bps_to_icc(76800000);

Can you compute a real bandwidth based on the i2c bus speed, rather
than some max vote?
