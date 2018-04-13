Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbeDMRyO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:54:14 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34143 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:54:12 -0400
X-Google-Smtp-Source: AIpwx4+Yc3J3qbCr3wuE21xXh8h6mbnfcp8vYXKORH5WLIRuKYwVH+Kz745aetP6DkaCbPThixMp/g==
Date: Fri, 13 Apr 2018 20:54:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, gs051095@gmail.com
Subject: [PATCH] proc: fix /proc/loadavg regression
Message-ID: <20180413175408.GA27246@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 95846ecf9dac5089aed4b144d912225f8ef86ae4
"pid: replace pid bitmap implementation with IDR API"

changed last field of /proc/loadavg (last pid allocated)
to be off by one:

	# unshare -p -f --mount-proc cat /proc/loadavg
	0.00 0.00 0.00 1/60 2	<===

It should be 1 after first fork into pid namespace.

This is formally a regression but given how useless this field is
I don't think anyone is affected.

Bug was found by /proc testsuite!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/powerpc/platforms/cell/spufs/sched.c |    2 +-
 fs/proc/loadavg.c                         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1093,7 +1093,7 @@ static int show_spu_loadavg(struct seq_file *s, void *private)
 		LOAD_INT(c), LOAD_FRAC(c),
 		count_active_contexts(),
 		atomic_read(&nr_spu_contexts),
-		idr_get_cursor(&task_active_pid_ns(current)->idr));
+		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }
 
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -24,7 +24,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
 		nr_running(), nr_threads,
-		idr_get_cursor(&task_active_pid_ns(current)->idr));
+		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }
 
