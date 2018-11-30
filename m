Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9902C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBCF2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k0pmH5bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBCF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLAGM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:12:28 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58892 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5leHZfbMcf4rOY8szzHEAYP0ejW4Zri1zuW+6NgRYIw=; b=k0pmH5bpry1gfGDBeVow7uA4r
        qqMDHwIfcmwrzDGFsGgjMXg27176OBagIcntzify+0wKQU1NA3rsyWvtYZcnFM8Z7/P1VD4fQhxrk
        sydV713wBbj2Y54DcmIxkOyEqr4nI0zE/zCF6tISNbcoMiX13OO0aAM9NJR2yp4xTjgZc=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:46712)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSo3G-0001WD-Bf; Fri, 30 Nov 2018 19:02:10 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSo37-0002E5-KU; Fri, 30 Nov 2018 19:02:01 +0000
Date:   Fri, 30 Nov 2018 19:02:00 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 14/83] ARM: make lookup_processor_type() non-__init
Message-ID: <20181130190200.GI30658@n2100.armlinux.org.uk>
References: <20181129140138.002176596@linuxfoundation.org>
 <20181129140138.869602566@linuxfoundation.org>
 <20181129142817.GW30658@n2100.armlinux.org.uk>
 <20181130151554.GA29005@kroah.com>
 <20181130151843.GB29005@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130151843.GB29005@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:18:43PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 30, 2018 at 04:15:54PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 29, 2018 at 02:28:18PM +0000, Russell King - ARM Linux wrote:
> > > Hi,
> > > 
> > > As I've already fed back to Sascha about this, this patch on its own
> > > does not fix anything, and is not a stable kernel candidate without
> > > a patch that makes use of it (iow, the spectre fixes.)  It is a
> > > preparatory patch for mainline commit 383fb3ee8024.
> > > 
> > > Every commit in:
> > > 
> > > $ git rev-list v4.16..383fb3ee8024
> > > 
> > > are the ARM spectre fixes, which are being back-ported by David Long.
> > > 
> > > Please do not cherry-pick commits from within this series for _any_
> > > stable kernel, but please wait for David to send you the back-ported
> > > patches.
> > 
> > Ugh, ok, that's a bunch here.
> 
> Ok, not that bad, only 4:
> 	383fb3ee8024 ("ARM: spectre-v2: per-CPU vtables to work around big.Little systems")
> 	e209950fdd06 ("ARM: add PROC_VTABLE and PROC_TABLE macros")
> 	945aceb1db88 ("ARM: clean up per-processor check_bugs method call")
> 	899a42f83667 ("ARM: make lookup_processor_type() non-__init")
> 
> I'll go drop them all from the trees now.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
