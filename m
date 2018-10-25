Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1712082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dik2rv8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1712082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJYQfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:35:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32860 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeJYQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:35:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so8258486wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EAemEQJe844MjkBnRg0+4whi9fHdd101VRQj4zDbdCo=;
        b=dik2rv8UuSrbFjIqO+00MBSIb1QD4c9EYJsnNFCr07WXS6KRT2WhbCoYdLHXBWd2Gz
         ldR20VYAql9OkY9f/VoNjgpIj0AQYNB6ryNx5uWR02z8EUm4DjMXWUSnv+gh1aClt2WW
         bsF0ncaYuMUkJJ0p8gw4GjOoE4dI3AIPh2avw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EAemEQJe844MjkBnRg0+4whi9fHdd101VRQj4zDbdCo=;
        b=Yl2fQtVx9cXQ2WwNoFLFI2jn19jVzRRrDJ7w8ifZSi5WPFcznMd7bOEQ1ouIU+t4wo
         UOYJfgAL94k/pVreH8EjjgHJ5c7UKasitJgVJYrkFw6yN4rWprcW8ZzLEOz+/gBZ0Roo
         CfmiC+q0E/O9QXT9pBc07wnh7uWGiQNMsAVtEwpsABPQD/pVAgCZA/wsegTcCgHiQq3n
         PNXTYZn1WGQKUunN6Vobp61V3FjQuI7qqiND5zjgDcXU3GzEiegFqeB3nwJpJvRTspWD
         GxVmVqc6x1tS6XyBOWNaHpPBtTzvmUeaZpwNjsQEQLVZDWJanueEDW37K6N0jResa58L
         7M7A==
X-Gm-Message-State: AGRZ1gIfypCuQeNyF1OE8RlLwvzS2ZHv/MXPssxuDZGordeyZnNAmlRl
        Q63W6qHMDrmfXEzGcEvPO+UyOw==
X-Google-Smtp-Source: AJdET5dKe0SRjqUmczkigmHogvy9AhvXdxMZx2xXle7eqUbg5K2vIQm2sHyHFOIEJI7hnsLXHeWIMw==
X-Received: by 2002:adf:9102:: with SMTP id j2-v6mr720567wrj.3.1540454613062;
        Thu, 25 Oct 2018 01:03:33 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id o130-v6sm943743wmd.11.2018.10.25.01.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:03:32 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:03:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: Fix some section annotations
Message-ID: <20181025080330.GI4939@dell>
References: <20181018005628.8295-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018005628.8295-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Nathan Chancellor wrote:

> When building the kernel with Clang, the following section mismatch
> warnings appear:
> 
> WARNING: vmlinux.o(.text+0x7239cc): Section mismatch in reference from
> the function db8500_prcmu_probe() to the function
> .init.text:init_prcm_registers()
> The function db8500_prcmu_probe() references
> the function __init init_prcm_registers().
> This is often because db8500_prcmu_probe lacks a __init
> annotation or the annotation of init_prcm_registers is wrong.
> 
> WARNING: vmlinux.o(.text+0x723e28): Section mismatch in reference from
> the function db8500_prcmu_probe() to the function
> .init.text:fw_project_name()
> The function db8500_prcmu_probe() references
> the function __init fw_project_name().
> This is often because db8500_prcmu_probe lacks a __init
> annotation or the annotation of fw_project_name is wrong.
> 
> db8500_prcmu_probe should not be marked as __init so remove the __init
> annotation from fw_project_name and init_prcm_registers.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mfd/db8500-prcmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for v4.21, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
