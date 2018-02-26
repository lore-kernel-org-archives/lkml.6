Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677391-2-7108920197661033062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677390; b=B0R/HwUu64XOwkBVmDz7joF55rbsYzol3WlL/mcvA62AI2L
    BzyozniRlwaRUb004+MUj+JLIo5cWBKRdq5aZlkdU/dyvpNlIXVDu5cnwlHbRSM0
    egd98Zi8PeHB/yabBZvQEY4EA3cTshr2nGGLU3joLHyZG/nD/x9oQf/xKbs/nbkt
    Yk5sqGkcfeMAkuHgR/kZuT7E304OqX3nLlvuU0Z2SM2gsyqi17FE8RDb/x2RzHDK
    +r1vTAfogHEMV6D9OBdpKWHs24NT04F89QjfJ9UCG4nRcnXvtl6zDxGByxnHh2fp
    0EgiQTZLTuEtuyiPKjlUeuuM77SRIK7VMbNxmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677390; bh=FKMRgmnkiGxmpYcx3dr8Y3CQXT
    /wBNe54aOIDu1jIIE=; b=nTf3M8i8kDMAGCGeDcxsldDPTVu3kqy7lkP8VodarE
    ShFIymSlO/PiqVKaRWPJ5XCsJ9Ar8aguj3Q00iLgfQ2P83BY754OLbgyvR+rDXAg
    dDsQDmCBbyWKJSxbs86sZoNUUAgShZHCEZRa45jC5PGCpMJbjnOShq9q28Yy3X4f
    oCXBk8mXUhAoUISvnIHEmlPeSexabS5w0zxqcvNh4Kz5FpcVkKvTSL6esbO9RONE
    7McmQazIA4uCAZYeBZD3dysvOcaHZBZzt/SWtF31vhe/BHsxM9oFTQvvuxt80VkM
    /qbqA5WpWX6mxywp0AGBaKnzzm2ac5qWK0Tef7xzK8kg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeBZUgR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:36:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbeBZU1i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 30/64] mm: dont defer struct page initialization for Xen pv guests
Date: Mon, 26 Feb 2018 21:22:07 +0100
Message-Id: <20180226202154.736497772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 895f7b8e90200cf1a5dc313329369adf30e51f9a upstream.

Commit f7f99100d8d9 ("mm: stop zeroing memory during allocation in
vmemmap") broke Xen pv domains in some configurations, as the "Pinned"
information in struct page of early page tables could get lost.

This will lead to the kernel trying to write directly into the page
tables instead of asking the hypervisor to do so.  The result is a crash
like the following:

  BUG: unable to handle kernel paging request at ffff8801ead19008
  IP: xen_set_pud+0x4e/0xd0
  PGD 1c0a067 P4D 1c0a067 PUD 23a0067 PMD 1e9de0067 PTE 80100001ead19065
  Oops: 0003 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-default+ #271
  Hardware name: Dell Inc. Latitude E6440/0159N7, BIOS A07 06/26/2014
  task: ffffffff81c10480 task.stack: ffffffff81c00000
  RIP: e030:xen_set_pud+0x4e/0xd0
  Call Trace:
   __pmd_alloc+0x128/0x140
   ioremap_page_range+0x3f4/0x410
   __ioremap_caller+0x1c3/0x2e0
   acpi_os_map_iomem+0x175/0x1b0
   acpi_tb_acquire_table+0x39/0x66
   acpi_tb_validate_table+0x44/0x7c
   acpi_tb_verify_temp_table+0x45/0x304
   acpi_reallocate_root_table+0x12d/0x141
   acpi_early_init+0x4d/0x10a
   start_kernel+0x3eb/0x4a1
   xen_start_kernel+0x528/0x532
  Code: 48 01 e8 48 0f 42 15 a2 fd be 00 48 01 d0 48 ba 00 00 00 00 00 ea ff ff 48 c1 e8 0c 48 c1 e0 06 48 01 d0 48 8b 00 f6 c4 02 75 5d <4c> 89 65 00 5b 5d 41 5c c3 65 8b 05 52 9f fe 7e 89 c0 48 0f a3
  RIP: xen_set_pud+0x4e/0xd0 RSP: ffffffff81c03cd8
  CR2: ffff8801ead19008
  ---[ end trace 38eca2e56f1b642e ]---

Avoid this problem by not deferring struct page initialization when
running as Xen pv guest.

Pavel said:

: This is unique for Xen, so this particular issue won't effect other
: configurations.  I am going to investigate if there is a way to
: re-enable deferred page initialization on xen guests.

[akpm@linux-foundation.org: explicitly include xen.h]
Link: http://lkml.kernel.org/r/20180216154101.22865-1-jgross@suse.com
Fixes: f7f99100d8d95d ("mm: stop zeroing memory during allocation in vmemmap")
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: <stable@vger.kernel.org>	[4.15.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
+#include <xen/xen.h>
 #include <linux/backing-dev.h>
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>
@@ -347,6 +348,9 @@ static inline bool update_defer_init(pg_
 	/* Always populate low zones for address-contrained allocations */
 	if (zone_end < pgdat_end_pfn(pgdat))
 		return true;
+	/* Xen PV domains need page structures early */
+	if (xen_pv_domain())
+		return true;
 	(*nr_initialised)++;
 	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
 	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
