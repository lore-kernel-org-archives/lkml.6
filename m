Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B4720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjPAdC7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B4720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeIJUXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:23:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51037 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeIJUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:23:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so22027728wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tEPdszxPXWbNgLdLMDMVxDSC1PkpW9oQ4oEAOSABt1s=;
        b=fjPAdC7WdU0eror5Pp9akLXaW4haJYwX7VrNr719OGKvPCyIweQLb8nHN5Kc6JeQDs
         ZPc9BzqOR1Eyt9X/Y6ba4bGO83ygktuFklJgP0c5HG1tWwoPZY0COtms4SpGORNNCBb6
         wtVimiox252aycMGtmbCb4rUHveOxV4waJKMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tEPdszxPXWbNgLdLMDMVxDSC1PkpW9oQ4oEAOSABt1s=;
        b=Pwv8aYaO5TTTNyyNkBeEn5xDZrydwkkzvqs3zrM5S0finy+jVkacHXEhCZfdap9M/j
         oPkPsndApvEFx2+qxauV1E3R+Z2Ft59WRFgPDACNYkDPC3V29cc862aLcYlJkoIAJjVi
         qM2ejAdGEYLwvzj8tGwhHUvquJxZ0Zoz8xZWwtYEcPYYduo3P02gaJUsF5GNw8+b0Qay
         2+FXI2P87HGJmA0fSuP+Z0GBY1ohIn0ywcw1CYfJ+r7xyD/ApGdvZng2APkGnVFTlfG8
         JOEVT7OLEjdd3Hvq0fIT/d49CPLnIMkkvpwDo2yPESFlaEPzDWzYdu23TuhapKrcyMg9
         clNQ==
X-Gm-Message-State: APzg51AYY4UC00PLfLd+JRcP9m30vxQoQr/fF/hx1XlaeJjtyrTpUbtQ
        eXLXzpk1lgcyW4ha01LQJaHF8A==
X-Google-Smtp-Source: ANB0VdbIHREKkSclBV3UoPHIW37DvjtTCu7xMXjrFYQq4Kw9oePSfQutRTFFC4kpgjjP1LqkyruyrA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26-v6mr1114871wmb.112.1536593347630;
        Mon, 10 Sep 2018 08:29:07 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t9-v6sm38922978wra.91.2018.09.10.08.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:29:06 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:29:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        andrey.gusakov@cogentembedded.com, cphealy@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] mfd: mc13xxx-core: Fix PMIC shutdown when reading ADC
 values
Message-ID: <20180910152905.GB28860@dell>
References: <1535486560-16267-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535486560-16267-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> When trying to read any MC13892 ADC channel on a imx51-babbage board:
> 
> # cat /sys/class/hwmon/hwmon0/device/in7_input
> 
> The MC13892 PMIC shutdowns completely.
> 
> After debugging this issue and comparing the MC13892 and MC13783
> initializations done in the vendor kernel, it was noticed that the
> CHRGRAWDIV bit of the ADC0 register was not being set.
> 
> This bit is set by default after power on, but the driver was
> clearing it.
> 
> After setting this bit it is possible to read the ADC values correctly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/mfd/mc13xxx-core.c  | 3 ++-
>  include/linux/mfd/mc13xxx.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
