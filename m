Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CEBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B9B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H++l1mfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B9B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJJSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:00:17 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46560 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ODn6CSKedcw5RWj+VDJe64GPsn7ondlBdtqLXyCzepg=; b=H++l1mfSF/CcQRJHrl0k0wqiS
        0xZQHwbLCdrqmMlAg4NrstV0SN616BRfNwfnO3mSKD/ayV3hddLqgxVpsUNV3nPGkhqRsVk7e7Q9y
        LI6cbN5Ri60zwWvx8qc8YVhWmp2lPcxpkq93HpsWt9tgPrvVoJeFsG4jEuy//NdosnSYk=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:58239)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gABsw-0006DT-2t; Wed, 10 Oct 2018 11:38:34 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gABst-0000le-1a; Wed, 10 Oct 2018 11:38:31 +0100
Date:   Wed, 10 Oct 2018 11:38:29 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/imx: make sure to cleanup DRM before unbinding
 components
Message-ID: <20181010103829.GN30658@n2100.armlinux.org.uk>
References: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
 <e08eff2ed53b441c8a6c41758c00c1c91dc48d2c.1539120077.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08eff2ed53b441c8a6c41758c00c1c91dc48d2c.1539120077.git.stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:30:49PM +0200, Stefan Agner wrote:
> In situations where a component fails to bind, a previously
> successfully bound component might already registered itself
> with the DRM framework (e.g. an encoder). When the master
> component then calls drm_mode_config_cleanup, we end up in a
> use after free sitution.
> 
> Use the cleanup callback to make sure all framework level
> cleanup is done by the time we unbind components.

I'm not sure about this approach - the idea about the component bind
and unbind callbacks is that unbind undoes _everything_ that bind has
done, so everything is correctly ordered.  If bind registers something,
unbind should unregister it.

What seems to be going on is that imx is registering stuff in bind()
but not unregistering it in unbind().

Since imx was one of the drivers that the component helper was
created for, if it's now crashing, that's a regression in the imx
driver.  Looking at the commit log, I'd say:

commit 8e3b16e2117409625b89807de3912ff773aea354
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Thu Aug 11 11:18:49 2016 +0200

    drm/imx: don't destroy mode objects manually on driver unbind

    Instead let drm_mode_config_cleanup() do the work when taking down
    the master device. This requires all cleanup functions to be
    properly hooked up to the mode object .destroy callback.

    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

is probably responsible for introducing this problem, since the
explicit calls were added by me when imx was stuck in staging due to
the problems that the component helper solved.

I think what we have here are different opinions on how cleanup
should be handled.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
