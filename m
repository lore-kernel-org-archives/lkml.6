Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C0AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ACD20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ACD20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeHQC2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 22:28:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:14000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeHQC2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 22:28:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 16:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,249,1531810800"; 
   d="scan'208";a="225288789"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 16:26:44 -0700
Date:   Thu, 16 Aug 2018 16:26:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jchandra@broadcom.com, Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: how to fix acpi_pci_root_remap_iospace?
Message-ID: <20180816232639.GA25889@agluck-desk>
References: <20180816204506.GA21144@agluck-desk>
 <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:10:33PM +0200, Arnd Bergmann wrote:
> Another way would be to add
> 
>  #include <asm-generic/io.h>
> +#undef PCI_IOBASE
> 
> in your asm/io.h. This is about as ugly as the your version, but
> it would be local to ia64 ;-)

Third way ...


Is "0" actually the right value for PCI_IOBASE for some platform?

#ifndef PCI_IOBASE
#define PCI_IOBASE ((void __iomem *)0)
#endif

Or is this just here to make sure that:

static inline u8 inb(unsigned long addr)
{
        u8 val;

        __io_pbr();
        val = __raw_readb(PCI_IOBASE + addr);
        __io_par();
        return val;
}

etc. Do not throw errors?

Should we really just enclose all of inb, inw, inl, ...
inside of:

#ifdef PCI_IOBASE

... all those static functions that use PCI_IOBASE ...

#endif


-Tony
