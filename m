Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C5920818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C5920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeKPNgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeKPNgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:36:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 336873082E50;
        Fri, 16 Nov 2018 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 340664BF;
        Fri, 16 Nov 2018 03:25:57 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dyoung@redhat.com, bhe@redhat.com
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
Date:   Fri, 16 Nov 2018 11:25:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115103959.GB26448@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Nov 2018 03:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月15日 18:39, Borislav Petkov 写道:
> + Bjorn.
> 
> On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
>> At present, the upstream kernel does not pass the e820 reserved ranges to the
>> second kernel, which might cause two problems:
>>
>> The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
>> the reserved region otherwise it falls back to legacy mode, which might lead to
>> the hot-plug device could not be recognized in kdump kernel.
> 
> Well, this still doesn't explain it fully. Let's look at a box:
> 
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable
> 
> this one has 8 reserved regions. Does that mean that we need to pass
> them *all* 8 to the second kernel so that MMCONFIG works?
> 
> Or is it only one reserved region which is needed for MMCONFIG?
> 

On my machine, the pci mmconfig region[mem 0x80000000-0x8fffffff] reserved in e820.
This address range belongs to the e820 reserved region[mem 0x0000000078000000-
0x000000008fffffff].

Kernel outputs the following log:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000029920fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029921000-0x0000000029921fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029922000-0x0000000062278fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062279000-0x0000000062378fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000062379000-0x000000006238bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006238c000-0x000000006238cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006238d000-0x000000006240bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006240c000-0x000000006264bfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006264c000-0x000000006266dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006266e000-0x00000000626cdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000626ce000-0x000000006278dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006278e000-0x000000006278efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006278f000-0x0000000062807fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062808000-0x000000006280afff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006280b000-0x000000006280cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006280d000-0x000000006280dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006280e000-0x000000006286afff] usable
[    0.000000] BIOS-e820: [mem 0x000000006286b000-0x000000006286efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006286f000-0x00000000682f8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000682f9000-0x0000000068b05fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b06000-0x0000000068b09fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b0a000-0x0000000068b1afff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b1b000-0x0000000068b1dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b1e000-0x0000000071d1dfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000071d1e000-0x0000000071d2dfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000071d2e000-0x0000000071d3dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000071d3e000-0x0000000071d4dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000071d4e000-0x0000000077ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000087f000000-0x000000087fffffff] reserved

......
[    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
......


For the pci mmconfig issue, it should be good enough that the e820 reserved region
[mem 0x0000000078000000-0x000000008fffffff] is only passed to the second kernel, but
the pci mmconfig region is not the same in another machine.

In addition, it has more serious problems that kdump could not work in some machine. 

> Bjorn, do you know what the detection logic should be to map the correct
> reserved region (or regions) for MMCONFIG?
> 
> Now, even if we don't map that reserved region and MMCONFIG falls back
> to legacy mode, why is that a problem for the kdump kernel? Why does
> the kdump kernel need the hotplug device? What would be the use case?
> Hotplug a SATA drive to store the memory dump to it ... or?
> 

A simple case, hotplug a pci network card and use the ssh/nfs to dump the vmcore.
If the pci mmconfig region is not reserved in kdump kernel, the pci hotplug device
could not be recognized. So the pci network card won't work.

>> Another one is that the e820 reserved ranges do not setup in kdump kernel, which
>> could cause kdump can't work in some machines. To know more information, please
>> refer to the [PATCH 2/2 v6] patch log.
> 
> Yah, I still don't understand *why* we need the reserved ranges in the
> second kernel. Once we've figured out the *why* we can look at the *how*.
> 

Here, there is an example about SME kdump. Maybe it can help to better understand.

The e820 reserved ranges do not setup in kdump kernel, which will cause some
functions that related to the e820 reserved ranges to become invalid.
    
early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

Please focus on these functions, early_memremap_pgprot_adjust() and
memremap_should_map_decrypted().

In the first kernel, these ranges sit in e820 reserved ranges, so the
memremap_should_map_decrypted() will return true, that is to say, the
reserved memory is decrypted, then the early_memremap_pgprot_adjust()
will call the pgprot_decrypted() to clear the memory encryption mask.

In the second kernel, because the e820 reserved ranges are not passed
to the second kernel, these ranges don't sit in the e820 reserved ranges,
so the memremap_should_map_decrypted() will return false, that is to say,
the reserved memory is encrypted, and then the early_memremap_pgprot_
adjust() will also call the pgprot_encrypted() to set the memory encryption
mask.

In fact, in the second kernel, the e820 reserved memory is still decrypted.
Obviously, it has gone wrong. So, this issue must be fixed, otherwise kdump
won't work in this case.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to kdump kernel.

Hope this is helpful.

Thanks,
Lianbo

> Thx.
> 
