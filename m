Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE40C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C6523FC4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C6523FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeGBPnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:43:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54824 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:43:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so9504741wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJ1//1YIlVLol+rxEaAWUwq+hFnvLuTp/reMU/xt8M0=;
        b=Fpr9qJtWnzPiLBH5dq4mxQNNehG1lgnXhafBvINf7y5Rb4E5jw7fuBmEFWQTa5uI9j
         PrFjSzChiz7Mi/cIOEjufqjhkhQGRo2bKMM9Yf4NPfAy3FZM4d1f59NV2WwIivjDFNJ5
         cneA2dBEPuqfEFgH1L02OxyYqch+mA4Dg5bht/F9hERrrwJMf1K58tY5gXxr6KqzH4sg
         WIgmecImilwE2cQ+gV03YFuU+Ch/fH3D7vcRgha4Wn+6ib+kHUMBSLN5jRexuuSXPpLq
         CVnGA3JQ5jZZ7zMqOUi4j9pp2JAoG36xHAOEvRmDvC66AlVuyXg6s5YswcCjXpDiL/cn
         sEBQ==
X-Gm-Message-State: APt69E0bajULLyTHha9A8aRmIFDYj2Qc1atD0n2h2uTJiQ4aGgvs4NRe
        KjRWLhJozSRV1rGJmnSEtWE=
X-Google-Smtp-Source: AAOMgpcQjfcHtgQvHpd8nuZop+akOsMu0dllxoOj8zU3dl+0mlXXqhUDk3eLcyvOTn4JV0n8xcxw1g==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184-v6mr8206803wmr.13.1530546219058;
        Mon, 02 Jul 2018 08:43:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v15-v6sm15437851wrq.37.2018.07.02.08.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 08:43:38 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 76C3F123A5E;
        Mon,  2 Jul 2018 17:43:37 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        bhe@redhat.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/sparse: Make sparse_init_one_section void and remove check
Date:   Mon,  2 Jul 2018 17:43:25 +0200
Message-Id: <20180702154325.12196-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

sparse_init_one_section() is being called from two sites:
sparse_init() and sparse_add_one_section().
The former calls it from a for_each_present_section_nr() loop,
and the latter marks the section as present before calling it.
This means that when sparse_init_one_section() gets called, we already know
that the section is present.
So there is no point to double check that in the function.

This removes the check and makes the function void.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b2848cc6e32a..f55e79fda03e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -264,19 +264,14 @@ struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pn
 	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
 }
 
-static int __meminit sparse_init_one_section(struct mem_section *ms,
+static void __meminit sparse_init_one_section(struct mem_section *ms,
 		unsigned long pnum, struct page *mem_map,
 		unsigned long *pageblock_bitmap)
 {
-	if (!present_section(ms))
-		return -EINVAL;
-
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
 	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
 							SECTION_HAS_MEM_MAP;
  	ms->pageblock_flags = pageblock_bitmap;
-
-	return 1;
 }
 
 unsigned long usemap_size(void)
@@ -801,12 +796,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 #endif
 
 	section_mark_present(ms);
-
-	ret = sparse_init_one_section(ms, section_nr, memmap, usemap);
+	sparse_init_one_section(ms, section_nr, memmap, usemap);
 
 out:
 	pgdat_resize_unlock(pgdat, &flags);
-	if (ret <= 0) {
+	if (ret < 0) {
 		kfree(usemap);
 		__kfree_section_memmap(memmap, altmap);
 	}
-- 
2.13.6

