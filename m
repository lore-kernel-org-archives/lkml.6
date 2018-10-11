Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA51C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4AA2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsnii21m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4AA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJKNNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:13:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40011 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:13:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so8150319wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BL8Rwo+brn9XQAuRQN6C0Mckm0OEWveZNlzdLfJZiZY=;
        b=fsnii21mfkzs8KnJx829x/FfQZElUBLTWupo/oy9cydSOSPtzgp0bN4lKZTzV647Er
         8ytHZgQRt9pjNqU3RLPBvASfxgwX4rpLZvFNWOgtDGsSFnaV0T3gtix/rd/M+vCk9/w4
         0nzLrPUAifMEyqj8a/sVjxZJhl2x67Qpj4t74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BL8Rwo+brn9XQAuRQN6C0Mckm0OEWveZNlzdLfJZiZY=;
        b=b7hOmTIrbR8KIGEPrZJluSo2xiXB/UNV07U6vKixrelvE5l0DX01ysYMzrdwD8sjLO
         EJN/Y6Zdrwz0izaOyyZCcPGKkrsO2tcgj2RHz+b8eQi1BoAu8ivHHrN1CGAJPP8/H+S/
         ok4LPzPFKJygPnHENv3aHG1o+zYgoLez2mmSq1XRUjrmVY4+5VhCJUjjh5J2CzVrjvsv
         mtwr2/v5OsaEtaUl92MIGQ+9lkvMoGJvWPuD6fGbkJpY52t2tykkle3yjHCGY8z58MSM
         fZz596ncTRremp4on/DYhXLu0rlDhjjo20r7PS5YijcPTdNw2yuOzOspyFwok2sSehVb
         77SQ==
X-Gm-Message-State: ABuFfojQnasWzdhH9uzDJ5VfozNTV8LATA7Ly2bbJ3S5Vwvtv20Ovr30
        xFBmhoMRWOBI/ORVNbikoz7NjbV+Kcc=
X-Google-Smtp-Source: ACcGV62F/T90ffnuMILBxuUDjmiIT0Ep+3pcs4T+6/HGREG7OVcsF8GBZFyyS1BzMtEq3MTvS+ggrw==
X-Received: by 2002:adf:e152:: with SMTP id f18-v6mr152678wri.42.1539236889953;
        Wed, 10 Oct 2018 22:48:09 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id z12-v6sm13143201wrv.46.2018.10.10.22.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 22:48:08 -0700 (PDT)
Date:   Thu, 11 Oct 2018 06:48:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: remove redundant 'default n' from Kconfig
Message-ID: <20181011054806.GS4939@dell>
References: <CGME20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb@eucas1p2.samsung.com>
 <20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Bartlomiej Zolnierkiewicz wrote:

> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/mfd/Kconfig |    6 ------
>  1 file changed, 6 deletions(-)

The change looks okay to me, but I would also like you to include the
Maintainers/Reviewers for the affected source files.

Also, I assume you are not just submitting these changes to the MFD
subsystem.  My suggesting is to change each subsystem per patch (as
you have done here), and submit them in one patch-set with each of the
subsystem Maintainers included, so each of us has some visibility into
how the general idea is being received.

> Index: b/drivers/mfd/Kconfig
> ===================================================================
> --- a/drivers/mfd/Kconfig	2018-10-09 15:58:40.547122978 +0200
> +++ b/drivers/mfd/Kconfig	2018-10-10 16:49:37.575915230 +0200
> @@ -8,7 +8,6 @@ menu "Multifunction device drivers"
>  config MFD_CORE
>  	tristate
>  	select IRQ_DOMAIN
> -	default n
>  
>  config MFD_CS5535
>  	tristate "AMD CS5535 and CS5536 southbridge core functions"
> @@ -870,7 +869,6 @@ config MFD_VIPERBOARD
>          tristate "Nano River Technologies Viperboard"
>  	select MFD_CORE
>  	depends on USB
> -	default n
>  	help
>  	  Say yes here if you want support for Nano River Technologies
>  	  Viperboard.
> @@ -1575,7 +1573,6 @@ config MFD_TWL4030_AUDIO
>  	bool "TI TWL4030 Audio"
>  	depends on TWL4030_CORE
>  	select MFD_CORE
> -	default n
>  
>  config TWL6040_CORE
>  	bool "TI TWL6040 audio codec"
> @@ -1583,7 +1580,6 @@ config TWL6040_CORE
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> -	default n
>  	help
>  	  Say yes here if you want support for Texas Instruments TWL6040 audio
>  	  codec.
> @@ -1605,7 +1601,6 @@ config MFD_WL1273_CORE
>  	tristate "TI WL1273 FM radio"
>  	depends on I2C
>  	select MFD_CORE
> -	default n
>  	help
>  	  This is the core driver for the TI WL1273 FM radio. This MFD
>  	  driver connects the radio-wl1273 V4L2 module and the wl1273
> @@ -1649,7 +1644,6 @@ config MFD_TC3589X
>  
>  config MFD_TMIO
>  	bool
> -	default n
>  
>  config MFD_T7L66XB
>  	bool "Toshiba T7L66XB"

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
