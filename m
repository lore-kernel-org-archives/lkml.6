Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946214-1519035443-2-6263542351169772376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035443; b=GEK5n/ZYR929mF+VCmZUtDZPRsa97WMGeruSTSsOT8dzWwy
    qMrScLI6uqgVhjnupq+yhRkpzjJeQwaAXqIM7DOP4V0+gKkqo5Qv+DElGbJRqL3b
    IED1fFlwQf6cpidB6sdEAP/286fdsfMZCMqmb0O3V5ncrzLTDvl/i+QWUPK4FbT6
    SRIEmtRhmSGr2i0W8snuQbzrMtvpEjWNiq5izrhKWA/u+bhGYvdUJh9xAiKulNuy
    c9O72wuQe/PJSpk4NDOO6tmQpD4FAycCxU3IB01Sf23vuif9pilaH1uE/KW1NIqh
    UDXGh9KYzcsbwVV9sdsWDKT2nLUCuwDyB0xvDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035443;
    bh=Ii+avSz21BmFlUaAjvoIbGQV+ejvmloj3ZbsWuMKEdM=; b=Y6jYAuVVhdas
    GU7ibOIq/xXhcNCTGwAu+RJkI0H2kwDMX61n8nPmkqF7h7AyN3oCA68UM9zHKsZw
    PRzh87y4sR217ToIZNDi/ILlYC04XqVC6H7Oea69DpxLGCyNQUnLVEUD4HGf+qRE
    RX2Y7mktAkOiN3EH0nxbQZCqWazoqwuaokaWdzjr2KD0EtcFt4pnlYjoxM1ukLtn
    ufoCod9m8I03i49zodCnditCmaJ+dCSlfMW8EdSK/PYzUlGWKJz0tu7ntXbKUUY+
    qYG7PLap1mlU0YFFY/W3FIwKjB0AFrH++9lJgGqBA9/u4CEKgor1P6HaIB2p5W9w
    WYFFBay/Yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeBSKQh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:53148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbeBSKOk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Feb 2018 05:14:40 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 3/3] x86/xen: add pvh specific rsdp address retrieval function
Date: Mon, 19 Feb 2018 11:09:06 +0100
Message-Id: <20180219100906.14265-4-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180219100906.14265-1-jgross@suse.com>
References: <20180219100906.14265-1-jgross@suse.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add pvh_get_root_pointer() for Xen PVH guests to communicate the
address of the RSDP table given to the kernel via Xen start info.

This makes the kernel boot again in PVH mode after on recent Xen the
RSDP was moved to higher addresses. So up to that change it was pure
luck that the legacy method to locate the RSDP was working when
running as PVH mode.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pvh.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 436c4f003e17..aa1c6a6831a9 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -6,6 +6,7 @@
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
+#include <asm/x86_init.h>
 
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
@@ -16,15 +17,20 @@
 /*
  * PVH variables.
  *
- * xen_pvh and pvh_bootparams need to live in data segment since they
- * are used after startup_{32|64}, which clear .bss, are invoked.
+ * xen_pvh pvh_bootparams and pvh_start_info need to live in data segment
+ * since they are used after startup_{32|64}, which clear .bss, are invoked.
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
+struct hvm_start_info pvh_start_info __attribute__((section(".data")));
 
-struct hvm_start_info pvh_start_info;
 unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
 
+static u64 pvh_get_root_pointer(void)
+{
+	return pvh_start_info.rsdp_paddr;
+}
+
 static void __init init_pvh_bootparams(void)
 {
 	struct xen_memory_map memmap;
@@ -71,6 +77,8 @@ static void __init init_pvh_bootparams(void)
 	 */
 	pvh_bootparams.hdr.version = 0x212;
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+
+	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;
 }
 
 /*
-- 
2.13.6
