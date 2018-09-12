Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B1C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30782146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c46G/2mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30782146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIMERu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:17:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57628 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIMERt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zs9yXh4E72VTbWRc7k7YA9oLVP1vM34WmaYbsPLQbpc=; b=c46G/2mpBNPHveeGFZzQSHg7s
        bcHpEDu122D0EvTQnVpQKdCMirTKd66KKqUOKTm0STha61LCqYcVnY9tWbQw7E7QUorBEIMkxANq/
        MK+wf++b5gTL/VO/JvGao1e6voiQmZtB+cC6DjOFJIQ5sCtmW35sAN6uhjhM4ieQeBWos=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:38876)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g0EHf-0007F2-IO; Thu, 13 Sep 2018 00:10:55 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g0EHc-0000sE-TL; Thu, 13 Sep 2018 00:10:52 +0100
Date:   Thu, 13 Sep 2018 00:10:51 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180912231050.GX30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhwm4kl6.fsf@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:49:41PM +0300, Baruch Siach wrote:
> I reproduced the same Oops on Clearfog Base without any taint:
> 
> [    1.476401] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
...
> [    1.855954] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)

That is a BUG().  Please turn on verbose bug reporting to get more
information about the cause.

There are two possibilities:

        BUG_ON(addr >= end);

and

                BUG_ON(!pte_none(*pte));

It's probably the latter - the region is probably already mapped, that
being the PCI IO region.

The original driver was setup to call pci_ioremap_io() as the very
last thing - and as the driver is non-removable, we were guaranteed
to never tear down this mapping (which is sensible, it's published
to userspace.)

However, the current code calls pci_ioremap_io() much earlier, in
a path where probe failures can occur.  This breaks pci_ioremap_io()'s
requirements - it must not be called more than once.  So:

ee1604381a37 ("PCI: mvebu: Only remap I/O space if configured")

is basically incorrect - pci_ioremap_io() needs to move back to a
place where it is only called in a path which will never fail.
However, looking at the generic host bits, I'm not sure such a place
exists in the new effort to make stuff more generic.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
