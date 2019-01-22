Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CB8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D2C217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGaHEIcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfAVVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:13:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44022 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfAVVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:13:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so24996294otr.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SXGfUfbqkWROu34b5v4AYgOrxsUcGJH357ltlGyo9L8=;
        b=fGaHEIczp0cXNaFIbGcNfyeUizHfqDTXJY7FuDAq19uVL9wqv16RGKUpni8Iuykx/l
         XpiGlTlzPsj+wdrbE//KHRHBmmuSxEFG+Rs7UfuCdbvaXlo6WcJyBJkaeJY/50e2yemf
         ti/TnHbe42HnHLp4PyD/8CwpK4KgWdrKQ1Zvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXGfUfbqkWROu34b5v4AYgOrxsUcGJH357ltlGyo9L8=;
        b=nn+07pRq0fpFbhRoWYfaC7rO+9EMu/m1/8UxssX0z4JzSWhBZZWBSy5HbZ2ke6HQqg
         gaKRh3MdGAA+9RiDN8vhD1gxiqhq5le9pZ9nBXnLPmWK3/wkQG23oJrYEKlo6mdE4/VJ
         TljBDWubmWQI3h520DtJDZ1QLDseveHik1OJFJE2ssHdGDpy3aQe5JqO0KwoM5cPeX/J
         2DBP7n3fbKhq/cb7QX1C2xxoqtHVZAHEjvAzT88qg1eKwGe0oiNNpKmtYw1nk25gyS28
         DlmozucM5rTyf33WdYIFUz1SmbSw/C9hBqq24k8QJKqVvNSMkTXSyd/LxiD1TuE1yq59
         Hq/w==
X-Gm-Message-State: AJcUukcYONLs/3In8O9OKwVtAd7s4KE0+DpomtpleC0J8Vg8z0kS+R0P
        JMbrRCTMkLqsMWsUL06QmTBO8w==
X-Google-Smtp-Source: ALg8bN6Mhuz9TYD+1xUjodUKIq3pdqnhXRGH3ckKMvm0gJwKp5J5dmRZM8DS/ZzyBF0F2kIe4sHZAw==
X-Received: by 2002:a9d:1296:: with SMTP id g22mr21719223otg.305.1548191630466;
        Tue, 22 Jan 2019 13:13:50 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id n185sm8065230oih.18.2019.01.22.13.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:13:49 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:13:46 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 00/15] qcom: spmi: add support for hierarchical IRQ
 chip
Message-ID: <20190122211346.GA30582@hector.attlocal.net>
References: <20190119204252.18370-1-masneyb@onstation.org>
 <CACRpkdap+AJ+eDVusg=ShwRKXOuR=tAyNLBeCxsxuu28DSfisQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdap+AJ+eDVusg=ShwRKXOuR=tAyNLBeCxsxuu28DSfisQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:31:20PM +0100, Linus Walleij wrote:
> On Sat, Jan 19, 2019 at 9:43 PM Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch series adds hierarchical IRQ chip support to spmi-gpio so
> > that device tree consumers can request an IRQ directly from the GPIO
> > block rather than having to request an IRQ from the underlying PMIC.
> 
> I have applied all these patches including the DTS patches to the GPIO
> tree and pushed for linux-next.
> 
> If all works out well I will solidify the branch, pull it into the pin control
> tree as well and offer the branch to ARM SoC.

Thanks Linus!
