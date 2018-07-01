Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6690BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1B724C4D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1B724C4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030520AbeGAR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:58:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965028AbeGAQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8847392B;
        Sun,  1 Jul 2018 16:30:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.14 008/157] m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()
Date:   Sun,  1 Jul 2018 18:21:20 +0200
Message-Id: <20180701160852.702996994@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/m68k/mm/kmap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -89,7 +89,8 @@ static inline void free_io_area(void *ad
 	for (p = &iolist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-			__iounmap(tmp->addr, tmp->size);
+			/* remove gap added in get_io_area() */
+			__iounmap(tmp->addr, tmp->size - IO_SIZE);
 			kfree(tmp);
 			return;
 		}


