Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E1C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B0D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B0D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIMI13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:27:29 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:41632 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeIMI13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:27:29 -0400
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2AB2A4402AF;
        Thu, 13 Sep 2018 06:19:55 +0300 (IDT)
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz> <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since "PCI: mvebu: Only remap I/O space if configured"
In-reply-to: <20180912231050.GX30658@n2100.armlinux.org.uk>
Date:   Thu, 13 Sep 2018 06:19:54 +0300
Message-ID: <87y3c63wyt.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Russell King - ARM Linux writes:
> On Wed, Sep 12, 2018 at 09:49:41PM +0300, Baruch Siach wrote:
>> I reproduced the same Oops on Clearfog Base without any taint:
>> 
>> [    1.476401] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> ...
>> [    1.855954] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)
>
> That is a BUG().  Please turn on verbose bug reporting to get more
> information about the cause.
>
> There are two possibilities:
>
>         BUG_ON(addr >= end);
>
> and
>
>                 BUG_ON(!pte_none(*pte));
>
> It's probably the latter - the region is probably already mapped, that
> being the PCI IO region.

That is the one. Enabling CONFIG_DEBUG_BUGVERBOSE shows:

[    1.481927] kernel BUG at lib/ioremap.c:72!
[    1.486118] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.491269] CPU: 0 PID: 1246 Comm: kworker/0:2 Not tainted 4.19.0-rc3 #146
...

baruch

> The original driver was setup to call pci_ioremap_io() as the very
> last thing - and as the driver is non-removable, we were guaranteed
> to never tear down this mapping (which is sensible, it's published
> to userspace.)
>
> However, the current code calls pci_ioremap_io() much earlier, in
> a path where probe failures can occur.  This breaks pci_ioremap_io()'s
> requirements - it must not be called more than once.  So:
>
> ee1604381a37 ("PCI: mvebu: Only remap I/O space if configured")
>
> is basically incorrect - pci_ioremap_io() needs to move back to a
> place where it is only called in a path which will never fail.
> However, looking at the generic host bits, I'm not sure such a place
> exists in the new effort to make stuff more generic.

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
