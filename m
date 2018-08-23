Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7422075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFLDXqvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHWV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:56:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41226 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWV43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:56:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so6588038qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XjIdE1a/8CcwW+OVb+YmWZJQvTVCpWbzLau9N26TmrA=;
        b=mFLDXqvcVaUL5HlBdbKNL+3MXRWEeTJtjWQKhgvsmNqfSUwMmYsPpdIbEql9ZFpOlu
         MgJmDYFhHSxnIe86bO0gyQvBW+4iocX3ZDGV5H2OLXT4WJriZcYnLvZYBnlAiNsGXHBS
         Ofdsd8tbqLpg1K9UrSXMoUOLVTEQrhgmAoeSP0GxzAJF7yOchmzbxW2ng3CC2BsG90B4
         eT33AZwMkRYHMoqoyyQlODc5E7fyPb42oaEB5zHp4qPP7J4ggPgj0N0QHNE+Io2UioqG
         /hGRYu13CAOUI/6l11sbdRW+RzPaHrHqmVw7jE8RTEcTVjzBmSUR8CLJv/turKm7iGPX
         dgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XjIdE1a/8CcwW+OVb+YmWZJQvTVCpWbzLau9N26TmrA=;
        b=hoiNI8ns3MfC6iCWEa0l4xm2ViJt4uezAKEyYrYRxEPqBnwg8pgpjPkpQD10N5AbCO
         HxSlvoSU2sGPVPg4NzM89f5+Tf1wVTbTmp/TpPP8rN/0gdwn0jZAAZRPMeB7rq/0oG+M
         VvxUwyKSJeeFMwndlc4Qqt/HH40nxtkXeK5lQmn5frrAdwPMhsTKPDieE2bHw5YRrEEt
         30UiX2XhM05hO2TNviKYHNfmZsvmx11Oxhuy585zpjWb/R8m499InPdQNrxyeTOrK1Y9
         oj3DZdjJkhDbTn963e2rtJmmdyj9XyL8GaUs+vJYplOEE/lWf6wzzL8jX2CF1069IlAb
         8QtA==
X-Gm-Message-State: APzg51Ddi+TmAb/aE5V6ET0voyf90BO3N2MXMapBl5TocyUsrO9RkyY6
        QS63kyqLLNoWcv3f5jc9aA==
X-Google-Smtp-Source: ANB0VdYU/yxgbxohH3wKRpg/NWHzRtfCkAO/MuwiXp27UTAxQVe83pCgQ1KDHr7x80xQJ1JDuQ5uHw==
X-Received: by 2002:a0c:e083:: with SMTP id l3-v6mr21512515qvk.1.1535048733229;
        Thu, 23 Aug 2018 11:25:33 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o7-v6sm1233582qtp.75.2018.08.23.11.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:25:32 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
Date:   Thu, 23 Aug 2018 14:25:12 -0400
Message-Id: <20180823182513.8801-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved") breaks movable_node kernel option because it
changed the memory gap range to reserved memblock. So, the node
is marked as Normal zone even if the SRAT has Hot plaggable affinity.

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

Naoya's v1 patch [*] fixes the original issue and this movable_node
issue doesn't occur.
Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
regions into memblock.reserved") and apply the v1 patch.

[*] https://lkml.org/lkml/2018/6/13/27

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
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
2.18.0

