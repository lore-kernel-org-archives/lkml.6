Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC840C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EE820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aQFhozzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EE820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbeKGUV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:21:27 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39124 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QnNk0YeMROty7L17O57/dvyZMVFLdjfFBr7aoHKIuFQ=; b=aQFhozzjI+ny6aPzug0B18ZL3
        Se6fDO1YQuc7igp965HIkYIEoSHjrWndi/WiEypq7p1TGYWI6bwciM2Jvv4TgRIB6Dnr3rEZlz8Ee
        TJaLiqn2Ikhk2YBO2TbKbcZD1mK0d6ByhCAZvMi+PGFST6bBXv9XdLOvsHrdabCZi+zmA=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38658)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gKLQi-0005ty-At; Wed, 07 Nov 2018 10:51:24 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gKLQf-0000VR-Ls; Wed, 07 Nov 2018 10:51:21 +0000
Date:   Wed, 7 Nov 2018 10:51:19 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/15] Bluetooth: hci_bcm: Simplify clk_get error handling
Message-ID: <20181107105119.GT30658@n2100.armlinux.org.uk>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-7-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107101308.7626-7-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:12:59PM +0800, Chen-Yu Tsai wrote:
> @@ -911,6 +911,10 @@ static int bcm_get_resources(struct bcm_device *dev)
>  	if (IS_ERR(dev->clk) && PTR_ERR(dev->clk) == -EPROBE_DEFER)

You can also simplify the above test to:

	if (dev->clk == ERR_PTR(-EPROBE_DEFER))

as error pointers are uniquely different from normal pointers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
