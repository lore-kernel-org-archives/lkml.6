Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233BCC282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB78721848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="FmvuaGhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfA2TC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:02:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43304 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbfA2TC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:02:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id n21so8615316ywd.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gdtZ03l2f09FV33buLEaZQuZ0ElvMotUvVTz5rqqWI=;
        b=FmvuaGhHYkeGQR7XrL3kOAVN2hLkm1dLgt4yjRcmvNKKaAXNKs/3aZcp9acw6kCdKl
         52thlhVAXh+MXCF5Ppr+lrYsioFZPgPXpgBJhqA6kI1eaWJjuYwqOrLRtovYfyIY9Fza
         3KjpC0gBjSOfGkTUz6eH5W8m49KzxUzh6fj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gdtZ03l2f09FV33buLEaZQuZ0ElvMotUvVTz5rqqWI=;
        b=HcQzGpUsHNNTFlgii9kUX7Qq3rlfvX92VHew3Bgw6Jb3QfvfB4x4yW+lDVuo3G9gX4
         t62Ufbc/eewtnjJFbPxokGh76WPdRFtEBf0Z9VuDxn/MGGTfXTuf9aCJrJeltB3mBZxa
         CrEQ+G5MX4WV8lKTeI5Uh2aNh8zpfFVffRD8u5vKyKhYmHpY4RbQZf/7OkALw08KKVFR
         aPh/m1pmR2Dpbtua1BoqBkSRpSYn+bn0uVnRhcfOKoMnqItqeFmX1EXHDI976E51WDDG
         aGZYIoD53RUxv7ZNCzGHrSRKSRktlZfvsQSLVsGF6cuLUoiy5qxLRCWI01AHWMsxn3At
         6ZgA==
X-Gm-Message-State: AJcUukfn054CvYBLH0X/1GRBCr7tEMYoBrrPTC4340QWDkb6AiRw7qNm
        4/QHaaCL1/BIYs8V/3TMVc8ebA==
X-Google-Smtp-Source: ALg8bN4AYRIpJa263wzK5jgww4Y8DEJmewRQGQ7X/LrIKkYouefQiRMEQd2WIPGVdJWxCuNpWOu3tA==
X-Received: by 2002:a81:5fd5:: with SMTP id t204mr25498495ywb.312.1548788575338;
        Tue, 29 Jan 2019 11:02:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:f1fc])
        by smtp.gmail.com with ESMTPSA id q24sm15181056ywa.95.2019.01.29.11.02.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 29 Jan 2019 11:02:54 -0800 (PST)
Date:   Tue, 29 Jan 2019 14:02:53 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH v2] mm: Make memory.emin the baseline for utilisation
 determination
Message-ID: <20190129190253.GA10430@chrisdown.name>
References: <20190129182516.GA1834@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190129182516.GA1834@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman points out that when when we do the low reclaim pass, we scale the
reclaim pressure relative to position between 0 and the maximum
protection threshold.

However, if the maximum protection is based on memory.elow, and
memory.emin is above zero, this means we still may get binary behaviour
on second-pass low reclaim. This is because we scale starting at 0, not
starting at memory.emin, and since we don't scan at all below emin, we
end up with cliff behaviour.

This should be a fairly uncommon case since usually we don't go into the
second pass, but it makes sense to scale our low reclaim pressure
starting at emin.

You can test this by catting two large sparse files, one in a cgroup
with emin set to some moderate size compared to physical RAM, and
another cgroup without any emin. In both cgroups, set an elow larger
than 50% of physical RAM. The one with emin will have less page
scanning, as reclaim pressure is lower.

Signed-off-by: Chris Down <chris@chrisdown.name>
Suggested-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 include/linux/memcontrol.h | 12 ++++++---
 mm/vmscan.c                | 55 +++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 26 deletions(-)

I'm an idiot and forgot to also update the !CONFIG_MEMCG definition for
mem_cgroup_protection. This is the fixed version.

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 290cfbfd60cd..ba99d25d2a98 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -333,9 +333,11 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg)
+static inline void mem_cgroup_protection(struct mem_cgroup *memcg,
+					 unsigned long *min, unsigned long *low)
 {
-	return max(READ_ONCE(memcg->memory.emin), READ_ONCE(memcg->memory.elow));
+	*min = READ_ONCE(memcg->memory.emin);
+	*low = READ_ONCE(memcg->memory.elow);
 }
 
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
@@ -826,9 +828,11 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 {
 }
 
-static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg)
+static inline void mem_cgroup_protection(struct mem_cgroup *memcg,
+					 unsigned long *min, unsigned long *low)
 {
-	return 0;
+	*min = NULL;
+	*low = NULL;
 }
 
 static inline enum mem_cgroup_protection mem_cgroup_protected(
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 549251818605..f7c4ab39d5d0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2447,12 +2447,12 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 		int file = is_file_lru(lru);
 		unsigned long lruvec_size;
 		unsigned long scan;
-		unsigned long protection;
+		unsigned long min, low;
 
 		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
-		protection = mem_cgroup_protection(memcg);
+		mem_cgroup_protection(memcg, &min, &low);
 
-		if (protection > 0) {
+		if (min || low) {
 			/*
 			 * Scale a cgroup's reclaim pressure by proportioning
 			 * its current usage to its memory.low or memory.min
@@ -2467,28 +2467,38 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			 * set it too low, which is not ideal.
 			 */
 			unsigned long cgroup_size = mem_cgroup_size(memcg);
-			unsigned long baseline = 0;
 
 			/*
-			 * During the reclaim first pass, we only consider
-			 * cgroups in excess of their protection setting, but if
-			 * that doesn't produce free pages, we come back for a
-			 * second pass where we reclaim from all groups.
+			 * If there is any protection in place, we adjust scan
+			 * pressure in proportion to how much a group's current
+			 * usage exceeds that, in percent.
 			 *
-			 * To maintain fairness in both cases, the first pass
-			 * targets groups in proportion to their overage, and
-			 * the second pass targets groups in proportion to their
-			 * protection utilization.
-			 *
-			 * So on the first pass, a group whose size is 130% of
-			 * its protection will be targeted at 30% of its size.
-			 * On the second pass, a group whose size is at 40% of
-			 * its protection will be
-			 * targeted at 40% of its size.
+			 * There is one special case: in the first reclaim pass,
+			 * we skip over all groups that are within their low
+			 * protection. If that fails to reclaim enough pages to
+			 * satisfy the reclaim goal, we come back and override
+			 * the best-effort low protection. However, we still
+			 * ideally want to honor how well-behaved groups are in
+			 * that case instead of simply punishing them all
+			 * equally. As such, we reclaim them based on how much
+			 * of their best-effort protection they are using. Usage
+			 * below memory.min is excluded from consideration when
+			 * calculating utilisation, as it isn't ever
+			 * reclaimable, so it might as well not exist for our
+			 * purposes.
 			 */
-			if (!sc->memcg_low_reclaim)
-				baseline = lruvec_size;
-			scan = lruvec_size * cgroup_size / protection - baseline;
+			if (sc->memcg_low_reclaim && low > min) {
+				/*
+				 * Reclaim according to utilisation between min
+				 * and low
+				 */
+				scan = lruvec_size * (cgroup_size - min) /
+					(low - min);
+			} else {
+				/* Reclaim according to protection overage */
+				scan = lruvec_size * cgroup_size /
+					max(min, low) - lruvec_size;
+			}
 
 			/*
 			 * Don't allow the scan target to exceed the lruvec
@@ -2504,7 +2514,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			 * some cases in the case of large overages.
 			 *
 			 * Also, minimally target SWAP_CLUSTER_MAX pages to keep
-			 * reclaim moving forwards.
+			 * reclaim moving forwards, avoiding decremeting
+			 * sc->priority further than desirable.
 			 */
 			scan = clamp(scan, SWAP_CLUSTER_MAX, lruvec_size);
 		} else {
-- 
2.20.1

