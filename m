Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623BAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JTPSHwHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2712C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJLSPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:15:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49956 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rnEl5GzSV3YXxFHSjGvf9aWvBWNTMoQfF8ESPq/Weo=; b=JTPSHwHSouEJYne4AWe8byJMC
        x3dbLYeroVpNFiTs5e/YVEHKi3aooYvKWpaCYuFDTVhcjCDY/dWhP0rfA6niW0re4rjg3c0Fx1mUX
        0Kz3vmhkHtgbckD4073yFxp/oVgqGyiowy6evyNAjxx+mr9ugF0ILK6pJ/qpousja8600=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:42337)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gAuv2-0000g5-D1; Fri, 12 Oct 2018 11:43:44 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gAuuy-0002M6-Oi; Fri, 12 Oct 2018 11:43:41 +0100
Date:   Fri, 12 Oct 2018 11:43:38 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
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
Message-ID: <20181012104338.GS30658@n2100.armlinux.org.uk>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com>
 <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:39:15AM +0100, Jon Hunter wrote:
> We had the same situation for Tegra124 Jetson TK1 but I don't think that
> adding a pseudo intermediate regulator is cleaner. If the GPIO controls
> more than one regulator, I don't see why is it necessary to change the
> DT. There are several other people reporting the same problem with
> various different boards. So this does seem to be a common usage.

Given that DT describes the hardware, not the software implementation,
it must not change just because we move from GPIO numbers to GPIO
descriptors.

The existing DT description is reasonable, and introducing ficticious
regulators in DT to work around the implementation is not reasonable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
