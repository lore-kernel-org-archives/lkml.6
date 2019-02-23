Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E520651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957005;
	bh=dW7VwPLQXp4yU4O1IB5ptrHGf0KwfqfxuApAIKre9G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBq1EBxrmmNqfLAF8FFUk+0qaSOGYgXCgVglF5ln7bU1F5jGqCpogfnuRWG8AShlh
	 C/G/yH6FbVwT9rXkWAEykDyWhNrnO2k/gTPCjxhN5UqVHDmuUNFLs+ZM6zVj99K2ci
	 mtDx2CWhaOpl7VzpFzThGXjko+rA1yzZnNn1UEOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfBWVXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbfBWVIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:08:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1916E2085A;
        Sat, 23 Feb 2019 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956086;
        bh=dW7VwPLQXp4yU4O1IB5ptrHGf0KwfqfxuApAIKre9G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ownML6dg1uiP9Yy26VnDWnqvpL7VOWLkUv5gVg9ggK7crZiQasjRqpRkS5LnbcKNs
         iQ9AvPNdHFxCaOTcixCF0Vj6tFrxwo6Bgh6ctZA/zVrSMTqoeYIOpgDlUXeDx5Ja2H
         3/QvPztepbEDU4zbvZdgOvc6ybGEp5trCEIJKX1c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 54/65] x86/microcode/amd: Don't falsely trick the late loading mechanism
Date:   Sat, 23 Feb 2019 16:06:29 -0500
Message-Id: <20190223210640.200911-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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
index 07b5fc00b1880..a4e7e100ed26b 100644
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

