Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933875AbeEIIDa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:03:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:61648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933715AbeEIIDZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:03:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="57148480"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf annotate: Display multiple events for --stdio
Date: Wed,  9 May 2018 23:57:15 +0800
Message-Id: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we perform following command lines:

perf record -e "{cycles,branches}" ./div
perf annotate main --stdio

Only shows one event "cycles" and the displaying format is not correct.

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
                 :

The issue is the value of nr_percent is hardcoded to 1.
This patch fixes it.

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
---
 tools/perf/util/annotate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 536ee14..5d74a30 100644
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
2.7.4
