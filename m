Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720878-2-11696382758810973420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720877; b=tM7Qf3HJnuLz1DjY8TRkblJbS9Czg5HjEZlPY0DRr2wl4Hq
    Z3XwLNlAG3wVzgCG90T2zHF0xFKEKpJsGcKHFZ1Nuek2w5A+ygNdJP27bfAAgIRs
    wIZeyDcTb1Nz7IXx914dUsU1GI38dx7eOWKJMTH/+x5Sju89LGfpqFJNR6jUS/nX
    /s589JIcjZiI0wErhcs364TGMKPFi256vvXcTtQUyRcxwqTD6mCfdZQwi7w2XPVl
    dHw0RS3VOJ4sGpaBJRHyulnRqL8AA623kywMNQrNdlRPBm1VmiFeopfcf52ebm5W
    PCPEkIR3btNtRQW7QYTLbycOx/BUvkpEY3K9DMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720877; bh=hPEkW5XsP1M5CjBHmzheRkZYd7
    xOJO1c5KvA48QCu2k=; b=SLlCOyd9cyUu3YYTHM0j3PtoMcV2NJs0qYmgGoJzgy
    dYR+bgyXb3t8U/eCFVIDBtlx1UfXut1MNZGibaXZmJPxFksb6AokF1i+bN8+7Oi/
    LXu6ExewL/JxsNNOS3dHEP6VQCsu7DIl4bZSEOZFapwrf2gqBhdKiraw2wt5VM75
    XKcOqWSDifYa3GVPZ6/LW1abFLf+LO7ETGKpuBMmzaTRhxk81K3o0u6FyM4jxSfh
    5rJ3JW5DjSggOWbuByvuqT9nahqfsv1ksNTDnp1rvPTu4Gs6Cv3BQOCI8w9bkDJO
    5exbyqWShoN101fasGeof+V9HMJ23Yxh2+FencNHtHAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161864AbeBOPUs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:20:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161799AbeBOPUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 002/108] powerpc/64: Fix flush_(d|i)cache_range() called from modules
Date: Thu, 15 Feb 2018 16:15:59 +0100
Message-Id: <20180215151222.601913314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver O'Halloran <oohall@gmail.com>

commit 8f5f525d5b83f7d76a6baf9c4e94d4bf312ea7f6 upstream.

When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does
not include a global entry point. A function's global entry point is
used when the function is called from a different TOC context and in the
kernel this typically means a call from a module into the vmlinux (or
vice-versa).

There are a few exported asm functions declared with _GLOBAL() and
calling them from a module will likely crash the kernel since any TOC
relative load will yield garbage.

flush_icache_range() and flush_dcache_range() are both exported to
modules, and use the TOC, so must use _GLOBAL_TOC().

Fixes: 721aeaa9fdf3 ("powerpc: Build little endian ppc64 kernel with ABIv2")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/ppc_asm.h |   12 ++++++++++++
 arch/powerpc/kernel/misc_64.S      |    4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -224,6 +224,16 @@ name: \
 	.globl name; \
 name:
 
+#define _KPROBE_TOC(name)			\
+	.section ".kprobes.text","a";		\
+	.align 2 ;				\
+	.type name,@function;			\
+	.globl name;				\
+name:						\
+0:	addis r2,r12,(.TOC.-0b)@ha;		\
+	addi r2,r2,(.TOC.-0b)@l;		\
+	.localentry name,.-name
+
 #define DOTSYM(a)	a
 
 #else
@@ -261,6 +271,8 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _KPROBE_TOC(n)	_KPROBE(n)
+
 #define DOTSYM(a)	GLUE(.,a)
 
 #endif
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -66,7 +66,7 @@ PPC64_CACHES:
  *   flush all bytes from start through stop-1 inclusive
  */
 
-_KPROBE(flush_icache_range)
+_KPROBE_TOC(flush_icache_range)
 BEGIN_FTR_SECTION
 	PURGE_PREFETCHED_INS
 	blr
@@ -117,7 +117,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_I
  *
  *    flush all bytes from start to stop-1 inclusive
  */
-_GLOBAL(flush_dcache_range)
+_GLOBAL_TOC(flush_dcache_range)
 
 /*
  * Flush the data cache to memory 
