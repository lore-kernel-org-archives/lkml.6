Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1CD3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EB6208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFN9Ct8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EB6208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934140AbeFMGLQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:11:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37064 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeFMGLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:11:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so1356220wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eF+23gm7dkN5QWNSLMUztmoBjGhponrIwCSrHVfpRKk=;
        b=bFN9Ct8yLY9VFtog/+HKohTQmIvLYJFzBbwd19ocYgJBnlTuA6gDgTMZcZ3jFkoolq
         yk3jMX674meUdSVrsHcBwQ9jFRMbO1uDmSx2SALgmqmdM13v6Y14b8FkORH8YCXi2IGt
         r/7ord35UvcwNUHaJ7TQ5gBYCaJxGbFe00H70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eF+23gm7dkN5QWNSLMUztmoBjGhponrIwCSrHVfpRKk=;
        b=LcxHLLzSd2WW+JA3QNYr7sNQ1TinMLvFO9A6tD285OVTXecUsePd3E+Mw1HaN1/6FZ
         jQrCs1IbnHn+HWoa7bb4pRybFwXJIYhTVhPLgw4nrTPXgToXd9veCk6Yb+1OMWjuc8Ky
         XoYc6RZYht+n2ZAP6/IlwkRwP7CraVHx5lrQ7MM1L3tC4lVkxa6A0HOPswbdMVXQ6sFB
         +w0eZ/W/dFhJNyN0DLDv+FWUnXNP3+b50hBfgYR9iZli+Z0sCPW5wXWwqF8sYUnSTi5P
         PgdqFvyRnP2w1pbovPAu4MqDCtZvzf6mnUkyJFeMAIt5JqT7nRm/h5aNur9sRUH9HIM8
         JLkA==
X-Gm-Message-State: APt69E30LBkw1ATIs5fn+tzkuufkd7HR8lQvKPFsTdeWz/cUorAoyXNU
        BWag7PWrlsoyHVohaQNvMn6+dQ==
X-Google-Smtp-Source: ADUXVKI0GlxC9RWbwv86qQUmT9VC9lyoMyzTy8B3fjg48ufgrke7+oFGtAZl2a2ylrpP2LT/sRcx0A==
X-Received: by 2002:adf:9d02:: with SMTP id k2-v6mr2846219wre.213.1528870272706;
        Tue, 12 Jun 2018 23:11:12 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id r75-v6sm2129231wmg.31.2018.06.12.23.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 23:11:11 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:11:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Message-ID: <20180613061110.GH5278@dell>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525171941.26766-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Radu Pirea wrote:

> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
