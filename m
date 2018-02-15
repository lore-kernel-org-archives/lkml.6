Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720857-2-11827290801872175647
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
    t=1518720856; b=EfiJjH89Vh5gfyS0wUp+5U3VrIdWBTg8+cncTPdBPSBPOyT
    TSL/Decj4FeS3xA+87io+Q7oD5LrVEVNy8CIp4ah2dCHxdsPiVtOvEQpzoNCqIdP
    jwX3vCVRVej5jLF2Np0PWdq9yU8C+9rQtbxH6YlRrPyfNcOBuLye8qAmLKRIHp56
    1u+AKQD0ZfZEIabYN+bQ/OzFrtoTacNjpy48HQKXKoeUS9qgUlVsh4Ojj+dN8bqN
    RBRj/XlXTHNT0AzZrlstd0s2wojoz0HXkfCPEG/2l4z88o1BewAI0x7iXZL62qrG
    14AGOVKpuooAQrY7I/F40O92AJkBcpmX01khPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720856; bh=WqYgzoqeOY6uPBHFvzGxHgTl8L
    Svnb77wGz28r9qPqA=; b=DD2OBqpo6LTX3OOhRLXs15fEQYr8eWbKrncaugrrmZ
    vQWWBDjnBL3bb8rpWfKjF02cjqoQ0/n7ZYx/nQPieCsMGjkh3xABHjl2liXsNU4e
    pgeRtvJ7R86cdbATpZC44vhqB8E4UaP0L+qLCDpFUVSqdQe7koBmAS2Bb40FdKrX
    HZ1wPwX2D3Mc03SuGiV54LkxDEPTCrmLRvTj5d76RLHIBC63BPWctOL9gEwBsG6E
    UfQGSynNbvdEVCZeEV9grYzTZZq+s4Wo5sPDPyzW23fhNwDIOO6kVqsl1BDbzAqb
    FlW7pRv2Wvlko+m+5hlHt1lGxa1a/ON2xgPOtb/ZMgTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161881AbeBOPUz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:20:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161799AbeBOPUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Modra <amodra@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 004/108] powerpc: Simplify module TOC handling
Date: Thu, 15 Feb 2018 16:16:01 +0100
Message-Id: <20180215151222.874728841@linuxfoundation.org>
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

From: Alan Modra <amodra@gmail.com>

commit c153693d7eb9eeb28478aa2deaaf0b4e7b5ff5e9 upstream.

PowerPC64 uses the symbol .TOC. much as other targets use
_GLOBAL_OFFSET_TABLE_. It identifies the value of the GOT pointer (or in
powerpc parlance, the TOC pointer). Global offset tables are generally
local to an executable or shared library, or in the kernel, module. Thus
it does not make sense for a module to resolve a relocation against
.TOC. to the kernel's .TOC. value. A module has its own .TOC., and
indeed the powerpc64 module relocation processing ignores the kernel
value of .TOC. and instead calculates a module-local value.

This patch removes code involved in exporting the kernel .TOC., tweaks
modpost to ignore an undefined .TOC., and the module loader to twiddle
the section symbol so that .TOC. isn't seen as undefined.

Note that if the kernel was compiled with -msingle-pic-base then ELFv2
would not have function global entry code setting up r2. In that case
the module call stubs would need to be modified to set up r2 using the
kernel .TOC. value, requiring some of this code to be reinstated.

mpe: Furthermore a change in binutils master (not yet released) causes
the current way we handle the TOC to no longer work when building with
MODVERSIONS=y and RELOCATABLE=n. The symptom is that modules can not be
loaded due to there being no version found for TOC.

Signed-off-by: Alan Modra <amodra@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/misc_64.S   |   28 ----------------------------
 arch/powerpc/kernel/module_64.c |   12 +++++++++---
 scripts/mod/modpost.c           |    3 ++-
 3 files changed, 11 insertions(+), 32 deletions(-)

--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -701,31 +701,3 @@ _GLOBAL(kexec_sequence)
 	li	r5,0
 	blr	/* image->start(physid, image->start, 0); */
 #endif /* CONFIG_KEXEC */
-
-#ifdef CONFIG_MODULES
-#if defined(_CALL_ELF) && _CALL_ELF == 2
-
-#ifdef CONFIG_MODVERSIONS
-.weak __crc_TOC.
-.section "___kcrctab+TOC.","a"
-.globl __kcrctab_TOC.
-__kcrctab_TOC.:
-	.llong	__crc_TOC.
-#endif
-
-/*
- * Export a fake .TOC. since both modpost and depmod will complain otherwise.
- * Both modpost and depmod strip the leading . so we do the same here.
- */
-.section "__ksymtab_strings","a"
-__kstrtab_TOC.:
-	.asciz "TOC."
-
-.section "___ksymtab+TOC.","a"
-/* This symbol name is important: it's used by modpost to find exported syms */
-.globl __ksymtab_TOC.
-__ksymtab_TOC.:
-	.llong 0 /* .value */
-	.llong __kstrtab_TOC.
-#endif /* ELFv2 */
-#endif /* MODULES */
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -326,7 +326,10 @@ static void dedotify_versions(struct mod
 		}
 }
 
-/* Undefined symbols which refer to .funcname, hack to funcname (or .TOC.) */
+/*
+ * Undefined symbols which refer to .funcname, hack to funcname. Make .TOC.
+ * seem to be defined (value set later).
+ */
 static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
 {
 	unsigned int i;
@@ -334,8 +337,11 @@ static void dedotify(Elf64_Sym *syms, un
 	for (i = 1; i < numsyms; i++) {
 		if (syms[i].st_shndx == SHN_UNDEF) {
 			char *name = strtab + syms[i].st_name;
-			if (name[0] == '.')
+			if (name[0] == '.') {
+				if (strcmp(name+1, "TOC.") == 0)
+					syms[i].st_shndx = SHN_ABS;
 				syms[i].st_name++;
+			}
 		}
 	}
 }
@@ -351,7 +357,7 @@ static Elf64_Sym *find_dot_toc(Elf64_Shd
 	numsyms = sechdrs[symindex].sh_size / sizeof(Elf64_Sym);
 
 	for (i = 1; i < numsyms; i++) {
-		if (syms[i].st_shndx == SHN_UNDEF
+		if (syms[i].st_shndx == SHN_ABS
 		    && strcmp(strtab + syms[i].st_name, "TOC.") == 0)
 			return &syms[i];
 	}
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -594,7 +594,8 @@ static int ignore_undef_symbol(struct el
 		if (strncmp(symname, "_restgpr0_", sizeof("_restgpr0_") - 1) == 0 ||
 		    strncmp(symname, "_savegpr0_", sizeof("_savegpr0_") - 1) == 0 ||
 		    strncmp(symname, "_restvr_", sizeof("_restvr_") - 1) == 0 ||
-		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0)
+		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0 ||
+		    strcmp(symname, ".TOC.") == 0)
 			return 1;
 	/* Do not ignore this symbol */
 	return 0;
