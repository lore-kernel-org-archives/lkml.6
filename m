Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A2C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B153A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a0X8Yffr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B153A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJPQdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:33:54 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54932 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJPQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HhrCCdmRuR8ygsjo3OhRo1cOVDN1LaiZ/MYESyMaT3A=; b=a0X8YffrnbUxYvPt7p3lu48+q
        gbmT7kk/dla+AoVIQfGPHrp/+6TOVfw59bmcCviptExavbOQ9HWYNOvCIjZv5bTtCJxfu1zYt+ZVf
        Q6i0QiIqclgphRcUKe//8qE707bgKhRlQhGk9sD6pAqMdHt3j3ypLwH1SoabV/fJ3z7xE=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:40773)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCKxl-0005ZW-FM; Tue, 16 Oct 2018 09:44:25 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCKxg-0005Cp-AY; Tue, 16 Oct 2018 09:44:20 +0100
Date:   Tue, 16 Oct 2018 09:44:17 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Nicolas Pitre <nico@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Yeryomin <roman@advem.lv>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input
 operands list
Message-ID: <20181016084416.GF30658@n2100.armlinux.org.uk>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:
> On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:
> 
> > When functions incoming parameters are not in input operands list gcc
> > 4.5 does not load the parameters into registers before calling this
> > function but the inline assembly assumes valid addresses inside this
> > function. This breaks the code because r0 and r1 are invalid when
> > execution enters v4wb_copy_user_page ()
> >
> > Also the constant needs to be used as third input operand so account
> > for that as well.
> >
> > This fixes copypage-fa.c what has previously done before for the other
> > copypage implementations in commit 9a40ac86152c ("ARM: 6164/1: Add kto
> > and kfrom to input operands list.").
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Please add:
> Cc: stable@vger.kernel.org

It's not obvious yet whether this is right - it contradicts the GCC
manual, but then we have evidence that it's required for some GCC
versions where GCC may clone the function, or if the function is
used within the same file.

> I am on deep waters with ARM assembly, admittedly. So I wanted to
> ask: OpenWRT has this cache patch:
> https://github.com/openwrt/openwrt/blob/master/target/linux/gemini/patches-4.14/0001-cache-patch-from-OpenWRT.patch
> I do not know why (sorry).
> 
> Do you think that patch is actually a hack to hide the problem
> fixed with this patch? (OK maybe stupid question but...)

No, it looks to me like a hack to make DMA cache handling "more
efficient" by cleaning/invalidating the entire cache when dealing
with large streaming buffers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
