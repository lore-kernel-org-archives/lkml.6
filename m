Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599BAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C8320854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C8320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeGMRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:24:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGMRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:24:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ZDgmY6Kfrv0; Fri, 13 Jul 2018 19:09:00 +0200 (CEST)
Received: from nazgul.tnic (unknown [78.130.197.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEDCD1EC0310;
        Fri, 13 Jul 2018 19:08:59 +0200 (CEST)
Date:   Fri, 13 Jul 2018 19:08:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180713170857.GB17896@nazgul.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:55:35PM +0800, lijiang wrote:
> About this issue, i want to use an example to describe it.
> /* drivers/iommu/amd_iommu_init.c */
> static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)

Those addresses come from the IVHD header which is an ACPI table. So the
dump kernel can find that out too.

> Obviously, the iommu mmio space is not encrypted, and the device
> mmio space is outside kdump kernel. We know that the old memory is
> encrypted, and the old memory is also outside kdump kernel. For the
> current case, e820__get_entry_type() and walk_iomem_res_desc() can't
> get the desired result, so we can't also decide whether encryption
> or not according to this result(rules). If we want to know whether
> encryption or not by deducing the address, we will need to read the
> content of memory and have a reference value for comparison, then
> what's a reference value? Sometimes we don't know that.

Again, if we don't know that how is the *caller* supposed to know
whether the memory is encrypted or not? Because

"we" == "caller"

in the kdump kernel.

And the more important question is, why are we dumping MMIO space of the
previous kernel *at* *all*? That doesn't make any sense to me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
