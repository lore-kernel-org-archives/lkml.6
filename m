Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935345AbeBMN3R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:29:17 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35039 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935174AbeBMN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:29:15 -0500
X-Google-Smtp-Source: AH8x224nSGurSSlxQbJpjPHldyyM2oULfPRZPw2xyB0K938aPDQT8/f6Sq7BqqE4M/YHsj/kvpyXBg==
Date: Tue, 13 Feb 2018 16:29:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] proc: do less stuff under ->pde_unload_lock
Message-ID: <20180213132911.GA24298@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca469f35a8e9ef12571a4b80ac6d7fdc0260fb44
("deal with races between remove_proc_entry() and proc_reg_release()")
moved too much stuff under ->pde_unload_lock making a problem described
at series "[PATCH v5] procfs: Improve Scaling in proc" worse.

While RCU is being figured out, move kfree() out of ->pde_unload_lock.

On my potato, difference is only 0.5% speedup with concurrent
open+read+close of /proc/cmdline, but the effect should be more
noticeable on more capable machines.

$ perf stat -r 16 -- ./proc-j 16

 Performance counter stats for './proc-j 16' (16 runs):

     130569.502377      task-clock (msec)         #   15.872 CPUs utilized            ( +-  0.05% )
            19,169      context-switches          #    0.147 K/sec                    ( +-  0.18% )
                15      cpu-migrations            #    0.000 K/sec                    ( +-  3.27% )
               437      page-faults               #    0.003 K/sec                    ( +-  1.25% )
   300,172,097,675      cycles                    #    2.299 GHz                      ( +-  0.05% )
    96,793,267,308      instructions              #    0.32  insn per cycle           ( +-  0.04% )
    22,798,342,298      branches                  #  174.607 M/sec                    ( +-  0.04% )
       111,764,687      branch-misses             #    0.49% of all branches          ( +-  0.47% )

       8.226574400 seconds time elapsed                                          ( +-  0.05% )
       ^^^^^^^^^^^


$ perf stat -r 16 -- ./proc-j 16

 Performance counter stats for './proc-j 16' (16 runs):

     129866.777392      task-clock (msec)         #   15.869 CPUs utilized            ( +-  0.04% )
            19,154      context-switches          #    0.147 K/sec                    ( +-  0.66% )
                14      cpu-migrations            #    0.000 K/sec                    ( +-  1.73% )
               431      page-faults               #    0.003 K/sec                    ( +-  1.09% )
   298,556,520,546      cycles                    #    2.299 GHz                      ( +-  0.04% )
    96,525,366,833      instructions              #    0.32  insn per cycle           ( +-  0.04% )
    22,730,194,043      branches                  #  175.027 M/sec                    ( +-  0.04% )
       111,506,074      branch-misses             #    0.49% of all branches          ( +-  0.18% )

       8.183629778 seconds time elapsed                                          ( +-  0.04% )
       ^^^^^^^^^^^

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -138,7 +138,7 @@ static void unuse_pde(struct proc_dir_entry *pde)
 		complete(pde->pde_unload_completion);
 }
 
-/* pde is locked */
+/* pde is locked on entry, unlocked on exit */
 static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 {
 	/*
@@ -157,9 +157,10 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 		pdeo->c = &c;
 		spin_unlock(&pde->pde_unload_lock);
 		wait_for_completion(&c);
-		spin_lock(&pde->pde_unload_lock);
 	} else {
 		struct file *file;
+		struct completion *c;
+
 		pdeo->closing = true;
 		spin_unlock(&pde->pde_unload_lock);
 		file = pdeo->file;
@@ -167,8 +168,10 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 		spin_lock(&pde->pde_unload_lock);
 		/* After ->release. */
 		list_del(&pdeo->lh);
-		if (unlikely(pdeo->c))
-			complete(pdeo->c);
+		c = pdeo->c;
+		spin_unlock(&pde->pde_unload_lock);
+		if (unlikely(c))
+			complete(c);
 		kfree(pdeo);
 	}
 }
@@ -188,6 +191,7 @@ void proc_entry_rundown(struct proc_dir_entry *de)
 		struct pde_opener *pdeo;
 		pdeo = list_first_entry(&de->pde_openers, struct pde_opener, lh);
 		close_pdeo(de, pdeo);
+		spin_lock(&de->pde_unload_lock);
 	}
 	spin_unlock(&de->pde_unload_lock);
 }
@@ -375,7 +379,7 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 	list_for_each_entry(pdeo, &pde->pde_openers, lh) {
 		if (pdeo->file == file) {
 			close_pdeo(pde, pdeo);
-			break;
+			return 0;
 		}
 	}
 	spin_unlock(&pde->pde_unload_lock);
