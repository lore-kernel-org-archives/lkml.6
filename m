Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD85BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876C1208A4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876C1208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGGP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:58:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbeGGP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:58:17 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A031CDBB;
        Sat,  7 Jul 2018 15:58:15 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:58:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] driver core: allow stopping deferred probe after
 init
Message-ID: <20180707155811.GA26377@kroah.com>
References: <20180628204344.13973-1-robh@kernel.org>
 <20180628204344.13973-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628204344.13973-2-robh@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:43:39PM -0600, Rob Herring wrote:
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
> 
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>

I wanted to apply this series, but this patch failed to apply to my
driver-core tree :(

Can you rebase it and resend?

thanks,

greg k-h
