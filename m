Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8745AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431BD208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NR1tOnTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431BD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGMHof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGMHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so24058030wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jPpNVrZb6VOKYGEgEypjJrq16i/E7PEMPIuc+xOvGjU=;
        b=NR1tOnTrG4H8O+ta/OUukn3VpSB9XT5TnzgQQT9VoZlYjpiyZDfjB8+yxBJwzL0jBd
         hmiaLMqy6+mmc9rzYx/HSuP9NfGy5rD3VnfbkppRqTeJ6fBkBUKC1I0AC42kgybE6P3c
         sHeaKtBOXCICPtTD6G/YmQrPx68NikEW8jPMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jPpNVrZb6VOKYGEgEypjJrq16i/E7PEMPIuc+xOvGjU=;
        b=iiJK2MHW/G6SRXhjaD6q+oapsHrkHQtgletklrUc02zcO87WHoW68Jmfpi2/WfEfO7
         wZWuxK6QFV1R14MJ6OkexJBkDO+UuKVMEbYfim0XNTvOcdF1qpgkKaDTkTBQWzYtAXoc
         6sYrdC9+cCw0oRdTVsLKhCR2RCisy2pCmOKzG2fbB/+SBWuIvFAvdvXoHYUayRAtGhcb
         R9gmi0PhYAMBSymhIoJ9u+8R7K6KDqZ+ZSN8q3BKtSAu9y5zc3GvnCPT78mC/hoggwxK
         zv1WqBRUAG1dJmMqi1EzlN3gfMRP5rQU3UWmGviGnpWNQkgQFV45uo2E3dS5TTxzBBcp
         ER9g==
X-Gm-Message-State: AOUpUlF007DD7wH1Q6hu/b4yw75EDKkLoOxE8VsxuO/3tGyDTsW/4AX0
        UFR9WhUrW85wnK+xvM581Gw5iQp1kOY=
X-Google-Smtp-Source: AAOMgpd/RQTPLTjfFLQR7ZQ5nfNYQyfTEcGZAFZZDxq51r98R2WQ9FO5L1ydRuY5Z0CvXqgUVDKwqA==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr3859568wrb.215.1531467071582;
        Fri, 13 Jul 2018 00:31:11 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id j77-v6sm10117115wmd.19.2018.07.13.00.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:31:10 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:31:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 4/6] mfd: rave-sp: Add legacy EEPROM access command
 translation
Message-ID: <20180713073109.GP4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-5-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-5-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> This is needed to make rave-sp-eeprom driver work on "legacy"
> firmware.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c       | 2 ++
>  include/linux/mfd/rave-sp.h | 1 +
>  2 files changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
