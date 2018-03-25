Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeCYWXB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:23:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeCYWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:22:55 -0400
Date: Sun, 25 Mar 2018 15:21:46 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nu4rxg5zkdtgs1b2gc40p7v7@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        acme@redhat.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ak@linux.intel.com, namhyung@kernel.org,
        adrian.hunter@intel.com, dsahern@gmail.com, jolsa@kernel.org
Reply-To: wangnan0@huawei.com, tglx@linutronix.de, acme@redhat.com,
        yao.jin@linux.intel.com, mingo@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, dsahern@gmail.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Use the default annotation options
 for --stdio2
Git-Commit-ID: 3563289208ecef339853692ecbf8690084744b53
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3563289208ecef339853692ecbf8690084744b53
Gitweb:     https://git.kernel.org/tip/3563289208ecef339853692ecbf8690084744b53
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 14:37:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 12:53:41 -0300

perf annotate: Use the default annotation options for --stdio2

With an empty '[annotate]' section in ~/.perfconfig:

  # perf record -a --all-kernel -e '{cycles,instructions}:P' sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.243 MB perf.data (5513 samples) ]
  # perf annotate --stdio2 _raw_spin_lock | head -20

                     Disassembly of section .text:

                     ffffffff81868790 <_raw_spin_lock>:
                     _raw_spin_lock():
                     EXPORT_SYMBOL(_raw_spin_trylock_bh);
                     #endif

                     #ifndef CONFIG_INLINE_SPIN_LOCK
                     void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
                     {
                     → callq  __fentry__
                     atomic_cmpxchg():
                             return xadd(&v->counter, -i);
                     }

                     static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
                     {
  # perf annotate --stdio2 _raw_spin_lock | head -20
                     → callq  __fentry__
                       xor    %eax,%eax
                       mov    $0x1,%edx
   87.50 100.00        lock   cmpxchg %edx,(%rdi)
    6.25   0.00        test   %eax,%eax
                     ↓ jne    16
    6.25   0.00        repz   retq
                 16:   mov    %eax,%esi
                     ↑ jmpq   ffffffff810e96b0 <queued_spin_lock_slowpath>
  #
  # cat ~/.perfconfig
  [annotate]

    hide_src_code = false
    show_linenr = true
  # perf annotate --stdio2 _raw_spin_lock | head -20

                 3   Disassembly of section .text:

                 5   ffffffff81868790 <_raw_spin_lock>:
                 6   _raw_spin_lock():
                 143 EXPORT_SYMBOL(_raw_spin_trylock_bh);
                 144 #endif

                 146 #ifndef CONFIG_INLINE_SPIN_LOCK
                 147 void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
                 148 {
                     → callq  __fentry__
                 150 atomic_cmpxchg():
                 187         return xadd(&v->counter, -i);
                 188 }

                 190 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
                 191 {
  #
  # cat ~/.perfconfig
  [annotate]

    hide_src_code = true
    show_total_period = true
  # perf annotate --stdio2 _raw_spin_lock | head -20
                               → callq  __fentry__
                                 xor    %eax,%eax
                                 mov    $0x1,%edx
      1411316      152339        lock   cmpxchg %edx,(%rdi)
       344694           0        test   %eax,%eax
                               ↓ jne    16
        80806           0        repz   retq
                           16:   mov    %eax,%esi
                               ↑ jmpq   ffffffff810e96b0 <queued_spin_lock_slowpath>
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nu4rxg5zkdtgs1b2gc40p7v7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cfa641bc1df6..ea83b9754ab0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2243,9 +2243,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation_options opts = {
-		.use_offset	= true,
-	};
+	struct annotation_options opts = annotation__default_options;
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
 		return -1;
