Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724120659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mu7EKHMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfAOAmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:42:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36046 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfAOAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:42:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so435286pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gCNGy+lmVbipFQBDWvVs7sZyzSaCMNVkjJmzTrdyfCQ=;
        b=Mu7EKHMP+rmf8mIBtLlq+wn1bs3hjBCUzDPQ8fWZNNY6EitTGWXN+XbWd5ozPhXiSk
         9jR2PEmsAa7dOLyfzc5Dl13M/7RKhgBfXjzJuN8uu91PkmmwhA7avHJB1JaKqZyzK8xO
         LrDl5Juot9EKJGFNDuu5AWzAX+TuTpOoCQeWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCNGy+lmVbipFQBDWvVs7sZyzSaCMNVkjJmzTrdyfCQ=;
        b=IlC8+kCKKFuUDfL3XUNqLdXCfioCfKXI1F9laFs437SXa909bPfKN7XJmhuC+1um6N
         qcZshTrrU6l5dHguRGCVKbPQmVLAcRNBqgKbTEhy5JBRIXeWd3Tj/yxz9zDzmvEu33FU
         QhoO4MuPG50lPAuOw4riHFjkramvS+/h8yDvtJLa/0STmPfG9bZv4fGnPkNHhkrsV5T8
         gu3a35tcm3zoefu14gcLxkXiA408oywDXK+RUl8YFwmRk9rC317GodbeKq05MPLlPs6f
         6RawI5kHG5afpRIpBpr1+cDavyIiXp2zS6MeGwSvD0s6oAHT5KSvrlPcjwj3h4ulmD+L
         n8gQ==
X-Gm-Message-State: AJcUukc4hv7SL5DQkra7g0cv0AtoZr4Ell7rnmHvZA1vgpjLhWcUa1Z3
        a+xIWrkSbHURyANVTqNHSc+GRA==
X-Google-Smtp-Source: ALg8bN7XIQkQCE2UOOg93LRPa0anje2VhU7JyhPK0TGzzUUrliOdWGNDreRhl0HL07/oNsL3IENH9A==
X-Received: by 2002:a63:1408:: with SMTP id u8mr1172687pgl.271.1547512926175;
        Mon, 14 Jan 2019 16:42:06 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v89sm2840054pfj.164.2019.01.14.16.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:42:05 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:42:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/14] spmi: pmic-arb: disassociate old virq if hwirq
 mapping already exists
Message-ID: <20190115004203.GK9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-7-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-7-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> Check to see if the hwirq is already associated with another virq on
> this IRQ domain. If so, then disassociate it before associating the
> hwirq with the new virq.
> 
> This is a temporary hack that is needed in order to not break git
> bisect for existing boards. The next patch in this series converts
> spmi-gpio to be a hierarchical IRQ chip, then there are several patches
> to update all of the device tree files, and finally this patch will be
> reverted within the same patch series.
> 

You must maintain compatibility with existing DTB files (at least for
some time), so I don't think we can revert this patch at the end of the
series. 

But the patch itself looks reasonable,

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> IRQs for spmi-gpio are all initially setup without an IRQ hierarchy
> on pmic-arb when mfd/qcom-spmi-pmic.c is probed (via the
> devm_of_platform_populate call) due to the interrupts property in
> device tree. Once spmi-gpio is converted to be a hierarchical IRQ chip
> in the next patch, existing users of gpio[d]_to_irq() will call
> pmic_gpio_to_irq(), and that will use the new IRQ chip code in
> spmi-gpio that sets up the IRQ in an IRQ hierarchy. The hwirq is now
> associated with two Linux virqs and interrupts will not work as
> expected. This patch corrects that issue.
> 
> Driver was tested using gpio-keys and iadc/vadc on the LG Nexus 5
> (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is a new patch introduced in V4, but this logic was present in V1.
> 
>  drivers/spmi/spmi-pmic-arb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 356bc3f66e22..b7cfee831417 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -744,8 +744,14 @@ static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
>  				   struct irq_domain *domain, unsigned int virq,
>  				   irq_hw_number_t hwirq)
>  {
> +	unsigned int old_virq;
> +
>  	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
>  
> +	old_virq = irq_find_mapping(domain, hwirq);
> +	if (old_virq)
> +		irq_domain_disassociate(domain, old_virq);
> +
>  	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
>  			    handle_level_irq, NULL, NULL);
>  }
> -- 
> 2.17.2
> 
