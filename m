Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3EAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE120862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CE120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeKGSkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:40:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeKGSkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:40:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A238307D97F;
        Wed,  7 Nov 2018 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 743DF66D40;
        Wed,  7 Nov 2018 09:10:53 +0000 (UTC)
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dyoung@redhat.com
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
 <20181107052345.GQ27491@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
Date:   Wed, 7 Nov 2018 17:10:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107052345.GQ27491@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 07 Nov 2018 09:11:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月07日 13:23, Baoquan He 写道:
> On 11/07/18 at 01:00pm, Lianbo Jiang wrote:
>> E820 reserved ranges is useful in kdump kernel, it has been added in
>> kexec-tools code.
>>
>> One reason is PCI mmconf (extended mode) requires reserved region otherwise
>> it falls back to legacy mode, and also outputs the following kernel log.
> 
> OK, it falls back to legacy mode, and also output kernel log, except of
> these, does it crash kernel? kdump kernel hang? Can we leave it if it
> only ouptut kernel log?
> 
>>
>> Example:
>> ......
>> [   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>> [   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
>> [   19.800995] PCI: not using MMCONFIG
>> ......
>>
>> The correct kernel log is like this:
>> ......
>> [    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>> [    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
>> ......
>>
>> Furthermore, when AMD SME kdump support, it needs to map dmi table area
>> as decrypted. For normal boot, these ranges sit in e820 reserved ranges,
>> thus the early ioremap code naturally map them as decrypted. If it also
>> has same e820 reserve setup in kdump kernel then it will just work like
>> normal kernel.
> 
> Why do we care? If don't fix, what's happening?
> 
> Lianbo, for a bug fix, please describe the problems. Then give out the
> analysis about root cause. 
> 

Thanks for your comment in detail.

In fact, these patches are really simple. As the subject mentioned, this patch
[PATCH 2/2] adds the reserved e820 ranges to kdump kernel e820 table, and the
first patch [PATCH 1/2] helps to exactly add the e820(E820_TYPE_RESERVED) type
to kdump kernel e820 table, that is to say, it will filter out some unnecessary
type(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_RESERVED_KERN).

At present, when we use the kexec to load the kernel image and initramfs(for
example: kexec -s -p xxxx), the latest kernel does not pass the e820 reserved
ranges to the second kernel, which might produce two problems:

The first one is the MMCONFIG issue, although which does not make the system
crash or hang, this issue is still a potential risk, because my test can't
cover all cases due to resource constraints(Machine), and i'm not sure what
it will happen on other machine.

The second issue is that the e820 reserved ranges do not setup in kdump kernel,
which will cause some functions which are related to the e820 reserved ranges
to become invalid. For example:

early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

Please focus on these functions, early_memremap_pgprot_adjust() and memremap_should_map_decrypted().

In the first kernel, these ranges sit in e820 reserved ranges, so the memremap_should_map_decrypted()
will return true, that is to say, the reserved memory is decrypted, then the early_memremap_pgprot_adjust()
will call the pgprot_decrypted() to clear the memory encryption mask.

In the second kernel, because the e820 reserved ranges are not passed to the second kernel, these ranges
don't sit in the e820 reserved ranges, so the the memremap_should_map_decrypted() will return false, that
is to say, the reserved memory is encrypted, and then the early_memremap_pgprot_adjust() will also call the
pgprot_encrypted() to set the memory encryption mask.

Obviously, in the second kernel, the e820 reserved memory is still decrypted, it has gone wrong. So, if
don't fix, kdump won't work when we use the command(kexec -s -p xxx) to load the kernel image and initramfs.

Hope this helps.

Thanks,
Lianbo

pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
                                             unsigned long size,
                                             pgprot_t prot)
{
        bool encrypted_prot;

        if (!mem_encrypt_active())
                return prot;

        encrypted_prot = true;

	//......

        if (encrypted_prot && memremap_should_map_decrypted(phys_addr, size))
                encrypted_prot = false;

        return encrypted_prot ? pgprot_encrypted(prot)
                              : pgprot_decrypted(prot);
}

static bool memremap_should_map_decrypted(resource_size_t phys_addr,
                                          unsigned long size)
{
        int is_pmem;

	//......

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


> 
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/crash.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index ae724a6e0a5f..d3167125800e 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -384,6 +384,10 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>  	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
>>  			memmap_entry_callback);
>>  
>> +	cmd.type = E820_TYPE_RESERVED;
>> +	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
>> +			   memmap_entry_callback);
>> +
>>  	/* Add crashk_low_res region */
>>  	if (crashk_low_res.end) {
>>  		ei.addr = crashk_low_res.start;
>> -- 
>> 2.17.1
>>
