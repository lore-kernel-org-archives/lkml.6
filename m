Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8335A2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107461;
	bh=8W/bHEVCf+wxyhXJO+oXgnVe4yx6rAu394nxd4KcNtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsD5UKxDQHfD/jIkESNl8hzs0AlFQ5LVC5eqjH+p8AYXCXO+WnpteP4EEXbatsX5I
	 thdTqnTQbV/gO1irtfB+k/qJDa84guE/EFfCSwC35u1TF4XltSLhMEhWn+ZugAWOkw
	 VHuKb7Yj4bOPEqG8eaPnn1TmmCqrtWpw7zRD0F24=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8335A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeLFOoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbeLFOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64CDF2082B;
        Thu,  6 Dec 2018 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107452;
        bh=8W/bHEVCf+wxyhXJO+oXgnVe4yx6rAu394nxd4KcNtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsgwxIVJHOekr7K+DGVwTahO9ikrdIn5jq9TR65T7QI+udcWz4o0kCav8fUm2kRaY
         fiSsRWzE63T7h2gLOXL72n92xuU9K2+ZpPnXSJ1Bbs5tiWhWhoAcvlUAupbifB5zSK
         KxlFAuIvUaVfZpAgqKjYPHBUZ41Nt6Fq3dj15x9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 012/101] x86/power/64: Use char arrays for asm function names
Date:   Thu,  6 Dec 2018 15:38:11 +0100
Message-Id: <20181206143012.274985118@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit c0944883c97c0ddc71da67cc731590a7c878a1a2 upstream.

This switches the hibernate_64.S function names into character arrays
to match other areas of the kernel where this is done (e.g., linker
scripts). Specifically this fixes a compile-time error noticed by the
future CONFIG_FORTIFY_SOURCE routines that complained about PAGE_SIZE
being copied out of the "single byte" core_restore_code variable.

Additionally drops the "acpi_save_state_mem" exern which does not
appear to be used anywhere else in the kernel.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/suspend_64.h |    5 ++---
 arch/x86/power/hibernate_64.c     |    6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -42,8 +42,7 @@ struct saved_context {
 	set_debugreg((thread)->debugreg##register, register)
 
 /* routines for saving/restoring kernel state */
-extern int acpi_save_state_mem(void);
-extern char core_restore_code;
-extern char restore_registers;
+extern char core_restore_code[];
+extern char restore_registers[];
 
 #endif /* _ASM_X86_SUSPEND_64_H */
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -126,7 +126,7 @@ static int relocate_restore_code(void)
 	if (!relocated_restore_code)
 		return -ENOMEM;
 
-	memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
+	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
 
 	/* Make the page containing the relocated code executable */
 	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
@@ -197,8 +197,8 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = (unsigned long)&restore_registers;
-	rdr->jump_address_phys = __pa_symbol(&restore_registers);
+	rdr->jump_address = (unsigned long)restore_registers;
+	rdr->jump_address_phys = __pa_symbol(restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;


