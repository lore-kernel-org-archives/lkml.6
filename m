Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A047C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208C320855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfAQIyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:54:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfAQIyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:54:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33D2765855;
        Thu, 17 Jan 2019 08:54:17 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-70.pek2.redhat.com [10.72.12.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4B8319751;
        Thu, 17 Jan 2019 08:54:10 +0000 (UTC)
Date:   Thu, 17 Jan 2019 16:54:06 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190117085406.GB17940@dhcp-128-65.nay.redhat.com>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117074959.GB31097@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117074959.GB31097@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 08:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-acpi list
On 01/17/19 at 03:49pm, Chao Fan wrote:
> On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
> >On Wed, Jan 16, 2019 at 5:46 PM Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Wed, Jan 16, 2019 at 03:08:42PM +0800, Kairui Song wrote:
> >> > I didn't see a way to reuse things in that patch series, situation is
> >> > different, in that patch it needs to get RSDP in very early boot stage
> >> > so it did everything from scratch, in this patch kexec_file_load need
> >> > to get RSDP too, but everything is well setup so things are a lot
> >> > easier, just read from current boot_prams, efi and fallback to
> >> > acpi_find_root_pointer should be good.
> >>
> >> No no. Early code should find out that venerable RSDP thing once and
> >> will save it somewhere for further use. No gazillion parsings of it.
> >> Just once and share it with the rest of the code that needs it.
> >>
> >
> >How about we refill the boot_params.acpi_rsdp_addr if it is not valid
> >in early code, so it could be used as a reliable RSDP address source?
> >That should make things easier.
> 
> I think it's OK.
> Try to read it, if get RSDP, use it.
> If not, search in EFI/BIOS/... and refill the RSDP to
> boot_params.acpi_rsdp_addr.
> By the way, I search kernel code, I didn't find other code fill and
> use it, only you(KEXEC) are trying to fill it.
> If I miss something, please let me know.
> 
> Thanks,
> Chao Fan
> 
> >
> >But if early code should parse it and store it should be done in
> >Chao's patch, or I can post another patch to do it if Chao's patch is
> >merged.
> >
> >For now I think good to have something like this in this patch series
> >to always keep storing acpi_rsdp in late code,
> >acpi_os_get_root_pointer_late (maybe comeup with a better name later)
> >could be used anytime to get RSDP and no extra parsing:
> >
> >--- a/drivers/acpi/osl.c
> >+++ b/drivers/acpi/osl.c
> >@@ -180,8 +180,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
> > #endif
> > }
> >
> >-#ifdef CONFIG_KEXEC
> > static unsigned long acpi_rsdp;
> >+#ifdef CONFIG_KEXEC
> > static int __init setup_acpi_rsdp(char *arg)
> > {
> >        return kstrtoul(arg, 16, &acpi_rsdp);
> >@@ -189,28 +189,38 @@ static int __init setup_acpi_rsdp(char *arg)
> > early_param("acpi_rsdp", setup_acpi_rsdp);
> > #endif
> >
> >+acpi_physical_address acpi_os_get_root_pointer_late(void) {
> >+       return acpi_rsdp;
> >+}
> >+
> > acpi_physical_address __init acpi_os_get_root_pointer(void)
> > {
> >        acpi_physical_address pa;
> >
> >-#ifdef CONFIG_KEXEC
> >        if (acpi_rsdp)
> >                return acpi_rsdp;
> >-#endif
> >+
> >        pa = acpi_arch_get_root_pointer();
> >-       if (pa)
> >+       if (pa) {
> >+               acpi_rsdp = pa;
> >                return pa;
> >+       }
> >
> >        if (efi_enabled(EFI_CONFIG_TABLES)) {
> >-               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> >+               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR) {
> >+                       acpi_rsdp = efi.acpi20;
> >                        return efi.acpi20;
> >-               if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> >+               }
> >+               if (efi.acpi != EFI_INVALID_TABLE_ADDR) {
> >+                       acpi_rsdp = efi.acpi;
> >                        return efi.acpi;
> >+               }
> >                pr_err(PREFIX "System description tables not found\n");
> >        } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> >                acpi_find_root_pointer(&pa);
> >        }
> >
> > +       acpi_rsdp = pa;
> >        return pa;
> > }
> >
> >> --
> >> Regards/Gruss,
> >>     Boris.
> >>
> >> Good mailing practices for 400: avoid top-posting and trim the reply.
> >--
> >Best Regards,
> >Kairui Song
> >
> >
> 
> 
