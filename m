Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA1ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83C121476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeL8Zk6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83C121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeJSCDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJSCDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F65205C9;
        Thu, 18 Oct 2018 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885666;
        bh=p7y0ju0Qdv7QJTWQQmGMPZExi2ygR8qzaC6WJnc+nng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeL8Zk6tz1p1eTEqtSxMayva3aQK3mIFsyKRP9VxxG82q/xwdJjcBw0zhSaVDyDwE
         REVhb6znIuk7B1adiXyV9GrCan/KORSitybtr+vGWCIe5gl3W1uxDqlA/ASuTRD70p
         /h+KbKnt7Sdqh+9p4SWNGzQze3j8+bwvm28TReqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 4.14 30/41] powerpc/lib/feature-fixups: use raw_patch_instruction()
Date:   Thu, 18 Oct 2018 19:54:45 +0200
Message-Id: <20181018175422.053789114@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 8183d99f4a22c2abbc543847a588df3666ef0c0c upstream.

feature fixups need to use patch_instruction() early in the boot,
even before the code is relocated to its final address, requiring
patch_instruction() to use PTRRELOC() in order to address data.

But feature fixups applies on code before it is set to read only,
even for modules. Therefore, feature fixups can use
raw_patch_instruction() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: David Gounaris <david.gounaris@infinera.com>
Tested-by: David Gounaris <david.gounaris@infinera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/code-patching.h |    1 +
 arch/powerpc/lib/code-patching.c         |    4 ++--
 arch/powerpc/lib/feature-fixups.c        |    8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -31,6 +31,7 @@ unsigned int create_cond_branch(const un
 				unsigned long target, int flags);
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
+int raw_patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -39,7 +39,7 @@ static int __patch_instruction(unsigned
 	return 0;
 }
 
-static int raw_patch_instruction(unsigned int *addr, unsigned int instr)
+int raw_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	return __patch_instruction(addr, instr, addr);
 }
@@ -156,7 +156,7 @@ static int do_patch_instruction(unsigned
 	 * when text_poke_area is not ready, but we still need
 	 * to allow patching. We just do the plain old patching
 	 */
-	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
+	if (!this_cpu_read(text_poke_area))
 		return raw_patch_instruction(addr, instr);
 
 	local_irq_save(flags);
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -63,7 +63,7 @@ static int patch_alt_instruction(unsigne
 		}
 	}
 
-	patch_instruction(dest, instr);
+	raw_patch_instruction(dest, instr);
 
 	return 0;
 }
@@ -92,7 +92,7 @@ static int patch_feature_section(unsigne
 	}
 
 	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_INST_NOP);
+		raw_patch_instruction(dest, PPC_INST_NOP);
 
 	return 0;
 }
@@ -292,7 +292,7 @@ void do_lwsync_fixups(unsigned long valu
 
 	for (; start < end; start++) {
 		dest = (void *)start + *start;
-		patch_instruction(dest, PPC_INST_LWSYNC);
+		raw_patch_instruction(dest, PPC_INST_LWSYNC);
 	}
 }
 
@@ -310,7 +310,7 @@ static void do_final_fixups(void)
 	length = (__end_interrupts - _stext) / sizeof(int);
 
 	while (length--) {
-		patch_instruction(dest, *src);
+		raw_patch_instruction(dest, *src);
 		src++;
 		dest++;
 	}


