Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DB520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HMny3uil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DB520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405201AbeKVVIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:08:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33076 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390585AbeKVVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6x2MxDkHB6qpj5hyItW86b8z8/JLPKx7NNxTtyvEZF4=; b=HMny3uilNNBrwK5jyYJGpduUD
        K+GdeQtte1lRl8SFPdmYacBdaX2ydhKddcjXHPpvCdJvGL7ljrkkPkSj0AZVWB0KaYaV4jIWXg3rQ
        AtiHK3iDnJ+8CiUv2o8uNNETzYr2uKeDagdOglmSK+y8Ar+cVUcDIIdDXAnrtNPl9yO7E=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:48885)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPmF6-0001U6-7s; Thu, 22 Nov 2018 10:29:52 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPmF3-0008AK-KY; Thu, 22 Nov 2018 10:29:49 +0000
Date:   Thu, 22 Nov 2018 10:29:48 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181122102948.GN6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> API were too annoying and flooding the console. And now that I tried
> using DMA again with g_ether, it doesn't work anymore. The device get's
> recognized on host side, but no traffic goes through. Switching back to
> PIO makes it to work again.

A solution to that would be to do what the warning message says, and
update the driver to the DMAengine API.

The reason it didn't get updated when the DMAengine conversion happened
is because I don't have hardware for it, so had no way to test, and no
one seemed to know that anyone was using it.  Eventually, the WARN_ON()
was added to try and root out any users and generate interest in
updating the drivers.  Obviously that didn't happen, because people
just worked around the warning rather than saying anything.

I'm afraid we're long past the time that I'd be willing to update the
omap_udc driver now as I've dropped most of my knowledge on that as
it's been four years, and Peter has been looking after OMAP DMAengine
issues since.

Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
