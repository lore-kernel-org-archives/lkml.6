Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDPGot (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:44:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeDPGos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:44:48 -0400
Date: Sun, 15 Apr 2018 23:43:07 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-upp6pfdetwlsx18ec2uf1od4@git.kernel.org>
Cc: jolsa@kernel.org, mliska@suse.cz, namhyung@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, torvalds@linux-foundation.org,
        brouer@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ravi.bangoria@linux.vnet.ibm.com, wangnan0@huawei.com,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        tmricht@linux.vnet.ibm.com, dsahern@gmail.com, yao.jin@linux.intel.com
Reply-To: jolsa@kernel.org, mliska@suse.cz, namhyung@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, torvalds@linux-foundation.org,
        brouer@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        wangnan0@huawei.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, tmricht@linux.vnet.ibm.com, dsahern@gmail.com,
        yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate browser: Allow showing offsets in
 more than just jump targets
Git-Commit-ID: 51f39603b5f260c73635f4d06d390476b32df6a5
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

Commit-ID:  51f39603b5f260c73635f4d06d390476b32df6a5
Gitweb:     https://git.kernel.org/tip/51f39603b5f260c73635f4d06d390476b32df6a5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 11 Apr 2018 10:41:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:09 -0300

perf annotate browser: Allow showing offsets in more than just jump targets

Jesper wanted to see offsets at callq sites when doing some performance
investigation related to retpolines, so save him some time by providing
a 'O' hotkey to allow showing offsets from function start at call
instructions or in all instructions, just go on pressing 'O' till the
offsets you need appear.

Example:

Starts with:

Samples: 64  of event 'cycles:ppp', 100000 Hz, Event count (approx.): 318963
ixgbe_read_reg  /proc/kcore
Percent│    ↑ je     2a
       │   ┌──cmp    $0xffffffff,%r13d
       │   ├──je     d0
       │   │  mov    $0x53e3,%edi
       │   │→ callq  __const_udelay
       │   │  sub    $0x1,%r15d
       │   │↑ jne    83
       │   │  mov    0x8(%rbp),%rax
       │   │  testb  $0x20,0x1799(%rax)
       │   │↑ je     2a
       │   │  mov    0x200(%rax),%rdi
       │   │  mov    %r13d,%edx
       │   │  mov    $0xffffffffc02595d8,%rsi
       │   │→ callq  netdev_warn
       │   │↑ jmpq   2a
       │d0:└─→mov    0x8(%rbp),%rsi
       │      mov    %rbp,%rdi
       │      mov    %eax,0x4(%rsp)
       │    → callq  ixgbe_remove_adapter.isra.77
       │      mov    0x4(%rsp),%eax
Press 'h' for help on key bindings
============================================================================

Pess 'O':

Samples: 64  of event 'cycles:ppp', 100000 Hz, Event count (approx.): 318963
ixgbe_read_reg  /proc/kcore
Percent│    ↑ je     2a
       │   ┌──cmp    $0xffffffff,%r13d
       │   ├──je     d0
       │   │  mov    $0x53e3,%edi
       │99:│→ callq  __const_udelay
       │   │  sub    $0x1,%r15d
       │   │↑ jne    83
       │   │  mov    0x8(%rbp),%rax
       │   │  testb  $0x20,0x1799(%rax)
       │   │↑ je     2a
       │   │  mov    0x200(%rax),%rdi
       │   │  mov    %r13d,%edx
       │   │  mov    $0xffffffffc02595d8,%rsi
       │c6:│→ callq  netdev_warn
       │   │↑ jmpq   2a
       │d0:└─→mov    0x8(%rbp),%rsi
       │      mov    %rbp,%rdi
       │      mov    %eax,0x4(%rsp)
       │db: → callq  ixgbe_remove_adapter.isra.77
       │      mov    0x4(%rsp),%eax
Press 'h' for help on key bindings
============================================================================

Press 'O' again:

Samples: 64  of event 'cycles:ppp', 100000 Hz, Event count (approx.): 318963
ixgbe_read_reg  /proc/kcore
Percent│8c: ↑ je     2a
       │8e:┌──cmp    $0xffffffff,%r13d
       │92:├──je     d0
       │94:│  mov    $0x53e3,%edi
       │99:│→ callq  __const_udelay
       │9e:│  sub    $0x1,%r15d
       │a2:│↑ jne    83
       │a4:│  mov    0x8(%rbp),%rax
       │a8:│  testb  $0x20,0x1799(%rax)
       │af:│↑ je     2a
       │b5:│  mov    0x200(%rax),%rdi
       │bc:│  mov    %r13d,%edx
       │bf:│  mov    $0xffffffffc02595d8,%rsi
       │c6:│→ callq  netdev_warn
       │cb:│↑ jmpq   2a
       │d0:└─→mov    0x8(%rbp),%rsi
       │d4:   mov    %rbp,%rdi
       │d7:   mov    %eax,0x4(%rsp)
       │db: → callq  ixgbe_remove_adapter.isra.77
       │e0:   mov    0x4(%rsp),%eax
Press 'h' for help on key bindings
============================================================================

Press 'O' again and it will show just jump target offsets.

Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-upp6pfdetwlsx18ec2uf1od4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 12c099a87f8b..3781d74088a7 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -692,6 +692,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"J             Toggle showing number of jump sources on targets\n"
 		"n             Search next string\n"
 		"o             Toggle disassembler output/simplified view\n"
+		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
 		"s             Toggle source code view\n"
 		"t             Circulate percent, total period, samples view\n"
 		"/             Search string\n"
@@ -719,6 +720,10 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			notes->options->use_offset = !notes->options->use_offset;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'O':
+			if (++notes->options->offset_level > ANNOTATION__MAX_OFFSET_LEVEL)
+				notes->options->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+			continue;
 		case 'j':
 			notes->options->jump_arrows = !notes->options->jump_arrows;
 			continue;
