Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC28C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BC120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfAQHvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:51:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40524 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727272AbfAQHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:51:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="52204647"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2019 15:50:56 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 55B4D4BAD9D8;
        Thu, 17 Jan 2019 15:50:54 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 17 Jan 2019 15:51:01 +0800
Date:   Thu, 17 Jan 2019 15:49:59 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Kairui Song <kasong@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <akpm@linux-foundation.org>, <robert.moore@intel.com>,
        <erik.schmauss@intel.com>, <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190117074959.GB31097@localhost.localdomain>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 55B4D4BAD9D8.AD2C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
>On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
>> > I didn't see a way to reuse things in that patch series, situation is
>> > different, in that patch it needs to get RSDP in very early boot stage
>> > so it did everything from scratch, in this patch kexec_file_load need
>> > to get RSDP too, but everything is well setup so things are a lot
>> > easier, just read from current boot_prams, efi and fallback to
>> > acpi_find_root_pointer should be good.
>>
>> No no. Early code should find out that venerable RSDP thing once and
>> will save it somewhere for further use. No gazillion parsings of it.
>> Just once and share it with the rest of the code that needs it.
>>
>
>How about we refill the boot_params.acpi_rsdp_addr if it is not valid
>in early code, so it could be used as a reliable RSDP address source?
>That should make things easier.

I think it's OK.
Try to read it, if get RSDP, use it.
If not, search in EFI/BIOS/... and refill the RSDP to
boot_params.acpi_rsdp_addr.
By the way, I search kernel code, I didn't find other code fill and
use it, only you(KEXEC) are trying to fill it.
If I miss something, please let me know.

Thanks,
Chao Fan

>
>But if early code should parse it and store it should be done in
>Chao's patch, or I can post another patch to do it if Chao's patch is
>merged.
>
>For now I think good to have something like this in this patch series
>to always keep storing acpi_rsdp in late code,
>acpi_os_get_root_pointer_late (maybe comeup with a better name later)
>could be used anytime to get RSDP and no extra parsing:
>
>--- a/drivers/acpi/osl.c
>+++ b/drivers/acpi/osl.c
>@@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> #endif
> }
>
>-#ifdef CONFIG_KEXEC
> static unsigned long acpi_rsdp;
>+#ifdef CONFIG_KEXEC
> static int __init setup_acpi_rsdp(char *arg)
> {
>        return kstrtoul(arg, 16, &acpi_rsdp);
>@@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
> early_param("acpi_rsdp", setup_acpi_rsdp);
> #endif
>
>+acpi_physical_address acpi_os_get_root_pointer_late(void) {
>+       return acpi_rsdp;
>+}
>+
> acpi_physical_address __init acpi_os_get_root_pointer(void)
> {
>        acpi_physical_address pa;
>
>-#ifdef CONFIG_KEXEC
>        if (acpi_rsdp)
>                return acpi_rsdp;
>-#endif
>+
>        pa = acpi_arch_get_root_pointer();
>-       if (pa)
>+       if (pa) {
>+               acpi_rsdp = pa;
>                return pa;
>+       }
>
>        if (efi_enabled(EFI_CONFIG_TABLES)) {
>-               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
>+               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
>+                       acpi_rsdp = efi.acpi20;
>                        return efi.acpi20;
>-               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
>+               }
>+               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
>+                       acpi_rsdp = efi.acpi;
>                        return efi.acpi;
>+               }
>                pr_err(PREFIX "System description tables not found\n");
>        } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
>                acpi_find_root_pointer(&pa);
>        }
>
> +       acpi_rsdp = pa;
>        return pa;
> }
>
>> --
>> Regards/Gruss,
>>     Boris.
>>
>> Good mailing practices for 400: avoid top-posting and trim the reply.
>--
>Best Regards,
>Kairui Song
>
>


