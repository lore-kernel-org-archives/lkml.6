Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880802146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880802146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbeKOUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:47:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOUrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:47:22 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0UkyxdbKJob3; Thu, 15 Nov 2018 11:40:04 +0100 (CET)
Received: from zn.tnic (p200300EC2BD00900D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:900:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CC0C1EC0606;
        Thu, 15 Nov 2018 11:40:04 +0100 (CET)
Date:   Thu, 15 Nov 2018 11:39:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181115103959.GB26448@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Bjorn.

On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
> At present, the upstream kernel does not pass the e820 reserved ranges to the
> second kernel, which might cause two problems:
> 
> The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> the reserved region otherwise it falls back to legacy mode, which might lead to
> the hot-plug device could not be recognized in kdump kernel.

Well, this still doesn't explain it fully. Let's look at a box:

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable

this one has 8 reserved regions. Does that mean that we need to pass
them *all* 8 to the second kernel so that MMCONFIG works?

Or is it only one reserved region which is needed for MMCONFIG?

Bjorn, do you know what the detection logic should be to map the correct
reserved region (or regions) for MMCONFIG?

Now, even if we don't map that reserved region and MMCONFIG falls back
to legacy mode, why is that a problem for the kdump kernel? Why does
the kdump kernel need the hotplug device? What would be the use case?
Hotplug a SATA drive to store the memory dump to it ... or?

> Another one is that the e820 reserved ranges do not setup in kdump kernel, which
> could cause kdump can't work in some machines. To know more information, please
> refer to the [PATCH 2/2 v6] patch log.

Yah, I still don't understand *why* we need the reserved ranges in the
second kernel. Once we've figured out the *why* we can look at the *how*.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
