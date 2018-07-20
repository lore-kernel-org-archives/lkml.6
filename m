Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36183ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E2320856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E2320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeGTFxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbeGTFxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89E0372643;
        Fri, 20 Jul 2018 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16D5F7C3C;
        Fri, 20 Jul 2018 05:07:03 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
Date:   Fri, 20 Jul 2018 13:06:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180713170857.GB17896@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 05:07:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 05:07:13 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月14日 01:08, Borislav Petkov 写道:
> On Mon, Jul 09, 2018 at 09:55:35PM +0800, lijiang wrote:
>> About this issue, i want to use an example to describe it.
>> /* drivers/iommu/amd_iommu_init.c */
>> static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
> 
> Those addresses come from the IVHD header which is an ACPI table. So the
> dump kernel can find that out too.
> Sure. I might understand your means, that will have to find all address out in
order to cover any cases in kdump kernel, those address  might include MMIO
space, HPET, ACPI device table, ERST, and so on... 

>> Obviously, the iommu mmio space is not encrypted, and the device
>> mmio space is outside kdump kernel. We know that the old memory is
>> encrypted, and the old memory is also outside kdump kernel. For the
>> current case, e820__get_entry_type() and walk_iomem_res_desc() can't
>> get the desired result, so we can't also decide whether encryption
>> or not according to this result(rules). If we want to know whether
>> encryption or not by deducing the address, we will need to read the
>> content of memory and have a reference value for comparison, then
>> what's a reference value? Sometimes we don't know that.
> 
> Again, if we don't know that how is the *caller* supposed to know
> whether the memory is encrypted or not? Because
> 
> "we" == "caller"
> 
> in the kdump kernel.
> 
> And the more important question is, why are we dumping MMIO space of the
> previous kernel *at* *all*? That doesn't make any sense to me.
> 
Sorry for my late reply.
Here, it doesn't need to dump MMIO space of the previous kernel, when the
kdump kernel boot, the MMIO address will be remapped in decryption manners,
but the MMIO address don't belong to the range of the crash reserved memory,
for the kdump kernel, the MMIO space(address) and IOMMU device table(address)
are outside address, whereas, the IOMMU device table is encrypted in the first
kernel, the kdump kernel will need to copy the content of IOMMU device table
from the first kernel when the kdump kernel boot, so the IOMMU device table will
be remapped in encryption manners.
So some of them require to be remapped in encryption manners, and some(address)
require to be remapped in decryption manners.

