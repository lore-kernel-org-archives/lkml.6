Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31AC2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="COuZ9pTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfAKKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:32:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37670 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfAKKcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:32:35 -0500
Received: from zn.tnic (p200300EC2BCAC5006CCD8D4D75E662CE.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:6ccd:8d4d:75e6:62ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A6CD1EC04F3;
        Fri, 11 Jan 2019 11:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547202753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+pnj6zzfcojt9GMlIisiNsE+Pvt/Tn7JDV2nrHjsuiI=;
        b=COuZ9pTnsauJ89zRSPiR50e90jVTPgd/M3ergmI67txCCOKGix3JZQFUUMoz8b53nk2SvL
        sTPyNpMp1Rst7ZW3jR8dQ4xlfM7AHirIZS3TQ4rv3zROoQ8uXjzFWj/DN+reVcq5XSmt8e
        NRlWbLllx1YljkxzNryqxmwtI9WvSGY=
Date:   Fri, 11 Jan 2019 11:32:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190111103225.GA4729@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111012353.GD2216@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:23:53AM +0800, Chao Fan wrote:
> Yes, 'table64' looks superfluous here, but after these lines, there is:
>                         if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
> so the 'table64' is useful here for i386. 'table' is unsigned long, it
> can't do the right shift. But the 'table64' who is u64 can do that right
> shift.

Have you actually tried fixing what I suggested or you're just talking?

---
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index e9dd84f459ed..0537d46fb21f 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -77,21 +77,19 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 			sizeof(efi_config_table_32_t);
 
 	for (i = 0; i < systab->nr_tables; i++) {
+		acpi_physical_address table;
 		void *config_tables;
-		unsigned long table;
 		efi_guid_t guid;
 
 		config_tables = (void *)(systab->tables + size * i);
 		if (efi_64) {
 			efi_config_table_64_t *tmp_table;
-			u64 table64;
 
 			tmp_table = config_tables;
 			guid = tmp_table->guid;
-			table64 = tmp_table->table;
-			table = table64;
+			table = tmp_table->table;
 
-			if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
 				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
 				return 0;
 			}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
