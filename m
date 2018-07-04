Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F0523C55
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKwcjK/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0523C55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeGDNMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:12:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40335 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeGDNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:12:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so5689809wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EgiRNl9TLh7Ewd96pa2Io31lJ2dValneJDKdJwnSaVY=;
        b=VKwcjK/XfmKYzZB6N9G0Wz0RG2cDgx+5fUcy9X3xKKtQFszt3JA/MpPf90YSS8tGDi
         NA68TdvCeJaZIdzyWsnhbe0fDOX9L9eAGS5Yajl8M5sVB9L7sj+sql6yPKrWY7vsntYt
         a/vph1FtUQn2lVaMAhrh6jKPiO3RgFE0pZQZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EgiRNl9TLh7Ewd96pa2Io31lJ2dValneJDKdJwnSaVY=;
        b=H/aZY2xfX23BhuVMGMtzC0v0fJvzHIeh9uiI6ZUZJjClwe33q7xqnY9PrjmOUMNGED
         lWI0S3kVl0OWZKpqyFGFxB0Q7V0+NDGnyGWq/6+ptyZrwE9LQjJICkIxKXVLO0X+mZ/W
         w+AABLqxC+thCyrNRQmwJSvgm6Amfe8mbSEQ4jhYFuXTOrEDFmwTomTCDacqEsLWsdbm
         B6L+2bdScMeydUGBSkBE30Gg+CCg2aB3sDHganetCq0Lp68+01WYV+2+X+i7/MeKjhiJ
         0+1yh3y1nR0EkPEVtVYj3i7psI14kHtzSMjjPslsJHWXWmWF5yAjiayrRNvNICLN/One
         aiDg==
X-Gm-Message-State: APt69E3sRwnj/7TgG2UH9HzOWF23cjKAsuzUSsQlgGaggarFYGrQQNe6
        rNWNeGs0PgNiSuYrHMc/6r01HQ==
X-Google-Smtp-Source: AAOMgpc1Zj2hO96c7b5+jUqZmEqZ+CM7gv3y04/8WlM8ZW1eXd7r9pcyI7qRkLGdgeWGCVD6lufmfA==
X-Received: by 2002:a1c:ec1:: with SMTP id 184-v6mr1691442wmo.84.1530709965426;
        Wed, 04 Jul 2018 06:12:45 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id n8-v6sm6315446wmg.27.2018.07.04.06.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 06:12:44 -0700 (PDT)
Date:   Wed, 4 Jul 2018 14:12:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v7 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
Message-ID: <20180704131242.GF496@dell>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-6-git-send-email-narmstrong@baylibre.com>
 <20180704074717.GP20176@dell>
 <eef093a4-55ea-fb59-97ee-408abeccc080@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eef093a4-55ea-fb59-97ee-408abeccc080@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Neil Armstrong wrote:

> Hi Lee,
> 
> On 04/07/2018 09:47, Lee Jones wrote:
> > On Fri, 01 Jun 2018, Neil Armstrong wrote:
> > 
> >> The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
> >> when the CEC feature bit is present.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> >> ---
> >>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> 
> Should I keep these Acked-for-MFD-by for the v8 ?

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
