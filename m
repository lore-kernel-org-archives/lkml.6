Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39446C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E721E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WOfb4efr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E721E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJLUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:31:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51494 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NG4XuLdYHT3yPUOmLHVgfEUhGAGgaOjVLAgb1Rz3Yj0=; b=WOfb4efrDd3mTiOvw2V7BCn8b
        +1BSzK+fdhZSms0mlQNC+hFhSty7NeHWCAo4g5V7DIdfHJUs4vebAapLpD7uShnCC3VCCST8DM+Zz
        /23ZUBoaJXYnOM48r8NlIZd8R3NfcRQPFws+7Rv2RsRwhNf07pdvwYet/X3nQcZEB02jo=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:33592)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gAx2H-0001Cy-HA; Fri, 12 Oct 2018 13:59:21 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gAx2B-0003dR-I2; Fri, 12 Oct 2018 13:59:16 +0100
Date:   Fri, 12 Oct 2018 13:59:12 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "zonque@gmail.com" <zonque@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "jmkrzyszt@gmail.com" <jmkrzyszt@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Message-ID: <20181012125911.GT30658@n2100.armlinux.org.uk>
References: <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com>
 <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
 <20181012104338.GS30658@n2100.armlinux.org.uk>
 <1539344591.30485.28.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539344591.30485.28.camel@toradex.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:43:13AM +0000, Marcel Ziswiler wrote:
> I don't think it is that fictitious as it makes it crystal clear that
> there is something shared with all its pros and cons. E.g. what happens
> if one of them regulators wants to turn off while the other one still
> needs power? The regular regulator dependency tree would nicely make
> this all clear.

If you're introducing a regulator that doesn't exist in reality
just to be able to share a GPIO line that is wired to several
real regulators, then it _is_ ficticious.  You're not describing
the hardware, you're describing something else to work around the
shortcomings of the implementation that can't cope with how stuff
is wired up in the real world.  You're making the DT description
fit the software implementation, rather than the software
implementation fit the real world hardware.

Having a single GPIO that controls multiple separate regulators
which have entirely separate supplies of their own is very common
in electronics.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
