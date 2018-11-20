Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8DC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24FB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24FB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeKUAMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:12:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36686 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeKUAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:12:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so1969934edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fk6j1qjZGqSUR1ucZm8jmR3zRWMJFCwmZwWK+RSH3Lk=;
        b=jP2iPKrEdPL60eDrpdLCvpybLHm9QBu7EojbRztljeoHP2jdVjNtZpmQDVG8Mh50Sc
         H1Fx4IKBbTIg+75RM0y1J6s37n8UTeXZwds5Tl/xYEnL9a60iBoOpH4k0DcND9T7rCU8
         HD1DAdrygia1mphpmbyUAlROChfdFNtV/KHy3tREvWUdZrY4MkqKuvZNLjnCn709Xhvk
         wjThvtFAfcNHuwTFf1BxdXslumXqdcYjLajTZt5Ib18b682Rb71kUKUuuLDZr1UnEjDP
         hXfKRgz+yDH1xTVViOUX14E5sD6yAF9oZztbFK48OvhStmUrMlLjqrNEVkKYtPPKl+dk
         1Taw==
X-Gm-Message-State: AA+aEWbQfZJ+OfqUpKIFbl8RqP55HebBAzpFWhsG39m/wTogYKI1XgPd
        5g4Tj4F+YA7CaZ20HCg+N50=
X-Google-Smtp-Source: AFSGD/V88S+hp74RyOZiVbXiGkCC3tC4E36Kd6sMvYipIRhe1zFoyL3SLdmM9ZVuyhkZxyHOOZp7Kw==
X-Received: by 2002:a50:9226:: with SMTP id i35mr2392413eda.8.1542721417077;
        Tue, 20 Nov 2018 05:43:37 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 49sm8428786edz.59.2018.11.20.05.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:43:36 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 2/3] mm, memory_hotplug: deobfuscate migration part of offlining
Date:   Tue, 20 Nov 2018 14:43:22 +0100
Message-Id: <20181120134323.13007-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120134323.13007-1-mhocko@kernel.org>
References: <20181120134323.13007-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Memory migration might fail during offlining and we keep retrying in
that case. This is currently obfuscate by goto retry loop. The code
is hard to follow and as a result it is even suboptimal becase each
retry round scans the full range from start_pfn even though we have
successfully scanned/migrated [start_pfn, pfn] range already. This
is all only because check_pages_isolated failure has to rescan the full
range again.

De-obfuscate the migration retry loop by promoting it to a real for
loop. In fact remove the goto altogether by making it a proper double
loop (yeah, gotos are nasty in this specific case). In the end we
will get a slightly more optimal code which is better readable.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 60 +++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6263c8cd4491..9cd161db3061 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1591,38 +1591,40 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		goto failed_removal_isolated;
 	}
 
-	pfn = start_pfn;
-repeat:
-	/* start memory hot removal */
-	ret = -EINTR;
-	if (signal_pending(current)) {
-		reason = "signal backoff";
-		goto failed_removal_isolated;
-	}
+	do {
+		for (pfn = start_pfn; pfn;)
+		{
+			/* start memory hot removal */
+			ret = -EINTR;
+			if (signal_pending(current)) {
+				reason = "signal backoff";
+				goto failed_removal_isolated;
+			}
 
-	cond_resched();
-	lru_add_drain_all();
-	drain_all_pages(zone);
+			cond_resched();
+			lru_add_drain_all();
+			drain_all_pages(zone);
 
-	pfn = scan_movable_pages(start_pfn, end_pfn);
-	if (pfn) { /* We have movable pages */
-		ret = do_migrate_range(pfn, end_pfn);
-		goto repeat;
-	}
+			pfn = scan_movable_pages(pfn, end_pfn);
+			if (pfn) {
+				/* TODO fatal migration failures should bail out */
+				do_migrate_range(pfn, end_pfn);
+			}
+		}
+
+		/*
+		 * dissolve free hugepages in the memory block before doing offlining
+		 * actually in order to make hugetlbfs's object counting consistent.
+		 */
+		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
+		if (ret) {
+			reason = "failure to dissolve huge pages";
+			goto failed_removal_isolated;
+		}
+		/* check again */
+		offlined_pages = check_pages_isolated(start_pfn, end_pfn);
+	} while (offlined_pages < 0);
 
-	/*
-	 * dissolve free hugepages in the memory block before doing offlining
-	 * actually in order to make hugetlbfs's object counting consistent.
-	 */
-	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
-	if (ret) {
-		reason = "failure to dissolve huge pages";
-		goto failed_removal_isolated;
-	}
-	/* check again */
-	offlined_pages = check_pages_isolated(start_pfn, end_pfn);
-	if (offlined_pages < 0)
-		goto repeat;
 	pr_info("Offlined Pages %ld\n", offlined_pages);
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
-- 
2.19.1

