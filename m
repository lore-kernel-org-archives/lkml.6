Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeCHU3f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:29:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52491 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:29:33 -0500
X-Google-Smtp-Source: AG47ELsqkMCiBHugW0tu5GX+f+7kKFdBOJ7YP2E2L4FKTygpm+b1V0kwb56F9pBPiFmZOG2UoDKQBg==
From: Mathieu Malaterre <malat@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: trival@kernel.org, Mathieu Malaterre <malat@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Move the inline keyword at the beginning of function declaration
Date: Thu,  8 Mar 2018 21:28:56 +0100
Message-Id: <20180308202856.9378-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline keyword was not at the beginning of the function declaration.
Fix the following warning (reported at W=1)

  CC      kernel/events/ring_buffer.o
kernel/events/ring_buffer.c:105:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static bool __always_inline
 ^~~~~~
kernel/events/ring_buffer.c:116:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static int __always_inline
 ^~~~~~
kernel/events/ring_buffer.c:416:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
 ^~~~~~
  AR      kernel/events/built-in.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/events/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6c6b3c48db71..03e39e3df543 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -102,7 +102,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	preempt_enable();
 }
 
-static bool __always_inline
+static __always_inline bool
 ring_buffer_has_space(unsigned long head, unsigned long tail,
 		      unsigned long data_size, unsigned int size,
 		      bool backward)
@@ -113,7 +113,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 		return CIRC_SPACE(tail, head, data_size) >= size;
 }
 
-static int __always_inline
+static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
@@ -413,7 +413,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 }
 EXPORT_SYMBOL_GPL(perf_aux_output_begin);
 
-static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
+static __always_inline bool rb_need_aux_wakeup(struct ring_buffer *rb)
 {
 	if (rb->aux_overwrite)
 		return false;
-- 
2.11.0
