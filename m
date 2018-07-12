Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8B6208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCazjq5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8B6208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeGLMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:35:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39440 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeGLMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:35:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so5794211wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kBZLPcFa72WGNuYk3Mmtlfkj8Tm7Awu3tpJXUOxMTU4=;
        b=bCazjq5oi/gnaHw1XQ4UdXLDdtgsm1eZBc3fB8wBFpFkl7jMitN/5q0lIxETIw4sZI
         4OMOGz4u16SlkKyyZQKvNKayWke0v8OdgJo3SgL2X1geiKCIPPoBgZNGuR/jIxXaINSA
         EZ6nV37Sxn/Lm6UZ8aMHAMN8V6zYn3qIYAtSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kBZLPcFa72WGNuYk3Mmtlfkj8Tm7Awu3tpJXUOxMTU4=;
        b=ri0iI24Wy5vIqs0kgengXRg+gTvVM6/oDVeZMY9TpK0FqYT5PIKxkPPF4k0Ezce6Cn
         0BJ5IEnmcwpt0fHKS451mBoFT82z8k3jOs8sFJRQ6IBrSayYyNKtSCyML9kZ4CX54UjK
         XQd1rjT3ZvVg1xY59TS2odQ667SBLN3NgYiWzpJEmKTRd/a6Ryb0jaTya+q32/AzMR0i
         ifG7s2Lf2SnSicJAiq9EVWbW5ghe6pERtCNowQKXzWkCORRxzCNhI9eMp/HZNRBYoUAX
         Pkkrb323oOJBz337vBObDRrMz0vX465Tw06g/gLadIu+300NLQbwjfFDKZeaqNVx7Yf7
         h2qw==
X-Gm-Message-State: AOUpUlHibx5AEyd7huAHWHd/PbTxvwKc0cd91YkwQXfOutMHGw/BX6TT
        GXW87PESqbZUDXDIRZV6kLEkiw==
X-Google-Smtp-Source: AAOMgpeumJhiJMSB3YK3UT1LmuCr2rEOarVtz+shOhlBG5/0/9Kf8JNHcvecElj3q4wYBCTGNN1jTA==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr1324957wmd.9.1531398381471;
        Thu, 12 Jul 2018 05:26:21 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id h12-v6sm2166319wmb.3.2018.07.12.05.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 05:26:20 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:26:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        Stefan Adolfsson <sadolfsson@chromium.org>
Subject: Re: [PATCH v8 3/6] mfd: cros-ec: Increase maximum mkbp event size
Message-ID: <20180712122618.GD4641@dell>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
 <1530716901-30164-4-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530716901-30164-4-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Neil Armstrong wrote:

> Having a 16 byte mkbp event size makes it possible to send CEC
> messages from the EC to the AP directly inside the mkbp event
> instead of first doing a notification and then a read.
> 
> Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 40 +++++++++++++++++++++++++--------
>  include/linux/mfd/cros_ec.h             |  2 +-
>  include/linux/mfd/cros_ec_commands.h    | 16 +++++++++++++
>  3 files changed, 48 insertions(+), 10 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
