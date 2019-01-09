Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84717C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C4520883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfAIGpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbfAIGpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:45:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3F9EC057E26;
        Wed,  9 Jan 2019 06:45:01 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCA875C1B5;
        Wed,  9 Jan 2019 06:44:54 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dyoung@redhat.com, akpm@linux-foundation.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH 1/2] x86, kexec_file_load: Don't setup EFI info if EFI runtime is not enabled
Date:   Wed,  9 Jan 2019 14:43:02 +0800
Message-Id: <20190109064302.26780-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 06:45:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currenly with "efi=noruntime" in kernel command line, calling
kexec_file_load will raise below problem:

[   97.967067] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   97.967894] #PF error: [normal kernel read fault]
...
[   97.980456] Call Trace:
[   97.980724]  efi_runtime_map_copy+0x28/0x30
[   97.981267]  bzImage64_load+0x688/0x872
[   97.981794]  arch_kexec_kernel_image_load+0x6d/0x70
[   97.982441]  kimage_file_alloc_init+0x13e/0x220
[   97.983035]  __x64_sys_kexec_file_load+0x144/0x290
[   97.983586]  do_syscall_64+0x55/0x1a0
[   97.983962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

When efi runtime is not enabled, efi memmap is not mapped, so just skip
EFI info setup.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 0d5efa34f359..53917a3ebf94 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-- 
2.20.1

