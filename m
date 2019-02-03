Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F94C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816AF218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfBCN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:56:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54010 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728432AbfBCNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003wE-Ic; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9j-0007Eu-0u; Sun, 03 Feb 2019 14:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric Biggers" <ebiggers@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jiri Kosina" <jkosina@suse.cz>, "Jann Horn" <jannh@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.625235033@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 214/305] HID: uhid: forbid UHID_CREATE under
 KERNEL_DS or elevated privileges
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8c01db7619f07c85c5cd81ec5eb83608b56c88f5 upstream.

When a UHID_CREATE command is written to the uhid char device, a
copy_from_user() is done from a user pointer embedded in the command.
When the address limit is KERNEL_DS, e.g. as is the case during
sys_sendfile(), this can read from kernel memory.  Alternatively,
information can be leaked from a setuid binary that is tricked to write
to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.

No other commands in uhid_char_write() are affected by this bug and
UHID_CREATE is marked as "obsolete", so apply the restriction to
UHID_CREATE only rather than to uhid_char_write() entirely.

Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
helpers fault on kernel addresses"), allowing this bug to be found.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16; Directly include <linux/uaccess.h>]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -12,6 +12,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compat.h>
+#include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/hid.h>
@@ -22,6 +23,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <linux/uhid.h>
 #include <linux/wait.h>
 
@@ -676,6 +678,17 @@ static ssize_t uhid_char_write(struct fi
 
 	switch (uhid->input_buf.type) {
 	case UHID_CREATE:
+		/*
+		 * 'struct uhid_create_req' contains a __user pointer which is
+		 * copied from, so it's unsafe to allow this with elevated
+		 * privileges (e.g. from a setuid binary) or via kernel_write().
+		 */
+		if (file->f_cred != current_cred() || uaccess_kernel()) {
+			pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
+				    task_tgid_vnr(current), current->comm);
+			ret = -EACCES;
+			goto unlock;
+		}
 		ret = uhid_dev_create(uhid, &uhid->input_buf);
 		break;
 	case UHID_CREATE2:

