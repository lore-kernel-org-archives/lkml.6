Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F4A2150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZUqboCnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F4A2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeIWFhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:37:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41837 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeIWFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:37:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so7520944plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yxP4rhfIhDVX/maUGdnrlkcLnjNANX3q76JH8ZURX0=;
        b=ZUqboCnM9ZG7xFxbvC7EYayAEVfJ2l1kN8pw2FsvaK8gYSvTtnhYU+O4ocgqTxpsY7
         gGm8aQgziXx+NbMSodtogA9AKsVVBaJgIdQLkUC0F6GYd9OpN8fosUBfr6bUOFcEOmxY
         62OgGkqDi3wurAf2l16KF9rnu+tkl4prNoBPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yxP4rhfIhDVX/maUGdnrlkcLnjNANX3q76JH8ZURX0=;
        b=synRIkqpL8Fck6JA774Hc1yXJSqH03PYPgMmCqxhfmiY2Hao6iR5pELt0jJJQXNZtc
         bZ+4S6MganexlBi8ifFsa4FmyZinRPROuAuyrNdoGCcAF8pc5aVuGL/j1ZxV9SgaHyPU
         jUjmlQj962AN28BVPTmreUS/z7mXYi5hXQA7sAm9j5wc7bEjA/HhF/SLnszppSnJX64g
         kR068kI9sVoAuAhGdF3NJ8u4rpsCeoeSxigk8k9WfGyC4gtSz4PqdSTuXW9XeLYgjEwv
         dbCELiXS+AqPFevZXnjEX+QXvcjCMf7XQD9PC4kD1dHbM4NwQySuivhb6gqq7TsYsKcL
         dF1A==
X-Gm-Message-State: ABuFfohdMq707BIWOBQ3AlbSLr8FJcTlNv2je23ghTDCEz74Xp5d+SN7
        om0GjOVXzc1rA6YImNQx6PiFFcrnRa4=
X-Google-Smtp-Source: ACcGV61PZMOYdvw3cRGg4CPuAf+ITcqoBWkXwRZPO2ga2T44ldc4d9F/dNog6fSvBqApTVTMy8djAQ==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr4155963plb.299.1537659700437;
        Sat, 22 Sep 2018 16:41:40 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id h4-v6sm32377789pgp.13.2018.09.22.16.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 16:41:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 2/3] rcu: tree: Fix comment about gp_seq_needed
Date:   Sat, 22 Sep 2018 19:41:26 -0400
Message-Id: <20180922234127.94970-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180922234127.94970-1-joel@joelfernandes.org>
References: <20180922234127.94970-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_state does not have a gp_seq_needed field. This comment therefore is
confusing or incorrect. Fix it.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 57a937ac51c2..fd2ba3f9eee9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -57,7 +57,7 @@ struct rcu_node {
 					/*  some rcu_state fields as well as */
 					/*  following. */
 	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
-	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
+	unsigned long gp_seq_needed; /* Track the furthest future gp request seen */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
 				/*  order for current grace period to proceed.*/
@@ -163,7 +163,7 @@ union rcu_noqs {
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
 	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
-	unsigned long	gp_seq_needed;	/* Track rsp->rcu_gp_seq_needed ctr. */
+	unsigned long	gp_seq_needed;	/* Track the furthest future gp request seen */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
 	bool		beenonline;	/* CPU online at least once. */
-- 
2.19.0.444.g18242da7ef-goog

