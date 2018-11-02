Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C39C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A852082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A852082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeKCIwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:52:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51394 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeKCIwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:52:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xnm0jc4hfx1w; Sat,  3 Nov 2018 00:42:54 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD3B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:3b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44FF21EC0A67;
        Sat,  3 Nov 2018 00:42:54 +0100 (CET)
Date:   Sat, 3 Nov 2018 00:42:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: skx_edac: add ACPI dependency
Message-ID: <20181102234255.GE26770@zn.tnic>
References: <20181102153232.1450251-1-arnd@arndb.de>
 <20181102161013.GG14602@zn.tnic>
 <20181102173959.GA27709@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102173959.GA27709@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:39:59AM -0700, Luck, Tony wrote:
> On Fri, Nov 02, 2018 at 05:10:13PM +0100, Borislav Petkov wrote:
> > On Fri, Nov 02, 2018 at 04:32:06PM +0100, Arnd Bergmann wrote:
> > > We cannot currently select ACPI_ADXL without also enabling the top-level
> > > ACPI option:
> > > 
> > > WARNING: unmet direct dependencies detected for ACPI_ADXL
> > >   Depends on [n]: ACPI [=n]
> > >   Selected by [y]:
> > >   - EDAC_SKX [=y] && EDAC [=y] && PCI [=y] && X86_64 [=y] && X86_MCE_INTEL [=y] && PCI_MMCONFIG [=y] && (ACPI_NFIT [=n] || !ACPI_NFIT [=n])
> > 
> > That should fix the issue too:
> > 
> > https://marc.info/?l=linux-acpi&m=154102117706500&w=2
> 
> I have to say that Arnd's fix is prettier. With it, we can go back
> to
> 
> 	select ACPI_ADXL
> 
> instead of
> 
> 	select ACPI_ADXL if ACPI

Arnd's fix already has that last line in there:

 config EDAC_SKX
        tristate "Intel Skylake server Integrated MC"
-       depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
+       depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG && ACPI
        depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
        select DMI
        select ACPI_ADXL if ACPI
	^^^^^^^^^^^^^^^^^^^^^^^^

so I'm reading this as *additionally* needed, ontop of the ugly fix.

But let's wait until he clarifies first.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
