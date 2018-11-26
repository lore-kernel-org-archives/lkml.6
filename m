Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21437C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF512089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmHrtTLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF512089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeKZVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A962089F;
        Mon, 26 Nov 2018 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229599;
        bh=MXcPL1qC0x+ovJYuiUUR4UPYbRdo5xYQ7KovozT4JoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmHrtTLVIwLvex8GgSKT/JgY9qMM7J3p1fYvmxxjguuVQ0NWiDBh09JG0syXe7AgO
         6FHiI7kn54aIsqM+tepMZR/VD9/RjVdTw1f29UClOB8zZU2FARc+fgtGa+efUQbU3I
         tTtMgpbJZ6dzaLKkoeSsQBp567SkOk6flHYsIJvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 3.18 24/24] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
Date:   Mon, 26 Nov 2018 11:51:18 +0100
Message-Id: <20181126105032.962397181@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v3.6+
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/uhid.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -12,6 +12,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compat.h>
+#include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/hid.h>
@@ -24,6 +25,7 @@
 #include <linux/spinlock.h>
 #include <linux/uhid.h>
 #include <linux/wait.h>
+#include <linux/uaccess.h>
 
 #define UHID_NAME	"uhid"
 #define UHID_BUFSIZE	32
@@ -721,6 +723,17 @@ static ssize_t uhid_char_write(struct fi
 
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


