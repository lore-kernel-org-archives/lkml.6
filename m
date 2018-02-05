Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517855044-2-5933311248240711261
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
    t=1517855043; b=VyaXfZ7CxeoWp7o02pZZTXaklMlwns/B4hxGp92qq9s8dcA
    tsUbLCYhn4Sb23KP0QWwUV+qKiKDnH1lIOprXsVXVbJBX8cpEQfsxTDlTTgEwVv2
    t7xP/uTyX51XCGL9sd/25nkQSHQQOCenLH+8b/yegEV3OINqTo5HlcF1ibieuJOB
    hQ6F4GKpaSXFjkjbZjnJ2FpNiUsm74nFlTwSHDpW390NjNuIyH2HvLAuAxeUzcMu
    CQra0nZeTrZLr4V9AYOpuO4wCJbj5zhK1ytoh1XIuqVWWyCmP173LKwOCx9BwcYk
    0jaod5HUZf/vSsiWk6lCzAhYdSy+kxY+J8RXJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855043; bh=GDaOmOnUO+cqGnSNV938ZTs5yJ
    5EbC/N2wZI5rUTQV0=; b=OX5h2SMP3mvZgCbiiAQVrhGJzVvGFDYFSUoSdWNPtb
    cho66SfYyjskjZHb6rjVooB330gNIZP9h+z4Tt6omSqY2Bq7heDdYU2XYXaeZImR
    jq+jSskEdaFhK5h5n+i6BvVJJJpePVkKg4COIc1a6ZYIipRUsCprgiYUDmQzHZ0z
    7rKyHbQ5RLsE8+3NARP2PJ86acnfKFMm2B54B4WQxIV0HvqWySxmNbd5OZxgUEnn
    v/znvDgNXbS/B38KazjGYYgqkaWHu5SuXVK4ze/wxLB3hn/mfLWIwY9tuiT2pz2O
    1xXAcuk6jSTlve0ymFgoV3ZJnFXuGcQRSAuz/8y3XuzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeBESYA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbeBESX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        William Grant <william.grant@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 31/64] x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
Date: Mon,  5 Feb 2018 10:22:50 -0800
Message-Id: <20180205182139.862012036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Grant <william.grant@canonical.com>

commit 55f49fcb879fbeebf2a8c1ac7c9e6d90df55f798

Since commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the
fixmap"), i386's CPU_ENTRY_AREA has been mapped to the memory area just
below FIXADDR_START. But already immediately before FIXADDR_START is the
FIX_BTMAP area, which means that early_ioremap can collide with the entry
area.

It's especially bad on PAE where FIX_BTMAP_BEGIN gets aligned to exactly
match CPU_ENTRY_AREA_BASE, so the first early_ioremap slot clobbers the
IDT and causes interrupts during early boot to reset the system.

The overlap wasn't a problem before the CPU entry area was introduced,
as the fixmap has classically been preceded by the pkmap or vmalloc
areas, neither of which is used until early_ioremap is out of the
picture.

Relocate CPU_ENTRY_AREA to below FIX_BTMAP, not just below the permanent
fixmap area.

Fixes: commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
Signed-off-by: William Grant <william.grant@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/fixmap.h           |    6 ++++--
 arch/x86/include/asm/pgtable_32_types.h |    5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -137,8 +137,10 @@ enum fixed_addresses {
 
 extern void reserve_top_address(unsigned long reserve);
 
-#define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_SIZE		(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_TOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_TOT_START	(FIXADDR_TOP - FIXADDR_TOT_SIZE)
 
 extern int fixmaps_set;
 
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,8 +44,9 @@ extern bool __vmalloc_start_set; /* set
  */
 #define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
 
-#define CPU_ENTRY_AREA_BASE				\
-	((FIXADDR_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1)) & PMD_MASK)
+#define CPU_ENTRY_AREA_BASE						\
+	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
+	 & PMD_MASK)
 
 #define PKMAP_BASE		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
