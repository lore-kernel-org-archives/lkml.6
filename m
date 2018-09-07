Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D45CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="sYHtGdSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3A92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeIHC0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:00 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59227 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeIHCZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356584; x=1567892584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvfRtEHrlTY3jRS58bKRgRg7UL19ocEBacWtm8wP9JU=;
  b=sYHtGdSWSQ/pCDZ+8Y3b4MLxAtWx4309RwkU7RWg2dTJoayoUAfPoP9A
   2Wo8rDI9TMkbpisVPDWgCj5X3TYSu6g/Z9A6Xm6MAT5B1vMtCPjbxcUdV
   yojAMGhmMf0pDC8xNPAYoAoaLV/kTqS4vfzp81Mz4uSj9st3M2xxoDW2W
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243269"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:03 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgvhc021528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:59 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgt66027812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:55 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lgsxo027808;
        Fri, 7 Sep 2018 23:42:54 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 53/60] cosched: Prevent balancing related functions from crossing hierarchy levels
Date:   Fri,  7 Sep 2018 23:40:40 +0200
Message-Id: <20180907214047.26914-54-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify update_blocked_averages() and update_cfs_rq_h_load() so that they
won't access the next higher hierarchy level, for which they don't hold a
lock.

This will have to be touched again, when load balancing is made
functional.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc219c9c3097..210fcd534917 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7686,7 +7686,7 @@ static void update_blocked_averages(int cpu)
 
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->my_se;
-		if (se && !skip_blocked_update(se))
+		if (se && !is_sd_se(se) && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
 		/*
@@ -7731,6 +7731,8 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	cfs_rq->h_load_next = NULL;
 	for_each_sched_entity(se) {
+		if (is_sd_se(se))
+			break;
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_load_next = se;
 		if (cfs_rq->last_h_load_update == now)
-- 
2.9.3.1.gcba166c.dirty

