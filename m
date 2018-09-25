Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A8620880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5NjyPyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A8620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeIZFl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:41:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40461 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIZFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:41:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so5802307pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSn7jm1/KU8DSfYZZ5EgILanyu8n3y8pLf10jTzLlvs=;
        b=R5NjyPypd57CGyHQqZUY2ycJGCNr33DN7Mbi7NoLbdmrTBGkhMx9hBBGjI/jfPlD9K
         VKZ1t5n0WFbnmDpNYVKXc0PDqSTpJVldx18EJSogGNVtD445AfzUA2SaEaexc0/ei8Jl
         CfD0URzDvHrSBqunqYIgQpJrH0ynjbVNNNbfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSn7jm1/KU8DSfYZZ5EgILanyu8n3y8pLf10jTzLlvs=;
        b=mDrUneNgxe8S8fjC2msA3RFQhr057UOvyQxiC3SxqhHOtbVC2wwYuXPLbOpjj/18Pz
         eM8LcFyxzzwY/fkDyQNYs8G/cmHj9qRb7PV4+JLAOeGUsUpbu08YufsGcN1rWMoF9NVs
         4liXiK5U7ngjRa2USxMocPCpP9AZaimfPmM1mpNskTyKQ1Li3a71t9amwW1QrdVupLCF
         khw09tUOUA2jqT/MFwoCkQspnIJVYL/qasR631PdyaBT/AR9D2wSDZYbpfUMn1ui29pv
         hgJVIkAVDGh0nODSrO+vrIPtFF2uJ/NLNnn6GhPVgDx/IxJeEZFwQNAfvb6nkpPHSLEc
         Q0EQ==
X-Gm-Message-State: ABuFfogwlVDadG87XqiyxRtqYAz9EVSwxQvEwSEvkzkkGxYVGprLx1Kg
        7WoAmUGbQV4PYLc1Nh2xKCEUo5QjMLRrZg==
X-Google-Smtp-Source: ACcGV61YVrVB8YKbF32rSUb1K53k74iJHrPnJ4yJASoq60ez+piEEkaGeXQLRaMJJ7efq8Af0XUZbg==
X-Received: by 2002:a62:e70a:: with SMTP id s10-v6mr3432262pfh.124.1537918292239;
        Tue, 25 Sep 2018 16:31:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d81-v6sm5008491pfj.122.2018.09.25.16.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 16:31:31 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:35:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add QCS404 remoteprocs
Message-ID: <20180925233550.GB27436@tuxbook-pro>
References: <20180920172237.30965-1-bjorn.andersson@linaro.org>
 <f0887494a9957496399046bac9b1fa32@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0887494a9957496399046bac9b1fa32@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Sep 03:18 PDT 2018, Sibi Sankar wrote:
> On 2018-09-20 22:52, Bjorn Andersson wrote:
> > diff --git a/drivers/remoteproc/qcom_adsp_pil.c
> > b/drivers/remoteproc/qcom_adsp_pil.c
> > index da2254ea1135..fcbb816a9698 100644
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
> > +	.sysmon_name = "wlan",
> 
> Shouldn't the sysmon name be "wcnss" instead of "wlan"?
> 

I derived this from the downstream kernel, perhaps I got it wrong?

Regards,
Bjorn
