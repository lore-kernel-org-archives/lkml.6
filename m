Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC6C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6870D2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6870D2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbeKLGCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:02:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52696 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbeKLGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:02:40 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000oJ-Pe; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Sq-6V; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.448382861@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 082/366] m68k/mm: Adjust VM area to be unmapped by
 gap size for __iounmap()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>

commit 3f90f9ef2dda316d64e420d5d51ba369587ccc55 upstream.

If 020/030 support is enabled, get_io_area() leaves an IO_SIZE gap
between mappings which is added to the vm_struct representing the
mapping.  __ioremap() uses the actual requested size (after alignment),
while __iounmap() is passed the size from the vm_struct.

On 020/030, early termination descriptors are used to set up mappings of
extent 'size', which are validated on unmapping. The unmapped gap of
size IO_SIZE defeats the sanity check of the pmd tables, causing
__iounmap() to loop forever on 030.

On 040/060, unmapping of page table entries does not check for a valid
mapping, so the umapping loop always completes there.

Adjust size to be unmapped by the gap that had been added in the
vm_struct prior.

This fixes the hang in atari_platform_init() reported a long time ago,
and a similar one reported by Finn recently (addressed by removing
ioremap() use from the SWIM driver.

Tested on my Falcon in 030 mode - untested but should work the same on
040/060 (the extra page tables cleared there would never have been set
up anyway).

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
[geert: Minor commit description improvements]
[geert: This was fixed in 2.4.23, but not in 2.5.x]
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m68k/mm/kmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -88,7 +88,8 @@ static inline void free_io_area(void *ad
 	for (p = &iolist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-			__iounmap(tmp->addr, tmp->size);
+			/* remove gap added in get_io_area() */
+			__iounmap(tmp->addr, tmp->size - IO_SIZE);
 			kfree(tmp);
 			return;
 		}

