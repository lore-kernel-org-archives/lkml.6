Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8287AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF002089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIwd5SOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF002089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933598AbeFLMoJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:44:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35108 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFLMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:44:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so25494063lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=loMCp3Ado1Vrtw7xRucYfMKgzCliS4iLPIjSCwYpQ5U=;
        b=MIwd5SOCn+Vx8BXdwu5wfISidI4//lvOM3hPnacnnHfEx2MZM2zommE9aqBAjWRh1N
         BiZc7JJcQXx1neDkiJc44LFmeAnL9GXlv0lm4REoANlLBtKOmikbJiSPXyB1W6ei8CEt
         Y8um4xFykKutMCEZ6gmxRXDJK6KTYhLk+xSXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=loMCp3Ado1Vrtw7xRucYfMKgzCliS4iLPIjSCwYpQ5U=;
        b=TcbNvMENmo1LXWg+syNgpV7pfgjzPTaHmofIUKJVQfmm8kFpDA64K5OeQrGuRtixsn
         y2sSoVSAEqxpN/e8QIbt809Jz7MShMvzo5g3tMNsgQGhi1Ssw3BnzZmeFKXmVa/JmzoL
         5eqJq77KGOYrmXUvyiGlCWJsIicDAlFXeSWl/K7fvSopYSS9245gh+pSWjU0geWqGama
         st/C3veIc2Rplxtm4sxVGH87L7G9sKfnj4Jy+ipFgbQMe5jHkxFvWqyhQH0u5Igdhfrf
         VoZStyuRRHLeGQ6IIT+eWLb4p7Ul73GeGSiizOLDTUQNH0yLRlecfYgIdoMlbMWJeebl
         5J0Q==
X-Gm-Message-State: APt69E1h4shPs6XD5A/NG9Nrz9MSQv5nd87ZsI9PfyoSskE80NYJVKrT
        AxSxk/oz9im4+UUhe31QC/t9Ig==
X-Google-Smtp-Source: ADUXVKL5lniFCPjxWkj8Fk12ZuIRrgsDJmfJ9mO2oaH4sKKY4/dybXfek5MT5sPQ7GbTFpxzTY91dg==
X-Received: by 2002:a19:4e86:: with SMTP id u6-v6mr130062lfk.105.1528807445586;
        Tue, 12 Jun 2018 05:44:05 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id n84-v6sm18449lfi.19.2018.06.12.05.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 05:44:05 -0700 (PDT)
Date:   Tue, 12 Jun 2018 14:44:03 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Govind Singh <govinds@codeaurora.org>, bjorn.andersson@linaro.org
Cc:     kvalo@codeaurora.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FW: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Message-ID: <20180612124403.GA26986@centauri.lan>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
 <20180612113907.15043-2-niklas.cassel@linaro.org>
 <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
 <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:02:48PM +0530, Govind Singh wrote:
> On 2018-06-12 17:45, Govind Singh wrote:
> > -----Original Message-----
> > From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Niklas
> > Cassel
> > Sent: Tuesday, June 12, 2018 5:09 PM
> > To: Kalle Valo <kvalo@codeaurora.org>; David S. Miller
> > <davem@davemloft.net>
> > Cc: Niklas Cassel <niklas.cassel@linaro.org>; netdev@vger.kernel.org;
> > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > ath10k@lists.infradead.org
> > Subject: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
> > 
> > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
> > b/drivers/net/wireless/ath/ath10k/Kconfig
> > index 54ff5930126c..6572a43590a8 100644
> > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> > @@ -42,7 +42,8 @@ config ATH10K_USB
> > 
> >  config ATH10K_SNOC
> >  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
> > -	depends on ATH10K && ARCH_QCOM
> > +	depends on ATH10K
> > +	depends on ARCH_QCOM || COMPILE_TEST
> >  	---help---
> >  	  This module adds support for integrated WCN3990 chip connected
> >  	  to system NOC(SNOC). Currently work in progress and will not
> 
> Thanks Niklas for enabling COMPILE_TEST. With QMI set of
> changes(https://patchwork.kernel.org/patch/10448183/), we need to enable
> COMPILE_TEST for
> QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix the
> same.


Argh..

qcom_scm seems fine, it is just missing a single definition in the
#else clause of include/linux/qcom_scm.h.

+++ b/include/linux/qcom_scm.h
@@ -89,6 +89,10 @@ static inline int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,                                     
 static inline int
 qcom_scm_pas_auth_and_reset(u32 peripheral) { return -ENODEV; }
 static inline int qcom_scm_pas_shutdown(u32 peripheral) { return -ENODEV; }                                                      
+static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,                                                       
+                                     unsigned int *src,
+                                     struct qcom_scm_vmperm *newvm,                                                              
+                                     int dest_cnt) { return -ENODEV; }                                                           
 static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32 qcom_scm_get_version(void) { return 0; }



include/linux/soc/qcom/qmi.h on the other hand doesn't have any
dummy defintions at all.
I think that it makes sense to be able to compile test
the QMI helpers also on other archs..

Bjorn, any opinion?


> 
>  config QCOM_SCM
>  	bool
> -	depends on ARM || ARM64
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	select RESET_CONTROLLER
> 
> 
>  config QCOM_SCM_64
>  	def_bool y
> -	depends on QCOM_SCM && ARM64
> +	depends on QCOM_SCM && ARM64 || COMPILE_TEST
> 
>  config QCOM_QMI_HELPERS
>  	tristate
> -	depends on ARCH_QCOM && NET
> +	depends on (ARCH_QCOM || COMPILE_TEST) && NET
> 
> -obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-y				+= qcom/
> 
> __qcom_scm_init/qcom_scm_call wrapper to support COMPILE_TEST.
> 
> 
> 
> BR,
> Govind
