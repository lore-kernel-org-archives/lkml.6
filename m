Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeEWG6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:58:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35910 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbeEWG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:58:18 -0400
X-Google-Smtp-Source: AB8JxZoKnd4Fk5Kq5ru/WGkoHPpVofnI3yD0nXd6fTUhWu7Cl4+ujoJmf+gZqBh6SRJm+3swVA60Mw==
Date: Tue, 22 May 2018 23:58:15 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vinod <vkoul@kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] remoteproc: qcom: Introduce Hexagon V5 based
 WCSS driver
Message-ID: <20180523065815.GZ14924@minitux>
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-6-bjorn.andersson@linaro.org>
 <20180523060516.GD20991@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523060516.GD20991@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 May 23:05 PDT 2018, Vinod wrote:

> On 22-05-18, 22:20, Bjorn Andersson wrote:
> 
> > +static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
> > +{
> > +	int ret;
> > +	u32 val;
> > +	int i;
> > +
> > +	/* Assert resets, stop core */
> > +	val = readl(wcss->reg_base + QDSP6SS_RESET_REG);
> > +	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
> > +	writel(val, wcss->reg_base + QDSP6SS_RESET_REG);
> > +
> > +	/* BHS require xo cbcr to be enabled */
> > +	val = readl(wcss->reg_base + QDSP6SS_XO_CBCR);
> > +	val |= 0x1;
> > +	writel(val, wcss->reg_base + QDSP6SS_XO_CBCR);
> 
> As commented on previous patch, it would help IMO to add a modify() wrapper
> here which would perform read, modify and write.
> 

Iirc the code ended up like this because a lot of these operations ended
up being line wrapped and harder to read using some modify(reg, mask,
val) helper. That said, the function isn't very pretty in it's current
state either...

One of the parts of the RFC is that this sequence is a verbatim copy
from the qcom_q6v5_pil.c driver for 8996, so if we find this duplication
suitable I would prefer that we keep them the same.


The alternative to duplicating this function is as Sricharan proposed to
have the qcom_q6v5_pil.c be both a driver for both the single-stage
remoteproc and the two-stage (load boot loader, then modem firmware).

> Looking at the patch, few other comments would be applicable too, so would be
> great if you/Sricharan can update this
> 

I agree, the primary purpose of this patch was rather to get feedback on
the structure of the drivers, I do expect this to take another round
through the editor to get some polishing touches. Sorry if this wasn't
clear from the description.

Regards,
Bjorn
