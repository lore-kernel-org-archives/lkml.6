Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ECC20864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qMKvfezm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ECC20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeK2EmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:42:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52326 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbeK2EmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=COh69bjQPE/f8vx0HdFjKn0LcpPO3aKPCfDM2iqkD2g=; b=qMKvfezmS3lQKiNSH+g1MuRkr
        g10yDSyVn35TWrK7ypHA0BJh+5qSryaSzHq62jFRRknOXqJOfCXwSS0f5uiyz64dP42/Z3szcaJqd
        hnZAxW8kD4X7yFvjYhk0iOztVdpYiU88zKLaGB9j6Mf1pVXI/CZcAFyk43EJFhhEScdVc=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:51115)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS3oD-00062B-Ca; Wed, 28 Nov 2018 17:39:33 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS3oA-0005UN-KY; Wed, 28 Nov 2018 17:39:30 +0000
Date:   Wed, 28 Nov 2018 17:39:28 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 10/21] ARM: make lookup_processor_type()
 non-__init
Message-ID: <20181128173928.GI30658@n2100.armlinux.org.uk>
References: <20181122195452.13520-1-sashal@kernel.org>
 <20181122195452.13520-10-sashal@kernel.org>
 <20181123000254.GM30658@n2100.armlinux.org.uk>
 <20181128141252.GB131942@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128141252.GB131942@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 09:12:52AM -0500, Sasha Levin wrote:
> On Fri, Nov 23, 2018 at 12:02:54AM +0000, Russell King - ARM Linux wrote:
> >Hi Sasha,
> >
> >We need to keep track of which Spectre patches have been backported
> >and which haven't.  David Long has been doing the backport work,
> >which doesn't include all the patches in my present spectre branch.
> >You've picked up the last five, meaning there's a bunch in the middle
> >of the entire series which haven't yet been considered - for example,
> >the Spectre variant 1.1 patches.
> 
> I'll drop all the ones you pointed out from my branches. Sometimes it's
> difficult to tell if a certain patch is part of the spectre fix.

Given that all the 32-bit ARM Spectre patches are sequential in a
branch, it shouldn't be too difficult as it's possible to list all
the commit IDs using:

$ git rev-list v4.16..383fb3ee8024

where 383fb3ee8024 is the current head.  I'm not anticipating at this
time anything further.

> >The entire series of 32-bit ARM Spectre patches can be listed in
> >mainline via:
> >
> >$ git log v4.16..383fb3ee8024
> >
> >where almost all of those need to be applied to stable kernels, with
> >possible manual back-porting where they don't apply.
> 
> Is it something that will be backported at some point?

Yes, as I mentioned, this is work that David Long is undertaking,
with a separate review process before submitting the backported
patches for inclusion in the appropriate stable tree.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
