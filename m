Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5833C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA948214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qEaDWBuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA948214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeKVFSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:18:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeKVFSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:18:14 -0500
Received: from zn.tnic (p200300EC2BD0AB00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:ab00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C9841EC0B07;
        Wed, 21 Nov 2018 19:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542825763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VK4SdnpJFPyLCuz5a+ZT5iRsO7HzYwchMEG7fctwy1E=;
        b=qEaDWBuf9Fn7Xl9UFJ386DMPLxlTsh7cTfmRtI7ARokdFA6VBcftT10iayHi+8CJjefJPK
        Aqyk7LZpH/TT6Dpl6EID6r4Pb9/30ASadzzvOZYkQITR4nnt0cap9BLB+uQRL5JJSCL/4S
        W/2pNnXGG5FWQTyDu8n7QDEetmejXkA=
Date:   Wed, 21 Nov 2018 19:42:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     bjorn@helgaas.com
Cc:     lijiang@redhat.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86 <x86@kernel.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181121184232.GB27559@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:43:57PM -0600, Bjorn Helgaas wrote:
> MMCONFIG (aka ECAM) space is described in the ACPI MCFG table.  The
> generic code to read that is in drivers/acpi/pci_mcfg.c (ignore all
> the quirks at the top) and the generic code to use it is
> drivers/pci/ecam.c.

/me saves that for future reference.

> Unfortunately x86 doesn't use any of that generic path.  It uses the
> same MCFG table, but it's parsed in arch/x86/pci/mmconfig-shared.c,
> and the code there checks to ensure the ECAM regions are reserved
> somehow by firmware, e.g., via the e820 table.

As they are on my workstation here, for example:

[    0.552607] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820

vs the "ACPI motherboard resources" reservation thing where it traverses
some PNP devices.

> There's a bunch of grungy device-dependent code there, too, possibly
> to work around firmware defects, or (just as likely) to compensate for
> Linux defects that were *attributed* to firmware.

Nah, latter we simply fix. :-)

> I think you should regard correct MCFG/ECAM usage in the kdump kernel
> as a requirement.  If you don't have ECAM (a) PCI devices won't work
> at all on non-x86 systems that use only ECAM for config access, (b)
> you won't be able to access devices on non-0 segments (granted, there
> aren't very many of these yet, but there will be more in the future),

Ah. don't worry, someone will pop up from the woodwork with the need for
this ;-\

> and (c) you won't be able to access extended config space (addresses
> 0x100-0xfff), which means none of the Extended Capabilities will be
> available (AER, ACS, ATS, etc).

Yap, and this answers my question:

e820__mapped_all() is being called with E820_TYPE_RESERVED down the path
in pci_mmcfg_check_reserved(). Which basically says that we need to
provide all reserved regions in the second kernel so that MMCONFIG works
there.

Thanks a lot Bjorn!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
