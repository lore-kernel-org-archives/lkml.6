Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE3CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63B621104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543864;
	bh=4iJcN/uCsHknOh9eN4aCEkFKWFNeq46a5OvHuz+s07I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rOaISUUkAYQ0ZXHOEyu5gNwWLXcVhE4XgI8ZsvPvR+BQq2W+xJO7Fh34eCyB02s6
	 ixRU+OTC3etmoFc1N6GxWx6OENhcYHBP3ObfPJA5lIV8HorC6ZXGNZBi/EQ+pUCwz0
	 OmIKdCaQr4oONuKJQ5xzjy8Zi3PbmJMr7FFDGYaA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63B621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeLKP5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbeLKP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C80205C9;
        Tue, 11 Dec 2018 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543858;
        bh=4iJcN/uCsHknOh9eN4aCEkFKWFNeq46a5OvHuz+s07I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xB/KiVDrwqK4lT+Q8xgWssGhlrABwE3MFTZHJN5J8nDmvxBGpgHka9hRoFzW+VvPj
         RlS/cpOlS3y0GlEYt0hWirhMO0/ePKlMik7nfhuVsL2hxYz9NNIQmJ46YWzgnDbPlo
         hYlbxZ8Vw6ZGqRiGPvsO9D/3us9EwpwObZJTs/W0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/118] Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
Date:   Tue, 11 Dec 2018 16:41:51 +0100
Message-Id: <20181211151647.981267206@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9fd61bc95130d4971568b89c9548b5e0a4e18e0e ]

commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved") breaks movable_node kernel option because it changed
the memory gap range to reserved memblock.  So, the node is marked as
Normal zone even if the SRAT has Hot pluggable affinity.

    =====================================================================
    kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
    kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
    ...
    kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
    ...
    kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
    kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
    ...
    kernel: Movable zone start for each node
    kernel:  Node 3: 0x00001c0000000000
    kernel: Early memory node ranges
    ...
    =====================================================================

The original issue is fixed by the former patches, so let's revert commit
124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved").

Link: http://lkml.kernel.org/r/20181002143821.5112-4-msys.mizuma@gmail.com
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/e820.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c88c23c658c1..d1f25c831447 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1248,7 +1248,6 @@ void __init e820__memblock_setup(void)
 {
 	int i;
 	u64 end;
-	u64 addr = 0;
 
 	/*
 	 * The bootstrap memblock region count maximum is 128 entries
@@ -1265,21 +1264,13 @@ void __init e820__memblock_setup(void)
 		struct e820_entry *entry = &e820_table->entries[i];
 
 		end = entry->addr + entry->size;
-		if (addr < entry->addr)
-			memblock_reserve(addr, entry->addr - addr);
-		addr = end;
 		if (end != (resource_size_t)end)
 			continue;
 
-		/*
-		 * all !E820_TYPE_RAM ranges (including gap ranges) are put
-		 * into memblock.reserved to make sure that struct pages in
-		 * such regions are not left uninitialized after bootup.
-		 */
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
-			memblock_reserve(entry->addr, entry->size);
-		else
-			memblock_add(entry->addr, entry->size);
+			continue;
+
+		memblock_add(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.19.1



