Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCABC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5B720835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UGbtMnBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5B720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933921AbeGIPw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:52:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35652 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeGIPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N1x9p2d/UbVZA/plWILacPxGjpFcmRK4JRTODSxJfuc=; b=UGbtMnBbVL6tHRsi79U8G/q/r
        XVnAt1DkXktHP20s23lCWGZE/VhGonCxy2piXi8gJU4OuBhxHs1IiGR/KdPX9oiw3NAftM5vy2HLi
        G4LUqd+NoslguAyV8qZrRsX5k94Fc3VRBdYbdYEdTnsha4gpBq6zvMUXqe313Zl2QVmtc=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:58638)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fcYSX-0006aM-18; Mon, 09 Jul 2018 16:52:17 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fcYSM-00033T-OH; Mon, 09 Jul 2018 16:52:06 +0100
Date:   Mon, 9 Jul 2018 16:52:01 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        boot-architecture@lists.linaro.org,
        Kevin Hilman <khilman@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] driver core: allow stopping deferred probe after
 init
Message-ID: <20180709155201.GG17271@n2100.armlinux.org.uk>
References: <20180709154153.15742-1-robh@kernel.org>
 <20180709154153.15742-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709154153.15742-2-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:41:48AM -0600, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version. Deferred
> probe issues can be difficult to debug especially if the console has
> dependencies or userspace fails to boot to a shell.
> 
> There are also cases like IOMMUs where only built-in drivers are
> supported, so deferring probe after initcalls is not needed. The IOMMU
> subsystem implemented its own mechanism to handle this using OF_DECLARE
> linker sections.
> 
> This commit adds makes ending deferred probe conditional on initcalls
> being completed or a debug timeout. Subsystems or drivers may opt-in by
> calling driver_deferred_probe_check_init_done() instead of
> unconditionally returning -EPROBE_DEFER. They may use additional
> information from DT or kernel's config to decide whether to continue to
> defer probe or not.
> 
> The timeout mechanism is intended for debug purposes and WARNs loudly.
> The remaining deferred probe pending list will also be dumped after the
> timeout. Not that this timeout won't work for the console which needs
> to be enabled before userspace starts. However, if the console's
> dependencies are resolved, then the kernel log will be printed (as
> opposed to no output).

So what happens if we have a set of modules which use deferred probing
in order to work?

For example, with sound stuff built as modules, and auto-loaded in
parallel by udev, the modules get added in a random order.  The
modules have non-udev obvious dependencies between them (resource
dependencies) which result in deferred probing being necessary to
bring the device up.

Eg,

snd_soc_kirkwood_spdif module declares the ASoC card.
snd_soc_spdif_tx is a codec as a loadable module.
snd_soc_kirkwood is the CPU digital audio interface module.

What I commonly see is this module load order:

snd_soc_kirkwood_spdif, then snd_soc_kirkwood and then snd_soc_spdif_tx.

This results at boot in:

kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CODEC DAI dit-hifi not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CODEC DAI dit-hifi not registered
kirkwood-spdif-audio audio-subsystem: snd-soc-dummy-dai <-> kirkwood-fe mapping ok
kirkwood-spdif-audio audio-subsystem: multicodec <-> kirkwood-spdif mapping ok

at boot, where most of these are deferred probe attempts.

So, disabling deferred probing after all the kernel-internal initcalls
are run is wrong.  You can have deferred probing required due to
external modules, and this can kick in at any time (think about
hot-pluggable hardware with a driver that's somehow componentised,
like an audio device...)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
