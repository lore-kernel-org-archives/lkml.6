Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A400245CA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A400245CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934420AbeFVQ2u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:28:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43167 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934164AbeFVQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:28:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so7248062wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FW1DIyGep9jzNGj98n5+2iAPwhw+YUsx3qRxJWpnxFg=;
        b=kIj+f77J3P29sD9e76LEWSSKYrlq7XDpmziVS1vpgOWJmGH/q7k1SV5a1+PczoDy8B
         aBB7qjE0ZCDuxmgRRfBRQjgPFyXGWTOV6/GVCdBQm0vNh+klgqsO8xUnQO/pnraeVr8E
         OZvr6Wk2O0hVC/I/BNEaJffMH97jfrUaS9UJhqJuMNWJMEZ+vCoXdmvyWbywOu66Tbdl
         z02T4GMHCVAJ0S8bHD2+UszU5cSAta7kUwFmA4rZO9ZFB3ivJ1FV32IszlGydrbfE4O2
         PvOO8K3XPJ2AOxQ8XmVuMnxv0Q3WTya5KFbHFWfDiKuyyrJx7SHEehY48Zd4bi4ovcv7
         Gvwg==
X-Gm-Message-State: APt69E1f6Mt97/ygudfwJ213qD3IZrQEH5uwD5d/TyMYMQ72BS1fUAIc
        ge7285T3YfaE/V9/116YN3I=
X-Google-Smtp-Source: AAOMgpfEQogbLwAcE8rKN7lTg7tcr7+54Cg8dHgH6UqYe/HR4itdkQQ26i83aOw7IIF8MpDspn4QYQ==
X-Received: by 2002:adf:a0c2:: with SMTP id n2-v6mr2055475wrn.23.1529684928402;
        Fri, 22 Jun 2018 09:28:48 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-179-217.eurotel.cz. [37.188.179.217])
        by smtp.gmail.com with ESMTPSA id h77-v6sm3520193wmd.9.2018.06.22.09.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 09:28:47 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Date:   Fri, 22 Jun 2018 18:28:41 +0200
Message-Id: <20180622162841.25114-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

There is no real reason to blow up just because the caller doesn't know
that __get_free_pages cannot return highmem pages. Simply fix that up
silently. Even if we have some confused users such a fixup will not be
harmful.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi Andrew,
previously posted [1] but it fell through cracks. Can we merge it now?

[1] http://lkml.kernel.org/r/20171129160446.jluzpv3n6mjc3fwv@dhcp22.suse.cz

 mm/page_alloc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..5f56f662a52d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4402,18 +4402,14 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 EXPORT_SYMBOL(__alloc_pages_nodemask);
 
 /*
- * Common helper functions.
+ * Common helper functions. Never use with __GFP_HIGHMEM because the returned
+ * address cannot represent highmem pages. Use alloc_pages and then kmap if
+ * you need to access high mem.
  */
 unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *page;
 
-	/*
-	 * __get_free_pages() returns a virtual address, which cannot represent
-	 * a highmem page
-	 */
-	VM_BUG_ON((gfp_mask & __GFP_HIGHMEM) != 0);
-
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
-- 
2.17.1

