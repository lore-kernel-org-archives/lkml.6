Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918202148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999405;
	bh=NtxTcTJ0l9oKO0yIweq9s23+d2vDv9F+ZEO1nGdLEVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H4VXPqauxuxULvHF7uhDBg6Z3xA2FfO0G8rSZcDUx2abdukFWtRLLnZi5VaQctxxs
	 r4OSeaf2mEgU79hM7E1RrfyRvoKX6uX1YeBgY/F0fTG7HlYmnAMsFMz8VhN6vfQtng
	 Y2RD9zkAlSMEqPkjlkX2dKhfW4SxA5tKQ/pygXz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbeL1MQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732734AbeL1MQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2C12087F;
        Fri, 28 Dec 2018 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999401;
        bh=NtxTcTJ0l9oKO0yIweq9s23+d2vDv9F+ZEO1nGdLEVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKRFMcXLkffpn3nLZJ4qQx93Vu+d5wDUDLGNITyOknTu9ATNTWajjsDmVQzaqGbxI
         gXiLU6NVJtEv1uPLvcfMlY5SD2/M6ufNCNDdNF5/0cga4VVkFPOJjrVS4R3NYnNJ82
         rWhxHcRf34h3SxyiXqnbcjSSfo8t5ecBADZLoQZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 34/36] mm: dont miss the last page because of round-off error
Date:   Fri, 28 Dec 2018 12:52:50 +0100
Message-Id: <20181228113128.655959064@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

commit 68600f623d69da428c6163275f97ca126e1a8ec5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/math64.h |    3 +++
 mm/vmscan.c            |    6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -254,4 +254,7 @@ static inline u64 mul_u64_u32_div(u64 a,
 }
 #endif /* mul_u64_u32_div */
 
+#define DIV64_U64_ROUND_UP(ll, d)	\
+	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
+
 #endif /* _LINUX_MATH64_H */
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2367,9 +2367,11 @@ out:
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


