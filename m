Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0765FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C796D20855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956174;
	bh=x9x3s+LjImT506imibzeRW6wHG8ELRJ3GLtKLGRcCNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sc9TztxHJGoDK3CO8g5vPZLmXhCkw3dbi1tIdbWUtg4rnTskj88HKUug6HJCXo3fs
	 J6bwsNIluXrAHtR+TBjzh48XgGgNfUG2DsZ8SVkHD/X5F1epI4AL3tdYt5gDgNFzq5
	 oEQ7jEHkp1/RnWlCAAcfDKeaC3pYNd+OK8/wU4rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfBWVJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbfBWVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6508420861;
        Sat, 23 Feb 2019 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956169;
        bh=x9x3s+LjImT506imibzeRW6wHG8ELRJ3GLtKLGRcCNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=salvZ6IpczKbnqdtmkLnc0rvfSN51y4AQDZ0IxVdRXBaUj5iHzAI+/z1zSNbA4sXn
         uOuVtnsD9oYuT39TcfdGUrmNh0xL5Uh1LrdPbVymbHZScP/p+SHLtyCNJQP95hia9j
         ApFsBg2+tt0EYPbwqUKAE/X0nixnNnTCp25K6oiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 35/45] x86/microcode/amd: Don't falsely trick the late loading mechanism
Date:   Sat, 23 Feb 2019 16:08:25 -0500
Message-Id: <20190223210835.201708-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Lendacky <Thomas.Lendacky@amd.com>

[ Upstream commit 912139cfbfa6a2bc1da052314d2c29338dae1f6a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9d33dbf2489e2..d0a61d3e2fb94 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -707,7 +707,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 	if (!p) {
 		return ret;
 	} else {
-		if (boot_cpu_data.microcode == p->patch_id)
+		if (boot_cpu_data.microcode >= p->patch_id)
 			return ret;
 
 		ret = UCODE_NEW;
-- 
2.19.1

