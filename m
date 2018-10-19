Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B53C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70C720C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="lUzZ/p17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70C720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeJSIxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:53:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16679 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1539910197; x=1571446197;
  h=from:to:cc:subject:date:message-id;
  bh=UWDgi3Nt+QQwkV11usPzy/dI+hg7NsrwWW3bhLvkG60=;
  b=lUzZ/p17iCEnVVlUTrVn0zq5chjEfCYYYgDQqeUcvZAG0erdIa2wYUZ4
   KVGovxof1hjvOZTfQjEStogHcHLZXa+Y4HGq1OuBIdwO2g6OhOTcZWOtk
   5SR4I/pNXEOq6yVs7ZU9veZVOkpkyXxBeNAYIG978IlmQKAfWg3q/z5qo
   E=;
X-IronPort-AV: E=Sophos;i="5.54,397,1534809600"; 
   d="scan'208";a="637087077"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Oct 2018 00:49:54 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9J0nkrK118598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 19 Oct 2018 00:49:49 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9J0njYc024440;
        Fri, 19 Oct 2018 02:49:45 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9J0niLc024437;
        Fri, 19 Oct 2018 02:49:44 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: Benefit from expedited grace period in __wait_rcu_gp
Date:   Fri, 19 Oct 2018 02:49:05 +0200
Message-Id: <1539910145-24305-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When expedited grace-period is set, both synchronize_sched
synchronize_rcu_bh can be optimized to have a significantly lower latency.

Improve wait_rcu_gp handling to also account for expedited grace-period.
The downside is that wait_rcu_gp will not wait anymore for all RCU variants
concurrently when an expedited grace-period is set, however, given the
improved latency it does not really matter.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 kernel/rcu/update.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 68fa19a..44b8817 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -392,13 +392,27 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
+
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
-			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		if (j != i)
+			continue;
+
+		if ((crcu_array[i] == call_rcu_sched ||
+		     crcu_array[i] == call_rcu_bh)
+		    && rcu_gp_is_expedited()) {
+			if (crcu_array[i] == call_rcu_sched)
+				synchronize_sched_expedited();
+			else
+				synchronize_rcu_bh_expedited();
+
+			continue;
+		}
+
+		init_rcu_head_on_stack(&rs_array[i].head);
+		init_completion(&rs_array[i].completion);
+		(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -407,11 +421,19 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		    (crcu_array[i] == call_rcu ||
 		     crcu_array[i] == call_rcu_bh))
 			continue;
+
+		if ((crcu_array[i] == call_rcu_sched ||
+		     crcu_array[i] == call_rcu_bh)
+		    && rcu_gp_is_expedited())
+			continue;
+
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
-			wait_for_completion(&rs_array[i].completion);
+		if (j != i)
+			continue;
+
+		wait_for_completion(&rs_array[i].completion);
 		destroy_rcu_head_on_stack(&rs_array[i].head);
 	}
 }
-- 
2.7.4

