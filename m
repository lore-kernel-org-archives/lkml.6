Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeENMXo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753270AbeENMXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:23:38 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf annotate: Display all available events on --stdio
Date: Mon, 14 May 2018 09:23:18 -0300
Message-Id: <20180514122321.27304-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

When we perform the following command lines:

  $ perf record -e "{cycles,branches}" ./div
  $ perf annotate main --stdio

The output shows only the first event, "cycles" and the displaying
format is not correct.

   Percent         |      Source code & Disassembly of div for cycles (44550 samples)
  -----------------------------------------------------------------------------------
                   :
                   :
                   :
                   :            Disassembly of section .text:
                   :
                   :            00000000004004b0 <main>:
                   :            main():
                   :
                   :                    return i;
                   :            }
                   :
                   :            int main(void)
                   :            {
      0.00 :   4004b0:       push   %rbx
                   :                    int i;
                   :                    int flag;
                   :                    volatile double x = 1212121212, y = 121212;
                   :
                   :                    s_randseed = time(0);
      0.00 :   4004b1:       xor    %edi,%edi
                   :                    srand(s_randseed);
      0.00 :   4004b3:       mov    $0x77359400,%ebx
                   :
                   :                    return i;
                   :            }

The issue is that the value of the 'nr_percent' variable is hardcoded to
1.  This patch fixes it.

With this patch, the output is:

   Percent         |      Source code & Disassembly of div for cycles (44550 samples)
  -----------------------------------------------------------------------------------
                   :
                   :
                   :
                   :            Disassembly of section .text:
                   :
                   :            00000000004004b0 <main>:
                   :            main():
                   :
                   :                    return i;
                   :            }
                   :
                   :            int main(void)
                   :            {
      0.00    0.00 :   4004b0:       push   %rbx
                   :                    int i;
                   :                    int flag;
                   :                    volatile double x = 1212121212, y = 121212;
                   :
                   :                    s_randseed = time(0);
      0.00    0.00 :   4004b1:       xor    %edi,%edi
                   :                    srand(s_randseed);
      0.00    0.00 :   4004b3:       mov    $0x77359400,%ebx
                   :
                   :                    return i;
                   :            }

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: f681d593d1ce ("perf annotate: Remove disasm__calc_percent() from disasm_line__print()")
Link: http://lkml.kernel.org/r/1525881435-4092-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 536ee148bff8..5d74a30fe00f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1263,6 +1263,9 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				max_percent = sample->percent;
 		}
 
+		if (al->samples_nr > nr_percent)
+			nr_percent = al->samples_nr;
+
 		if (max_percent < min_pcnt)
 			return -1;
 
-- 
2.14.3
