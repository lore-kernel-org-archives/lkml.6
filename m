Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA70C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65AE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65AE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK3VFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:05:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeK3VFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:05:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9t3do3260871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:55:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9t2093260858;
        Fri, 30 Nov 2018 01:55:02 -0800
Date:   Fri, 30 Nov 2018 01:55:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Snowberg <tipbot@zytor.com>
Message-ID: <tip-b84a64fad40637b1c9fa4f4dbf847a23e29e672b@git.kernel.org>
Cc:     natechancellor@gmail.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, julien.thierry@arm.com,
        tglx@linutronix.de, ard.biesheuvel@linaro.org,
        jonathanh@nvidia.com, arend.vanspriel@broadcom.com,
        dave.hansen@intel.com, sedat.dilek@gmail.com, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, zhuyifei1999@gmail.com,
        matt@codeblueprint.co.uk, eric.snowberg@oracle.com,
        sai.praneeth.prakhya@intel.com, luto@kernel.org,
        bhsharma@redhat.com, marc.zyngier@arm.com, hdegoede@redhat.com,
        joe@perches.com, bp@alien8.de, stable@vger.kernel.org
Reply-To: sai.praneeth.prakhya@intel.com, luto@kernel.org,
          bhsharma@redhat.com, joe@perches.com, bp@alien8.de,
          hdegoede@redhat.com, marc.zyngier@arm.com,
          stable@vger.kernel.org, natechancellor@gmail.com,
          linux-kernel@vger.kernel.org, julien.thierry@arm.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          ard.biesheuvel@linaro.org, jonathanh@nvidia.com,
          arend.vanspriel@broadcom.com, dave.hansen@intel.com,
          sedat.dilek@gmail.com, hpa@zytor.com, mingo@kernel.org,
          zhuyifei1999@gmail.com, peterz@infradead.org,
          matt@codeblueprint.co.uk, eric.snowberg@oracle.com
In-Reply-To: <20181129171230.18699-2-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Allocate e820 buffer before calling
 efi_exit_boot_service
Git-Commit-ID: b84a64fad40637b1c9fa4f4dbf847a23e29e672b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b84a64fad40637b1c9fa4f4dbf847a23e29e672b
Gitweb:     https://git.kernel.org/tip/b84a64fad40637b1c9fa4f4dbf847a23e29e672b
Author:     Eric Snowberg <eric.snowberg@oracle.com>
AuthorDate: Thu, 29 Nov 2018 18:12:20 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 08:30:07 +0100

x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

The following commit:

  d64934019f6c ("x86/efi: Use efi_exit_boot_services()")

introduced a regression on systems with large memory maps causing them
to hang on boot. The first "goto get_map" that was removed from
exit_boot() ensured there was enough room for the memory map when
efi_call_early(exit_boot_services) was called. This happens when
(nr_desc > ARRAY_SIZE(params->e820_table).

Chain of events:

  exit_boot()
    efi_exit_boot_services()
      efi_get_memory_map                  <- at this point the mm can't grow over 8 desc
      priv_func()
        exit_boot_func()
          allocate_e820ext()              <- new mm grows over 8 desc from e820 alloc
      efi_call_early(exit_boot_services)  <- mm key doesn't match so retry
      efi_call_early(get_memory_map)      <- not enough room for new mm
      system hangs

This patch allocates the e820 buffer before calling efi_exit_boot_services()
and fixes the regression.

 [ mingo: minor cleanliness edits. ]

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 65 +++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 8b4c5e001157..544ac4fafd11 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1,3 +1,4 @@
+
 /* -----------------------------------------------------------------------
  *
  *   Copyright 2011 Intel Corporation; author Matt Fleming
@@ -634,37 +635,54 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 	return status;
 }
 
+static efi_status_t allocate_e820(struct boot_params *params,
+				  struct setup_data **e820ext,
+				  u32 *e820ext_size)
+{
+	unsigned long map_size, desc_size, buff_size;
+	struct efi_boot_memmap boot_map;
+	efi_memory_desc_t *map;
+	efi_status_t status;
+	__u32 nr_desc;
+
+	boot_map.map		= &map;
+	boot_map.map_size	= &map_size;
+	boot_map.desc_size	= &desc_size;
+	boot_map.desc_ver	= NULL;
+	boot_map.key_ptr	= NULL;
+	boot_map.buff_size	= &buff_size;
+
+	status = efi_get_memory_map(sys_table, &boot_map);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	nr_desc = buff_size / desc_size;
+
+	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+
+		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+
+	return EFI_SUCCESS;
+}
+
 struct exit_boot_struct {
 	struct boot_params	*boot_params;
 	struct efi_info		*efi;
-	struct setup_data	*e820ext;
-	__u32			e820ext_size;
 };
 
 static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   struct efi_boot_memmap *map,
 				   void *priv)
 {
-	static bool first = true;
 	const char *signature;
 	__u32 nr_desc;
 	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
-	if (first) {
-		nr_desc = *map->buff_size / *map->desc_size;
-		if (nr_desc > ARRAY_SIZE(p->boot_params->e820_table)) {
-			u32 nr_e820ext = nr_desc -
-					ARRAY_SIZE(p->boot_params->e820_table);
-
-			status = alloc_e820ext(nr_e820ext, &p->e820ext,
-					       &p->e820ext_size);
-			if (status != EFI_SUCCESS)
-				return status;
-		}
-		first = false;
-	}
-
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
@@ -687,8 +705,8 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
-	struct setup_data *e820ext;
-	__u32 e820ext_size;
+	struct setup_data *e820ext = NULL;
+	__u32 e820ext_size = 0;
 	efi_status_t status;
 	__u32 desc_version;
 	struct efi_boot_memmap map;
@@ -702,8 +720,10 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	map.buff_size		= &buff_size;
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
-	priv.e820ext		= NULL;
-	priv.e820ext_size	= 0;
+
+	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	if (status != EFI_SUCCESS)
+		return status;
 
 	/* Might as well exit boot services now */
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
@@ -711,9 +731,6 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	e820ext			= priv.e820ext;
-	e820ext_size		= priv.e820ext_size;
-
 	/* Historic? */
 	boot_params->alt_mem_k	= 32 * 1024;
 
