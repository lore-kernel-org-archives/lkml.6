Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625A9206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jbWGGnWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625A9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeIHCal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:41 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11682 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeIHCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356864; x=1567892864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTgWdw7ZBKVWP+6m7LPtFL+DbBprL8TsSJO+8jgZ8bE=;
  b=jbWGGnWrZyLoLyD+LDR6c8/BqcGmmKxQXxbwyoxC6cPK0oNq/VtVUD13
   SReijzBJVzPJwzRPFUb2m8pDk7DJ9EF0Q/Hv0nBd9iueGEy2+w8i46jt7
   uD4vHcHnynntD4uKUp75u7jT0nXrzHqlVRLT5yTnXnsvOGXawovwIEUEP
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370826"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:45:08 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh96O010314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:12 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lh8W3027903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:43:08 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lh7jC027890;
        Fri, 7 Sep 2018 23:43:07 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 60/60] cosched: Add command line argument to enable coscheduling
Date:   Fri,  7 Sep 2018 23:40:47 +0200
Message-Id: <20180907214047.26914-61-jschoenh@amazon.de>
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

Add a new command line argument cosched_max_level=<n>, which allows
enabling coscheduling at boot. The number corresponds to the scheduling
domain up to which coscheduling can later be enabled for cgroups.

For example, to enable coscheduling of cgroups at SMT level, one would
specify cosched_max_level=1.

The use of symbolic names (like off, core, socket, system) is currently
not possible, but could be added. However, to force coscheduling at up
to system level not knowing the scheduling domain topology in advance,
it is possible to just specify a too large number. It will be clamped
transparently to system level.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index eb6a6a61521e..a1f0d3a7b02a 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -162,6 +162,29 @@ static int __init cosched_split_domains_setup(char *str)
 
 early_param("cosched_split_domains", cosched_split_domains_setup);
 
+static int __read_mostly cosched_max_level;
+
+static __init int cosched_max_level_setup(char *str)
+{
+	int val, ret;
+
+	ret = kstrtoint(str, 10, &val);
+	if (ret)
+		return ret;
+	if (val < 0)
+		val = 0;
+
+	/*
+	 * Note, that we cannot validate the upper bound here as we do not
+	 * know it yet. It will happen in cosched_init_topology().
+	 */
+
+	cosched_max_level = val;
+	return 0;
+}
+
+early_param("cosched_max_level", cosched_max_level_setup);
+
 struct sd_sdrqmask_level {
 	int groups;
 	struct cpumask **masks;
@@ -407,6 +430,10 @@ void cosched_init_topology(void)
 
 	/* Make permanent */
 	set_sched_topology(tl);
+
+	/* Adjust user preference */
+	if (cosched_max_level >= levels)
+		cosched_max_level = levels - 1;
 }
 
 /*
@@ -419,7 +446,7 @@ void cosched_init_topology(void)
  *
  * We can do this without any locks, as nothing will automatically traverse into
  * these data structures. This requires an update of the sdrq.is_root property,
- * which will happen only later.
+ * which will happen only after everything as been setup at the very end.
  */
 void cosched_init_hierarchy(void)
 {
@@ -483,6 +510,9 @@ void cosched_init_hierarchy(void)
 		sdrq->sd_parent = &sd->shared->rq.cfs.sdrq;
 		list_add_tail(&sdrq->siblings, &sdrq->sd_parent->children);
 	}
+
+	/* Activate the hierarchy according to user preferences */
+	cosched_set_scheduled(&root_task_group, cosched_max_level);
 }
 
 /*****************************************************************************
-- 
2.9.3.1.gcba166c.dirty

