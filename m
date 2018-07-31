Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959ECC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F32083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeGaOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:25:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44218 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbeGaOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:25:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so16495084wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r1CBh5En4n4Wn7J9Am2n5DoLoLM4u1BZ9VrK61wlxgE=;
        b=qi1f7Tcm7+MuSoJM7FDrpNUCOZyfGHWPAyrgG0a5jca80K2OaoLj8y3Ha3Hzoi7x3k
         d5+CFqKjJvTuLnQs9EyFDh6J12AosmFmp6DJgREI0O7bqqMnym4M9n9DW2mBPfmkIGHK
         23UG9oAamWVUc8xolQz0gAmZCKgtSeJfmf+mic9uRv2mefpBRweuzYvHBmCoC+pwbamg
         VYbPAFC7O0ACc9NEBzxSjmdPJwxLxBwqDJMDrssoebghktsAINnLSiI3hW08Y9hrieBG
         UtX3ixrXEM1/t/oouBrN5xf25z1eoErRUAD+xqOAu/qDk/hV7o2A+Zq9whZemWX7jpNa
         RIdA==
X-Gm-Message-State: AOUpUlH6squzetJ/wxwIhorj5IMwNUeApHBNWI2LyRC3uulOwywDkRiu
        dEX5RV88i2Evfoyg+CcT4Ys=
X-Google-Smtp-Source: AAOMgpcW1KXz68RKY5jX8yJSJULd+rFg25AeMBH/XsUlVSl/lA3W7jZRQS+2Gq1ZlWvEHHkAkgy4sA==
X-Received: by 2002:adf:cc0a:: with SMTP id x10-v6mr19939564wrh.242.1533041114347;
        Tue, 31 Jul 2018 05:45:14 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h5-v6sm17333140wrr.19.2018.07.31.05.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 05:45:13 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id EBE2F1244CC;
        Tue, 31 Jul 2018 14:45:12 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com, mgorman@suse.de,
        jrdr.linux@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Date:   Tue, 31 Jul 2018 14:45:04 +0200
Message-Id: <20180731124504.27582-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

__pagininit macro is being used to mark functions for:

a) Functions that we do not need to keep once the system is fully
   initialized with regard to memory.
b) Functions that will be needed for the memory-hotplug code,
   and because of that we need to keep them after initialization.

Right now, the condition to choose between one or the other is based on
CONFIG_SPARSEMEM, but I think that this should be changed to be based
on CONFIG_MEMORY_HOTPLUG.

The reason behind this is that it can very well be that we have CONFIG_SPARSEMEM
enabled, but not CONFIG_MEMORY_HOTPLUG, and thus, we will not need the
functions marked as __paginginit to stay around, since no
memory-hotplug code will call them.

Although the amount of freed bytes is not that big, I think it will
become more clear what __paginginit is used for.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/internal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 33c22754d282..c9170b4f7699 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -392,10 +392,11 @@ static inline struct page *mem_map_next(struct page *iter,
 /*
  * FLATMEM and DISCONTIGMEM configurations use alloc_bootmem_node,
  * so all functions starting at paging_init should be marked __init
- * in those cases. SPARSEMEM, however, allows for memory hotplug,
- * and alloc_bootmem_node is not used.
+ * in those cases.
+ * In case that MEMORY_HOTPLUG is enabled, we need to keep those
+ * functions around since they can be called when hot-adding memory.
  */
-#ifdef CONFIG_SPARSEMEM
+#ifdef CONFIG_MEMORY_HOTPLUG
 #define __paginginit __meminit
 #else
 #define __paginginit __init
-- 
2.13.6

