Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0955C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C92473F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7Tt9Gmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991C92473F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeGDHEm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:04:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33987 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbeGDHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:04:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so12203916wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lsCHGXZlRttPuZ6p24BypbQnoibzMxlubJOo2nkaUNg=;
        b=i7Tt9Gmpy1q4JIQVwbJQRYuy89IHEENbHEnScDhqaYA5XU6U71Hj6AuZqvTGfbeZ7J
         7rDTXm/NfiWDzMScfXM8p6XgX8nlTS8juoL0HMPxpVcORD4C4WVOXeDGPmgGzDSUpNfb
         ZccmrVrnljHGW2+HQZKqDq09DMeP0IF5bubAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lsCHGXZlRttPuZ6p24BypbQnoibzMxlubJOo2nkaUNg=;
        b=DgoYsSI45t3ZwzvcSWjSCycHCTHvdVef+DsLkPRo3rQlf+PKKeFPCdhfSm4sRoTMsA
         JGeTa4iBKQBz6eHrrlULNzQzWPskkcfUkRFqJrsQAdKRE9Hh5smDPWuhtcl/B9nKdNpj
         TIztbERMmU8yD4X7sSRSbRyH6G7JB3R1FcfrfzFt2gX+APV1RYJ2evKl6FQqdvRrJwAg
         8A9NUu7MRRxVye3jAGe+DoCyyv1hcgHCZmWrjS4nubBc274r32xsrY4A+2DmFqMGapUF
         3IXm49+bzfy7qD/04h8QtGv/D8FXDC+2PK1oCd8a/S7TGwBGQ0uID/JfLJ4WDlRo+fuu
         H+UA==
X-Gm-Message-State: APt69E3rKala3yN//vhCD2ntXgO/NKcDr/ITGAv8j5BSYYIbCn2WPTgL
        x5HzpMzH1l+s7YqXSf7oR47IVQ==
X-Google-Smtp-Source: AAOMgpfWAM885FjvYRavlcE51kB0lrquGnGaTfuyWO8GFaG7kgTwxZ6XmZ+fO6NhEMsahFnaePlwgQ==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr771864wmd.51.1530687875768;
        Wed, 04 Jul 2018 00:04:35 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id h102-v6sm4676679wrh.60.2018.07.04.00.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:04:34 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:04:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 09/10] mfd: 88pm860x-i2c: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
Message-ID: <20180704070432.GF20176@dell>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-10-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620051803.12206-10-peda@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Peter Rosin wrote:

> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
> sit behind a mux-locked mux, the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mfd/88pm860x-i2c.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

If Wolfram is happy with this, then I am.

Since this file sees few changes - please merge through the I2C tree.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
