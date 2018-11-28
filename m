Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61320C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23296208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZ2mewLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23296208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeK1Uej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:34:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50645 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeK1Uej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:34:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id 125so1837808wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oa/hIsW//2XisCsX33C/OXQYWRPWhRO+d5V3m+w9gCs=;
        b=ZZ2mewLgAxZ7Fvu5dUERz0MYxvGu/4O9I99iU7c0PKpIn8VWND8U0fl6+sXGJdIbxh
         NxKxrtFSd2p+5uJzN33NWY4BPBLFXPzEuuWe7bDCo0l4TlnmIf1Pk0QqtGFm5NorKOGl
         DFHtkj5RcUNQWPYg9Es5yQsbk71K2yNXdG/fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oa/hIsW//2XisCsX33C/OXQYWRPWhRO+d5V3m+w9gCs=;
        b=YbYXpV+MDoxtOSUfGcqLf6GhCm7hJGzzGCcVsi3JT7sZk4kEgxU2dJvMCRNxnyRm/C
         qecKhsJ7a2cLL4aB/BhBEJMqgJ8BRUWTOqvt6gZT0oPV4eiXjb2BQ24AD3aziaPAT2cy
         IYLUgA17HB9BMb0eHv/1cLSZu25n4uX5rf3XXdCVlcKfyjZQ/zwLkNayquSYyQ6pnafE
         Ll2CExeptOnttWv4El4060Rjt/5i+079CJ1XzKY31HO9PBpmYKP8AWuGu36ewLSsNcf/
         GNKH+emut7EglGU+qo8oxpk+xT9rmmziYj8KBQcj6m3L4k4oFvAzVE3HaQR+9GE9wAWz
         6trA==
X-Gm-Message-State: AA+aEWabBncl5BKYz7jYZVlbm/NRnYel+HI5yCEiqEth/t2TJSYN/I94
        M2sWOpQtkY9ueXTPXuWYI9+KK5Cj0zw=
X-Google-Smtp-Source: AFSGD/UK0ml+25bBxhXwjIXMVcz2LS4muH3U3K3bI0x+OcQtvmESxSbocml9Sp5ZK/UXZqbZJNJKQQ==
X-Received: by 2002:a1c:16d5:: with SMTP id 204mr1993687wmw.148.1543397617854;
        Wed, 28 Nov 2018 01:33:37 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id h203sm4524605wma.19.2018.11.28.01.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:33:37 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:33:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 12/14] mfd: axp20x: use explicit bit defines
Message-ID: <20181128093335.GB4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The AXP20X_OFF define is an actual specific bit, define it as such.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
