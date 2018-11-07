Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C48C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5EA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5EA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeKGTsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39842 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKGTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so15253998wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sv3VICkYWNHJQH5t9PKiqFFrwl24VUUEG3pNBfSVfqc=;
        b=uMBNXOZnq5Q886X8Kh3y2Rbi3QZ2Xw1zuhyWIRtOpJx0CYWM8McbsEOHaSI1XFB3qx
         bVnVTAOYzgdyQ3LoBa+QbTduPd4pGxG3bxqwklujajywr8b7zeHwQArEocHO2c1u9qPi
         QJNm4JXCa31pa4O8eMHVriUFI5xJqRGYl/C3kbEN7s3WdGix0m7HBWm16wHoKxsLWA+3
         Cp0TpW+u/FYJcbV9FXe4GFFVJAz81PaUODpuh05uuKeS3aASnUgFpup/08CepnClNnTy
         Y9XGrgebtNP4MUdvzix18bAMjzR2pMAcoRT2ejwhwBDVoMwr+6yst5w2pxy5VD1YIIaW
         Aisw==
X-Gm-Message-State: AGRZ1gI6juYtIaz5H92Uolk4aSde9VP3vZprgGBvrn2C9C/8BjTBkK5M
        6t0K1YYVyUwhoRtemmHEF0M=
X-Google-Smtp-Source: AJdET5dKm4DMMZdgXpmyKhgPMwFbI3RIdspl0FyX88e49xONBxbKQ/WPj6h9FTwNXMVUFskcPEVvNA==
X-Received: by 2002:a1c:8dcd:: with SMTP id p196-v6mr1465756wmd.49.1541585927961;
        Wed, 07 Nov 2018 02:18:47 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-140-85.eurotel.cz. [37.188.140.85])
        by smtp.gmail.com with ESMTPSA id w18-v6sm217527wrn.66.2018.11.07.02.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:18:47 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 4/5] mm, memory_hotplug: print reason for the offlining failure
Date:   Wed,  7 Nov 2018 11:18:29 +0100
Message-Id: <20181107101830.17405-5-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101830.17405-1-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
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

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a92b1b8f6218..1badac89c58e 100644
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
+		reason = "failed to isolate range";
+		goto failed_removal
 	}
 
 	arg.start_pfn = start_pfn;
@@ -1582,15 +1586,19 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
 	ret = notifier_to_errno(ret);
-	if (ret)
-		goto failed_removal;
+	if (ret) {
+		reason = "notifiers failure";
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
+		reason = "fails to disolve hugetlb pages";
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

