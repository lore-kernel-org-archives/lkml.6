Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A74ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305A32147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIM08Ate"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305A32147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeITWOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:14:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbeITWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:14:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so4620175pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UiqWWeJ6bITtNzf49TO0jt3/uqdv70YAZx9CujVr1is=;
        b=KIM08AtemBj/8tsJgNCdlkzL+9Gn39otrLWeUT/2cT9ieF4+9LtPBpftFMjeYP8sQe
         Vxcc/c7CPSVaFag8O0C5kk++KJJRrf/fke2FlEDa1E9k9E4ijbx6WFr31apyeC3Q7Ja2
         mx8KmYSufMWDN5wqG1U6gUk9GuCNZ6dFTUHvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiqWWeJ6bITtNzf49TO0jt3/uqdv70YAZx9CujVr1is=;
        b=P/h8mgBdHaKPgnLHSK0B10vXXaNrijczOgEo9/aoB7jtq8xm+gLRvUEXk8k5rPatVd
         lN9KxgXrEvueWVaEq6ktglMVln7TINWeNWx+CVE0/OOFp5fZV4rFsgDIlSjvxUBCa3mW
         434vc9ab+lFnyvxe69558E1CT8oT9wvRgt6WPmhnrrDnqJC6DqdxD3c8bJ3Wx+W2KH0N
         /K3FdP6elqeK8BiufnO4MMapU5SoNKO/wIHcUDwEZvtvkMgoTW8tx/PZXdLAOf4VGyV3
         jdUiUr0aTteFoFouvGjQ4chWToMiDK3WP0yXAgFRVjMDYlab133b+TUFJCKKUuuw+wzA
         QhGw==
X-Gm-Message-State: APzg51DaPixn2A23pdtdxjPqPLDzHuDiHcIBy4ztyG7hzNgZq/uP5Qja
        Zz9fWcxexLxceNejzeCGP+kXhA==
X-Google-Smtp-Source: ANB0VdbAHZq07/AEwlLiNkMbqR+6PSUXQ1G2rG7HeYaIL2vI+GcqYCFhAuOtHtLUHwT/OsN0Gwa5Gg==
X-Received: by 2002:a63:cc4f:: with SMTP id q15-v6mr37537256pgi.217.1537460994281;
        Thu, 20 Sep 2018 09:29:54 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o62-v6sm31209654pfb.0.2018.09.20.09.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:29:53 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:34:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pms405 gpio support
Message-ID: <20180920163405.GE1367@tuxbook-pro>
References: <20180920014705.15144-1-bjorn.andersson@linaro.org>
 <153745740342.119890.12073424910838960020@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153745740342.119890.12073424910838960020@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Sep 08:30 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-09-19 18:47:05)
> > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > index a29efbe08f48..b54891998caa 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > @@ -1055,6 +1055,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
> >         { .compatible = "qcom,pm8994-gpio" },   /* 22 GPIO's */
> >         { .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
> >         { .compatible = "qcom,pma8084-gpio" },  /* 22 GPIO's */
> > +       { .compatible = "qcom,pms405-gpio" }, /* 11 GPIO's */
> 
> I thought we didn't update the C driver, because there isn't anything to
> do here. Just make binding updates and it's all fine.
> 

Right, forgot that we just use the fallback.

Thanks,
Bjorn

> >         { .compatible = "qcom,spmi-gpio" }, /* Generic */
> >         { },
> >  };
