Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35034208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35034208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeLFRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeLFRrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:47:22 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB1920892;
        Thu,  6 Dec 2018 17:47:21 +0000 (UTC)
Date:   Thu, 6 Dec 2018 12:47:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181206124719.1fa76d92@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This is a single commit that fixes a bug in uprobes SDT code
due to a missing mutex protection.


Please pull the latest trace-v4.20-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.20-rc5

Tag SHA1: a5405a88026387f237d97b607234db71d91c13e2
Head SHA1: 1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636


Ravi Bangoria (1):
      Uprobes: Fix kernel oops with delayed_uprobe_remove()

----
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)
---------------------------
commit 1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636
Author: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed Dec 5 09:04:23 2018 +0530

    Uprobes: Fix kernel oops with delayed_uprobe_remove()
    
    There could be a race between task exit and probe unregister:
    
      exit_mm()
      mmput()
      __mmput()                     uprobe_unregister()
      uprobe_clear_state()          put_uprobe()
      delayed_uprobe_remove()       delayed_uprobe_remove()
    
    put_uprobe() is calling delayed_uprobe_remove() without taking
    delayed_uprobe_lock and thus the race sometimes results in a
    kernel crash. Fix this by taking delayed_uprobe_lock before
    calling delayed_uprobe_remove() from put_uprobe().
    
    Detailed crash log can be found at:
      Link: http://lkml.kernel.org/r/000000000000140c370577db5ece@google.com
    
    Link: http://lkml.kernel.org/r/20181205033423.26242-1-ravi.bangoria@linux.ibm.com
    
    Acked-by: Oleg Nesterov <oleg@redhat.com>
    Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
    Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
    Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96d4bee83489..98b9312ce6b2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
 		 * gets called, we don't get a chance to remove uprobe from
 		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 		 */
+		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
+		mutex_unlock(&delayed_uprobe_lock);
 		kfree(uprobe);
 	}
 }
