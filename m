Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73A206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eoaoVZPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A73A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeJFGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:19:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47084 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeJFGTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:19:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so7462911plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jy3+afbhcoBBWCkKDq49jdH16mCQEkKTdo6+KmIauoI=;
        b=eoaoVZPqMzi4LZ1H8Tpx9DfAVybQ8tMwdZNylBaD63o4KRwZaiWrcYllGNhrhu9NtR
         ZJylVC9WAoM1hX98Ob7EoU6xkzu5M5Xk/5/MiW9r9FIE351NAWsu3G+uxSJEcfkr4SeR
         GaXl1uoMWbKe0AVaUtiOy4UO4x8vDaUNfr1HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jy3+afbhcoBBWCkKDq49jdH16mCQEkKTdo6+KmIauoI=;
        b=ZTEQ5DS/kFNy/q9YUXCyHgb6xMTkqQiNtv+cibJeT/zsdiZgh22fJqrNLj54LkpwjZ
         cQ158lyBQile7s5XlNUFiycwRgUOmo4I13AZ2aqob4xhObsSHHoKCaJJHPiSxAxjVPEF
         gDOeZ3YWKkF+EA3sMDvH48g+lasM+DWipvp4P5RdKsj/pJATaybupo+f2ClHU0XQUHou
         WF9NR5ve8A3wsYrqXd619XvKUTB5+FduCycssxSy2ffgx5QJcC1Q+B/2OxlcPQ0teII4
         sFxjNnEJXFApYuDoOrVXyg8O+qNUG1FK9UBSAT6qst89CHjLxD0DBthzPKZgSiKzrVll
         OjRA==
X-Gm-Message-State: ABuFfoiO3rc1YFPqWq+nEytv898Bmt9ttTBFOnZec/2BklDTIfodCjot
        ER1ySGPdF0frO75sSt7f3APpsHkcD3A=
X-Google-Smtp-Source: ACcGV62vxheOV0Wa8tSgtroZSOD2qNMI+CiTX9+Pj7hsb6f+o8hE1aRxG9rsHCyxc+KmsqHlCzeXig==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr13776194pld.244.1538781514664;
        Fri, 05 Oct 2018 16:18:34 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q76-v6sm16641028pfa.18.2018.10.05.16.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:18:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: [PATCH RFC 4/5] doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
Date:   Fri,  5 Oct 2018 16:18:13 -0700
Message-Id: <20181005231815.170433-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181005231815.170433-1-joel@joelfernandes.org>
References: <20181005231815.170433-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the RCU mechanisms have been consolidated, this checklist item
seems no longer useful or relevant. Probably even a bit misleading. For
example, synchronize_rcu will now guarantee that all interrupt disabled
regions have finished executing. So lets remove this checklist item.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/checklist.txt | 37 +++++++--------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index cc22ce49618d..b90ad1b0665a 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -320,37 +320,14 @@ over a rather long period of time, but improvements are always welcome!
 	will break Alpha, cause aggressive compilers to generate bad code,
 	and confuse people trying to read your code.
 
-11.	Note that synchronize_rcu() -only- guarantees to wait until
-	all currently executing rcu_read_lock()-protected RCU read-side
-	critical sections complete.  It does -not- necessarily guarantee
-	that all currently running interrupts, NMIs, preempt_disable()
-	code, or idle loops will complete.  Therefore, if your
-	read-side critical sections are protected by something other
-	than rcu_read_lock(), do -not- use synchronize_rcu().
-
-	Similarly, disabling preemption is not an acceptable substitute
-	for rcu_read_lock().  Code that attempts to use preemption
-	disabling where it should be using rcu_read_lock() will break
-	in CONFIG_PREEMPT=y kernel builds.
-
-	If you want to wait for interrupt handlers, NMI handlers, and
-	code under the influence of preempt_disable(), you instead
-	need to use synchronize_irq() or synchronize_sched().
-
-	This same limitation also applies to synchronize_rcu_bh()
-	and synchronize_srcu(), as well as to the asynchronous and
-	expedited forms of the three primitives, namely call_rcu(),
-	call_rcu_bh(), call_srcu(), synchronize_rcu_expedited(),
-	synchronize_rcu_bh_expedited(), and synchronize_srcu_expedited().
-
-12.	Any lock acquired by an RCU callback must be acquired elsewhere
+11.	Any lock acquired by an RCU callback must be acquired elsewhere
 	with softirq disabled, e.g., via spin_lock_irqsave(),
 	spin_lock_bh(), etc.  Failing to disable irq on a given
 	acquisition of that lock will result in deadlock as soon as
 	the RCU softirq handler happens to run your RCU callback while
 	interrupting that acquisition's critical section.
 
-13.	RCU callbacks can be and are executed in parallel.  In many cases,
+12.	RCU callbacks can be and are executed in parallel.  In many cases,
 	the callback code simply wrappers around kfree(), so that this
 	is not an issue (or, more accurately, to the extent that it is
 	an issue, the memory-allocator locking handles it).  However,
@@ -366,7 +343,7 @@ over a rather long period of time, but improvements are always welcome!
 	not the case, a self-spawning RCU callback would prevent the
 	victim CPU from ever going offline.)
 
-14.	Unlike other forms of RCU, it -is- permissible to block in an
+13.	Unlike other forms of RCU, it -is- permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
 	Please note that if you don't need to sleep in read-side critical
@@ -410,7 +387,7 @@ over a rather long period of time, but improvements are always welcome!
 	Note that rcu_dereference() and rcu_assign_pointer() relate to
 	SRCU just as they do to other forms of RCU.
 
-15.	The whole point of call_rcu(), synchronize_rcu(), and friends
+14.	The whole point of call_rcu(), synchronize_rcu(), and friends
 	is to wait until all pre-existing readers have finished before
 	carrying out some otherwise-destructive operation.  It is
 	therefore critically important to -first- remove any path
@@ -422,13 +399,13 @@ over a rather long period of time, but improvements are always welcome!
 	is the caller's responsibility to guarantee that any subsequent
 	readers will execute safely.
 
-16.	The various RCU read-side primitives do -not- necessarily contain
+15.	The various RCU read-side primitives do -not- necessarily contain
 	memory barriers.  You should therefore plan for the CPU
 	and the compiler to freely reorder code into and out of RCU
 	read-side critical sections.  It is the responsibility of the
 	RCU update-side primitives to deal with this.
 
-17.	Use CONFIG_PROVE_LOCKING, CONFIG_DEBUG_OBJECTS_RCU_HEAD, and the
+16.	Use CONFIG_PROVE_LOCKING, CONFIG_DEBUG_OBJECTS_RCU_HEAD, and the
 	__rcu sparse checks to validate your RCU code.	These can help
 	find problems as follows:
 
@@ -451,7 +428,7 @@ over a rather long period of time, but improvements are always welcome!
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-18.	If you register a callback using call_rcu(), call_rcu_bh(),
+17.	If you register a callback using call_rcu(), call_rcu_bh(),
 	call_rcu_sched(), or call_srcu(), and pass in a function defined
 	within a loadable module, then it in necessary to wait for
 	all pending callbacks to be invoked after the last invocation
-- 
2.19.0.605.g01d371f741-goog

