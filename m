Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1649C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B23521479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2UbV5RI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B23521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeGLMlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:41:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGLMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:41:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so8860000wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8GVC8nOb3xOC4MdCGLelS+AXxoKXYGfLRJFZH0wFqVU=;
        b=P2UbV5RI2YS4zFmyIJm3EVTmabHlJmtW7oAUO1pEt9K7PwOX70NO2TlK+8F3cf7j+U
         xFDp4zBeWSy4jzVaZOxr5ohjmb4piSwokmXc4LBzgyp/N3FF86OcfZdRQR+TBRwCzteH
         MZ/W3sG1dcx8ZyhAdIZ8JtHGqxjP5RnVEOxR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8GVC8nOb3xOC4MdCGLelS+AXxoKXYGfLRJFZH0wFqVU=;
        b=J4MRWnFQhZMSBcX1Ax0IZNpE1NQulVYAaGBcK4uZKMB+VS2tcrfqLh9U3aeV698QLy
         YftukzeMW3E8yrp3PisaRSrJZ6M67djra1OFSZ6Ez2c84K7GHJ0l79//hMRkapjAKwg0
         8/x/HFcog2o4UeWDSosM8AicjUo9K91FvsAOyekCSj9cbFCVAw3N6BW+2Yf3lHB+E8CV
         rkXxyp6H77+VeXFATqo5H1LtBJUAOfLAtNx3T/5fmqf3co1KTYDpf4PANcGkkXSzDyi4
         koGN56UScivUsuq+UPAT4bVZN1ukXuZE3vLNQLXFR8/+RT+uLvauXo69BJ6gTuiAr9yW
         +dGA==
X-Gm-Message-State: AOUpUlG/6N5PN52RX2rTMhCbt7JAyHSivVUmqitA6Cptj0qVeGLgVR/l
        mzLKyIAXkLr0rl0k0EZgIJuQ6w==
X-Google-Smtp-Source: AAOMgpfLpPRIafAna8UC2a8fRbrlyjUXFqT/87/QbmCjrL8MjrB95doyn0uTIONwo7Ad+eX2BGfOzg==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr1793033wrq.8.1531398729452;
        Thu, 12 Jul 2018 05:32:09 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 65-v6sm6463139wmk.46.2018.07.12.05.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 05:32:08 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:32:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v10 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180712123206.GI4641@dell>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <8ef84806b7152a4da2bffa0456052e98f4c6e1c6.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ef84806b7152a4da2bffa0456052e98f4c6e1c6.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
