Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69718C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27433208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543900;
	bh=Z4dEKU5XyzUe5XhxqjuWXU2SvcsVn6Ng+Qqi2xedwIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rj4vTJk1xHhWb+m+Qz6P1K1XnYuvIDUC/vdd8jeWOvGBM9zueblXQmIgfIX4vplpC
	 ijNG+bWAMl+YqFJxMyzWBvG8yLM2RudNG8t9GI2KI/EYwrWNKaIcFPqphGxsWBIcjQ
	 +WUE0EDJq58e57GTDLqyiQGJpLd9ReVfkqC1nNm4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27433208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbeLKP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbeLKP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EF220855;
        Tue, 11 Dec 2018 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543894;
        bh=Z4dEKU5XyzUe5XhxqjuWXU2SvcsVn6Ng+Qqi2xedwIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHbMYihmfgeoKPLDNUcbEK/WUr4M/1YvqeqKGZs9qVb2+RQT73ZZm2SkBwUGStq1o
         D3Z+W6JJ+6lzvzmZRFz02jhjqcK7ZGp6vOc0g6wpUXasJVWtP9s/N/O0kglbd/upsD
         olBqgEDmJtAqEJtdioV1YYt724H/E55KAuxXET/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 104/118] x86/efi: Allocate e820 buffer before calling efi_exit_boot_service
Date:   Tue, 11 Dec 2018 16:42:03 +0100
Message-Id: <20181211151648.466213185@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Snowberg <eric.snowberg@oracle.com>

commit b84a64fad40637b1c9fa4f4dbf847a23e29e672b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/compressed/eboot.c |   65 ++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 24 deletions(-)

--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1,3 +1,4 @@
+
 /* -----------------------------------------------------------------------
  *
  *   Copyright 2011 Intel Corporation; author Matt Fleming
@@ -634,37 +635,54 @@ static efi_status_t alloc_e820ext(u32 nr
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
@@ -687,8 +705,8 @@ static efi_status_t exit_boot(struct boo
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
@@ -702,8 +720,10 @@ static efi_status_t exit_boot(struct boo
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
@@ -711,9 +731,6 @@ static efi_status_t exit_boot(struct boo
 	if (status != EFI_SUCCESS)
 		return status;
 
-	e820ext			= priv.e820ext;
-	e820ext_size		= priv.e820ext_size;
-
 	/* Historic? */
 	boot_params->alt_mem_k	= 32 * 1024;
 


