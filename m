Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754770AbeDMOBt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2562183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/17] perf annotate browser: Allow showing offsets in more than just jump targets
Date: Fri, 13 Apr 2018 11:00:59 -0300
Message-Id: <20180413140111.25313-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
