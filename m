Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436802148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKAVPvjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436802148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390283AbeHPMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:03:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37388 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390251AbeHPMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:03:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so3614162wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W2UMAOafJSBzRTCPSM2It0MYgvM5tHJLFSvFLYlnx/U=;
        b=jKAVPvjWk34WtbsfGXx1FXhDuUblnqnL8zqdfiNPEYqvafl6Zup6GaWaTSzw/uTWHu
         1SLRoWr9erTONw6DlcARTH6eB2/iY6wOGIagMonIWixR4MtBoux0A+wPl74AJfF/uC7h
         kh+uuFr+SerkHtGfCCi4d4U3iyNVj1TcK07rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W2UMAOafJSBzRTCPSM2It0MYgvM5tHJLFSvFLYlnx/U=;
        b=HjB0VCG1f1BwWXsaRUVxI8i9wXXdebAsxiALiYuA6CeKel1EON66nujnHA7juEJWw0
         KSGryIdvHhKoxXdihWuliplLjiMQvoVQ+tTGEht2ZVEHOHGe8c/Ly5YreSCJiZuRRRmY
         +y98MTVTnnFdXTp9W2cC4JXXBelyjmkI476prpbPBVo1vZosEfuUPlYxLQz1aRgNHhDo
         YSkjrYdyogy4nSYNv9eJwFQsRVGeJchsn7ygmlbEL+9VkTtUk7dRV2+LSp/9tZMNUhz6
         UlGHAQUbPXEu9EQWMqy+zww2K1RvFsHtxSx5U8KMTxT9tmTJR1wOxgR7asmgBJ9swAFT
         YF2A==
X-Gm-Message-State: AOUpUlFFlC47cr0zq+k0/l1NI/g/mn2ipg6qUCBf0N4n9KN1rfdNdE2y
        20tGNjEtivt9gh7BlR1RIjm6ZQ==
X-Google-Smtp-Source: AA+uWPzOmKbgPUjX9OeCE4dxHuu7VYmeXR4f7E50W0d8OBc4IQlitlrtZtsYP9zNCFIZAScUtr+/Cg==
X-Received: by 2002:a1c:c7cb:: with SMTP id x194-v6mr16145305wmf.117.1534410381847;
        Thu, 16 Aug 2018 02:06:21 -0700 (PDT)
Received: from dell ([2.31.163.71])
        by smtp.gmail.com with ESMTPSA id h14-v6sm30242708wro.15.2018.08.16.02.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:06:21 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:06:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com,
        linus.walleij@linaro.org, mazziesaccount@gmail.com,
        dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v12 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180816090619.GD10054@dell>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <d053f54e5ce726ffaa95fbd9c20962a49dd1ee07.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d053f54e5ce726ffaa95fbd9c20962a49dd1ee07.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018, Matti Vaittinen wrote:

> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
