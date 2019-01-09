Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8808214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfAIJUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbfAIJUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163058"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:20 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] perf thread-stack: Improve thread_stack__no_call_return()
Date:   Wed,  9 Jan 2019 11:18:34 +0200
Message-Id: <20190109091835.5570-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve thread_stack__no_call_return() to better handle 'returns' that do
not match the stack i.e. 'no call'. See code comments for details.
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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.17.1

