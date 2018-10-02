Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32697C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0052064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GXQJ/tLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0052064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJBIBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:01:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33593 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJBIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:01:02 -0400
Received: by mail-io1-f66.google.com with SMTP id l25-v6so357072ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffOc9t5+lcVZ3T+KDXtadxdy+to1qeTKigvuih9/fUU=;
        b=GXQJ/tLSRuYz/CZj14XzaLVaEWjsx4THpiqWDxidwFS8xPdpLsE6tNrEbaVNutCkAx
         URjJUc1iwSs8oaVFKaZUEVn1o9oC8aCbhOHctGCCy9B82liaTlvxm7aqV3r5g0GDkNG2
         llutFr47MlVMrjr37gymoDZZTE/3ukSr6kvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffOc9t5+lcVZ3T+KDXtadxdy+to1qeTKigvuih9/fUU=;
        b=P6hiQLQswVWMYEutvn6TjGoCsjhv8gIy1w8yg/1AaRfanOHwtYk4O8VnskSf9TJl1t
         qYxU4BQLbu+usK2nMW0wvysGRa5wAL/GGYXFmZUm0c9SLlDHVA6CMk9dWSd5jSZBXTFq
         Dy1r5b5CjY0mWZMmbL8cNJk30l+iMlltIJunhazCPTBNLZNVtY/8I582X3xu253YF/vS
         m7NjPuRlz3o0a2jSZZlhDmhcBmtXJhvTIhwOoI8k09BpmZ97nmxzb+9AHAos4OuKOb4v
         5Z/WU4Pd03H46kJnl8uFHrcbh4X8HyGRbpIbqNlSHeBx/ddAE5xtum8yQc3Llep5jHJr
         6Fng==
X-Gm-Message-State: ABuFfoiPz4c0hxaP+AOiSPh6nyQxPnidCtmUkCqVLljyZuEur/Yl/eXw
        rqFzTFoqpqE6SZ8tzHti/LYZflJYHSw=
X-Google-Smtp-Source: ACcGV61z+zxshmGQaLKzUVgC+XGL79EkBMm2IKYX0TiL6SgChuDb8BO+dvChZLBEfwDdl85KWMIE4w==
X-Received: by 2002:a17:902:103:: with SMTP id 3-v6mr12613290plb.58.1538443225109;
        Mon, 01 Oct 2018 18:20:25 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h7-v6sm7409003pfd.35.2018.10.01.18.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:20:23 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 2/2] rcu: Remove synchronize_rcu_mult since it has no more users
Date:   Mon,  1 Oct 2018 18:20:12 -0700
Message-Id: <20181002012012.13133-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181002012012.13133-1-joel@joelfernandes.org>
References: <20181002012012.13133-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

sched/core.c was the only user of synchronize_rcu_mult. It has been
coverted to use synchronize_rcu. So lets remove the synchronize_rcu_mult
implementation entirely.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate_wait.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 8a16c3eb3dd0..c0578ba23c1a 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -31,21 +31,4 @@ do {									\
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
 
-/**
- * synchronize_rcu_mult - Wait concurrently for multiple grace periods
- * @...: List of call_rcu() functions for different grace periods to wait on
- *
- * This macro waits concurrently for multiple types of RCU grace periods.
- * For example, synchronize_rcu_mult(call_rcu, call_rcu_tasks) would wait
- * on concurrent RCU and RCU-tasks grace periods.  Waiting on a give SRCU
- * domain requires you to write a wrapper function for that SRCU domain's
- * call_srcu() function, supplying the corresponding srcu_struct.
- *
- * If Tiny RCU, tell _wait_rcu_gp() does not bother waiting for RCU,
- * given that anywhere synchronize_rcu_mult() can be called is automatically
- * a grace period.
- */
-#define synchronize_rcu_mult(...) \
-	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
-
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
-- 
2.19.0.605.g01d371f741-goog

