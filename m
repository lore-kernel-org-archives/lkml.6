Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C84F22511
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynvul6Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84F22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbeKMPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbeKMPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:50 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192D622507;
        Tue, 13 Nov 2018 05:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088342;
        bh=9dH0lsyD10h8yVXMzJ7Xjtl0we3Me20hRIgdPeiXvpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ynvul6QgrEZCrINCz9RtbJqrtbf4rBEz0X/1qkxmW6l8IOXBjEacvF81AanMN9TK+
         HrS0OzjE+VkYmg/b8ZVPFgq6FFoZ3zVOr2NWzEpbTPWlZ3sej0MwMWGpZu+3ja2/l8
         UAmBcK7C0nNLz7VTVj8KyPnZKg+yW72IGiupEMRY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 25/26] mm: don't miss the last page because of round-off error
Date:   Tue, 13 Nov 2018 00:51:49 -0500
Message-Id: <20181113055150.78773-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 68600f623d69da428c6163275f97ca126e1a8ec5 ]

I've noticed, that dying memory cgroups are often pinned in memory by a
single pagecache page.  Even under moderate memory pressure they sometimes
stayed in such state for a long time.  That looked strange.

My investigation showed that the problem is caused by applying the LRU
pressure balancing math:

  scan = div64_u64(scan * fraction[lru], denominator),

where

  denominator = fraction[anon] + fraction[file] + 1.

Because fraction[lru] is always less than denominator, if the initial scan
size is 1, the result is always 0.

This means the last page is not scanned and has
no chances to be reclaimed.

Fix this by rounding up the result of the division.

In practice this change significantly improves the speed of dying cgroups
reclaim.

[guro@fb.com: prevent double calculation of DIV64_U64_ROUND_UP() arguments]
  Link: http://lkml.kernel.org/r/20180829213311.GA13501@castle
Link: http://lkml.kernel.org/r/20180827162621.30187-3-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/math64.h | 3 +++
 mm/vmscan.c            | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 082de345b73c..3a7a14062668 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -254,4 +254,7 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+#define DIV64_U64_ROUND_UP(ll, d)	\
+	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
+
 #endif /* _LINUX_MATH64_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index be56e2e1931e..9734e62654fa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2367,9 +2367,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			/*
 			 * Scan types proportional to swappiness and
 			 * their relative recent reclaim efficiency.
+			 * Make sure we don't miss the last page
+			 * because of a round-off error.
 			 */
-			scan = div64_u64(scan * fraction[file],
-					 denominator);
+			scan = DIV64_U64_ROUND_UP(scan * fraction[file],
+						  denominator);
 			break;
 		case SCAN_FILE:
 		case SCAN_ANON:
-- 
2.17.1

