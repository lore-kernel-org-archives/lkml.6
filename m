Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57AFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89833214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89833214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sembritzki.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeHOWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:36:48 -0400
Received: from mail.sembritzki.me ([5.45.101.249]:60536 "EHLO
        mail.sembritzki.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbeHOWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:36:47 -0400
Received: from yannik-laptop.fritz.box (x4dbb4132.dyn.telefonica.de [77.187.65.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.sembritzki.me (Postfix) with ESMTPSA id 9F570A7AAF;
        Wed, 15 Aug 2018 21:43:14 +0200 (CEST)
From:   Yannik Sembritzki <yannik@sembritzki.me>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>, stable@vger.kernel.org
Subject: [PATCH 1/2] Fix kexec forbidding kernels signed with keys in the secondary keyring to boot
Date:   Wed, 15 Aug 2018 21:42:43 +0200
Message-Id: <20180815194244.29564-2-yannik@sembritzki.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180815194244.29564-1-yannik@sembritzki.me>
References: <20180815194244.29564-1-yannik@sembritzki.me>
In-Reply-To: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
References: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The split of .system_keyring to .builtin_trusted_keys and .secondary_trusted_keys broke kexec, as kernels signed by keys which are now in the secondary keyring cannot be kexec'd anymore.

Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
CC: stable@vger.kernel.org
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7326078e..74628275 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       ((struct key *)1UL),
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif
-- 
2.17.1

