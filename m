Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607B72083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131871;
	bh=NDDtdpOLpau2TggkZGV+MaVnNhrV1jqbqX1ztQxB/iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14VRe/835NG/F2tlPRKLb987T3GsLbkEaR9edCfdecfjinx6dZd3A8uiACmEAmbBT
	 0gxb/q/Nteg149hOSuqYkgvCPCPyA4HycbQU0gxoRxN3/ZCpiqjbGFnGTYxeqBShdL
	 GpfObF41bU/UlnW3F1msi5thrvICyMRD+C2lXsxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfBYV5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbfBYVU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:58 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC8B21848;
        Mon, 25 Feb 2019 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129657;
        bh=NDDtdpOLpau2TggkZGV+MaVnNhrV1jqbqX1ztQxB/iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMhWY/4DkDb3dUxZ/YgyqhCr6iNvDD8ceYE4uEOAE+PxkSU7xiqsfxUWnBBEfjSU0
         fJcvstHFAISaG8zHvBXUtktcbiCqd80nsNNwngCWd4/VNX4EfZzULk3FU/P/Svf+rE
         zMzutG7gWcGRsLh/N623E2GJKBEjsmWtccg1zbhg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/37] perf thread-stack: Improve thread_stack__no_call_return()
Date:   Mon, 25 Feb 2019 18:20:00 -0300
Message-Id: <20190225212035.24781-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Improve thread_stack__no_call_return() to better handle 'returns' that
do not match the stack i.e. 'no call'. See code comments for details.
The example below shows how retpolines are affected:

Example:

  $ cat simple-retpoline.c
  __attribute__((noinline)) int bar(void)
  {
          return -1;
  }

  int foo(void)
  {
          return bar() + 1;
  }

  __attribute__((indirect_branch("thunk"))) int main()
  {
          int (*volatile fn)(void) = foo;

          fn();
          return fn();
  }
  $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
  $ objdump -d simple-retpoline
  <SNIP>
  0000000000001040 <main>:
      1040:       48 83 ec 18             sub    $0x18,%rsp
      1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
      104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
      1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
      1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
      105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
      105f:       48 83 c4 18             add    $0x18,%rsp
      1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
  <SNIP>
  0000000000001160 <bar>:
      1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
      1165:       c3                      retq
  <SNIP>
  0000000000001170 <foo>:
      1170:       e8 eb ff ff ff          callq  1160 <bar>
      1175:       83 c0 01                add    $0x1,%eax
      1178:       c3                      retq
  0000000000001179 <__x86_indirect_thunk_rax>:
      1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
      117e:       f3 90                   pause
      1180:       0f ae e8                lfence
      1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
      1185:       48 89 04 24             mov    %rax,(%rsp)
      1189:       c3                      retq
  <SNIP>
  $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
  $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  2019-01-08 14:03:37.851655 Creating database...
  2019-01-08 14:03:37.863256 Writing records...
  2019-01-08 14:03:38.069750 Adding indexes
  2019-01-08 14:03:38.078799 Done
  $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db

Before:

    main
        -> __x86_indirect_thunk_rax
            -> __x86_indirect_thunk_rax
                -> __x86_indirect_thunk_rax
                    -> bar

After:

    main
        -> __x86_indirect_thunk_rax
            -> __x86_indirect_thunk_rax
                -> foo
                    -> bar

Committer testing:

Chose "Reports", Then "Context-Sensitive Call Graph" and then go on
expanding:

Before:

simple-retpolin
   PID:PID
      _start
         _start
            __libc_start_main
               main
                   __x86_indirect_thunk_rax
                      __x86_indirect_thunk_rax
                      bar

After:

Remove the "simple.retpoline.db" file, run again the 'perf script' line
to regenerate the .db file and run the exported-sql-viewer.py again to
get the same all the way to 'main', then, from there, including 'main':

               main
                   __x86_indirect_thunk_rax
                       __x86_indirect_thunk_rax
                           foo
                               bar

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 49 +++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index f52c0f90915d..632c07a125ab 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -638,14 +638,57 @@ static int thread_stack__no_call_return(struct thread *thread,
 	else
 		parent = root;
 
-	/* This 'return' had no 'call', so push and pop top of stack */
-	cp = call_path__findnew(cpr, parent, fsym, ip, ks);
+	if (parent->sym == from_al->sym) {
+		/*
+		 * At the bottom of the stack, assume the missing 'call' was
+		 * before the trace started. So, pop the current symbol and push
+		 * the 'to' symbol.
+		 */
+		if (ts->cnt == 1) {
+			err = thread_stack__call_return(thread, ts, --ts->cnt,
+							tm, ref, false);
+			if (err)
+				return err;
+		}
+
+		if (!ts->cnt) {
+			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+
+			return thread_stack__push_cp(ts, addr, tm, ref, cp,
+						     true, false);
+		}
+
+		/*
+		 * Otherwise assume the 'return' is being used as a jump (e.g.
+		 * retpoline) and just push the 'to' symbol.
+		 */
+		cp = call_path__findnew(cpr, parent, tsym, addr, ks);
+
+		err = thread_stack__push_cp(ts, 0, tm, ref, cp, true, false);
+		if (!err)
+			ts->stack[ts->cnt - 1].non_call = true;
+
+		return err;
+	}
+
+	/*
+	 * Assume 'parent' has not yet returned, so push 'to', and then push and
+	 * pop 'from'.
+	 */
+
+	cp = call_path__findnew(cpr, parent, tsym, addr, ks);
 
 	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	return thread_stack__pop_cp(thread, ts, addr, tm, ref, tsym);
+	cp = call_path__findnew(cpr, cp, fsym, ip, ks);
+
+	err = thread_stack__push_cp(ts, ip, tm, ref, cp, true, false);
+	if (err)
+		return err;
+
+	return thread_stack__call_return(thread, ts, --ts->cnt, tm, ref, false);
 }
 
 static int thread_stack__trace_begin(struct thread *thread,
-- 
2.20.1

