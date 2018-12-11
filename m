Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E457AC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA182084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qi+DHPqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA182084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeLKWXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:23:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46218 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeLKWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:33 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CDE61EC0C01;
        Tue, 11 Dec 2018 23:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544567011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICYBXFaJIVLNHQr0eO8+1a7LQhPda4hKCJimxgnVvfY=;
        b=Qi+DHPqOwVaI4OUBLuiX+fOZxDG4vel48u/0A3cT0XU+BNorvFLsRDolcTAEc63AjsBw+S
        YcN2+bstlJyLTHTmi660mVTvELwq+N6nm1D3qUe81tqCVUF8QbRGdUDZ/E1lW3E2InOnwZ
        0yDc6jaM5fkzoqu3w0aQcACqnAfmLyA=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 2/4] x86/alternatives: Print containing function
Date:   Tue, 11 Dec 2018 23:23:24 +0100
Message-Id: <20181211222326.14581-3-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211222326.14581-1-bp@alien8.de>
References: <20181211222326.14581-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... in the "debug-alternative" output so that one can find her way
easier when staring at the vmlinux disassembly.

For example:

  apply_alternatives: feat: 3*32+18, old: (read_tsc+0x0/0x10 (ffffffff8101d1c0) len: 5), repl: (ffffffff824e6d33, len: 5)
  					   ^^^^^^^^^^^^^^^^^
  ffffffff8101d1c0: old_insn: 0f 31 90 90 90
  ffffffff824e6d33: rpl_insn: 0f ae e8 0f 31
  ffffffff8101d1c0: final_insn: 0f ae e8 0f 31

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..d458c7973c56 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,10 +393,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, a->instrlen,
+			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
-- 
2.19.1

