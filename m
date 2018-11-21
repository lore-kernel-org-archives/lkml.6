Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF0FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D6720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeKUV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:28:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKUV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:28:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E018130820F2;
        Wed, 21 Nov 2018 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D2B604A4;
        Wed, 21 Nov 2018 10:54:13 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, dyoung@redhat.com,
        bhe@redhat.com
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
 <20181118115251.GB19380@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <ddeff176-2517-4b58-73b6-3787e84b2a5e@redhat.com>
Date:   Wed, 21 Nov 2018 18:54:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181118115251.GB19380@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 21 Nov 2018 10:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月18日 19:52, Borislav Petkov 写道:
> On Fri, Nov 16, 2018 at 11:25:55AM +0800, lijiang wrote:
>> For the pci mmconfig issue, it should be good enough that the e820 reserved region
>> [mem 0x0000000078000000-0x000000008fffffff] is only passed to the second kernel, but
>> the pci mmconfig region is not the same in another machine.
> 
> Yes. And now the question is, *which* reserved regions need to be mapped
> for the second kernel to function properly? How do we figure that out?
> 
>> A simple case, hotplug a pci network card and use the ssh/nfs to dump the vmcore.
>> If the pci mmconfig region is not reserved in kdump kernel, the pci hotplug device
>> could not be recognized. So the pci network card won't work.
> 
> Yes that's a good example; put *that* example in your commit message.
> 
>> Here, there is an example about SME kdump. Maybe it can help to better understand.
> 
> You keep pasting that and I've read it already. And you keep repeating
> that the reserved regions need to be mapped in the second kernel and I'm
> asking, how do we determine *which* regions should we pass to the second
> kernel?
> 

For the pci mmconfig issue, it is clear according to Dave and Bjorn's comment. So i'd like
to explain two things:

1. why the SME kdump kernel does not work without the reserved ranges.

The first kernel can get e820 table's information from BIOS or bootloader, but for kdump
kernel, it can not use this method to get e820 table. Maybe you have known who should pass
the e820 ranges to the second kernel, it is just the kexec-tools.

Unfortunately, kernel does not pass the e820 reserved ranges to the kdump kernel, when use
the kexec_file_load syscall to load the kernel image and initramfs.

At the early boot stage, the caller will use the early_memremap() to remap the address space,
such as DMI, ACPI and Firmware, etc.

Here, i only use an example to illustrate the issue what the DMI encountered in kdump kernel.

At the early boot stage, the DMI will use the early_memremap() to remap the address ranges
[0xF0000-0xFFFFF], and then check for the SMBIOS entry point signature.

And when the caller checks the SMBIOS entry point signature, the caller will use the early_memremap()
to remap another reserved ranges [0x0x6286B000-0x6286EFFF] again, which is reported by firmware(or
SMBIOS).

Please refer to the code: drivers/firmware/dmi_scan.c

dmi_scan_machine()-> / dmi_early_remap()-> early_memremap()
                     \ dmi_smbios3_present()->dmi_walk_early()->dmi_early_remap()->early_memremap()

Obviously, the DMI remapped ranges [0xF0000-0xFFFFF] and [0x6286b000-0x6286efff] are not in the e820
table for the kdump kernel. Therefore, when SME is enabled, these regions will be consider to be
encrypted according to the following code: arch/x86/mm/ioremap.c. Actually, these regions are still
decrypted in kdump kernel. It has gone wrong.

Note: 
When SME is enabled, if the memory regions are decrypted, but the caller marks the memory pages as
encrypted, the content of pages is unpredictable when read from memory.

early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

static bool memremap_should_map_decrypted(resource_size_t phys_addr,
                                          unsigned long size)
{
        int is_pmem;

        ......

        /* Check if the address is outside kernel usable area */
        switch (e820__get_entry_type(phys_addr, phys_addr + size - 1)) {
        case E820_TYPE_RESERVED:
        case E820_TYPE_ACPI:
        case E820_TYPE_NVS:
        case E820_TYPE_UNUSABLE:
                /* For SEV, these areas are encrypted */
                if (sev_active())
                        break;
                /* Fallthrough */

        case E820_TYPE_PRAM:
                return true;
        default:
                break;
        }

        return false;
}

Similarly, for ACPI, firmware, etc. They will also encounter the same problems, eventually, which
causes the system fails to start. That is the reason why the SME kdump kernel does not work without
the reserved ranges.

2. why the all reserved ranges are passed to the second kernel(or which regions should we pass to
   the second kernel?)

As previously mentioned, for the DMI, the reserved regions[0xF0000-0xFFFFF] and [0x0x6286B000-0x6286EFFF]
are accurately passed to the second kernel, the DMI can work well on my machine. But for the ACPI, firmware,
etc. How to deal with this?

I think that we have to find all places where to call the early_memremap(), and determine whether these
reserved regions need be passed to the second kernel, and then add the code for kdump kernel in these code
paths. It is really too expensive to do this.

Furthermore, i only did a same thing in kernel, just like the kexec-tools pass the all reserved ranges to the
second kernel.

If you understood this issue, you might ignore it, please.

Thanks.
Lianbo

> If we should pass *all* reserved regions, why?
> 
> IOW, I'm looking for the *why* first.
> 
> Thx.
> 
