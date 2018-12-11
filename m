Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FFFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538486;
	bh=B7R6Eim+WLAdgbvZoBLTgG3jKGZAMGXO06qll/hqrBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q1NmHa7zGkDLSv4xVmp2WL5xDuO54qBrEd1NvQbOyzgJSkzGPxkFXfiKKX7Td0ZCw
	 YMaM/8vKB8kbYbNmm1617bCzNYhT4gQwF3Dkbb1834ryP/TWXIuzwKrHF7PJzpDb5v
	 rLrSpw6WRU3ZQFKj6W+YG16A8b/jleQ4fwEcyOSk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA8F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeLKO2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:28:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43197 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLKO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:27:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so12665477eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8sh+9FkpWv6DFNlPPgKqUlqTEtJzBvplK2abR1KP7U=;
        b=PEemiriaLXX14G7zJ9RnZ9qBCWgmJ6S0YxOgT3p4YpK0hgtOHT2mZCbuQgz1c54WpB
         ztGcZUd4nBp6mcYG2RS0oNaiubowu5oRtO/112iZGb1HamEBuGH9E//ZAOdb70bUHEL1
         SabqWaV7XuVTJpWyyntPoJly7HCisPKg6glQmlvlO2Fqo8cT33VF6E7H61IbjOZVyvQf
         X9+Lrz71+DZ3cY40409iGZJ0xrTAezI1NkgWizHazObWneuYfVaemFW9bcykXTH4QWeT
         Rndf/3289jogQHaWqTaWV0BbrapDKcJci9v+WWaMIQu8TbHYH4LJIBbPd/PfnrhFKn3p
         gmww==
X-Gm-Message-State: AA+aEWadKu5sFdeqykVoPeyKmB/usJhnPtADFnz93SyUjzszikzKYraR
        wkVB82TfJStOsg6W+FmIZ3U=
X-Google-Smtp-Source: AFSGD/Xb/9v/+9EOR4DQqoxgTxgYu4+WFUeAMf/WERoa5tPJYu2EQVJWRavObQF6AqoNGie3Iwhl5g==
X-Received: by 2002:a17:906:590a:: with SMTP id h10-v6mr13068100ejq.102.1544538471623;
        Tue, 11 Dec 2018 06:27:51 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g31sm4073975eda.96.2018.12.11.06.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:27:51 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/3] mm, memory_hotplug: deobfuscate migration part of offlining
Date:   Tue, 11 Dec 2018 15:27:40 +0100
Message-Id: <20181211142741.2607-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211142741.2607-1-mhocko@kernel.org>
References: <20181211142741.2607-1-mhocko@kernel.org>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6263c8cd4491..c6c42a7425e5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1591,38 +1591,38 @@ static int __ref __offline_pages(unsigned long start_pfn,
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
+		for (pfn = start_pfn; pfn;) {
+			if (signal_pending(current)) {
+				ret = -EINTR;
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
2.19.2

