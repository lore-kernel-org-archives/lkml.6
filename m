Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96884C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C55E2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfADDTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfADDTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:19:00 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445062087F;
        Fri,  4 Jan 2019 03:18:59 +0000 (UTC)
Date:   Thu, 3 Jan 2019 22:18:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        kbuild test robot <lkp@intel.com>
Subject: [GIT PULL][PATCH] sh: ftrace: Fix missing parenthesis in WARN_ON()
Message-ID: <20190103221857.3458296b@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

It appears that the zero-day bot did find a bug in my sh build.
And that I didn't have the bad code in my config file when I
cross compiled it, although there are a few other errors in sh
that makes it not build for me, I missed that I added one more.

I replaced WARN_ON(current->curr_ret_stack) with
 WARN_ON(ftrace_graph_get_ret_stack(current, 1) where it should be:
 WARN_ON(ftrace_graph_get_ret_stack(current, 1))


Please pull the latest trace-v4.21-1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.21-1

Tag SHA1: 0695bd08e48f3e80e08afb6ea256639a4e81624c
Head SHA1: dc56367cb5dbf9d593e4b12373489df9a7edb72c


Steven Rostedt (VMware) (1):
      sh: ftrace: Fix missing parenthesis in WARN_ON()

----
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit dc56367cb5dbf9d593e4b12373489df9a7edb72c
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Jan 3 22:02:39 2019 -0500

    sh: ftrace: Fix missing parenthesis in WARN_ON()
    
    Adding a function inside a WARN_ON() didn't close the WARN_ON parathesis.
    
    Link: http://lkml.kernel.org/r/201901020958.28Mzbs0O%fengguang.wu@intel.com
    Cc: linux-sh@vger.kernel.org
    Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
    Cc: Rich Felker <dalias@libc.org>
    Reported-by: kbuild test robot <lkp@intel.com>
    Fixes: cec8d0e7f06e ("sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index df0fd6efe758..00622598a245 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -619,7 +619,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 		 * than one patched return address on our stack,
 		 * complain loudly.
 		 */
-		WARN_ON(ftrace_graph_get_ret_stack(current, 1);
+		WARN_ON(ftrace_graph_get_ret_stack(current, 1));
 	}
 #endif
 
