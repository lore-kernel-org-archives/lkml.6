Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A8C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0C2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUG/9wvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D0C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJFNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:38:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45158 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeJFNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:38:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id y15-v6so7773601plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tVLE85ddP2uBzT4iQP1ZEJKofHKZkrJ9VNH1IiNNDYc=;
        b=LUG/9wvI78nBSKOUdTUyPIfDS0ODUMSNeaA56Qe3a9Arvtvx5nSaONCo73Cku33SnE
         cS+xovlpWO/LzlPCj5ZmM8EPaX7DwLaPh4hwHISnFOEBC8M3/DAihelH2PFiluFd4Vec
         CqiszgsaR0u7qGu63Ba5ci0tWxKOLSo3kd8oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVLE85ddP2uBzT4iQP1ZEJKofHKZkrJ9VNH1IiNNDYc=;
        b=iXTcwvI3hs/+Du0X3MagiP6VDyWJpp94gugs+7wmVyXLfTXOt4FS8pldVd+W5b56pD
         W3VTvQx4NeILhuKdttOymxd6jUIHCb8XErOzwYyM/5yMPGdkuU27Ba4Vd2Jrys8zoC5h
         dklYeHRwBWZyxq8LmYatgvZT/UTw0+fyRQpu7bpK7ONA4MBZ0cvxiVTWYkpHsgGwzKil
         P9/sMniq3IAHk2+FwKUiBTmYyArGyUIg0dmi/paWJscoUlC3jog7fe5m5QfQXDdnSLM2
         24MGOMgRlZaPHPp1yTP/hpPoKWo81xVX2SAdGEfwZJYzZ29SoL8p8g3A/uIoqZ2g3Nbh
         ixBA==
X-Gm-Message-State: ABuFfogWaa9e+fcGotQnOVSnjYgDeOzoFMamfXC1+hbzOPeCosVS6QCL
        bDYGNYvnoejhRJDN7F8SPzBz6Q==
X-Google-Smtp-Source: ACcGV63+5ePxsmbpIf6AAG/p6V/gVaeFNi9lW3+2FxQGImbwfbL2S2G55y4qrJInqeTAqnXc5maEoA==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr14745847pld.287.1538807753093;
        Fri, 05 Oct 2018 23:35:53 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g62-v6sm15542109pgc.22.2018.10.05.23.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:35:52 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:38:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom: pas: Add QCS404 remoteprocs
Message-ID: <20181006063838.GI12063@builder>
References: <20180927190346.2984-1-bjorn.andersson@linaro.org>
 <580f4c902aa18e86e5a2e78521d998ee@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580f4c902aa18e86e5a2e78521d998ee@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 Sep 23:27 PDT 2018, Sibi Sankar wrote:

> On 2018-09-28 00:33, Bjorn Andersson wrote:
> > Add compatibles for the three PAS based remote processors found in
> > QCS404.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> 
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> 

Thanks for the review Sibi, applied the patch.

Regards,
Bjorn

> > Changes since v1:
> > - Fixed incorrect sysmon_name, as pointed out by Sibi.
> > 
> >  .../devicetree/bindings/remoteproc/qcom,adsp.txt     |  3 +++
> >  drivers/remoteproc/qcom_adsp_pil.c                   | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > index b7d058228185..9c0cff3a5ed8 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > @@ -10,6 +10,9 @@ on the Qualcomm ADSP Hexagon core.
> >  		    "qcom,msm8974-adsp-pil"
> >  		    "qcom,msm8996-adsp-pil"
> >  		    "qcom,msm8996-slpi-pil"
> > +		    "qcom,qcs404-adsp-pas"
> > +		    "qcom,qcs404-cdsp-pas"
> > +		    "qcom,qcs404-wcss-pas"
> >  		    "qcom,sdm845-adsp-pas"
> >  		    "qcom,sdm845-cdsp-pas"
> > 
> > diff --git a/drivers/remoteproc/qcom_adsp_pil.c
> > b/drivers/remoteproc/qcom_adsp_pil.c
> > index da2254ea1135..d5e58235e83a 100644
> > --- a/drivers/remoteproc/qcom_adsp_pil.c
> > +++ b/drivers/remoteproc/qcom_adsp_pil.c
> > @@ -362,10 +362,22 @@ static const struct adsp_data slpi_resource_init =
> > {
> >  		.ssctl_id = 0x16,
> >  };
> > 
> > +static const struct adsp_data wcss_resource_init = {
> > +	.crash_reason_smem = 421,
> > +	.firmware_name = "wcnss.mdt",
> > +	.pas_id = 6,
> > +	.ssr_name = "mpss",
> > +	.sysmon_name = "wcnss",
> > +	.ssctl_id = 0x12,
> > +};
> > +
> >  static const struct of_device_id adsp_of_match[] = {
> >  	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
> >  	{ .compatible = "qcom,msm8996-adsp-pil", .data = &adsp_resource_init},
> >  	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
> > +	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
> > +	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
> > +	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
> >  	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
> >  	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
> >  	{ },
> 
> -- 
> -- Sibi Sankar --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
