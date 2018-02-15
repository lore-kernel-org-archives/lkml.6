Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720503-2-5719182777304080554
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
    t=1518720502; b=XPGmtq/uO2IhOpiahyXuKnF/rUfzSIctDPzs+HPH36nX8Z2
    DsIYRSIHlWx+Ir++xNIub6E6nQLfkfQmITw2WXBGstzVjmUw+NQ9aip7BeC7CMSV
    ymFrgTd3+undDaYhsc/gXMTxNG0YoNpI6clrAoR2UTqgqu3+HGKkVfd5+0lAMMDc
    SlbtM0qWT8FJ6JGD6o0OxYP6wi8tdi7saGbkm0xnuDcdkOX2TjL3HQbmtalx/oVn
    h4HBtyUimWvr4Ts69ttCVqvttPKHt/+RdPSSOdyph30RPri6C/KcOYFYo9QNo0eq
    ZleYRYhjNb7v9e2te7EBYOOsIZXjK1zmFB2cpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720502; bh=fYLIg73O2kzrZyxVLurjPgDvoU
    9B+cAYbp66lnsZMso=; b=G/gMC7TBw4QwCMMAOevJy4XVqCG5URFQUQoPEvpRbc
    +VYiIDWdXLkbCIx8PXq8PGYsYkAX/AS7nlpfqPSbm2rP7I8EVuC5IlKDM2Audmm/
    RAATVH3l6Df3b45fz9G2/z0TS4NuddrbMJe/gMWzYX17a7FNZal49skDTqnOKPKf
    SE0jSkJLX0up+UNrH98SmIFmL7TuRjJqeDe7q6EVJZknxLbTx9xQk7PVMWfD1Fqq
    qebVmba2H+Iysb8KvD0/2p5J2mpXdc5ecepo+gU9zuo5wBtLBgm5hZk/jnPsVx05
    gEomFvjnTUJMNIQhLhhwnXyESv24UGoD97+FDJdiGT4g==
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
        id S1162300AbeBOPWK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162248AbeBOPWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 4.4 038/108] x86/microcode: Do the family check first
Date: Thu, 15 Feb 2018 16:16:35 +0100
Message-Id: <20180215151227.742442946@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit 1f161f67a272cc4f29f27934dd3f74cb657eb5c4 upstream with adjustments.

On CPUs like AMD's Geode, for example, we shouldn't even try to load
microcode because they do not support the modern microcode loading
interface.

However, we do the family check *after* the other checks whether the
loader has been disabled on the command line or whether we're running in
a guest.

So move the family checks first in order to exit early if we're being
loaded on an unsupported family.

Reported-and-tested-by: Sven Glodowski <glodi1@arcor.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.11..
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://bugzilla.suse.com/show_bug.cgi?id=1061396
Link: http://lkml.kernel.org/r/20171012112316.977-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -94,9 +94,6 @@ static bool __init check_loader_disabled
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (!have_cpuid_p())
-		return *res;
-
 	a = 1;
 	c = 0;
 	native_cpuid(&a, &b, &c, &d);
@@ -138,8 +135,9 @@ void __init load_ucode_bsp(void)
 {
 	int vendor;
 	unsigned int family;
+	bool intel = true;
 
-	if (check_loader_disabled_bsp())
+	if (!have_cpuid_p())
 		return;
 
 	vendor = x86_vendor();
@@ -147,16 +145,27 @@ void __init load_ucode_bsp(void)
 
 	switch (vendor) {
 	case X86_VENDOR_INTEL:
-		if (family >= 6)
-			load_ucode_intel_bsp();
+		if (family < 6)
+			return;
 		break;
+
 	case X86_VENDOR_AMD:
-		if (family >= 0x10)
-			load_ucode_amd_bsp(family);
+		if (family < 0x10)
+			return;
+		intel = false;
 		break;
+
 	default:
-		break;
+		return;
 	}
+
+	if (check_loader_disabled_bsp())
+		return;
+
+	if (intel)
+		load_ucode_intel_bsp();
+	else
+		load_ucode_amd_bsp(family);
 }
 
 static bool check_loader_disabled_ap(void)
