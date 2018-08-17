Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2705EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD0F21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD0F21A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeHQTYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:24:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56239 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeHQTYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:24:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DDAE9215D8; Fri, 17 Aug 2018 18:20:13 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F2E5212C4;
        Fri, 17 Aug 2018 18:20:03 +0200 (CEST)
Date:   Fri, 17 Aug 2018 18:20:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Subject: Re: how to fix acpi_pci_root_remap_iospace?
Message-ID: <20180817182003.22f4e198@bbrezillon>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D3B3159@ORSMSX110.amr.corp.intel.com>
References: <20180816204506.GA21144@agluck-desk>
        <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
        <20180816232639.GA25889@agluck-desk>
        <CAK8P3a0hFDv2kvVN=QobTVaZxAX-M+YZzkBU_b=vDGLbCLziNg@mail.gmail.com>
        <20180817105551.100d6e0a@bbrezillon>
        <3908561D78D1C84285E8C5FCA982C28F7D3B3159@ORSMSX110.amr.corp.intel.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:56:23 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> >> - Some targets don't have any support for I/O space on their PCI bus and just
> >>    want to get things to compile by setting PCI_IOBASE to zero, this still opens
> >>     up some of the same problems as above, but doesn't really help otherwise.  
> 
> That sounds horrible. Why would you want to have a driver that can't possibly
> work on your platform compile cleanly? That's just asking for trouble. Sombody
> might load that driver, and ... all the outb/outw/outl calls just corrupt low memory.

Well, COMPILE_TEST is here just for that, and it's actually quite
useful to detect potential compilation errors/warnings and make sure
the driver is portable. So, either we decide that readsx/writesx() are
not standard and we create a Kconfig option to reflect when an arch
implements them so that drivers using those funcs can at least be
compile-tested on a few archs, or we fix all archs that do not
implement those functions.

> 
> > Hm, maybe it's just easier to revert the patch since we got rid of
> > patches adding COMPILE_TEST to drivers which were using read/writesl()
> > (it turned out ia64 and sparc were not the only archs to not implement
> > readsx/writesx() variants, and fixing them is not that easy).  
> 
> That sounds like a better course of action.

The solution I propose here is just a way to get that problem fixed
quickly, but I'd still like to have a way to enable the s3c2xx and
orion NAND driver when COMPILE_TEST=y.
