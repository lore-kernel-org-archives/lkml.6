Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C778C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37DE208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37DE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbeKPSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:41:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32927 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389345AbeKPSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id r27so15979648eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSKUKWTu/JnWNKe9NUPf6eNFtrvxLeBHWSYH+NlRpmU=;
        b=gqJuVV0e2UNLs5mGY4qx2Z7dmi4vOLTUA1HTiNUsMl60w5NFqxC32zY0f4NKZ+aMth
         asUJ/dldlUm2iCa+Ij7gDRZuSHHzMdIYalaX9S2gLF7d9PquVDY+rPcqJvAtT6uNuGL9
         OqUkbedthBH7UbJnue01b6PV/XBPDu6l52l+lbGnlvvCIVtUzKPgLSdy3jMzeW4+y//I
         wlG4ZM4hWxigg74eezZwLtfEbndRWwdEc5R3G6h3Q6edfNTeEUvwwnSjW0+EpU94E3dJ
         yazTVRKmwJH+ZQRx2u+iaNmcci4o6LEXZfYptGK7EzEGFnWryTszrEosbbFg2cbekT3O
         EAPQ==
X-Gm-Message-State: AGRZ1gKDysFsoLS0XNOQnEv3DEWTPnauStGPTL4dsdfLqDCznYCI/GiD
        q9J5xCfUUiHAU0MXZJSR2OM=
X-Google-Smtp-Source: AJdET5c3+G/+V7gFn4TE0EzjkRjzL9V/6jTihahs2hAbkoHDen2rn55TLhiQuPA/cvNpYSXM2K25pg==
X-Received: by 2002:a50:8d46:: with SMTP id t6mr8854960edt.269.1542357037478;
        Fri, 16 Nov 2018 00:30:37 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:36 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 4/5] mm, memory_hotplug: print reason for the offlining failure
Date:   Fri, 16 Nov 2018 09:30:19 +0100
Message-Id: <20181116083020.20260-5-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116083020.20260-1-mhocko@kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

The memory offlining failure reporting is inconsistent and insufficient.
Some error paths simply do not report the failure to the log at all.
When we do report there are no details about the reason of the failure
and there are several of them which makes memory offlining failures
hard to debug.

Make sure that the
	memory offlining [mem %#010llx-%#010llx] failed
message is printed for all failures and also provide a short textual
reason for the failure e.g.

[ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff

this tells us that the offlining has failed because of a signal pending
aka user intervention.

[akpm: tweak messages a bit]
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a92b1b8f6218..88d50e74e3fe 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1553,6 +1553,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	unsigned long valid_start, valid_end;
 	struct zone *zone;
 	struct memory_notify arg;
+	char *reason;
 
 	mem_hotplug_begin();
 
@@ -1561,7 +1562,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
 				  &valid_end)) {
 		mem_hotplug_done();
-		return -EINVAL;
+		ret = -EINVAL;
+		reason = "multizone range";
+		goto failed_removal;
 	}
 
 	zone = page_zone(pfn_to_page(valid_start));
@@ -1573,7 +1576,8 @@ static int __ref __offline_pages(unsigned long start_pfn,
 				       MIGRATE_MOVABLE, true);
 	if (ret) {
 		mem_hotplug_done();
-		return ret;
+		reason = "failure to isolate range";
+		goto failed_removal;
 	}
 
 	arg.start_pfn = start_pfn;
@@ -1582,15 +1586,19 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
 	ret = notifier_to_errno(ret);
-	if (ret)
-		goto failed_removal;
+	if (ret) {
+		reason = "notifier failure";
+		goto failed_removal_isolated;
+	}
 
 	pfn = start_pfn;
 repeat:
 	/* start memory hot removal */
 	ret = -EINTR;
-	if (signal_pending(current))
-		goto failed_removal;
+	if (signal_pending(current)) {
+		reason = "signal backoff";
+		goto failed_removal_isolated;
+	}
 
 	cond_resched();
 	lru_add_drain_all();
@@ -1607,8 +1615,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	 * actually in order to make hugetlbfs's object counting consistent.
 	 */
 	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
-	if (ret)
-		goto failed_removal;
+	if (ret) {
+		reason = "failure to dissolve huge pages";
+		goto failed_removal_isolated;
+	}
 	/* check again */
 	offlined_pages = check_pages_isolated(start_pfn, end_pfn);
 	if (offlined_pages < 0)
@@ -1648,13 +1658,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	mem_hotplug_done();
 	return 0;
 
+failed_removal_isolated:
+	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 failed_removal:
-	pr_debug("memory offlining [mem %#010llx-%#010llx] failed\n",
+	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
-		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
+		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
+		 reason);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 	/* pushback to free area */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	mem_hotplug_done();
 	return ret;
 }
-- 
2.19.1

