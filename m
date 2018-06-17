Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A478C208D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A478C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936768AbeFQMAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 08:00:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934123AbeFQMAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 08:00:17 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nj69nrRC_W2q; Sun, 17 Jun 2018 14:00:16 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3B341EC01D4;
        Sun, 17 Jun 2018 14:00:15 +0200 (CEST)
Date:   Sun, 17 Jun 2018 14:00:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
Message-ID: <20180617120012.GB16877@zn.tnic>
References: <20180507213755.GA32406@avx2>
 <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1529235613.4572.7.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 01:40:13PM +0200, Mike Galbraith wrote:
> On Mon, 2018-05-14 at 05:53 -0700, tip-bot for Alexey Dobriyan wrote:
> > Commit-ID:  51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > Gitweb:     https://git.kernel.org/tip/51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > Author:     Alexey Dobriyan <adobriyan@gmail.com>
> > AuthorDate: Tue, 8 May 2018 00:37:55 +0300
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 14 May 2018 11:43:03 +0200
> > 
> > x86/asm: Pad assembly functions with INT3 instructions
> > 
> > Use INT3 instead of NOP. All that padding between functions is
> > an illegal area, no legitimate code should jump into it.
> 
> Is dinky patchlet suggesting cryptomgr is being naughty?
> 
> (revert silences spew, but..)
> 
> ...
> [   21.041608] int3: 0000 [#1] SMP PTI
> [   21.041754] CPU: 3 PID: 935 Comm: cryptomgr_test Tainted: G            E     4.17.0.g075a1d3-tip-default #146
> [   21.041888] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [   21.042035] RIP: 0010:crypto_aegis128_aesni_enc_tail+0x74/0x80 [aegis128_aesni]
> [   21.042171] Code: 38 dc ca 66 0f 38 dc d3 66 0f 38 dc de 66 0f ef e5 f3 0f 7f 27 f3 0f 7f 47 10 f3 0f 7f 4f 20 f3 0f 7f 57 30 f3 0f 7f 5f 40 cc <cc> cc cc cc cc cc cc cc cc cc cc cc 48 83 fe 10 0f 82 c3 03 00 00

Looks like it misses a RET:

---
From 6ac281ee69f4cb5b581d5f49662fb56b6326155a Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Sun, 17 Jun 2018 13:57:42 +0200
Subject: [PATCH] x86/crypto: Add a missing RET

crypto_aegis128_aesni_enc_tail() needs to return too.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/crypto/aegis128-aesni-asm.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 9254e0b6cc06..717bf0776421 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -535,6 +535,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
 	movdqu STATE3, 0x40(STATEP)
 
 	FRAME_END
+	ret
 ENDPROC(crypto_aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
