Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF12146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JLSj7SCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBF12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeIREnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51454 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UcA7K8HVcFS6vMCmv4ZO0/XdStgByiP6jDGluDLBoag=; b=JLSj7SCtSRtl7OLBw1r4iVp9D
        a5+GG9bBOyyCHz9EKnxUNBXHczuPQrpwc8OLNXN4CBZRn7g9KoF4ExR7UGIm/vguC+dHBAq/ASayA
        L8A2vjaH2DfX4ButT8TVBkDy/GppeLlEQCwSstc7dobsZEJ2by4KuZLtfMATBlL7yh7+c=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:52785)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g22iF-00020u-NM; Tue, 18 Sep 2018 00:13:51 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g22iC-0001Rt-RM; Tue, 18 Sep 2018 00:13:48 +0100
Date:   Tue, 18 Sep 2018 00:13:46 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: sfp: Prevent NULL deference of socket_ops
Message-ID: <20180917231346.GG30658@n2100.armlinux.org.uk>
References: <20180914230132.23228-1-f.fainelli@gmail.com>
 <20180915073228.GE30658@n2100.armlinux.org.uk>
 <3abb0233-4234-ca8c-31ac-8a6b9e123064@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abb0233-4234-ca8c-31ac-8a6b9e123064@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:30:52AM -0700, Florian Fainelli wrote:
> On 09/15/2018 12:32 AM, Russell King - ARM Linux wrote:
> > On Fri, Sep 14, 2018 at 04:01:31PM -0700, Florian Fainelli wrote:
> >> In case we have specified a SFP and an I2C phandle in the Device Tree,
> >> but we somehow failed to look up the I2C adapter (e.g: the driver is not
> >> enabled), we will leave dangling socket_ops, and the sfp_bus will still
> >> have been registered. We can then observe NULL pointer dereferences
> >> while doing ethtool -m:
> >>
> >> [   20.218613] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> >> [   20.226977] pgd = (ptrval)
> >> [   20.229785] [00000008] *pgd=7c400831, *pte=00000000, *ppte=00000000
> >> [   20.236274] Internal error: Oops: 17 [#1] SMP ARM
> >> [   20.241122] Modules linked in:
> >> [   20.244278] CPU: 0 PID: 1480 Comm: ethtool Not tainted 4.19.0-rc3 #138
> >> [   20.251013] Hardware name: Broadcom Northstar Plus SoC
> >> [   20.256316] PC is at sfp_get_module_info+0x8/0x10
> >> [   20.261172] LR is at dev_ethtool+0x218c/0x2afc
> >>
> >> Specifically guard against that.
> > 
> > The other alternative to this would be to only set ndev->sfp_bus when
> > the bus moves to registered state, which would probably be a saner
> > alternative than to add an additional layer of tests.  IOW:
> 
> Indeed, your patch works for me:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, I'll re-send it properly for davem tomorrow.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
