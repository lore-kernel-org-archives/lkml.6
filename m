Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE64C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1550220651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956338;
	bh=JDwliawijCiA2P3WU3sjbZVid+9htdxs6gjJdkwgy40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=13DEDmtfOCg5m2CEb1hZ4/1h4cJ/pKwnsNXq8vpHcB5C4p2ryvRhzSNc93ftaXCSC
	 QoOHuQKym7Hl4DP002NGzDkpQ6z5/GsDr7vNNigkUI5NdRkJSNTj1XWt6zSI1BvsUW
	 eFnjyf3qFX5NukZDMrfJt3rj0QfwKqyMxH+1KdfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfBWVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbfBWVMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:12:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8011F20861;
        Sat, 23 Feb 2019 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956320;
        bh=JDwliawijCiA2P3WU3sjbZVid+9htdxs6gjJdkwgy40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hI7Pb95sXRuZhuCGBCxtKLCxw5XKw7Dyw6+S7SF5FEahDGQ6p94cQfrNn4GYLc37l
         IuhQJHISbkL6fO4QyYDi2wMeMnpHRDaVmqGh1+mu9I/U9+Qv8v+pWfANnXOGmvXz1f
         GMreDTwCAHytEKaxZxTkwYICmCtTDuAB0a7WJa0g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@suse.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhe@redhat.com,
        David Howells <dhowells@redhat.com>, erik.schmauss@intel.com,
        fanc.fnst@cn.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        rafael.j.wysocki@intel.com, robert.moore@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 15/18] x86/kexec: Don't setup EFI info if EFI runtime is not enabled
Date:   Sat, 23 Feb 2019 16:11:32 -0500
Message-Id: <20190223211135.203082-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211135.203082-1-sashal@kernel.org>
References: <20190223211135.203082-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@redhat.com>

[ Upstream commit 2aa958c99c7fd3162b089a1a56a34a0cdb778de1 ]

Kexec-ing a kernel with "efi=noruntime" on the first kernel's command
line causes the following null pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  #PF error: [normal kernel read fault]
  Call Trace:
   efi_runtime_map_copy+0x28/0x30
   bzImage64_load+0x688/0x872
   arch_kexec_kernel_image_load+0x6d/0x70
   kimage_file_alloc_init+0x13e/0x220
   __x64_sys_kexec_file_load+0x144/0x290
   do_syscall_64+0x55/0x1a0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Just skip the EFI info setup if EFI runtime services are not enabled.

 [ bp: Massage commit message. ]

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: bhe@redhat.com
Cc: David Howells <dhowells@redhat.com>
Cc: erik.schmauss@intel.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com
Cc: robert.moore@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190118111310.29589-2-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index ca05f86481aac..3e22751382c38 100644
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
2.19.1

