Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28806C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE0D21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BsIsyjYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE0D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJDFtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:49:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33093 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeJDFtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:49:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so2394455pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rChkiNm0DGN9lEZ/1Cxc8ksjfYrvM3uvh3jfueH7fqg=;
        b=BsIsyjYL7H576qFXiQ2fkZ0KaG3+cABDJLqF0MUoqF5CBAvRxvO08CKz9CgDGEqIcF
         7+WCwwCerx/nrdNLdi/udeg5D29KUbz4hoL9iuZi7VppPXhWRk3YFfl/9bemvGxwEJx/
         wJfJ1s08HDMWpY0rXKDKuIvwWxdGXF8auu2NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rChkiNm0DGN9lEZ/1Cxc8ksjfYrvM3uvh3jfueH7fqg=;
        b=iQ/F7fbvVUywZcw2RDuatMkpRCJiXkcQ4t0E02b5ecURQW55pNl4R6PETws38U5U2o
         nBu7dEBNvHvkIojlrx0RGGUay4hzTFE1Q4Lchi7JAq8Jyn6eEjnGnsLpaYEu2NaF/WA+
         pud4Cur6JwbBUdTOuUrflm27qM1EekNQaZ95SSKM3Io+gCiWJbIs7voHGSP7LBtP5NVr
         1QaAjOQhVwE2on8AdfwLi3GjO7tADHwgEchobiyYTKO38+PFhzh8nHAk2+c91ndKIcZy
         q6kg1AR3MNHtYza1RPrWYZcGrsE/bO2BDAIZYnL84JxmqVRswxJbeQy7b3iT0JTahRg8
         7p+g==
X-Gm-Message-State: ABuFfoihB1uBv/EiOf9E4m6y8QWV7SLnkXL9fp9mBH5oo9dZdWhS+6Yn
        l25+iz4w+mYiQVz+elrOA3VFyA==
X-Google-Smtp-Source: ACcGV63UL9uftReAjK1RA4nUnZ1RVcrcvNs7x6lTHEXNDyntmXlFNvYkt28w3yC+g4N8h3LYHdaxPQ==
X-Received: by 2002:a62:184a:: with SMTP id 71-v6mr3779571pfy.246.1538607554303;
        Wed, 03 Oct 2018 15:59:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 64-v6sm4319374pgb.74.2018.10.03.15.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 15:59:13 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:59:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add UART nodes
Message-ID: <20181003225913.GK22824@google.com>
References: <20181003211239.41069-1-mka@chromium.org>
 <CAD=FV=XAqyLqyQQmM8pqPUh-ZvbxXgjSaypqGd4-orpWg3btgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XAqyLqyQQmM8pqPUh-ZvbxXgjSaypqGd4-orpWg3btgA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:31:03PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 3, 2018 at 2:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > +                       uart8: serial@a80000 {
> > +                               compatible = "qcom,geni-uart";
> > +                               reg = <0xa80000 0x4000>;
> > +                               clock-names = "se";
> > +                               clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> 
> uart8/10/11/12/13/14/15 are on GCC_QUPV3_WRAP1_S0_CLK, not WRAP0.
> 
> Everything else here looks good.  I ran my old hacky script at
> <http://crosreview.com/1091631> (mentioned in the message of commit
> 897cf34e7305 ("arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9
> nodes")) after changing it to generate "qcom,geni-uart" as the
> compatible string and changing it to generate nodes for all UARTs and
> the diff looks fine.
> 
> ...so once you fix the clock reference feel free to add my Reviewed-by.

Thanks for catching this! I'll send out a fixed version soon.
