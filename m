Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A83C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB12083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3jE7FMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDB12083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeHaHQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:16:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38069 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeHaHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:16:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4811671pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MK/GK/+Rf+3Yk+d1U8g4sMgd6IpLRrTTAh/skLhPL8k=;
        b=J3jE7FMub54wgSKjBLhf26ffizyEarqtcshYOzDr/KLE9WmbYPdH8ddqWUYhjyqD+N
         VXjo+VEq15uSuhldvA+tiS7WRjyqlVsFzUTgeeVT+MmTukRRaR5T5lO8qOOVibS+rk+X
         L1xollt0wiXqXK0rTSDxTTzhDnN4uaA2Awsnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MK/GK/+Rf+3Yk+d1U8g4sMgd6IpLRrTTAh/skLhPL8k=;
        b=XdDpQDRLkAIxwp/HXAFKsS95An+vqs/BzjsoFukSLgPTZTmXNPj4rCrKM89GslyK2v
         R7f7br69zat7yoJwbXW5VIxDWbJPRLceGCc9ZrjoH4lfRjy/9AkA++qE1v1Lw6sZVOk2
         /YDMGugvJfiRVHZTNHfcRKJFGjSlNdiIBkKLy5dBXM792fRkeJ5moJ2U+xu+pcPgZwO0
         JMzbaourm7U7wLVlWwcrnO1YjlbVBUuVW73zxsL9qtjtytH2LuMoTFd0rUPMHUvPRgh1
         JuwtpAr0pbZp6bcfdOxYELnJf/bholjJJHaXgsXv5eXdrlwu4JzRfLuikignsl+tJUTg
         60fg==
X-Gm-Message-State: APzg51CFr9NNXjHWhVYQs01HHfjeWSe4FT9uoLjA559ZtUjeQ044cWkU
        Yl0jp8pu6zg5MZ6PTdIMHBfVMA==
X-Google-Smtp-Source: ANB0Vda4onzKU6piFJ37TTHm/cFF/EC6FJf7g8u5Tq406Gi5o1S+fmO2+IQfag6BEGMJ08Lll9Hn4w==
X-Received: by 2002:a63:e756:: with SMTP id j22-v6mr12547846pgk.185.1535685056162;
        Thu, 30 Aug 2018 20:10:56 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g5-v6sm22748036pgn.73.2018.08.30.20.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 20:10:55 -0700 (PDT)
Date:   Thu, 30 Aug 2018 20:10:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH] remoteproc: qcom: Rename Hexagon v5 PAS driver
Message-ID: <20180831031053.GP2523@minitux>
References: <20180828051203.22394-1-bjorn.andersson@linaro.org>
 <20180829092520.GA9677@centauri.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829092520.GA9677@centauri.ideon.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 02:25 PDT 2018, Niklas Cassel wrote:

> On Mon, Aug 27, 2018 at 10:12:03PM -0700, Bjorn Andersson wrote:
> > The Hexagon v5 ADSP driver is used for more than only the ADSP and
> > there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
> > qcom_q6v5_pas in order to better suite this.
> 
> Hello Bjorn,
> 
> so I'm a bit new to this, but after your rename we will have:
> 
> QCOM_Q6V5_PIL
> and
> QCOM_Q6V5_PAS
> 
> that both are PILs.
> I guess that the difference is that the latter uses TrustZone?
> 
> The ADSP for some QCOM SoCs is a Hexagon v5, therefore the
> QCOM_Q6V5_PAS can also boot certain ADSPs?
> 
> But we also have QCOM_Q6V5_WCSS
> "Qualcomm Hexagon based WCSS Peripheral Image Loader",
> which also appears to be Hexagon v5 based, but I assume that
> neither QCOM_Q6V5_PIL nor QCOM_Q6V5_PAS can boot the WCSS?
> 
> There is also an upcoming non-PAS ADSP PIL loader for SDM845,
> but I guess that the ADSP there is not based on Hexagon v5,
> so the QCOM_Q6V5_PIL will not be able to boot it?
> 
> This all seems to be quite confusing, perhaps the help texts
> could be improved to mitigate this confusion?
> 

You're right, as proposed this is confusing.

The plan is to have QCOM_Q6V5_PAS, which deals with standard Hexagon
peripherals that relies on the PAS service in TrustZone and then rename
QCOM_Q6V5_PIL to QCOM_Q6V5_MSA to denote that this is the remoteproc
driver for the self-authenticating modem.

The QCOM_Q6V5_WCSS then fits into this pattern, of being the non-TZ
based WCSS remoteproc driver.

> > 
> > Cc: Rohit kumar <rohitkr@codeaurora.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/remoteproc/Kconfig                    | 22 +++++++++----------
> >  drivers/remoteproc/Makefile                   |  2 +-
> >  .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 ++--
> 
> You should probably also edit the qcom_defconfig:
> arch/arm/configs/qcom_defconfig:CONFIG_QCOM_ADSP_PIL=y
> 

Yes, this needs to be done as well. But needs to be done in a separate
patch.

> >  3 files changed, 14 insertions(+), 14 deletions(-)
> >  rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 052d4dd347f9..c98c0b2a2237 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -84,8 +84,16 @@ config KEYSTONE_REMOTEPROC
> >  	  It's safe to say N here if you're not interested in the Keystone
> >  	  DSPs or just want to use a bare minimum kernel.
> >  
> > -config QCOM_ADSP_PIL
> > -	tristate "Qualcomm ADSP Peripheral Image Loader"
> > +config QCOM_RPROC_COMMON
> > +	tristate
> > +
> > +config QCOM_Q6V5_COMMON
> > +	tristate
> > +	depends on ARCH_QCOM
> > +	depends on QCOM_SMEM
> > +
> > +config QCOM_Q6V5_PAS
> > +	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
> >  	depends on OF && ARCH_QCOM
> >  	depends on QCOM_SMEM
> >  	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> > @@ -98,15 +106,7 @@ config QCOM_ADSP_PIL
> >  	select QCOM_SCM
> >  	help
> >  	  Say y here to support the TrustZone based Peripherial Image Loader
> 
> Since you are editing this help text, yoy may just as well s/Peripherial/Peripheral.
> 

Thanks, will do.

Regards,
Bjorn

> Kind regards,
> Niklas
> 
> > -	  for the Qualcomm ADSP remote processors.
> > -
> > -config QCOM_RPROC_COMMON
> > -	tristate
> > -
> > -config QCOM_Q6V5_COMMON
> > -	tristate
> > -	depends on ARCH_QCOM
> > -	depends on QCOM_SMEM
> > +	  for the Qualcomm Hexagon v5 based remote processors.
> >  
> >  config QCOM_Q6V5_PIL
> >  	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index 03332fa7e2ee..eb86c8ba5a87 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
> >  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
> >  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> >  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> > -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
> >  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
> >  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
> > +obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
> >  obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
> >  obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
> >  obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
> > diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > similarity index 98%
> > rename from drivers/remoteproc/qcom_adsp_pil.c
> > rename to drivers/remoteproc/qcom_q6v5_pas.c
> > index d4339a6da616..2478ef3cd519 100644
> > --- a/drivers/remoteproc/qcom_adsp_pil.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -364,11 +364,11 @@ static struct platform_driver adsp_driver = {
> >  	.probe = adsp_probe,
> >  	.remove = adsp_remove,
> >  	.driver = {
> > -		.name = "qcom_adsp_pil",
> > +		.name = "qcom_q6v5_pas",
> >  		.of_match_table = adsp_of_match,
> >  	},
> >  };
> >  
> >  module_platform_driver(adsp_driver);
> > -MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
> > +MODULE_DESCRIPTION("Qualcomm Hexagon v5 Peripheral Authentication Service driver");
> >  MODULE_LICENSE("GPL v2");
> > -- 
> > 2.18.0
> > 
