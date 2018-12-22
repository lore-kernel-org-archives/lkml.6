Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DA21974
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gtAkhyCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404461AbeLVRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:25:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52400 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731167AbeLVRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=apuqiLj+TpxWJk6SYegcyJnD0U8ddp+XTxXkAZSGQJI=; b=gtAkhyCCS8LMlAogxjgM00QaQ
        RpDi5sFKB7qWgJRmi2gSL1VA2kj0j4QKiqumdHVaoSVKvlexBLNOxhOD/09LGxpdES5Xq0Rmz9lzw
        Gy+HER2wdmGRYNqofZ5UocK/S9neUyr0baly7LZdN5WFHyIB7ioFjZ1YuU/UMDXkHomsQ=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:46477)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gaeaz-0003YD-7G; Sat, 22 Dec 2018 10:33:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gaeaw-0002g3-Af; Sat, 22 Dec 2018 10:33:22 +0000
Date:   Sat, 22 Dec 2018 10:33:20 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robh@kernel.org, a.hajda@samsung.com, andy.shevchenko@gmail.com,
        b.zolnierkie@samsung.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: Add an error message to
 platform_get_irq*()
Message-ID: <20181222103320.GW26090@n2100.armlinux.org.uk>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181222072452.186726-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222072452.186726-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:24:52PM -0800, Stephen Boyd wrote:
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
...
> +error:
> +	if (warn)
> +		dev_err(&dev->dev, "IRQ%d not found\n", num);

Please don't use the notation IRQn - this is normally used when
referring to interrupt numbers (such as those seen in
/proc/interrupts) rather than a per-device interrupt index.
Grep for IRQ% in drivers/ for many examples.

dev_err(&dev->dev, "IRQ index %u not found: %d\n", num, ret);

would be better - note also the use of %u for unsigned integers.
Using %d for them is IMHO sloppy coding.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
