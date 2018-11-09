Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD4020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD4020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeKJIGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:06:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33163 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeKJIGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:06:17 -0500
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wA9MN5O92543672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 9 Nov 2018 14:23:12 -0800
Subject: PLEASE REVERT URGENTLY: Re: [PATCH v5 2/3] x86/boot: add acpi rsdp
 address to setup_header
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net,
        boris.ostrovsky@oracle.com
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010061456.22238-3-jgross@suse.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
Date:   Fri, 9 Nov 2018 14:23:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181010061456.22238-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed this patch -- I missed it because the cover message
seemed far more harmless so I didn't notice this change.

THIS PATCH IS FATALLY WRONG AND NEEDS TO BE IMMEDIATELY REVERTED BEFORE
ANYONE STARTS RELYING ON IT; IT HAS THE POTENTIAL OF BREAKING THE
BOOTLOADER PROTOCOL FOR ALL FUTURE.

It seems to be based on fundamental misconceptions about the various
data structures in the protocol, and does so in a way that completely
breaks the way the protocol is designed to work.

The protocol is specifically designed such that fields are not version
dependencies. The version number is strictly to inform the boot loader
about which capabilities the kernel has, so that the boot loader can
know if a certain data field is meaningful and/or honored.

> +Protocol 2.14:	(Kernel 4.20) Added acpi_rsdp_addr holding the physical
> +		address of the ACPI RSDP table.
> +		The bootloader updates version with:
> +		0x8000 | min(kernel-version, bootloader-version)
> +		kernel-version being the protocol version supported by
> +		the kernel and bootloader-version the protocol version
> +		supported by the bootloader.

[...]

>  **** MEMORY LAYOUT
>
>  The traditional memory map for the kernel loader, used for Image or
> @@ -197,6 +209,7 @@ Offset	Proto	Name		Meaning
>  0258/8	2.10+	pref_address	Preferred loading address
>  0260/4	2.10+	init_size	Linear memory required during initialization
>  0264/4	2.11+	handover_offset	Offset of handover entry point
> +0268/8	2.14+	acpi_rsdp_addr	Physical address of RSDP table

NO.

That is not how struct setup_header works, nor does this belong here.

struct setup_header contains *initialized data*, and has a length byte
at offset 0x201.  The bootloader is responsible for copying the full
structure into the appropriate offset (0x1f1) in struct boot_params.

The length byte isn't actually a requirement, since the maximum possible
size of this structure is 144 bytes, and the kernel will (obviously) not
look at the older fields anyway, but it is good practice. The kernel or
any other entity is free to zero out the bytes past this length pointer.

There are only 24 bytes left in this structure, and this would occupy 8
of them for no valid reason.  The *only* valid reason to put a
zero-initialized field in struct setup_header is if it used by the
16-bit legacy BIOS boot, which is obviously not the case here.

This field thus belongs in struct boot_params, not struct setup_header.

>  
> @@ -317,6 +330,12 @@ Protocol:	2.00+
>    e.g. 0x0204 for version 2.04, and 0x0a11 for a hypothetical version
>    10.17.
>  
> +  Up to protocol version 2.13 this information is only read by the
> +  bootloader. From protocol version 2.14 onwards the bootloader will
> +  write the used protocol version ored with 0x8000 to the field. The
> +  used protocol version will be the minimum of the supported protocol
> +  versions of the bootloader and the kernel.
> +

Again, this is completely wrong. The version number is communication to
the bootloader, which may end up going through multiple stages.
Modifying this field breaks this invariant in a not-very-subtle way.

Fields in struct setup_header are to be initialized from the image
provided in the kernel header.

Fields in struct boot_params are to be initialized to zero.

There is a field called "sentinel" which attempts to detect broken
bootloaders which do not do this correctly; however, when enabling new
bootloaders the Right Thing to do is to make sure they adhere to the
protocol as defined, rather than pushing a new hack onto the kernel.

Thus:

1. Please revert this patch immediately, and destroy any boot loaders
   which tries to implement this.
2. Add the acpi_rsdp_addr to struct boot_params.
3. DO NOT modify the boot protocol version header field. Instead
   make sure that the bootloader follows the protocol and zeroes
   all unknown fields in struct boot_params.
4. Possibly make the kernel panic if it notices that the boot version
   header has been mucked with, in case some of these boot loaders
   have already escaped into the field.

