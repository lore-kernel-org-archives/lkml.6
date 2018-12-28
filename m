Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5702CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E61218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999326;
	bh=vPBPvjgH1t7ww02oDRj2K7FOl6nIFeFORM3N0IZ3BQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kc4Oo+IaXn3+KYXPNnOJu6zIQzpcuAUaUJXg/fcT553/qERbogPOqcUA+IP2ET/Q7
	 rvFxh8eVQKbrYnygUPGOGigyLAKrWhepVzShRsEcwcGjjROIDCq1Y8LuujngIQYnee
	 UOgVGBSlnBSvfJjxORUX8QMznvwD8FTv3GmB2mio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeL1MPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbeL1MPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915EA2184B;
        Fri, 28 Dec 2018 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999321;
        bh=vPBPvjgH1t7ww02oDRj2K7FOl6nIFeFORM3N0IZ3BQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtN+PaXEpryp8fZnCeHvhpy4MzTQIaPxoG5NvuLSlYAWfUYefO1vadMObJfrN/rSh
         ujomqfcmx5oO+GMMQH6Oo5xwWIRzQGfcqzWNypNECjCxoJbKC6xfv/n5G2JHLWSiB9
         hJONuBrE2A6gp5afayyL8oIvaEtHZk4CIzBlqMio=
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
Subject: [PATCH 4.19 43/46] mm: dont miss the last page because of round-off error
Date:   Fri, 28 Dec 2018 12:52:37 +0100
Message-Id: <20181228113127.485380863@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -281,4 +281,7 @@ static inline u64 mul_u64_u32_div(u64 a,
 }
 #endif /* mul_u64_u32_div */
 
+#define DIV64_U64_ROUND_UP(ll, d)	\
+	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
+
 #endif /* _LINUX_MATH64_H */
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2456,9 +2456,11 @@ out:
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


