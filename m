Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F777C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24C021748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFtcbNmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24C021748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeI1Sty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:49:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35565 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbeI1Stx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:49:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4-v6so5663857ljd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wnfoO30FgmVOdWLyb1hEdGjogUfjeU42D8+RF1eHhA=;
        b=hFtcbNmnddYDaygYwKwHLM43KLpsjEmLuOD60Ph4ftYwh4avzVqugzwM1AvGZWzzxs
         jDUPLdmlcpfybI+GwHFx+/Hpb3omqxuoC/wEESUPQGjjOphObgNMOw9k4AZlfcUAM5lC
         EMGyu/Jwn9vN81uDiqmeHNZJ4yKxUcfmyMbGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wnfoO30FgmVOdWLyb1hEdGjogUfjeU42D8+RF1eHhA=;
        b=ME7kPTnJB+WLL5etbjdEL9+7tFy/IQl5BCo0qAzw2Z4xbNgcQMKlyVeBIgwYH68KAP
         ixPc7ydMbNLtX/Y6A03u2XhRKTcD8s5fbP4pi4MUIkfEFjYJxmvfvDLpbDsIgEsl33lq
         1/Zara0CA8JqxAHuzzY4t+3UFzvNL4/oayMgi2/Pg+hsV/UeqjGikR5CvDH8rLfHQsdm
         Jm/aq+FNjMn9ZiCg/dbYg7PBVyhdnwk72Rhqe0hKlpw0Adi8ft1Dw+rIqHOhVq2Wlc7F
         0h19WlPe7v0itb/rujsSNEOYI7EBy02P32/a4YycCnkcHe2ytozEw3Ayc+3f8qV31yfl
         9G+Q==
X-Gm-Message-State: ABuFfojyjeu8lD0xnT/WcRKn+Zh7AI+xeN7ZAMLwqnvVj0aZYhthyfp3
        TMJ5EE9mtiypuqtPJN4not+99A==
X-Google-Smtp-Source: ACcGV60f0Vs/UXi3Se4THLS5NFVZx1J15kdyE8wyVBGwDhHVQhfyB6B3w1nZmvXclTwq0S67xlbTKw==
X-Received: by 2002:a2e:924e:: with SMTP id v14-v6mr3751650ljg.24.1538137579146;
        Fri, 28 Sep 2018 05:26:19 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id d4-v6sm990429lfc.57.2018.09.28.05.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 05:26:18 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:26:16 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
Message-ID: <20180928122616.GA5249@centauri.lan>
References: <20180427140358.30839-1-elder@linaro.org>
 <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:41:11AM -0500, Alex Elder wrote:
> Was there something wrong with this patch?  I sent it a long time
> ago but it still applies cleanly.  I can re-send if you like.

Hello Alex,

This patch does not apply on top of
https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next


When you don't specify a string for a Kconfig, then you won't be able to
select it via menuconfig, only through other Kconfigs, e.g.:
$ git grep QCOM_QMI_HELPERS
drivers/remoteproc/Kconfig:     select QCOM_QMI_HELPERS

What Kconfig is it that needs QCOM_QMI_HELPERS?
Why do you need to make is selectable via menuconfig?
Isn't it sufficient to add a "select QCOM_QMI_HELPERS" to that Kconfig?


Kind regards,
Niklas

> 
> 					-Alex
> 
> On 04/27/2018 09:03 AM, Alex Elder wrote:
> > Add a prompt to the "tristate" attribute in the Kconfig file in
> > which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> > without it.
> > 
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > ---
> >  drivers/soc/qcom/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index 5c4535b545cc..81a501765cd9 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -36,7 +36,7 @@ config QCOM_PM
> >  	  low power modes.
> >  
> >  config QCOM_QMI_HELPERS
> > -	tristate
> > +	tristate "Qualcomm QMI Helpers"
> >  	depends on ARCH_QCOM && NET
> >  	help
> >  	  Helper library for handling QMI encoded messages.  QMI encoded
> > 
> 
