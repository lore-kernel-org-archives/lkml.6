Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AFA21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FrwP2dZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfBSWzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:55:48 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36131 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfBSWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:55:46 -0500
Received: by mail-wr1-f41.google.com with SMTP id o17so23801928wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktqBzmGJ2TM5v5gOlTFWHS69JLWGzysduwLKHimO48w=;
        b=FrwP2dZdqs8rVfByyEGpSYqm9ALUg8KDnkORAgiSrbmkhGZAZw70Hf/5VfSROSIsk/
         zyzG8Z5LF4lxV6Qlh5AM2dxkW5Pu91cK7rLKHCTqgrCBwzxBxZU4L2EwaORR/ChPJ5jO
         JGEy+YMt4pOSJ9yb+4IitzoGxhFQDUHY0ghyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktqBzmGJ2TM5v5gOlTFWHS69JLWGzysduwLKHimO48w=;
        b=ayXxK7T8TDzKKqxNHYK4dA+Ebbk3uqzynMImjutMq8BSzVCwMSwV7xGHMumcUSmzPQ
         4zJDNrZ0Qhqt0L+ZMyxIt0ck5puLQ1CIzFrwpJVBIMh43pKHne9Ji/3HdR4VQ+8tk2BB
         PKrr+ZU7wRv4FQFC5KbYsC+sOQFwn/lf3biP29b/BApKCpMtOtWyuk+Do/l1NzCBWUsi
         Z/8xV2k8F+68NLHkvPsPdUK5UjpaWKu/dVCclcTGaHSqoSaMBsrUkKhvX4Y+Midm4ER7
         RsPvEH88Ijk0dgVN+V+6Yjaf/yKk4cvxmBrWs/8N4AWW8F2UTPUL53cZ0/EqbcHYlwWT
         9UeA==
X-Gm-Message-State: AHQUAuaXzuh8YK1bOdLYkuLvNe5r/hqJgiIjyYlUyKQ4qC+fqZ9sP3Zd
        VgW+8t5wjgYRe8xwUIC/wmSxjK+XlGCumw==
X-Google-Smtp-Source: AHgI3IbF4jtnncws2vLEabE1fg3gwsmvdWglCNzevNl4uVZ3XgXHVFTCxiYEo64DFaEyyeJCQNOY6Q==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr20993775wrs.252.1550616944522;
        Tue, 19 Feb 2019 14:55:44 -0800 (PST)
Received: from localhost.localdomain ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id b3sm7073951wme.27.2019.02.19.14.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 14:55:43 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH 2/2] tools/memory-model: Do not use "herd" to refer to "herd7"
Date:   Tue, 19 Feb 2019 23:55:23 +0100
Message-Id: <1550616923-4795-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "herd7" in each such reference.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 tools/memory-model/litmus-tests/README       | 2 +-
 tools/memory-model/lock.cat                  | 2 +-
 tools/memory-model/scripts/README            | 4 ++--
 tools/memory-model/scripts/checkalllitmus.sh | 2 +-
 tools/memory-model/scripts/checklitmus.sh    | 2 +-
 tools/memory-model/scripts/parseargs.sh      | 2 +-
 tools/memory-model/scripts/runlitmushist.sh  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 5ee08f129094e..681f9067fa9ed 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -244,7 +244,7 @@ produce the name:
 Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
 
 The descriptors that describe connections between consecutive accesses
-within the cycle through a given litmus test can be provided by the herd
+within the cycle through a given litmus test can be provided by the herd7
 tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
 Release, Acquire, and so on).
 
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index a059d1a6d8a29..6b52f365d73ac 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -11,7 +11,7 @@
 include "cross.cat"
 
 (*
- * The lock-related events generated by herd are as follows:
+ * The lock-related events generated by herd7 are as follows:
  *
  * LKR		Lock-Read: the read part of a spin_lock() or successful
  *			spin_trylock() read-modify-write event pair
diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 29375a1fbbfa1..095c7eb36f9f9 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -22,7 +22,7 @@ checklitmushist.sh
 
 	Run all litmus tests having .litmus.out files from previous
 	initlitmushist.sh or newlitmushist.sh runs, comparing the
-	herd output to that of the original runs.
+	herd7 output to that of the original runs.
 
 checklitmus.sh
 
@@ -43,7 +43,7 @@ initlitmushist.sh
 
 judgelitmus.sh
 
-	Given a .litmus file and its .litmus.out herd output, check the
+	Given a .litmus file and its .litmus.out herd7 output, check the
 	.litmus.out file against the .litmus file's "Result:" comment to
 	judge whether the test ran correctly.  Not normally run manually,
 	provided instead for use by other scripts.
diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index b35fcd61ecf6d..3c0c7fbbd223b 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run herd tests on all .litmus files in the litmus-tests directory
+# Run herd7 tests on all .litmus files in the litmus-tests directory
 # and check each file's result against a "Result:" comment within that
 # litmus test.  If the verification result does not match that specified
 # in the litmus test, this script prints an error message prefixed with
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index dd08801a30b05..11461ed40b5e4 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run a herd test and invokes judgelitmus.sh to check the result against
+# Run a herd7 test and invokes judgelitmus.sh to check the result against
 # a "Result:" comment within the litmus test.  It also outputs verification
 # results to a file whose name is that of the specified litmus test, but
 # with ".out" appended.
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 859e1d581e051..40f52080fdbd6 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -91,7 +91,7 @@ do
 		shift
 		;;
 	--herdopts|--herdopt)
-		checkarg --destdir "(herd options)" "$#" "$2" '.*' '^--'
+		checkarg --destdir "(herd7 options)" "$#" "$2" '.*' '^--'
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index e507f5f933d53..6ed376f495bb4 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -79,7 +79,7 @@ then
 	echo ' ---' Summary: 1>&2
 	grep '!!!' $T/*.sh.out 1>&2
 	nfail="`grep '!!!' $T/*.sh.out | wc -l`"
-	echo 'Number of failed herd runs (e.g., timeout): ' $nfail 1>&2
+	echo 'Number of failed herd7 runs (e.g., timeout): ' $nfail 1>&2
 	exit 1
 else
 	echo All runs completed successfully. 1>&2
-- 
2.7.4

