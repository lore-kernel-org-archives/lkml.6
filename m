Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC26C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXh4d1hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E5820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeGaF7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:59:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:47099 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeGaF7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:59:09 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so6538813ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ttABI2g+B19JOYy2SH7b7iexeMIakFxlaB8lJHb7BA=;
        b=LXh4d1hX4MzrRTkgNjFcO8VAtneHJrk0eE2lC15wVGw84ub1Ib2N8B2Zj6DZwIJnDM
         tVStWpw23nuob9jraXe573fxLXL2nf89he2ucXSfExTCCvop8KfgcRauM7XBsviMnCc+
         wus0yU+JV1/5J8CRv8T6/hQTXnWknFc9/J0z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ttABI2g+B19JOYy2SH7b7iexeMIakFxlaB8lJHb7BA=;
        b=nydVDwMHPAaAd4GqWm5Euy/UyXtKw3rSgN2oIXYwRFIzwyAj+pbGhiCSN3oSr8CBMH
         VxRNa4k2oZqpYcA70xAHXXhcvmhxyDj6kvYa+u7pBj/xr5ZF4wzrd7VG8h9+oCo+0Eeb
         2fc+U2mr3deB0xqPPC1PFsCJVmSgSg78S9sZlFs71HXTST1rAmtX5eKPbxzOtHY/ZODF
         XKGxE0TaIyR+sEtFDAhJivRDKIlf1ejsy5HVbe8InwBJ4nbEVUDomntx+OymBQrtY+yp
         JC9LSIsiFQI26rdk/cpN1Uf1WFxyJSuZuQK1hWj0qC8p3QirDXZa0+iJ4uEV4s2Oy13S
         pkQw==
X-Gm-Message-State: AOUpUlECm1IJVnkzB0frg7zPokBayMbyyOwJ95yGdeqjauiplYlNQo6J
        NMatZUKoGA6XBW8IKzrutEg/yw==
X-Google-Smtp-Source: AAOMgpdpsBKFdTX1feL9EX4QrqsjuXD63DIpBPykuHmrB2C4G3JKN1Cm1fvlXDag/OIRcwe+iV3YwA==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr18760109pln.175.1533010852516;
        Mon, 30 Jul 2018 21:20:52 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y63-v6sm20170483pgd.94.2018.07.30.21.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 21:20:51 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:21:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Sarangdhar Joshi <spjoshi@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: fix Q6V5_WCSS dependencies
Message-ID: <20180731042140.GD5090@builder>
References: <20180718111730.3531477-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718111730.3531477-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Jul 04:16 PDT 2018, Arnd Bergmann wrote:

> A new driver got added that depends on QCOM_SMD and fails to link
> as built-in with CONFIG_QCOM_SMD=m:
> 
> drivers/remoteproc/qcom_common.o: In function `smd_subdev_stop':
> qcom_common.c:(.text+0x674): undefined reference to `qcom_smd_unregister_edge'
> drivers/remoteproc/qcom_common.o: In function `smd_subdev_start':
> qcom_common.c:(.text+0x700): undefined reference to `qcom_smd_register_edge'
> 
> We've fixed the same thing several times before, so use the same
> dependency here.
> 

I have a change where I remove this inherited dependency, so I asked
Sricharan to only depend on the ones he actually uses - but I forgot
that I haven't pushed this.

Sorry about screwing this up again. Thanks for catching it!

Regards,
Bjorn

> Fixes: 3a3d4163e0bf ("remoteproc: qcom: Introduce Hexagon V5 based WCSS driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 0dde3753c3a5..052d4dd347f9 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -127,6 +127,7 @@ config QCOM_Q6V5_WCSS
>  	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>  	depends on OF && ARCH_QCOM
>  	depends on QCOM_SMEM
> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> -- 
> 2.9.0
> 
