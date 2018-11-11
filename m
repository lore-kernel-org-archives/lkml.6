Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A1F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50036 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729507AbeKLFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:14 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000lJ-7q; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001iP-4c; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Vineet Gupta" <vgupta@synopsys.com>,
        "Alexey Brodkin" <abrodkin@synopsys.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.885427863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 243/366] ARC: Fix CONFIG_SWAP
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

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 6e3761145a9ba3ce267c330b6bff51cf6a057b06 upstream.

swap was broken on ARC due to silly copy-paste issue.

We encode offset from swapcache page in __swp_entry() as (off << 13) but
were not decoding back in __swp_offset() as (off >> 13) - it was still
(off << 13).

This finally fixes swap usage on ARC.

| # mkswap /dev/sda2
|
| # swapon -a -e /dev/sda2
| Adding 500728k swap on /dev/sda2.  Priority:-2 extents:1 across:500728k
|
| # free
|              total       used       free     shared    buffers     cached
| Mem:        765104      13456     751648       4736          8       4736
| -/+ buffers/cache:       8712     756392
| Swap:       500728          0     500728

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -361,7 +361,7 @@ void update_mmu_cache(struct vm_area_str
 
 /* Decode a PTE containing swap "identifier "into constituents */
 #define __swp_type(pte_lookalike)	(((pte_lookalike).val) & 0x1f)
-#define __swp_offset(pte_lookalike)	((pte_lookalike).val << 13)
+#define __swp_offset(pte_lookalike)	((pte_lookalike).val >> 13)
 
 /* NOPs, to keep generic kernel happy */
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })

