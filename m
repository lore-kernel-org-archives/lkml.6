Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096192088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096192088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbeIREWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:22:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIREWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:22:34 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 512BDCAF;
        Mon, 17 Sep 2018 22:53:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 16/70] mm, vmscan: clear PGDAT_WRITEBACK when zone is balanced
Date:   Tue, 18 Sep 2018 00:41:49 +0200
Message-Id: <20180917211650.531450671@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@suse.de>

commit c2f83143f1c67d186520b72b6cefbf0aa07a34ee upstream.

Hillf Danton pointed out that since commit 1d82de618dd ("mm, vmscan:
make kswapd reclaim in terms of nodes") that PGDAT_WRITEBACK is no
longer cleared.

It was not noticed as triggering it requires pages under writeback to
cycle twice through the LRU and before kswapd gets stalled.
Historically, such issues tended to occur on small machines writing
heavily to slow storage such as a USB stick.

Once kswapd stalls, direct reclaim stalls may be higher but due to the
fact that memory pressure is required, it would not be very noticable.

Michal Hocko suggested removing the flag entirely but the conservative
fix is to restore the intended PGDAT_WRITEBACK behaviour and clear the
flag when a suitable zone is balanced.

Fixes: 1d82de618ddd ("mm, vmscan: make kswapd reclaim in terms of nodes")
Link: http://lkml.kernel.org/r/20170203203222.gq7hk66yc36lpgtb@suse.de
Signed-off-by: Mel Gorman <mgorman@suse.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
Cc: Rik van Riel <riel@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3123,6 +3123,7 @@ static bool zone_balanced(struct zone *z
 	 */
 	clear_bit(PGDAT_CONGESTED, &zone->zone_pgdat->flags);
 	clear_bit(PGDAT_DIRTY, &zone->zone_pgdat->flags);
+	clear_bit(PGDAT_WRITEBACK, &zone->zone_pgdat->flags);
 
 	return true;
 }


