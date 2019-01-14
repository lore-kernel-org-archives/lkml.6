Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMG7wzak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfANXUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:20:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44543 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:20:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so327768plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPv3/bN89enoIVQgsLOLZ/K+PfySq5gtHDmb7PMtbHI=;
        b=YMG7wzak+8VQMP7Eee9yUWQZum4ghO9D2fL+xoztVYI+LDmAEz8sSYWznfV9Hswk/d
         xwZQb3Zjdcy+gGsHRGRuy3HtLdb2g/VIrRxzBK/B09N3HtPmjPFF4ZWkMPmATMCx6yjp
         2v+Z93GHBnOskv/gl5iuFO0yYHkmEOdJZIhi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPv3/bN89enoIVQgsLOLZ/K+PfySq5gtHDmb7PMtbHI=;
        b=OfpSwm4ZLQgyf7Mtu3d3EcG4V0eg+fiwCmjRgnZFbhk9VXxBasI+TWyotXc2lYY7fL
         6E7hZLwqSM7ht+AAq89sBqjYqExmiXWv8goDvI+79Tn1y9GqSqPRaxdloTJRVUoTi0uW
         BITYatoRkvRz7ycRUKqQIlmL812hdt1YQ2T3C8yl1Xg++eX84EV0HxEXTkf6GjtrdUjC
         o/5rg1DONODum89XvoIbVASyRH3hBOI/eLitY9vFC9esqOk7AOOgdwrSgDvTjjMPQB0u
         zd97ISt1gMjtMfJtKrUfdasig8SBNUXZZFMmwL6wISJxw4i4baQKpnz0mG1O8v73rcWv
         gZwg==
X-Gm-Message-State: AJcUukeoIRr5vTqwHYSuXhRJCJ12u+kiuzNX2m161JVis7vvlfNu4Wo9
        rJosukmCjBZmspkoqQLnxMgQiw==
X-Google-Smtp-Source: ALg8bN67miuUSngWCUTR6C9LsCRbKMB7NXtD3+GWglocJE7ciSav5u3MyqhUHfiCE5XX/oSn4UiG0Q==
X-Received: by 2002:a17:902:5982:: with SMTP id p2mr954892pli.39.1547508034403;
        Mon, 14 Jan 2019 15:20:34 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z13sm1856656pgf.84.2019.01.14.15.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:20:33 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:20:31 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] soc: qcom: Add AOSS QMP communication driver
Message-ID: <20190114232031.GD9278@minitux>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-3-bjorn.andersson@linaro.org>
 <154750540229.169631.4962369801600780946@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154750540229.169631.4962369801600780946@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 14:36 PST 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-01-06 00:09:10)
> > diff --git a/drivers/soc/qcom/aoss-qmp.c b/drivers/soc/qcom/aoss-qmp.c
> > new file mode 100644
> > index 000000000000..de52703b96b6
> > --- /dev/null
> > +++ b/drivers/soc/qcom/aoss-qmp.c
> > @@ -0,0 +1,313 @@
> [...]
> > +
> > +static int qmp_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res;
> > +       struct qmp *qmp;
> > +       int irq;
> > +       int ret;
> > +
> > +       qmp = devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
> > +       if (!qmp)
> > +               return -ENOMEM;
> > +
> > +       qmp->dev = &pdev->dev;
> > +       init_waitqueue_head(&qmp->event);
> > +       mutex_init(&qmp->tx_lock);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(qmp->msgram))
> > +               return PTR_ERR(qmp->msgram);
> > +
> > +       qmp->mbox_client.dev = &pdev->dev;
> > +       qmp->mbox_client.knows_txdone = true;
> > +       qmp->mbox_chan = mbox_request_channel(&qmp->mbox_client, 0);
> > +       if (IS_ERR(qmp->mbox_chan)) {
> > +               dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
> > +               return PTR_ERR(qmp->mbox_chan);
> > +       }
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
> > +                              "aoss-qmp", qmp);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to request interrupt\n");
> 
> Don't we need to free_mbox_channel() all over the place here?
> 

We do, thanks for spotting this.

[..]
> > diff --git a/include/linux/soc/qcom/aoss-qmp.h b/include/linux/soc/qcom/aoss-qmp.h
> > new file mode 100644
> > index 000000000000..32ccaa091a9f
> > --- /dev/null
> > +++ b/include/linux/soc/qcom/aoss-qmp.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018, Linaro Ltd
> > + */
> > +#ifndef __AOP_QMP_H__
> > +#define __AOP_QMP_H__
> 
> include <linux/types.h> for size_t usage?
> 

That wouldn't hurt.

> > +
> > +struct qmp;
> > +
> > +int qmp_send(struct qmp *qmp, const void *data, size_t len);
> > +

Thanks,
Bjorn
