Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C8BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfAaQHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:07:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733167AbfAaQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:07:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0VG6tBx2939635
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 31 Jan 2019 08:06:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0VG6sZM2939632;
        Thu, 31 Jan 2019 08:06:54 -0800
Date:   Thu, 31 Jan 2019 08:06:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Lendacky <tipbot@zytor.com>
Message-ID: <tip-912139cfbfa6a2bc1da052314d2c29338dae1f6a@git.kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, Thomas.Lendacky@amd.com, bp@suse.de
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          x86@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
          bp@suse.de, Thomas.Lendacky@amd.com, thomas.lendacky@amd.com
In-Reply-To: <154894518427.9406.8246222496874202773.stgit@tlendack-t1.amdoffice.net>
References: <154894518427.9406.8246222496874202773.stgit@tlendack-t1.amdoffice.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode/amd: Don't falsely trick the late
 loading mechanism
Git-Commit-ID: 912139cfbfa6a2bc1da052314d2c29338dae1f6a
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

Commit-ID:  912139cfbfa6a2bc1da052314d2c29338dae1f6a
Gitweb:     https://git.kernel.org/tip/912139cfbfa6a2bc1da052314d2c29338dae1f6a
Author:     Thomas Lendacky <Thomas.Lendacky@amd.com>
AuthorDate: Thu, 31 Jan 2019 14:33:06 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 31 Jan 2019 16:54:32 +0100

x86/microcode/amd: Don't falsely trick the late loading mechanism

The load_microcode_amd() function searches for microcode patches and
attempts to apply a microcode patch if it is of different level than the
currently installed level.

While the processor won't actually load a level that is less than
what is already installed, the logic wrongly returns UCODE_NEW thus
signaling to its caller reload_store() that a late loading should be
attempted.

If the file-system contains an older microcode revision than what is
currently running, such a late microcode reload can result in these
misleading messages:

  x86/CPU: CPU features have changed after loading microcode, but might not take effect.
  x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.

These messages were issued on a system where SME/SEV are not
enabled by the BIOS (MSR C001_0010[23] = 0b) because during boot,
early_detect_mem_encrypt() is called and cleared the SME and SEV
features in this case.

However, after the wrong late load attempt, get_cpu_cap() is called and
reloads the SME and SEV feature bits, resulting in the messages.

Update the microcode level check to not attempt microcode loading if the
current level is greater than(!) and not only equal to the current patch
level.

 [ bp: massage commit message. ]

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/154894518427.9406.8246222496874202773.stgit@tlendack-t1.amdoffice.net
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 51adde0a0f1a..e1f3ba19ba54 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -855,7 +855,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 	if (!p) {
 		return ret;
 	} else {
-		if (boot_cpu_data.microcode == p->patch_id)
+		if (boot_cpu_data.microcode >= p->patch_id)
 			return ret;
 
 		ret = UCODE_NEW;
