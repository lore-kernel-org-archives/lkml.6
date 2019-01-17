Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EDEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfAQHl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:41:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51837 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfAQHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:41:26 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so7338469ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 23:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AAfFlRu1NDwD/GO1n9yGF0xxCJf9RZ0AohwM6u14zM=;
        b=lYwzr8aSxMWncVSFw7kEGX4eHTJayIKHmuYWQtu/9npLOroSRnXopdASegfmJ78L9W
         ddYTp0kZ4kH+flBfqisxiAY+5TMZFIhgaog3ZSk9VI5nizC3PSqekwSps9BydS8uo9WQ
         x9TlOYizcN40X8IbAPMUL6ebcJ14MQMQhmWzobpNZJCe8wkqp4xLecj4TC5xWXOg5vcp
         uXgFvuItpETZKElNm9hU/xxjFpa2JSgKRE0LkDmm9zSf2KPuc4tWSPAQsToQjnFDS/T5
         6sS+Sq1dz2ANkxw0qmz4zg89BDUjenxn8Vw9pD6GhHtWoM0EmfnAyKkOYzm0GYf1j+Wa
         6SDA==
X-Gm-Message-State: AJcUukdk83u9XmQb+XGO34mv6aewo/4dMDtJZUgd7mPU33wVDc92QKvA
        EbrnYqV8TLCNEvtxckEcLVUvYD9l1fA+8IED+NffL7eUKi7A5Ana
X-Google-Smtp-Source: ALg8bN7vXkUo4/nrfqn9SIjJLfIgQjM1z+Aw5NU7z/IWL7hD4HFHW48t806xa2Hm4EWqkKYKGlXSIaDPyjGtIZLKdgk=
X-Received: by 2002:a24:5fd2:: with SMTP id r201mr8970959itb.19.1547710884742;
 Wed, 16 Jan 2019 23:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
In-Reply-To: <20190116094619.GB15409@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 17 Jan 2019 15:41:13 +0800
Message-ID: <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> > I didn't see a way to reuse things in that patch series, situation is
> > different, in that patch it needs to get RSDP in very early boot stage
> > so it did everything from scratch, in this patch kexec_file_load need
> > to get RSDP too, but everything is well setup so things are a lot
> > easier, just read from current boot_prams, efi and fallback to
> > acpi_find_root_pointer should be good.
>
> No no. Early code should find out that venerable RSDP thing once and
> will save it somewhere for further use. No gazillion parsings of it.
> Just once and share it with the rest of the code that needs it.
>

How about we refill the boot_params.acpi_rsdp_addr if it is not valid
in early code, so it could be used as a reliable RSDP address source?
That should make things easier.

But if early code should parse it and store it should be done in
Chao's patch, or I can post another patch to do it if Chao's patch is
merged.

For now I think good to have something like this in this patch series
to always keep storing acpi_rsdp in late code,
acpi_os_get_root_pointer_late (maybe comeup with a better name later)
could be used anytime to get RSDP and no extra parsing:

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #endif
 }

-#ifdef CONFIG_KEXEC
 static unsigned long acpi_rsdp;
+#ifdef CONFIG_KEXEC
 static int __init setup_acpi_rsdp(char *arg)
 {
        return kstrtoul(arg, 16, &acpi_rsdp);
@@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
 early_param("acpi_rsdp", setup_acpi_rsdp);
 #endif

+acpi_physical_address acpi_os_get_root_pointer_late(void) {
+       return acpi_rsdp;
+}
+
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
        acpi_physical_address pa;

-#ifdef CONFIG_KEXEC
        if (acpi_rsdp)
                return acpi_rsdp;
-#endif
+
        pa = acpi_arch_get_root_pointer();
-       if (pa)
+       if (pa) {
+               acpi_rsdp = pa;
                return pa;
+       }

        if (efi_enabled(EFI_CONFIG_TABLES)) {
-               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
+                       acpi_rsdp = efi.acpi20;
                        return efi.acpi20;
-               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+               }
+               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
+                       acpi_rsdp = efi.acpi;
                        return efi.acpi;
+               }
                pr_err(PREFIX "System description tables not found\n");
        } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
                acpi_find_root_pointer(&pa);
        }

 +       acpi_rsdp = pa;
        return pa;
 }

> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
--
Best Regards,
Kairui Song
