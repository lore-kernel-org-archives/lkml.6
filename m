Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeEOGkh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:40:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeEOGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:40:35 -0400
Date: Mon, 14 May 2018 23:40:15 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-04d2600ab669b2d44dd7920cc8a1b95c8144084c@git.kernel.org>
Cc: yao.jin@linux.intel.com, ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        jolsa@kernel.org
Reply-To: yao.jin@linux.intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
References: <1525881435-4092-1-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Display all available events on
 --stdio
Git-Commit-ID: 04d2600ab669b2d44dd7920cc8a1b95c8144084c
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

Commit-ID:  04d2600ab669b2d44dd7920cc8a1b95c8144084c
Gitweb:     https://git.kernel.org/tip/04d2600ab669b2d44dd7920cc8a1b95c8144084c
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Wed, 9 May 2018 23:57:15 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 10 May 2018 15:19:30 -0300

perf annotate: Display all available events on --stdio

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
 
