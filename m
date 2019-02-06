Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7064218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479115;
	bh=tbHKB84uZVkFAIMEd37OEM5ssMBr2bAhhNAwQS9We0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/Xpi86elPB6zZT8mSOlqWp7IehRKWUi3dR1v1vzA4ffi6Kesd5sCQ6vU1XIZAaBe
	 emLzcCcluVLvEyekoQX/PEkVCu6oryemeuh7CpvPkfVbnPbadHkVWvnfyNBbCFQg0Y
	 IyaD4VMoPYA8V2IQxAPmabGV7qFcUE4Fwn2Z3N8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfBFSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfBFSvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:52 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F41B2186A;
        Wed,  6 Feb 2019 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479111;
        bh=tbHKB84uZVkFAIMEd37OEM5ssMBr2bAhhNAwQS9We0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=di6vxzsEywdKsTQAnTU/mTdUi3T77dTM7bz4YxtGruIyjDt5JKLlyh+xZ8IhbQZdu
         cXJKvAn3ly6+gwS1Sco2Yzxey7GWO7/ZgwM7eNcvyFYtvn/uLph/WXgPMWH+TXjYpz
         wf+FopOLy5+gZ9JXhavuB30tWLF72DcjtWj1iALA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 48/53] perf thread-stack: Represent jmps to the start of a different symbol
Date:   Wed,  6 Feb 2019 15:48:58 -0300
Message-Id: <20190206184903.24054-49-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The compiler might optimize a call/ret combination by making it a jmp.
However the thread-stack does not presently cater for that, so that such
control flow is not visible in the call graph. Make it visible by
recording on the stack a branch to the start of a different symbol.
Note, that means when a ret pops the stack, all jmps must be popped off
first.

Example:

  $ cat jmp-to-fn.c
  __attribute__((noinline)) int bar(void)
  {
          return -1;
  }

  __attribute__((noinline)) int foo(void)
  {
          return bar() + 1;
  }

  int main()
  {
          return foo();
  }
  $ gcc -ggdb3 -Wall -Wextra -O2 -o jmp-to-fn jmp-to-fn.c
  $ objdump -d jmp-to-fn
  <SNIP>
  0000000000001040 <main>:
      1040:       31 c0                   xor    %eax,%eax
      1042:       e9 09 01 00 00          jmpq   1150 <foo>
  <SNIP>
  0000000000001140 <bar>:
      1140:       b8 ff ff ff ff          mov    $0xffffffff,%eax
      1145:       c3                      retq
  <SNIP>
  0000000000001150 <foo>:
      1150:       31 c0                   xor    %eax,%eax
      1152:       e8 e9 ff ff ff          callq  1140 <bar>
      1157:       83 c0 01                add    $0x1,%eax
      115a:       c3                      retq
  <SNIP>
  $ perf record -o jmp-to-fn.perf.data -e intel_pt/cyc/u ./jmp-to-fn
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0,017 MB jmp-to-fn.perf.data ]
  $ perf script -i jmp-to-fn.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py jmp-to-fn.db branches calls
  2019-01-08 13:24:58.783069 Creating database...
  2019-01-08 13:24:58.794650 Writing records...
  2019-01-08 13:24:59.008050 Adding indexes
  2019-01-08 13:24:59.015802 Done
  $  ~/libexec/perf-core/scripts/python/exported-sql-viewer.py jmp-to-fn.db

Before:

    main
        -> bar

After:

    main
        -> foo
            -> bar

Committer testing:

Install the python2-pyside package, then select these menu options
on the GUI:

   "Reports"
      "Context sensitive callgraphs"

Then go on expanding the symbols, to get, full picture when doing this
on a fedora:29 with gcc version 8.2.1 20181215 (Red Hat 8.2.1-6) (GCC):

jmp-to-fn
  PID:TID
    _start                (ld-2.28.so)
      __libc_start_main
        main
          foo
            bar

To verify that indeed, this fixes the problem.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/export-to-postgresql.py    |  2 +-
 tools/perf/scripts/python/export-to-sqlite.py |  2 +-
 tools/perf/util/thread-stack.c                | 30 +++++++++++++++++--
 tools/perf/util/thread-stack.h                |  3 ++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 0564dd7377f2..30130213da7e 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -478,7 +478,7 @@ if perf_db_export_calls:
 			'branch_count,'
 			'call_id,'
 			'return_id,'
-			'CASE WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' ELSE \'\' END AS flags,'
+			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
 			'parent_call_path_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 245caf2643ed..ed237f2ed03f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -320,7 +320,7 @@ if perf_db_export_calls:
 			'branch_count,'
 			'call_id,'
 			'return_id,'
-			'CASE WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' ELSE \'\' END AS flags,'
+			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
 			'parent_call_path_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 7f8eff018c16..f52c0f90915d 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -38,6 +38,7 @@
  * @cp: call path
  * @no_call: a 'call' was not seen
  * @trace_end: a 'call' but trace ended
+ * @non_call: a branch but not a 'call' to the start of a different symbol
  */
 struct thread_stack_entry {
 	u64 ret_addr;
@@ -47,6 +48,7 @@ struct thread_stack_entry {
 	struct call_path *cp;
 	bool no_call;
 	bool trace_end;
+	bool non_call;
 };
 
 /**
@@ -268,6 +270,8 @@ static int thread_stack__call_return(struct thread *thread,
 		cr.flags |= CALL_RETURN_NO_CALL;
 	if (no_return)
 		cr.flags |= CALL_RETURN_NO_RETURN;
+	if (tse->non_call)
+		cr.flags |= CALL_RETURN_NON_CALL;
 
 	return crp->process(&cr, crp->data);
 }
@@ -510,6 +514,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->cp = cp;
 	tse->no_call = no_call;
 	tse->trace_end = trace_end;
+	tse->non_call = false;
 
 	return 0;
 }
@@ -531,14 +536,16 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 							 timestamp, ref, false);
 	}
 
-	if (ts->stack[ts->cnt - 1].ret_addr == ret_addr) {
+	if (ts->stack[ts->cnt - 1].ret_addr == ret_addr &&
+	    !ts->stack[ts->cnt - 1].non_call) {
 		return thread_stack__call_return(thread, ts, --ts->cnt,
 						 timestamp, ref, false);
 	} else {
 		size_t i = ts->cnt - 1;
 
 		while (i--) {
-			if (ts->stack[i].ret_addr != ret_addr)
+			if (ts->stack[i].ret_addr != ret_addr ||
+			    ts->stack[i].non_call)
 				continue;
 			i += 1;
 			while (ts->cnt > i) {
@@ -757,6 +764,25 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		err = thread_stack__trace_begin(thread, ts, sample->time, ref);
 	} else if (sample->flags & PERF_IP_FLAG_TRACE_END) {
 		err = thread_stack__trace_end(ts, sample, ref);
+	} else if (sample->flags & PERF_IP_FLAG_BRANCH &&
+		   from_al->sym != to_al->sym && to_al->sym &&
+		   to_al->addr == to_al->sym->start) {
+		struct call_path_root *cpr = ts->crp->cpr;
+		struct call_path *cp;
+
+		/*
+		 * The compiler might optimize a call/ret combination by making
+		 * it a jmp. Make that visible by recording on the stack a
+		 * branch to the start of a different symbol. Note, that means
+		 * when a ret pops the stack, all jmps must be popped off first.
+		 */
+		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
+					to_al->sym, sample->addr,
+					ts->kernel_start);
+		err = thread_stack__push_cp(ts, 0, sample->time, ref, cp, false,
+					    false);
+		if (!err)
+			ts->stack[ts->cnt - 1].non_call = true;
 	}
 
 	return err;
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 1f626f4a1c40..b7c04e19ad41 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -35,10 +35,13 @@ struct call_path;
  *
  * CALL_RETURN_NO_CALL: 'return' but no matching 'call'
  * CALL_RETURN_NO_RETURN: 'call' but no matching 'return'
+ * CALL_RETURN_NON_CALL: a branch but not a 'call' to the start of a different
+ *                       symbol
  */
 enum {
 	CALL_RETURN_NO_CALL	= 1 << 0,
 	CALL_RETURN_NO_RETURN	= 1 << 1,
+	CALL_RETURN_NON_CALL	= 1 << 2,
 };
 
 /**
-- 
2.20.1

