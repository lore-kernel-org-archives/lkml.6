Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeDLByn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbeDLBym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:54:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF707217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180412015440.633150795@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 11 Apr 2018 21:54:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <jbacik@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH 2/5] tracing/uprobe: Add support for overlayfs
References: <20180412015359.244491749@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-uprobe-Add-support-for-overlayfs.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Howard McLauchlan <hmclauchlan@fb.com>

uprobes cannot successfully attach to binaries located in a directory
mounted with overlayfs.

To verify, create directories for mounting overlayfs
(upper,lower,work,merge), move some binary into merge/ and use readelf
to obtain some known instruction of the binary. I used /bin/true and the
entry instruction(0x13b0):

	$ mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merge
	$ cd /sys/kernel/debug/tracing
	$ echo 'p:true_entry PATH_TO_MERGE/merge/true:0x13b0' > uprobe_events
	$ echo 1 > events/uprobes/true_entry/enable

This returns 'bash: echo: write error: Input/output error' and dmesg
tells us 'event trace: Could not enable event true_entry'

This change makes create_trace_uprobe() look for the real inode of a
dentry. In the case of normal filesystems, this simplifies to just
returning the inode. In the case of overlayfs(and similar fs) we will
obtain the underlying dentry and corresponding inode, upon which uprobes
can successfully register.

Running the example above with the patch applied, we can see that the
uprobe is enabled and will output to trace as expected.

Link: http://lkml.kernel.org/r/20180410231030.2720-1-hmclauchlan@fb.com

Reviewed-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 268029ae1be6..8b86d76c55ee 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -446,7 +446,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	if (ret)
 		goto fail_address_parse;
 
-	inode = igrab(d_inode(path.dentry));
+	inode = igrab(d_real_inode(path.dentry));
 	path_put(&path);
 
 	if (!inode || !S_ISREG(inode->i_mode)) {
-- 
2.16.3
