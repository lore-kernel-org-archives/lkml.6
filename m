Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE74ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK0+ExBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892F4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeGMHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGMHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so15155816wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q1Wyc8E+YwDdyHTWuhKysjK2Jhbq+hANw9OpepHIwpY=;
        b=BK0+ExBEb1CbmtCkImJsFaTHo5+fpF66Vf99kJGeGs6zFEK2bG4WCLs/+Ub0ByTE4r
         JeP8ERjIp/mJ/+WDb9ZmowBOA2r05kE6huD9b0LDHh0nfsHL+/DbpLxrEMxyWUCt/ND/
         09gZeM9XB5WLnm/+fpFLA37hksZ8dE6MW0JdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q1Wyc8E+YwDdyHTWuhKysjK2Jhbq+hANw9OpepHIwpY=;
        b=Yk3x3/kPGV94aN/u82WauqZzDaiYlFjjUyLXcUWabpZUa9vMJkSOHyLhyovxDMMuqa
         kESLldzhKQ4auR4ciQOL42X9Su3y/S6ZMllntqPPXBrn5qa/ooDXsk634+aHSWiDUVf3
         1MnZ1+1RKNnYZkHDhfUC60qEGANlDA4Y2//eyq/pqD2tN5iw25+PQjUNb/TfNAe8J6Wg
         glNpNs0uHQGpSZ2B1gnRxDRGmtaSeLuoZ4OAo0HOJ49AQ//LegPiVR8cP4PIp0LdZ7ee
         BQgTk4sADxEg35ja6JejNPhLu618ZXaI+89LmHdSwkk7IYVrVEr7jUqiNzHebhnnyP+t
         eM4g==
X-Gm-Message-State: AOUpUlGS92u1zpTykXRnMHevC04IKKERhDC3lPMGpXMGarjQDL+JPFEI
        nsV/zF0dRIS/fbLQwfaiYd5PPzMSnrQ=
X-Google-Smtp-Source: AAOMgpf5D0/SH/YLI/jOEq0FIMYcr4VKGbwuUGhEtW3cGi/Jow5Lz1+83FV/g2R032KEKEjdTj1Zmg==
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr4019763wrq.116.1531467080838;
        Fri, 13 Jul 2018 00:31:20 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id u3-v6sm12867174wre.21.2018.07.13.00.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:31:20 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:31:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 5/6] mfd: rave-sp: Add legacy watchdog ping command
 translation
Message-ID: <20180713073118.GQ4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-6-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-6-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> This is needed to make rave-sp-wdt driver to properly ping the
> watchdog on "legacy" firmware.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
