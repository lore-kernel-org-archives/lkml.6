Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6F20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="rKVEXV/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbeIHCYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:22 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:2841 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbeIHCYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356485; x=1567892485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/dZ5LLpx2KgS0hOfSWMQeo+PIufJsoKR0fzFom6iZjw=;
  b=rKVEXV/J3ew0xqdgDOKZbyaIhDJf6dp03de8HWGdb9V1UGDnMnKf5UW0
   /BURR9DN64KTtIaA2RsMR11VUaZf++0h23Iv571n+8YCQKp2Gk7r5pdNt
   aVcUeo0JA9D9GourKs6l10s+88M5SDsieDRV485Ud7niBYfR6uI/YzBzP
   c=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243110"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:25 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfJRH034269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:21 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfHP9027137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:17 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfGg4027136;
        Fri, 7 Sep 2018 23:41:16 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 05/60] sched: Allow to retrieve the sched_domain_topology
Date:   Fri,  7 Sep 2018 23:39:52 +0200
Message-Id: <20180907214047.26914-6-jschoenh@amazon.de>
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

While it is possible to simply overwrite the sched_domain_topology,
it was not possible to retrieve the sched_domain_topology to modify
it instead. Add a function to enable that use case.

Note, that this does not help with the already existing potential
memory leak, when one dynamically allocated sched_domain_topology
is replaced with another one.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 include/linux/sched/topology.h | 1 +
 kernel/sched/topology.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f78534f1cc1e..28d037d0050e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -194,6 +194,7 @@ struct sched_domain_topology_level {
 };
 
 extern void set_sched_topology(struct sched_domain_topology_level *tl);
+struct sched_domain_topology_level *get_sched_topology(void);
 
 #ifdef CONFIG_SCHED_DEBUG
 # define SD_INIT_NAME(type)		.name = #type
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0f2c3aa0a097..f2db2368ac5f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1226,6 +1226,11 @@ void set_sched_topology(struct sched_domain_topology_level *tl)
 	}
 }
 
+struct sched_domain_topology_level *get_sched_topology(void)
+{
+	return sched_domain_topology;
+}
+
 #ifdef CONFIG_NUMA
 
 static const struct cpumask *
-- 
2.9.3.1.gcba166c.dirty

