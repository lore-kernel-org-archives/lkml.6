Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B500C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8BE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8BE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968044AbeFRIgS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:36:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030229AbeFRIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:36:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E933CC8A;
        Mon, 18 Jun 2018 08:36:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Dave Anderson <anderson@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 4.14 147/189] proc/kcore: dont bounds check against address 0
Date:   Mon, 18 Jun 2018 10:14:03 +0200
Message-Id: <20180618081215.142601807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit 3955333df9a50e8783d115613a397ae55d905080 ]

The existing kcore code checks for bad addresses against __va(0) with
the assumption that this is the lowest address on the system.  This may
not hold true on some systems (e.g.  arm64) and produce overflows and
crashes.  Switch to using other functions to validate the address range.

It's currently only seen on arm64 and it's not clear if anyone wants to
use that particular combination on a stable release.  So this is not
urgent for stable.

Link: http://lkml.kernel.org/r/20180501201143.15121-1-labbott@redhat.com
Signed-off-by: Laura Abbott <labbott@redhat.com>
Tested-by: Dave Anderson <anderson@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>a
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/kcore.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -209,25 +209,34 @@ kclist_add_private(unsigned long pfn, un
 {
 	struct list_head *head = (struct list_head *)arg;
 	struct kcore_list *ent;
+	struct page *p;
+
+	if (!pfn_valid(pfn))
+		return 1;
+
+	p = pfn_to_page(pfn);
+	if (!memmap_valid_within(pfn, p, page_zone(p)))
+		return 1;
 
 	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
 		return -ENOMEM;
-	ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
+	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	/* Sanity check: Can happen in 32bit arch...maybe */
-	if (ent->addr < (unsigned long) __va(0))
+	if (!virt_addr_valid(ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */
 	if (ULONG_MAX - ent->addr < ent->size)
 		ent->size = ULONG_MAX - ent->addr;
 
-	/* cut when vmalloc() area is higher than direct-map area */
-	if (VMALLOC_START > (unsigned long)__va(0)) {
-		if (ent->addr > VMALLOC_START)
-			goto free_out;
+	/*
+	 * We've already checked virt_addr_valid so we know this address
+	 * is a valid pointer, therefore we can check against it to determine
+	 * if we need to trim
+	 */
+	if (VMALLOC_START > ent->addr) {
 		if (VMALLOC_START - ent->addr < ent->size)
 			ent->size = VMALLOC_START - ent->addr;
 	}


