Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3528208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H2s2x1cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3528208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757438AbeFSWOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:14:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41410 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757392AbeFSWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:14:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so530928pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/y9VeAim7vsLjiX6uxZjEblMmfw2sPsa6w0bV3n+UU=;
        b=H2s2x1cga7ZBG0Y780KlwD4uKUekXxTZGgZnI+ZFE+TmbqxnokdYAXSibRFHa/E9Jz
         6ZAcBfQRs7yk3exY6n7BnCcp08IJgUyLrqPVtHWFOvsOVDBO9OzcxwxlAkBJvbivHa72
         o9APuwz/OeULGHmc87cnhLieQJ42nCIF+tn8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W/y9VeAim7vsLjiX6uxZjEblMmfw2sPsa6w0bV3n+UU=;
        b=OHcjdPCgrQYTtxBSUCq/h0dZyuGTItVwCi+khmnfH9IFVKDsgJi7FOWfz6v1VKN1rY
         xAsGlDfV/YZuOlv7D/5cvbhNuHQtTjQSdmmm/PrVnRt9/xoJ+pvTgC81ipruXFZS2fWp
         3K7wCNobYuDOQ4VnyQihqhZdDU3z9tKKzuttnC+ytBe4caCB+J0/yapdgW9pIWGfne79
         RTinPLytppZsCObrHjEIeGrEKwg6BDqQsNI7QTvBiIV3ORbbjI6qAxhEvtgHp8exbL2W
         bWgzKnvz1rr932ev9o9fPj3DXJ0LjIK99MDuux1Lg5l+j+Alyqy9kEqTC0vrGw9sek6r
         txwg==
X-Gm-Message-State: APt69E2tN3uaKeuw6blG87C62F9BKTUr7iQeJI1S4sBUmG/SuraMu9SH
        MSuXJrAlmyxV643tpLQCmDhxJCL+eH0=
X-Google-Smtp-Source: ADUXVKKGntIwLpZ3u1pYljJXBOJasz8OX42aZuC44EqRQ0SlpXFtULpG8v5DIAxPgS8v63qIob33cg==
X-Received: by 2002:a63:a557:: with SMTP id r23-v6mr16488707pgu.336.1529446468786;
        Tue, 19 Jun 2018 15:14:28 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n85-v6sm841389pfa.146.2018.06.19.15.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:14:28 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/3] rcutorture: Fix rcu_barrier successes counter
Date:   Tue, 19 Jun 2018 15:14:19 -0700
Message-Id: <20180619221419.41340-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180619221419.41340-1-joel@joelfernandes.org>
References: <20180619221419.41340-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

rcutorture currently increments both successes and error for barrier
test incase of errors. It should only increment the error counter incase
of errors so make it do so.

Test: Introduced rcu_barrier errors by returning from the barrier
callback without incrementing the callback counter.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2d1af5ffe536..b77012135ec0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -169,7 +169,7 @@ static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
 static long n_barrier_attempts;
-static long n_barrier_successes;
+static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static atomic_long_t n_cbfloods;
 static struct list_head rcu_torture_removed;
 
@@ -1722,8 +1722,9 @@ static int rcu_torture_barrier(void *arg)
 			       atomic_read(&barrier_cbs_invoked),
 			       n_barrier_cbs);
 			WARN_ON_ONCE(1);
+		} else {
+			n_barrier_successes++;
 		}
-		n_barrier_successes++;
 		schedule_timeout_interruptible(HZ / 10);
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_barrier");
-- 
2.18.0.rc1.244.gcf134e6275-goog

