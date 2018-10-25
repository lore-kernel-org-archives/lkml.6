Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0141520834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpH2ZZrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0141520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJYRl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:41:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43535 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeJYRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:41:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10-v6so8441287wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l+S5Ceyy8Ac56dhSROdqlF1bBhZT3O0dybbDGWYjPvs=;
        b=TpH2ZZrfqdrTcuCzU/0Dx7ZvAgpCxuZHzLupRNJMJtQjyq9VJoZIbRdMLyjG0zBEox
         qmJUDViOScdxSPhadSpXYkmBxkN0IDUKwapYh9TYxFq2ViOdtJaJ9AcuoZqskbfEDbzo
         tangj4I7iVHximQzra2QGqsIPG0L1QCRWc29M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l+S5Ceyy8Ac56dhSROdqlF1bBhZT3O0dybbDGWYjPvs=;
        b=q8cdTmUMQdKBsqFP5TbzGSgksdBGnWq7a4XZhUy3YbuyC28NaFYIx18P4B2ReacCuO
         0q+dd2fGNyyEaFHHqlNCAaPyj29Fo+if9a5XpLZDyZm1tViuDJjqVAtoO0kT8M7gW/Hp
         3dU2LfdjZhiI06ABMTCCasQbSZnQgJkBy3ESl47cs82KNVA5xXJ5DEjsH9pEzySmFP//
         4WvL0UerVAlKfM2jSeO42CYRxzkevUHSBLl2//mOPIei4D98v2ZEeDkiJHr3HnQT4IWm
         54xViEz0Ay/V7vycOTy07aKSLPVLoXg94o/Az1pGkjdTTvbICr7MUC6ZQchFXh10FURq
         WtkQ==
X-Gm-Message-State: AGRZ1gLzNMK0uRdtx8sED/OlqVFcELcvZz6O9UjGDvRwMEJaULB11O/o
        xS5lfLzgTu2G1t4fh5dhfejnTlGTEfc=
X-Google-Smtp-Source: AJdET5cC6cTVQ/jtquP9JfgAzgnLD+qYMEQkIOluLzQNYH/an5KJ0UeEQQUAUlSagsQxtFgr/P5Djg==
X-Received: by 2002:adf:dc4a:: with SMTP id m10-v6mr951555wrj.84.1540458605109;
        Thu, 25 Oct 2018 02:10:05 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id o13sm6286090wrx.53.2018.10.25.02.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:10:04 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:10:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mfd: mt6397: Do not call irq_domain_remove if PMIC
 unsupported
Message-ID: <20181025091001.GM4939@dell>
References: <20181022025505.27919-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181022025505.27919-1-drinkcat@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018, Nicolas Boichat wrote:

> If the PMIC ID is unknown, the current code would call
> irq_domain_remove and panic, as pmic->irq_domain is only
> initialized by mt6397_irq_init.
> 
> Return immediately with an error, if the chip ID is unsupported.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/mfd/mt6397-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied for v4.21, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
